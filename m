Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3987C34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F224697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814777;
	bh=Q1kE/ZPI0n+f9SXApJyQvp1ClIoX4uMzSdUChjX1Wco=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=x/ynlsWmV8obciu28B0kfKJL5qz5RHE2tYrh3U0XWRzKYs83VOma4qGopwxw4/Jv3
	 ZjYEgU/iLohKtSqnwf1thbomX5sJcuN8JdZ1dFbqQX7Lrm2l6NDWegJdGU8eVgacLi
	 1UfqJGQGjcXcfG9LiJJGIz0/3IsTa71g97gDETgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgB0OqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgB0OqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:46:13 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41AF02468F;
        Thu, 27 Feb 2020 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814773;
        bh=Q1kE/ZPI0n+f9SXApJyQvp1ClIoX4uMzSdUChjX1Wco=;
        h=Date:From:To:cc:Subject:From;
        b=2YOB3UF8dyR/sSd6o5i3T/I56LLo6+8l9QyGsG2VQY2GqL7SAwbq6wqyOcLCynYYM
         2WyTml+WMZndMmBTNLm3P16K1alLNKCa5atAYAkOznVluz393rFE4vCLaxx9o+Z12I
         IcBbXY7EPZTLzAokqJ0uBgf1Z6XKKj9X6oxDbHFs=
Date:   Thu, 27 Feb 2020 15:46:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
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

to receive HID subsystem fixes for 5.6.

=====
- syzkaller-reported error handling fixes in various drivers, from various 
  people
- increase of HID report buffer size to 8K, which is apparently needed
  by certain modern devices
- a few new device-ID-specific fixes / quirks
- battering charging status reporting fix in logitech-hidpp, from Filipe 
  Laíns
=====

Thanks.

----------------------------------------------------------------
Christophe JAILLET (1):
      HID: alps: Fix an error handling path in 'alps_input_configured()'

Filipe Laíns (1):
      HID: logitech-hidpp: BatteryVoltage: only read chargeStatus if extPower is active

Hanno Zulla (3):
      HID: hid-bigbenff: fix general protection fault caused by double kfree
      HID: hid-bigbenff: call hid_hw_stop() in case of error
      HID: hid-bigbenff: fix race condition for scheduled work during removal

Hans de Goede (1):
      HID: ite: Only bind to keyboard USB interface on Acer SW5-012 keyboard dock

Johan Korsnes (2):
      HID: core: fix off-by-one memset in hid_report_raw_event()
      HID: core: increase HID report buffer size to 8KiB

Kai-Heng Feng (1):
      HID: i2c-hid: add Trekstor Surfbook E11B to descriptor override

Mansour Behabadi (1):
      HID: apple: Add support for recent firmware on Magic Keyboards

dan.carpenter@oracle.com (1):
      HID: hiddev: Fix race in in hiddev_disconnect()

 drivers/hid/hid-alps.c                   |  2 +-
 drivers/hid/hid-apple.c                  |  3 ++-
 drivers/hid/hid-bigbenff.c               | 31 +++++++++++++++++------
 drivers/hid/hid-core.c                   |  4 ++-
 drivers/hid/hid-ite.c                    |  5 ++--
 drivers/hid/hid-logitech-hidpp.c         | 43 ++++++++++++++++----------------
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++
 drivers/hid/usbhid/hiddev.c              |  2 +-
 include/linux/hid.h                      |  2 +-
 9 files changed, 64 insertions(+), 36 deletions(-)

-- 
Jiri Kosina
SUSE Labs

