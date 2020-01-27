Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E393DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD18D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580136863;
	bh=BgrdK2DMF2WD3bWQDtzYaA2txFf/F5wW7SDPZdOKVKg=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=sxfphj2Ktqd6yUjDS+O+r2RgKLNOqlWOkpbMQJsKOpRGbOEmc8fz6jnj6aXzWhb9S
	 gi/4Y3iu3slntpbrI7ZZmRk5RcsG1c5GTc41DmhYnMplkanTBDb02AEvOB2XKsh5wM
	 Z9SwF3Inr9buYd8xzmRdwU1P1dWX6sK4hfG/pbgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgA0OyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:54:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgA0OyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:54:22 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2321620716;
        Mon, 27 Jan 2020 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580136862;
        bh=BgrdK2DMF2WD3bWQDtzYaA2txFf/F5wW7SDPZdOKVKg=;
        h=Date:From:To:cc:Subject:From;
        b=aAQ2vzYX8BPjp5bBMbl+0KnC+n8IaNEKuwvFQKQFFcvIZmY5abq9aq3atcJQe4+ws
         Cq2crJoRMW471TVI/DQM4Huiv4cSRZOTiQ8qTdSHhxgewf14pR6Q0yvtyK7KoFgcj3
         i32jbfEhdn80bIJpm2QGh1Il6hbDVFO5frk/cUgs=
Date:   Mon, 27 Jan 2020 15:54:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID updates for 5.6
Message-ID: <nycvar.YFH.7.76.2001271551490.31058@cbobk.fhfr.pm>
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

to receive HID updates queued for 5.6 merge window. This time it's 
surprisingly quiet one (probably due to the christmas break).

=====
- Logitech HID++ protocol improvements from Mazin Rezk, Pedro Vanzella and 
  Adrian Freund
- support for hidraw uniq ioctl from Marcel Holtmann
=====

Thanks.

----------------------------------------------------------------
Adrian Freund (1):
      HID: logitech: Add MX Master 3 Mouse

Christophe JAILLET (1):
      HID: logitech-hidpp: avoid duplicate error handling code in 'hidpp_probe()'

Marcel Holtmann (1):
      HID: hidraw: add support uniq ioctl

Mazin Rezk (2):
      HID: logitech-hidpp: Support translations from short to long reports
      HID: logitech-hidpp: Support WirelessDeviceStatus connect events

Pedro Vanzella (1):
      hid-logitech-hidpp: read battery voltage from newer devices

 drivers/hid/hid-logitech-hidpp.c | 247 ++++++++++++++++++++++++++++++++++++---
 drivers/hid/hidraw.c             |   9 ++
 include/uapi/linux/hidraw.h      |   1 +
 3 files changed, 242 insertions(+), 15 deletions(-)

-- 
Jiri Kosina
SUSE Labs

