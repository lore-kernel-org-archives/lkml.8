Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC855206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 22:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588630722;
	bh=MW0nrCAK8Zv2S7BwVMRrLBNr4vxsKP89dvxowLz8qj8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=n98VJzQImWNabjm4wW+LbnunRFvaQ35OxrVXpTxuvYdCHjoDV+W9PSP8YG8DK71K3
	 ZmALOhwz6rHZio9qlE/0185xgfhYZO37q1bXuFjqMjwxf11TlH1ZTPwRecPFWNg7po
	 zMFijnPu5HCxB3eZAOiUwkjK8hUcwYCK8yZel/BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgEDWSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 18:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgEDWSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 18:18:41 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C44206A4;
        Mon,  4 May 2020 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588630721;
        bh=MW0nrCAK8Zv2S7BwVMRrLBNr4vxsKP89dvxowLz8qj8=;
        h=Date:From:To:cc:Subject:From;
        b=aJzxShxVM/DuFSossjFq+6t0i06Br+h6m+lB0uEpoZYFcz5jklHuhqMAimRUPX2Rn
         Ae+8gQx6xpod9Pw60K4nkJR51rooLvh37yHjHNkrxIoiTtuUnVWwED0UT68weMcRsh
         QWyGlVX0iTSmqxveftkwIkl75be5RPrUX/IP6oo0=
Date:   Tue, 5 May 2020 00:18:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID subsystem fixes
Message-ID: <nycvar.YFH.7.76.2005050016220.19713@cbobk.fhfr.pm>
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

to receive HID subsytem fixes.

=====
- Wacom driver functional and regression fixes from Jason Gerecke
- race condition fix in usbhid, found by syzbot and fixed by Alan Stern
- a few device-specific quirks and ID additions
=====

Thanks.

----------------------------------------------------------------
Alan Stern (1):
      HID: usbhid: Fix race between usbhid_close() and usbhid_stop()

Arnd Bergmann (1):
      HID: mcp2221: add gpiolib dependency

Artem Borisov (1):
      HID: alps: Add AUI1657 device ID

Daniel Playfair Cal (1):
      HID: i2c-hid: reset Synaptics SYNA2393 on resume

Fabian Schindlatz (1):
      HID: logitech: Add support for Logitech G11 extra keys

Hans de Goede (1):
      HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K12A keyboard-dock

Jason Gerecke (3):
      HID: wacom: Read HID_DG_CONTACTMAX directly for non-generic devices
      Revert "HID: wacom: generic: read the number of expected touches on a per collection basis"
      HID: wacom: Report 2nd-gen Intuos Pro S center button status over BT

Jiri Kosina (1):
      HID: alps: ALPS_1657 is too specific; use U1_UNICORN_LEGACY instead

Sebastian Reichel (1):
      HID: multitouch: add eGalaxTouch P80H84 support

 drivers/hid/Kconfig                |  1 +
 drivers/hid/hid-alps.c             |  1 +
 drivers/hid/hid-ids.h              |  8 +++-
 drivers/hid/hid-lg-g15.c           |  4 ++
 drivers/hid/hid-multitouch.c       |  3 ++
 drivers/hid/hid-quirks.c           |  1 +
 drivers/hid/i2c-hid/i2c-hid-core.c |  2 +
 drivers/hid/usbhid/hid-core.c      | 37 ++++++++++++----
 drivers/hid/usbhid/usbhid.h        |  1 +
 drivers/hid/wacom_sys.c            |  4 +-
 drivers/hid/wacom_wac.c            | 88 ++++++++++----------------------------
 11 files changed, 74 insertions(+), 76 deletions(-)

-- 
Jiri Kosina
SUSE Labs

