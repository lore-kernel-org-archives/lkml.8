Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E030B2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073187;
	bh=k9emq/KdsW08FKCMSWFUNTgkoEyy13pRKrMhiQmpdnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dlc0rb03owqScLJsVOJ0yNO8/qZyjoKN4nT5IXXWfIzFBfcEsYndOkGQ0W7xh2+Sr
	 YLHUEW/mzx48d48lvK13jl34pZh2q/RiCJYlRiCn7FsEuNq6ueeFZy0iWRPPxSdthy
	 LloKYyx+ACLgwfOqJbdMpVRZEM6RwB1BlWLF2saI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgHJP0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgHJP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:26:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6341922CF7;
        Mon, 10 Aug 2020 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073172;
        bh=k9emq/KdsW08FKCMSWFUNTgkoEyy13pRKrMhiQmpdnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PK9lQn35aJvozC1N/X/BQd2PnVoiqJuMeEGqh6JuJ5Qusj+4n4iPQMFPorWYdYTjP
         imaOkQbHKzzz0n03XhMyuWawhEPoA6uBCxSyRGBZwzQ820dK11n0ZGg2KeEPtBFTTB
         D9BMtlwOy0eozqbriDH7UHJzgLsc0Ncnyz67FV60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Connor McAdams <conmanx360@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 12/67] ALSA: hda/ca0132 - Fix AE-5 microphone selection commands.
Date:   Mon, 10 Aug 2020 17:20:59 +0200
Message-Id: <20200810151810.032971729@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor McAdams <conmanx360@gmail.com>

commit 7fe3530427e52dd53cd7366914864e29215180a4 upstream.

The ca0113 command had the wrong group_id, 0x48 when it should've been
0x30. The front microphone selection should now work.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200803002928.8638-3-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4671,7 +4671,7 @@ static int ca0132_alt_select_in(struct h
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			tmp = FLOAT_THREE;
 			break;
 		default:
@@ -4717,7 +4717,7 @@ static int ca0132_alt_select_in(struct h
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			break;
 		default:
 			break;
@@ -4756,7 +4756,7 @@ static int ca0132_alt_select_in(struct h
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x3f);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x3f);
 			tmp = FLOAT_THREE;
 			break;
 		default:


