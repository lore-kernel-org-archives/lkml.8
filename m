Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4872C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961472074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598343300;
	bh=8EW34ibwnW7BkR5Qk0Ee3PsLO+miGm/KlQL7y2qhlD4=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=ubNLAMmd0kWZdMItySLryvrrzCCXlQyzFg0JYnbDhjwLDXCeG4irB5arPQz7WREA0
	 KhCtVB970INclJcA6owRVfFqf6GGPqOPACAZ+WTEdJY8toDJTwK8oADsqbR0agR1/l
	 MsgBp8NbJeBB2jWs8iO1HcrEivbUsIRr8WV0TmI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgHYIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:14:59 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BFE2065F;
        Tue, 25 Aug 2020 08:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598343298;
        bh=8EW34ibwnW7BkR5Qk0Ee3PsLO+miGm/KlQL7y2qhlD4=;
        h=Date:From:To:cc:Subject:From;
        b=oYLcJAQfodpRl21EsdwCrOuz5AEB8mk2G15Cepvy0T1l/3httUGHJJPizVHBNkWfc
         72u13AtY8qV6vCxgZhY9E8JcpwbCi9T6oGPdsY+3kjBx1jg+Do1oJB8xLWw/dSApnX
         S3/6ZvllEe5Df47n6n3DieaiYcGxerRrOMQy449I=
Date:   Tue, 25 Aug 2020 10:14:56 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2008251003480.27422@cbobk.fhfr.pm>
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

to receive HID subsystem fixes. Highlights:

=====
- regression fix / revert of a commit that intended to reduce probing 
  delay by ~50ms, but introduced a race that causes quite a few devices
  not to enumerate, or get stuck on first IRQ
- buffer overflow fix in hiddev, from Peilin Ye
=====

Thanks.

----------------------------------------------------------------
Hans de Goede (1):
      HID: i2c-hid: Always sleep 60ms after I2C_HID_PWR_ON commands

Jiri Kosina (1):
      Revert "HID: usbhid: do not sleep when opening device"

Peilin Ye (1):
      HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()

Rikard Falkeborn (2):
      HID: cougar: Constify cougar_id_table
      HID: macally: Constify macally_id_table

Sebastian Parschauer (1):
      HID: quirks: Always poll three more Lenovo PixArt mice

 drivers/hid/hid-cougar.c           |  2 +-
 drivers/hid/hid-ids.h              |  3 +++
 drivers/hid/hid-macally.c          |  2 +-
 drivers/hid/hid-quirks.c           |  3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 22 +++++++++-------
 drivers/hid/usbhid/hid-core.c      | 53 +++++++++++++++++---------------------
 drivers/hid/usbhid/hiddev.c        |  4 +++
 drivers/hid/usbhid/usbhid.h        |  2 --
 8 files changed, 49 insertions(+), 42 deletions(-)

-- 
Jiri Kosina
SUSE Labs

