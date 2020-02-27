Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E672AC52D43
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C62469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811897;
	bh=Sxg0R93GbOQROQbzavKod+ynQMnPQ8PoZ+nJxzzu8sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rs3qAQnECrwFydqRY//wBjBfJOoGftAIjog3qK/qJYXiD/BxkJ84LDHdKNNVKQY9a
	 n+4vPwkC14tq+ybkBNIG8rCtB8xMXYTQ9AwpFFiWhS3q0wowYoAL9RN29tcFsfpKbV
	 2HXn5/SA5MClkU3S+CVE4D7TSq2uEqjh2ozB3MHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgB0N6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732416AbgB0N6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:58:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088192084E;
        Thu, 27 Feb 2020 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811891;
        bh=Sxg0R93GbOQROQbzavKod+ynQMnPQ8PoZ+nJxzzu8sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwhSoGfyCTXVXHM+GosUdMWmw7FRrVElxz0vBjraz0EQ4po9TMrMq2JZivmhFcCMF
         q0SemOeHl5GHJYWtVsFYMgxpJAmaJ7dqsjjzLg12jMcvWbgIOCnfd60Rb4fVMRZShJ
         m6j5TOj7zEVx8tPLuRSbrgmz2o2sg1QdOfq3ltnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 141/237] ALSA: hda - Add docking station support for Lenovo Thinkpad T420s
Date:   Thu, 27 Feb 2020 14:35:55 +0100
Message-Id: <20200227132307.031619258@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Große <pegro@friiks.de>

[ Upstream commit ef7d84caa5928b40b1c93a26dbe5a3f12737c6ab ]

Lenovo Thinkpad T420s uses the same codec as T420, so apply the
same quirk to enable audio output on a docking station.

Signed-off-by: Peter Große <pegro@friiks.de>
Link: https://lore.kernel.org/r/20200122180106.9351-1-pegro@friiks.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 382b6d2ed8036..9cc9304ff21a7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -969,6 +969,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x215f, "Lenovo T510", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21ce, "Lenovo T420", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
+	SND_PCI_QUIRK(0x17aa, 0x21d2, "Lenovo T420s", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
-- 
2.20.1



