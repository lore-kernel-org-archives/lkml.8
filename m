Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC89C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28EA20770
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584452503;
	bh=ic3ydP+IoXQ7wu6a/bT76r5LXmDNJV03lwMeUEMds2w=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=idzt3MGX7aJiVav0uPnzhE5qaLC5ibHTLSAM3rp/O4wPVSWERZICh8QpaDVgYxnVr
	 tyBjwclwIqXlRLFILATHmcKBjSvqJ4jdhyecP3KYoNdW6ArQT9IjADo6LyS9j/DegX
	 GMd/ZlTlKh/MKZDrM6n32/vo1T8P2GYkH+r8RSyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCQNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQNll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:41:41 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97D520770;
        Tue, 17 Mar 2020 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584452500;
        bh=ic3ydP+IoXQ7wu6a/bT76r5LXmDNJV03lwMeUEMds2w=;
        h=Date:From:To:cc:Subject:From;
        b=HU0FQR9AO15rGEFYhUhMu8vDCsT+oxXRhbuX5b+3DztHfer3ew3GV10IQSHRwvz/k
         qtL+uFjzDPZNdDy4J/kHGgdltQTcZiClfv/wtymFBC93K33DZVlpcP68N0V+kGoaWJ
         qVpbi8MPxNMndxb1GO3di+2KXvEInC0z9/yF1spQ=
Date:   Tue, 17 Mar 2020 14:41:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2003171439360.19500@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes.

=====
- string buffer formatting fixes in picolcd and sensor drivers, from 
  Takashi Iwai
- two new device IDs from Chen-Tsung Hsieh and Tony Fischetti
=====

Thanks.

----------------------------------------------------------------
Chen-Tsung Hsieh (1):
      HID: google: add moonball USB id

Takashi Iwai (2):
      HID: hid-picolcd_fb: Use scnprintf() for avoiding potential buffer overflow
      HID: hid-sensor-custom: Use scnprintf() for avoiding potential buffer overflow

Tony Fischetti (1):
      HID: add ALWAYS_POLL quirk to lenovo pixart mouse

 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 2 ++
 drivers/hid/hid-picolcd_fb.c    | 4 ++--
 drivers/hid/hid-quirks.c        | 1 +
 drivers/hid/hid-sensor-custom.c | 6 +++---
 5 files changed, 10 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

