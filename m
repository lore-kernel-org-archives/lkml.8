Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5600C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB54420771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgGWQAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:00:34 -0400
Received: from mta01.start.ca ([162.250.196.97]:54702 "EHLO mta01.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGWQAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:00:34 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 12:00:33 EDT
Received: from mta01.start.ca (localhost [127.0.0.1])
        by mta01.start.ca (Postfix) with ESMTP id 7B14D41FCE;
        Thu, 23 Jul 2020 11:51:06 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca [24.53.240.163])
        by mta01.start.ca (Postfix) with ESMTPS id 2724941BB3;
        Thu, 23 Jul 2020 11:51:02 -0400 (EDT)
Date:   Thu, 23 Jul 2020 11:51:01 -0400
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: PROBLEM: cryptsetup fails to unlock drive in 5.8-rc6 (regression)
Message-ID: <20200723155101.pnezpo574ot4qkzx@atlas.draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After installing Linux 5.8-rc6, it seems cryptsetup can no longer
open LUKS volumes.  Regardless of the entered passphrase (correct
or otherwise), the result is a very unhelpful "Keyslot open failed."
message.

On the kernels which fail, I also noticed that the cryptsetup
benchmark command appears to not be able to determine that any
ciphers are available (output at end of message), possibly for
the same reason.

Bisected to the following commit, which suggests a problem specific
to compat userspace (this is amd64 kernel).  I tested both ia32 and
x32 userspace to confirm the problem.  Reverting this commit on top
of 5.8-rc6 resolves the issue.

Looking at strace output the failing syscall appears to be:

  sendmsg(8, {msg_name=NULL, msg_namelen=0, 
	     msg_iov=[{iov_base=..., iov_len=512}], msg_iovlen=1,
	     msg_control=[{cmsg_len=16, cmsg_level=SOL_ALG,
	     cmsg_type=0x3}, {cmsg_len=32, cmsg_level=SOL_ALG,
	     cmsg_type=0x2}], msg_controllen=48, msg_flags=0}, 0)
	     = -1 EINVAL (Invalid argument)

where fd 8 is the descriptor received after "accept" from the AF_ALG
socket bound to the skcipher algorithm.

  547ce4cfb34cdecfa0ee19c29a5510329a7ac802 is the first bad commit
  commit 547ce4cfb34cdecfa0ee19c29a5510329a7ac802
  Author: Al Viro <viro@zeniv.linux.org.uk>
  Date:   Sun May 31 02:06:55 2020 +0100

      switch cmsghdr_from_user_compat_to_kern() to copy_from_user()

      no point getting compat_cmsghdr field-by-field

      Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
      Signed-off-by: David S. Miller <davem@davemloft.net>

   net/compat.c | 15 ++++++++-------
   1 file changed, 8 insertions(+), 7 deletions(-)

  # cryptsetup open /dev/nvme0n1p2 test
  Enter passphrase for /dev/nvme0n1p2:
  Keyslot open failed.
  
  # cryptsetup benchmark
  # Tests are approximate using memory only (no storage IO).
  PBKDF2-sha1       362077 iterations per second for 256-bit key
  PBKDF2-sha256     503155 iterations per second for 256-bit key
  PBKDF2-sha512     396586 iterations per second for 256-bit key
  PBKDF2-ripemd160  283398 iterations per second for 256-bit key
  PBKDF2-whirlpool  159649 iterations per second for 256-bit key
  argon2i       4 iterations, 111601 memory, 4 parallel threads (CPUs) for 256-bit key (requested 2000 ms time)
  argon2id      4 iterations, 112215 memory, 4 parallel threads (CPUs) for 256-bit key (requested 2000 ms time)
  #     Algorithm |       Key |      Encryption |      Decryption
          aes-cbc        128b               N/A               N/A
      serpent-cbc        128b               N/A               N/A
      twofish-cbc        128b               N/A               N/A
          aes-cbc        256b               N/A               N/A
      serpent-cbc        256b               N/A               N/A
      twofish-cbc        256b               N/A               N/A
          aes-xts        256b               N/A               N/A
      serpent-xts        256b               N/A               N/A
      twofish-xts        256b               N/A               N/A
          aes-xts        512b               N/A               N/A
      serpent-xts        512b               N/A               N/A
      twofish-xts        512b               N/A               N/A

Cheers,
-- 
Nick Bowler
