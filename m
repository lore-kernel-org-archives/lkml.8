Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0BC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9E20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272806;
	bh=vhv9ahD5jt/VGshNDEu0h4s5rHcm99nOExO90XMU3HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTFpEOaPntc+b98tyrVhoNlvKNuA8PxhvtJs0KkEBpk6B6G27b2WL6Zc92Kgm0cDs
	 SHV1m2hogqaqhOdAickO1uG30f64RPe2WCDMhI+aWQaxMbIg+dcJJT1GHwOrJYSazp
	 vSSHkQh6iIbZXV5dtpi8IfzeTVWc/dL24rXhM7q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgBUINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732537AbgBUINX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:13:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5C420722;
        Fri, 21 Feb 2020 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272802;
        bh=vhv9ahD5jt/VGshNDEu0h4s5rHcm99nOExO90XMU3HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3dxmM+CtllzzXGLjEEJmc0xLSyculEao95b28H1nBzbrcy3KXE5LAuYGB5zF2i8C
         j7pzsnoSiD/3poBzYs5bPB3q3r/ZE/ltoHwH0JNPEMobJhtht3/AWD00rDLEvQLhex
         L08vtpt5WALhUx725By1LMn6HIg6U3NattoUglLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 280/344] ALSA: hda - Add docking station support for Lenovo Thinkpad T420s
Date:   Fri, 21 Feb 2020 08:41:19 +0100
Message-Id: <20200221072415.195560600@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index 90aa0f400a57d..1e20e85e9b466 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -922,6 +922,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x215f, "Lenovo T510", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21ce, "Lenovo T420", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
+	SND_PCI_QUIRK(0x17aa, 0x21d2, "Lenovo T420s", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
-- 
2.20.1



