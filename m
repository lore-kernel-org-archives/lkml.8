Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439FCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A8E20772
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072769;
	bh=XSqucGMa32wJj88uZBFYJ2AD4Hy2/Cjd6juWq2PmRHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nwPuKQspp8QWmZD9B4II48KOWieF5koqbC1zFX0F3+POjgNeK05J6fVJ3rZ24aS9j
	 gH0XbXBxbTcAXuikgOpqSk+61/SKrZ4mwDIbPEs+NOiFXN7jui3LGUvkh7wv7VjJ3M
	 mnrgi55GicT0efkMV2rn9/QhNtksTahSxTpbtRnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHJPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHJPT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:19:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B937207BB;
        Mon, 10 Aug 2020 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072765;
        bh=XSqucGMa32wJj88uZBFYJ2AD4Hy2/Cjd6juWq2PmRHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=175tJjZtT+gKtVID6pBj5pUcoOi+jpemEzEUD+0naK0/W9xVmpJO+OvW7IUbCSHEP
         0h/M7AsHsBL2z2xx4KoorbzBCmT6kEyR1hn0BUlM/yPp5WJ5vaMzrItVBTbM8omYJC
         gjwS4PIq1aWwHX4PRq8r74lenz6ouj6r2WLMgL1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Connor McAdams <conmanx360@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.8 10/38] ALSA: hda/ca0132 - Fix AE-5 microphone selection commands.
Date:   Mon, 10 Aug 2020 17:19:00 +0200
Message-Id: <20200810151804.399701106@linuxfoundation.org>
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
@@ -4672,7 +4672,7 @@ static int ca0132_alt_select_in(struct h
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			tmp = FLOAT_THREE;
 			break;
 		default:
@@ -4718,7 +4718,7 @@ static int ca0132_alt_select_in(struct h
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			break;
 		default:
 			break;
@@ -4757,7 +4757,7 @@ static int ca0132_alt_select_in(struct h
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x3f);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x3f);
 			tmp = FLOAT_THREE;
 			break;
 		default:


