Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519332082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585743089;
	bh=nXg2q3C/JR3U7vgkBSpwLmR4cHFshKwDTJd+tr+jbp8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=0rJj2hKzzUtMAMatxMLPiGLuDK9PG/jhFSpRtg8ToTZkP+9ZNRzxZxU7dCvOpXjPE
	 F4C0IJjaFDEcv3B3t6/JhVK8wBUNkP26bcQucQZaGqEPssgzyEIrb3EVqelRuTxVcF
	 Xf+oF7RrNJ4kgFtBDG94OsI9xnJl4liB0Rrt/w54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgDAML2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDAML2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:11:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2B620776;
        Wed,  1 Apr 2020 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585743087;
        bh=nXg2q3C/JR3U7vgkBSpwLmR4cHFshKwDTJd+tr+jbp8=;
        h=Date:From:To:cc:Subject:From;
        b=UHgJmVpG+OUk04bkT+BFaxKCFfETuvkWxQPHzTebqR6aVSli4dMlnBSG/cettVqmg
         wX4vcqULvD/U4Z+7A6rY4i88SqKDYpjQr+qjIEjIK0Dbi/V6ZkaYqkEqFZNuIVI7Yk
         ktS5WBoj4LYlFmbanAtpzMTe6LDPlyrpEqVAgQxg=
Date:   Wed, 1 Apr 2020 14:11:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.7
Message-ID: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsytem patches for 5.7 merge window.

=====
- Logitech HID++ protocol support improvement from Filipe Laíns
- probe fix for Logitech-G* devices from Hans de Goede
- a few other small code cleanups and support for new device IDs
=====

Thanks.

----------------------------------------------------------------
Christophe JAILLET (1):
      HID: rmi: Simplify an error handling path in 'rmi_hid_read_block()'

Filipe Laíns (2):
      HID: logitech-dj: add debug msg when exporting a HID++ report descriptors
      HID: logitech-dj: add support for the static device in the Powerplay mat/receiver

Gustavo A. R. Silva (2):
      HID: intel-ish-hid: ishtp-dev.h: Replace zero-length array with flexible-array member
      HID: intel-ish-hid: hbm.h: Replace zero-length array with flexible-array member

Hans de Goede (2):
      HID: quirks: Remove ITE 8595 entry from hid_have_special_driver
      HID: lg-g15: Do not fail the probe when we fail to disable F# emulation

Lucas Tanure (2):
      HID: appleir: Remove unnecessary goto label
      HID: appleir: Use devm_kzalloc() instead of kzalloc()

Rishi Gupta (1):
      HID: mcp2221: add usb to i2c-smbus host bridge

Samuel Èavoj (1):
      HID: Add driver fixing Glorious PC Gaming Race mouse report descriptor

 MAINTAINERS                                 |   7 +
 drivers/hid/Kconfig                         |  17 +
 drivers/hid/Makefile                        |   2 +
 drivers/hid/hid-appleir.c                   |  12 +-
 drivers/hid/hid-glorious.c                  |  86 ++++
 drivers/hid/hid-ids.h                       |   5 +
 drivers/hid/hid-lg-g15.c                    |   6 +-
 drivers/hid/hid-logitech-dj.c               |  11 +-
 drivers/hid/hid-mcp2221.c                   | 742 ++++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c                    |   3 -
 drivers/hid/hid-rmi.c                       |   1 -
 drivers/hid/intel-ish-hid/ishtp/hbm.h       |   2 +-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |   2 +-
 13 files changed, 878 insertions(+), 18 deletions(-)
 create mode 100644 drivers/hid/hid-glorious.c
 create mode 100644 drivers/hid/hid-mcp2221.c

-- 
Jiri Kosina
SUSE Labs

