Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A87C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35A82072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258731;
	bh=HLMAsXt1RVcl9qu5BXO6Mz/mvjPSCnG4BohMGqYDItA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nN2wF445K1aGU0YQgA1HwEUP2G9DZCjwtszVnL7kXDGpzX81afjsTfcJeYLgcDAzw
	 XNdKU1F2Xm0DvLGteXREFNoeOtoPH2ButDHTX3vOHptK18MWP+wrlquViy3ziaWuve
	 HYRFMvvjugUdt4r1f009edD36MVzXeXEjEA4TYnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgHXIp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgHXIpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462402087D;
        Mon, 24 Aug 2020 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258717;
        bh=HLMAsXt1RVcl9qu5BXO6Mz/mvjPSCnG4BohMGqYDItA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWNITOVBhsNTGFT7UXqcw1osKXAGdTMh8m/tON1beifI+2lgH9VdUQWwqkBNM37Wv
         CBpjEolt0cFjYDQQz1+sJw+UJwJO/aJY/E3pnXfbwnui8JlObkTc/72V3YZv0TnDTq
         MwM0KIYPhgYRrcv7W1RqOg7/TPzcTpdAKBl+XI6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Pozulp <pozulp.kernel@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 021/107] ALSA: hda/realtek: Add quirk for Samsung Galaxy Flex Book
Date:   Mon, 24 Aug 2020 10:29:47 +0200
Message-Id: <20200824082406.132838134@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Pozulp <pozulp.kernel@gmail.com>

commit f70fff83cda63bbf596f99edc131b9daaba07458 upstream.

The Flex Book uses the same ALC298 codec as other Samsung laptops which
have the no headphone sound bug, like my Samsung Notebook. The Flex Book
owner used Early Patching to confirm that this quirk fixes the bug.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200814045346.645367-1-pozulp.kernel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7666,6 +7666,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),


