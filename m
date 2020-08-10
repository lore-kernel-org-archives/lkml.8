Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB71C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693A720709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597051766;
	bh=lw+bpRlrXJTPDCtcj9f5WxhjPY5GIP/lZi+kKoie1Gk=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=oLAnJMN3WW5CwT9M6bVderH6I4h8dVzW6FZevHbcw1f9EqWY6IKwdSRpA8elP4zfR
	 xMDwjlpFwPSEFz5tETzXea6TUMJlcvH0RGtLQT9AiAUbYYecJDNV8kE/kJm3V0fxdA
	 kZ25aMKHRrzRexdBQAuUvp7Jqho1jkWGe+wSL1/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHJJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgHJJ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:29:22 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805D520709;
        Mon, 10 Aug 2020 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597051762;
        bh=lw+bpRlrXJTPDCtcj9f5WxhjPY5GIP/lZi+kKoie1Gk=;
        h=Date:From:To:cc:Subject:From;
        b=fPw2EOiAT+i0qhM0ChneteXgOUo7xIS4rEYNLK6i2Ke9XW1SdrH0JuidfxKtDGOgF
         69q4ROFzlX+RVe5oSuWQn1X8dLi2VcbyzkFL+b1JQtlSB/MQ7LlfvRoNhLOJbuvUD5
         lWD16reWJD4H3t+shvML7bIWtcSmCDOIEGD+XW7w=
Date:   Mon, 10 Aug 2020 11:29:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.9
Message-ID: <nycvar.YFH.7.76.2008101127040.27422@cbobk.fhfr.pm>
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

to receive HID subsystem updates for 5.9. Highlights:

=====
- fix for some modern devices that return multi-byte battery report, 
  from Grant Likely
- fix for devices with Resolution Multiplier, from Peter Hutterer
- device probing speed increase, from Dmitry Torokhov
- ThinkPad 10 Ultrabook Keyboard support, from Hans de Goede
- other small assorted fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
Alexander A. Klimov (3):
      HID: mcp2221: Replace HTTP links with HTTPS ones
      HID: udraw-ps3: Replace HTTP links with HTTPS ones
      HID: Replace HTTP links with HTTPS ones

Colin Ian King (1):
      HID: usbhid: remove redundant assignment to variable retval

Daniel G. Morse (1):
      HID: Wiimote: Treat the d-pad as an analogue stick

Dmitry Torokhov (1):
      HID: usbhid: do not sleep when opening device

Grant Likely (1):
      HID: input: Fix devices that return multiple bytes in battery report

Hans de Goede (6):
      HID: lenovo: Merge tpkbd and cptkbd data structures
      HID: lenovo: Factor out generic parts of the LED code
      HID: lenovo: Rename fn_lock sysfs attr handlers to make them generic
      HID: lenovo: Add ThinkPad 10 Ultrabook Keyboard support
      HID: lenovo: Add ThinkPad 10 Ultrabook Keyboard fn_lock support
      HID: lenovo: Fix spurious F23 key press report during resume from suspend

Ikjoon Jang (1):
      HID: quirks: add NOGET quirk for Logitech GROUP

Kai-Heng Feng (1):
      HID: intel-ish-hid: Replace PCI_DEV_FLAGS_NO_D3 with pci_save_state

Peter Hutterer (1):
      HID: input: do not run GET_REPORT unless there's a Resolution Multiplier

 drivers/hid/Kconfig                     |   2 +-
 drivers/hid/hid-cp2112.c                |   2 +-
 drivers/hid/hid-ids.h                   |   2 +
 drivers/hid/hid-input.c                 |  36 ++--
 drivers/hid/hid-lenovo.c                | 360 +++++++++++++++++++++++++-------
 drivers/hid/hid-mcp2221.c               |   2 +-
 drivers/hid/hid-quirks.c                |   1 +
 drivers/hid/hid-udraw-ps3.c             |   2 +-
 drivers/hid/hid-wiimote-core.c          |   5 +
 drivers/hid/hid-wiimote-modules.c       |  67 +++---
 drivers/hid/hid-wiimote.h               |   2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  16 +-
 drivers/hid/usbhid/hid-core.c           |  55 ++---
 drivers/hid/usbhid/usbhid.h             |   2 +
 14 files changed, 404 insertions(+), 150 deletions(-)

-- 
Jiri Kosina
SUSE Labs

