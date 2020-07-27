Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC1C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5140620775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859606;
	bh=iINv9F84Bgoo99yjFob1WezwwZvaTlQYEjVwF0s72S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lm8Dmlypy7oLdow+1roXVzQb/L7tn0DVruDxYuTo0zIhHDb+ljtkbM4HajRLANBmm
	 I807Y624l5761EYkU9/KyL/i45coHwXjEKiPzrymwBNLs2tqSJZxdiLg/ojdWBaER8
	 YHbf5gXdJSwUjc7N73Z23e7sGGWA1vbGD1t+zOzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgG0OUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731461AbgG0OT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:19:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA592070A;
        Mon, 27 Jul 2020 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859597;
        bh=iINv9F84Bgoo99yjFob1WezwwZvaTlQYEjVwF0s72S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HajdEWyRRXdwXdOC61jAVC4pwatQTnCsyW3YG9YU26sUsdt+w0hIIK45mVcoplphj
         KDfVSugCWFWTNa8HvxoMF8dElaCv2DATR7mqLK9ZjruKIZyhwRD9Tq+Q6Pw2mBJhUy
         rR9QOd2azZ8FIDtEuPBf2XHtJ/shgUHDeLra8UvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joonho Wohn <doomsheart@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 033/179] ALSA: hda/realtek: Fixed ALC298 sound bug by adding quirk for Samsung Notebook Pen S
Date:   Mon, 27 Jul 2020 16:03:28 +0200
Message-Id: <20200727134934.279131875@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonho Wohn <doomsheart@gmail.com>

commit 568e4e82128aac2c62c2c359ebebb6007fd794f9 upstream.

Fixed no headphone sound bug on laptop Samsung Notebook Pen S
(950SBE-951SBE), by using existing patch in Linus' tree, commit
14425f1f521f (ALSA: hda/realtek: Add quirk for Samsung Notebook).
This laptop uses the same ALC298 but different subsystem id 0x144dc812.
I added SND_PCI_QUIRK at sound/pci/hda/patch_realtek.c

Signed-off-by: Joonho Wohn <doomsheart@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/CAHcbMh291aWDKiWSZoxXB4-Eru6OYRwGA4AVEdCZeYmVLo5ZxQ@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7551,6 +7551,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
+	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),


