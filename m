Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C83FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B88D20639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258737;
	bh=gIazi6x58FX9+J9bAlcFwxT9oi5406XSbZ8njmSAYsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNo/3P20H5BWpsW294bkyYa5Zmgw1lZSqWAvQ3DH2ZFek4OpjGqXbkTgEH7sDINMS
	 n+t8zqVyalnImFL7gds9JKRbp1/uaKIAQbiGEXRBAiL85aFVXyozO9/ntv0Va5FP5c
	 g+HjUlwzEqePAW/BfetehDO1hH+5Kym7TnWOvras=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgHXIpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbgHXIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662BC2072D;
        Mon, 24 Aug 2020 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258721;
        bh=gIazi6x58FX9+J9bAlcFwxT9oi5406XSbZ8njmSAYsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=si47KW3XijPR66MZ9cKHsZi07uXAAei1aYSxda2W0eoqCF6Q5pA/s1yn/Pbwg8QPG
         IqT3AALF4sMAzu/S2tMmuXwAVjuqMkFBr8JKv8t17XxgYIeWW9V70DGgI+uwlNhpRR
         LMH5MJMHGAoohgsP4QEAhRqdCyu3HdJBg+Xp1ayE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Pozulp <pozulp.kernel@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 022/107] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
Date:   Mon, 24 Aug 2020 10:29:48 +0200
Message-Id: <20200824082406.177836692@linuxfoundation.org>
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

commit e17f02d0559c174cf1f6435e45134490111eaa37 upstream.

The Galaxy Book Ion uses the same ALC298 codec as other Samsung laptops
which have the no headphone sound bug, like my Samsung Notebook. The
Galaxy Book owner confirmed that this patch fixes the bug.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200818165446.499821-1-pozulp.kernel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7667,6 +7667,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),


