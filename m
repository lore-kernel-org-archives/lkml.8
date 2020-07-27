Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E513C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5FF2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgG0QGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG0QGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:06:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696F8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:06:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05dS-003kVB-Or; Mon, 27 Jul 2020 16:05:54 +0000
Date:   Mon, 27 Jul 2020 17:05:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: PROBLEM: cryptsetup fails to unlock drive in 5.8-rc6 (regression)
Message-ID: <20200727160554.GG794331@ZenIV.linux.org.uk>
References: <20200723155101.pnezpo574ot4qkzx@atlas.draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723155101.pnezpo574ot4qkzx@atlas.draconx.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:51:01AM -0400, Nick Bowler wrote:
> Hi,
> 
> After installing Linux 5.8-rc6, it seems cryptsetup can no longer
> open LUKS volumes.  Regardless of the entered passphrase (correct
> or otherwise), the result is a very unhelpful "Keyslot open failed."
> message.
> 
> On the kernels which fail, I also noticed that the cryptsetup
> benchmark command appears to not be able to determine that any
> ciphers are available (output at end of message), possibly for
> the same reason.
> 
> Bisected to the following commit, which suggests a problem specific
> to compat userspace (this is amd64 kernel).  I tested both ia32 and
> x32 userspace to confirm the problem.  Reverting this commit on top
> of 5.8-rc6 resolves the issue.
> 
> Looking at strace output the failing syscall appears to be:
> 
>   sendmsg(8, {msg_name=NULL, msg_namelen=0, 
> 	     msg_iov=[{iov_base=..., iov_len=512}], msg_iovlen=1,
> 	     msg_control=[{cmsg_len=16, cmsg_level=SOL_ALG,
> 	     cmsg_type=0x3}, {cmsg_len=32, cmsg_level=SOL_ALG,
> 	     cmsg_type=0x2}], msg_controllen=48, msg_flags=0}, 0)
> 	     = -1 EINVAL (Invalid argument)

Huh?  Just in case - could you verify that on the kernel with that
commit reverted the same sendmsg() succeeds?
