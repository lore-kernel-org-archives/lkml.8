Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D079F2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591216264;
	bh=qUNzJiCqPglvwtzmTvctitZnvvqDPh2fic8W1vH8Xy0=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=rYIZQ10ZAUKTzCNpVKMYIqsgOtCajo70EdnGv04O45xt4YiUJ4aSK1uty05gcP1Y8
	 9dlsIQSgxZGy3undZFyEbW25AaomwNJf/SVJDklr/sKlAyhhCbYUfQHo6EH8xhNjY1
	 4nGmACumk3wHPU7Gq5rbyvzChm3/Wud8SoA101Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFCUbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgFCUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:31:03 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3080420734;
        Wed,  3 Jun 2020 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591216263;
        bh=qUNzJiCqPglvwtzmTvctitZnvvqDPh2fic8W1vH8Xy0=;
        h=Date:From:To:cc:Subject:From;
        b=aLcLcKFtmdFQZR1JL5mRzTKYhYhXYt/A/+ovkDyeVM9hD+veC66Kh2D6H+2J6Eb4e
         GtC5JBONZ0vcj/mrQT9/657fhj7mIvIvKK1/aHLynbj11p3ly7wBUrcdYH7Y1x1pWZ
         J5IG3U/DR19isiXPHzjXxGJC3JdvjuFvZLa4XEy8=
Date:   Wed, 3 Jun 2020 22:31:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.8
Message-ID: <nycvar.YFH.7.76.2006032225550.13242@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem updates for 5.8. Highlights:

=====
- hid-mcp2221 GPIO support, from Rishi Gupta
- MT_CLS_WIN_8_DUAL obsolete quirk removal from hid-multitouch, from 
  Kai-Heng Feng
- a bunch of new hardware support to hid-asus driver, from Hans de Goede
- other assorted small fixes, cleanups and device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (1):
      HID: intel-ish-hid: avoid bogus uninitialized-variable warning

Benjamin Tissoires (1):
      HID: multitouch: enable multi-input as a quirk for some devices

Christophe JAILLET (1):
      HID: fix typo in Kconfig

Cristian Klein (1):
      HID: Add quirks for Trust Panora Graphic Tablet

Filipe Laíns (1):
      HID: logitech: drop outdated references to unifying receivers

Hans de Goede (7):
      HID: asus: Only set EV_REP if we are adding a mapping
      HID: asus: Simplify skipping of mappings for Asus T100CHI keyboard-dock
      HID: asus: Add hid_is_using_ll_driver(usb_hid_driver) check
      HID: asus: Add report_size to struct asus_touchpad_info
      HID: asus: Add support for multi-touch touchpad on Medion Akoya E1239T
      HID: asus: Fix mute and touchpad-toggle keys on Medion Akoya E1239T
      HID: asus: Add depends on USB_HID to HID_ASUS Kconfig option

Julian Sax (1):
      HID: i2c-hid: add Schneider SCL142ALM to descriptor override

Kai-Heng Feng (1):
      HID: multitouch: Remove MT_CLS_WIN_8_DUAL

Rishi Gupta (1):
      HID: mcp2221: add GPIO functionality support

Scott Shumate (1):
      HID: sony: Fix for broken buttons on DS3 USB dongles

free5lot (1):
      HID: apple: Swap the Fn and Left Control keys on Apple keyboards

 drivers/hid/Kconfig                         |  11 +-
 drivers/hid/hid-apple.c                     |  30 ++++-
 drivers/hid/hid-asus.c                      | 122 ++++++++++++++++----
 drivers/hid/hid-ids.h                       |  12 +-
 drivers/hid/hid-logitech-dj.c               |   4 +-
 drivers/hid/hid-logitech-hidpp.c            |   2 +-
 drivers/hid/hid-mcp2221.c                   | 169 ++++++++++++++++++++++++++++
 drivers/hid/hid-multitouch.c                |  60 ++++------
 drivers/hid/hid-quirks.c                    |   1 +
 drivers/hid/hid-sony.c                      |  17 +++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c    |   8 ++
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c |   2 +
 12 files changed, 364 insertions(+), 74 deletions(-)

-- 
Jiri Kosina
SUSE Labs

