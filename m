Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14652067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727138;
	bh=ZBFtnAmeQ8t9fKMcpKVMVgX3tj65vhesANvORxze0G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sbYnclfYUuIqX5cvgcQdlfoQI9DLooYX3j4vx2VB9Zbqxd2YKk5CDK5QslH51DPlB
	 MnOgxjGeMHRB4uwharbBuMVzCoeN25Es0tXcZCj9BJzgjOIis7NcrmrbTTFTfyKhOM
	 Xajr9CIBYIHKq/5fZPH5kMX4Q7h1GyJz+v5X+9bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbgFISZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731924AbgFIRqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F359820820;
        Tue,  9 Jun 2020 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724782;
        bh=ZBFtnAmeQ8t9fKMcpKVMVgX3tj65vhesANvORxze0G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbJ5WofGfrPyWQ7SeGwQoWwGK3wN+63vec3770o6miyO9RBcReKgimPVTe0Hcln7R
         NxtI1Z/IANRN3RFP7VEpfDbR09fJPqafSuPjcDyQQCuTGHMmxhDl+Iwxf9Dgg7YQrF
         RDR9LrYBPMB2Ajdajfdtv6S5HkGIL0e8urRUZPn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 06/36] ALSA: hda - No loopback on ALC299 codec
Date:   Tue,  9 Jun 2020 19:44:06 +0200
Message-Id: <20200609173933.652838647@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit fa16b69f1299004b60b625f181143500a246e5cb upstream.

ALC299 has no loopback mixer, but the driver still tries to add a beep
control over the mixer NID which leads to the error at accessing it.
This patch fixes it by properly declaring mixer_nid=0 for this codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195775
Fixes: 28f1f9b26cee ("ALSA: hda/realtek - Add new codec ID ALC299")
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6342,8 +6342,11 @@ static int patch_alc269(struct hda_codec
 		break;
 	case 0x10ec0225:
 	case 0x10ec0295:
+		spec->codec_variant = ALC269_TYPE_ALC225;
+		break;
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
+		spec->gen.mixer_nid = 0; /* no loopback on ALC299 */
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:


