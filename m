Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF518C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01F421D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473401;
	bh=+RXnEyWQ9AZBlUJK9uGq1xTC7wqOFcAILUiorIVSfO8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JfG0pYlmkN03PA8WBYoxdmWRBqN/nPtu9vEG2ZcHbyAiwOnjdYvuN3AoRZPawLiDA
	 oo8FDSoR6N9NFQsNVFhefezPEfl84cB5u8Rzq3tVZTK1q9C7WK4FOZH+gQZish7aDE
	 SYP46PTRYGFuc2H6SpTqLM/9Cl+JhbQqlSIj5lQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgFRJnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFRJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE5D21D7A;
        Thu, 18 Jun 2020 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473391;
        bh=+RXnEyWQ9AZBlUJK9uGq1xTC7wqOFcAILUiorIVSfO8=;
        h=From:To:Cc:Subject:Date:From;
        b=xmLusXzWT6s+rVn9d6aL2LzcxlFvxFSHhADDfCAPl4fJkdf6H//ZZTWxRdc33sghp
         dFe4Sd53tTD714hLtgethmOjjabiejKN3RN4FBepIoK6/9YVrKisc5MRn/cZM17AAL
         raVceltVD5e6C7S9dmUHRXEP0AivsnFooWvSjHVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrey Konovalov <andreyknvl@google.com>,
        Bastien Nocera <hadess@hadess.net>, Bin Liu <b-liu@ti.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        Harry Pan <harry.pan@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cox <jonathan@jdcox.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keiya Nobuta <nobuta.keiya@fujitsu.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Qi Zhou <atmgnd@outlook.com>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 0/8] USB: fix up some old and obsolete terminology, we can do better
Date:   Thu, 18 Jun 2020 11:42:52 +0200
Message-Id: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in the USB kernel code where terms that are
"loaded" are used.  Fix this up to be more specific and inclusive as
there is no need for us to use these terms at all.

In one case, this ends up saving code, a nice side affect.

Greg Kroah-Hartman (8):
  USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
  USB: rename USB OTG hub configuration option
  USB: OHCI: remove obsolete FIXME comment
  USB: serial: qcserial: fix up wording in a comment
  USB: serial: sierra: unify quirk handling logic
  USB: storage: fix wording in error message
  USB: storage: scsi: fix up comment to be more specific
  USB: OTG: rename product list of devices

 arch/mips/configs/fuloong2e_defconfig         |  2 +-
 arch/mips/configs/gcw0_defconfig              |  2 +-
 arch/mips/configs/lemote2f_defconfig          |  2 +-
 drivers/usb/core/Kconfig                      |  8 +--
 drivers/usb/core/config.c                     |  8 +--
 drivers/usb/core/hub.c                        |  6 +-
 .../{otg_whitelist.h => otg_productlist.h}    | 14 ++---
 drivers/usb/core/quirks.c                     | 18 +++---
 drivers/usb/core/usb.h                        |  2 +-
 drivers/usb/host/ohci-pci.c                   |  4 --
 drivers/usb/musb/Kconfig                      |  2 +-
 drivers/usb/musb/musb_core.c                  |  4 +-
 drivers/usb/serial/qcserial.c                 |  5 +-
 drivers/usb/serial/sierra.c                   | 57 +++++++------------
 drivers/usb/storage/scsiglue.c                |  2 +-
 drivers/usb/storage/uas-detect.h              |  2 +-
 include/linux/usb/quirks.h                    |  4 +-
 17 files changed, 57 insertions(+), 85 deletions(-)
 rename drivers/usb/core/{otg_whitelist.h => otg_productlist.h} (90%)

-- 
2.27.0

