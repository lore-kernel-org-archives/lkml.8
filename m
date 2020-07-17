Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A76C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981BA20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594987319;
	bh=mnfntLyEtiq+iUKE1T/sBh9oAXfeZzV6JUguluXcCAw=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=wQGVlb65Khrr0+M0O4odnKODxmWmFwVlzpgBc90sURBTvPglFjhmAnakrPb0ap97W
	 7rghUUhiHqkGGJJsLNnrQCc6jb5zvZ3Nz+KdxdeZMXDaH2ZyLAEfgKYzW6ghwbNbye
	 JKEa2gvz6XHe6ad3zwGTl5CyjTOykSayPXV/NKHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGQMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgGQMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:01:57 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DA52065F;
        Fri, 17 Jul 2020 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594987317;
        bh=mnfntLyEtiq+iUKE1T/sBh9oAXfeZzV6JUguluXcCAw=;
        h=Date:From:To:cc:Subject:From;
        b=I9pqLgX3Y/uerBKEqPUSoOfKOpSAR2vRANsbrBq+NL5vfBnjkwmhG+W7WrBKTvPgX
         /flhQJrgiphbYcI/PvsQlpRqpHJJEUSatglM/WbC6jAxhKqikzrFP7Dhtvn/c7dc6k
         EIyc1lMHfjGKx6NxnWHctktjq5MrmQ50x928B7Q8=
Date:   Fri, 17 Jul 2020 14:01:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2007171358430.23768@cbobk.fhfr.pm>
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
- linked list race condition fix in hid-steam driver from Rodrigo Rivas 
  Costa
- assorted deviceID-specific quirks and other small cosmetic cleanups
=====

Thanks.

----------------------------------------------------------------
Caiyuan Xie (1):
      HID: alps: support devices with report id 2

David Rheinsberg (1):
      MAINTAINERS: update uhid and hid-wiimote entry

Dmitry Torokhov (1):
      HID: magicmouse: do not set up autorepeat

Federico Ricchiuto (1):
      HID: i2c-hid: add Mediacom FlexBook edge13 to descriptor override

Hans de Goede (1):
      HID: apple: Disable Fn-key key-re-mapping on clone keyboards

James Hilliard (1):
      HID: quirks: Ignore Simply Automated UPB PIM

Maciej S. Szmigiero (1):
      HID: logitech-hidpp: avoid repeated "multiplier = " log messages

Mazin Rezk (1):
      HID: logitech: Use HIDPP_RECEIVER_INDEX instead of 0xff

Rodrigo Rivas Costa (1):
      HID: steam: fixes race in handling device list.

Sebastian Parschauer (1):
      HID: quirks: Always poll Obins Anne Pro 2 keyboard

 MAINTAINERS                              |  4 ++--
 drivers/hid/hid-alps.c                   |  2 ++
 drivers/hid/hid-apple.c                  | 18 ++++++++++++++++++
 drivers/hid/hid-ids.h                    |  3 +++
 drivers/hid/hid-logitech-dj.c            |  6 +++---
 drivers/hid/hid-logitech-hidpp.c         |  2 +-
 drivers/hid/hid-magicmouse.c             |  6 ++++++
 drivers/hid/hid-quirks.c                 |  2 ++
 drivers/hid/hid-steam.c                  |  6 ++++--
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++++
 10 files changed, 49 insertions(+), 8 deletions(-)

-- 
Jiri Kosina
SUSE Labs

