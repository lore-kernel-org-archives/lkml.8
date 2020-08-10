Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44249C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5F422BEA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072811;
	bh=RpCwl2a7mMi1lqBMI4RzZIrIwVlneuHUmBfc9qf5QcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcjA1w4zXRDaZzqAdZ+ijmG8qy1SYeluRXHGSq2/QcSaG4v3btnle6yvBm0bOgp2d
	 htau2pSYrl/VhtSP/5KchjTB5zeUDh+m5o91uTYNLWdiUkp3nRG4sDxlhzVGIZMkET
	 EgVNUbjFpC0PLzR61tOZwf75atq8J9CfB/WyHgwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHJPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgHJPUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:20:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B57C20772;
        Mon, 10 Aug 2020 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072803;
        bh=RpCwl2a7mMi1lqBMI4RzZIrIwVlneuHUmBfc9qf5QcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eADqm4y0Ouo1ESKzMp/MWO7iIwhX8jwqPckETQlXpl9ZwaIV24FYoNeM6jmJwDljm
         //indc9EEo0WJl3rrjgHkKeNASX7IFBHXKzfJmeAvfraQT/2BXuzOBcr27xusMCeER
         rRQydqZfOombIQSB/Ssh0GGiTZsMS713vF60GOdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Connor McAdams <conmanx360@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.8 08/38] ALSA: hda/ca0132 - Add new quirk ID for Recon3D.
Date:   Mon, 10 Aug 2020 17:18:58 +0200
Message-Id: <20200810151804.308756801@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor McAdams <conmanx360@gmail.com>

commit cc5edb1bd3f7bfe450f767b12423f6673822427b upstream.

Add a new quirk ID for the Recon3D, as tested by me.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200803002928.8638-2-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1182,6 +1182,7 @@ static const struct snd_pci_quirk ca0132
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
+	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
 	{}
 };


