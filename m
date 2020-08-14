Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F84120B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfmccwaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgHNMdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgHNMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:33:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB1C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 05:33:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so4486341pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMDtNR26hhEws5urGuPDuNDJnZY4acdKK7mNXzOEzD4=;
        b=mfmccwaVDf8eBSVHF2kqV/jf8XJvqpNdJXpniiM9SNN7/X3M3Uq4wG35Ykymlyorrp
         sNIjDj4gI2t7BgmMBn1dAujA4Vzbf9EPhZQJccpoJr3Mei1a461MYkXiwEp7JQJyUoQA
         SDhiFQ00Q+JQ6ooc5pzg5vyvIlZCDNPFueU/82a1faa079k4T+nVbBdO+qrmM4Xeh2/S
         3wBDa1/fr3Jcsl7v1QzQ1gtVFt4CCnlH9nZYAO/I0Pa8HpE/dO5me6jgS7vDayMTRhvh
         6Gkr+/oTvIE5DGEG29CVkWA8x6asq84pGXbiTrNIrRpF9/NyivEsY5GOH20ccLEEDjJH
         NgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMDtNR26hhEws5urGuPDuNDJnZY4acdKK7mNXzOEzD4=;
        b=SVxxnGRfK19txCdxh8HvLO0zqqptg988JAFeg7fjKegJATnBb6v59QMJM0YMjlyCfN
         q/KKhK1uVY3VBLiVpFRfgwX1wIDNfJtNy5y0pR1u2notQ5jtn83qvnwtsWFpYVtmGqzB
         s3cuztHsy/pK2J367Q4YTwgVzEE5hTojGtYQrYkcoTjZ2n4Rot1pA8GDpQb3sjtSfMVn
         HggeLXsPVchQAM4RHz2bYobLBu4eo2U+UQfLqCom8x+3Tf2JwrcyE2gQyekFls7MTl2Q
         k/UDhOyPml3CymvyDTJp8xAecl0jHsYUxx/A/HAQTcGWVr2darKtdWGs6+P14j9C2/F0
         /HFw==
X-Gm-Message-State: AOAM532tJGIfN7LiVNfvEpIDa1aYiUGcZ/BjCk9w1QxDf4HVDKQ/g4S0
        GC8937S9vEo/Nb1i5YGXEPs=
X-Google-Smtp-Source: ABdhPJy3RUbKPHh6p35U+35BTGkwbCGSjqaHJwafgAFRFxpcyomhgV6dy29zbUSeASnLIPH8tMtY5A==
X-Received: by 2002:a63:ce56:: with SMTP id r22mr1624540pgi.141.1597408411457;
        Fri, 14 Aug 2020 05:33:31 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id x8sm9808957pfp.101.2020.08.14.05.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:33:31 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v3] staging: greybus: audio: fix uninitialized value issue
Date:   Fri, 14 Aug 2020 18:03:15 +0530
Message-Id: <bc4f29eb502ccf93cd2ffd98db0e319fa7d0f247.1597408126.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation for gbcodec_mixer_dapm_ctl_put() uses
uninitialized gbvalue for comparison with updated value. This was found
using static analysis with coverity.

Uninitialized scalar variable (UNINIT)
11. uninit_use: Using uninitialized value
gbvalue.value.integer_value[0].
460        if (gbvalue.value.integer_value[0] != val) {

This patch fixes the issue with fetching the gbvalue before using it for
    comparision.

Fixes: 6339d2322c47 ("greybus: audio: Add topology parser for GB codec")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
Changelog:
v2: Fix the missing check for return value after get_control.
v3: Use single exit path to avoid missing autosuspend sequence.
---
 drivers/staging/greybus/audio_topology.c | 29 ++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 2f9fdbdcd547..83b38ae8908c 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -456,6 +456,15 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	val = ucontrol->value.integer.value[0] & mask;
 	connect = !!val;

+	ret = gb_pm_runtime_get_sync(bundle);
+	if (ret)
+		return ret;
+
+	ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
+				      GB_AUDIO_INVALID_INDEX, &gbvalue);
+	if (ret)
+		goto exit;
+
 	/* update ucontrol */
 	if (gbvalue.value.integer_value[0] != val) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
@@ -466,25 +475,17 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gbvalue.value.integer_value[0] =
 			cpu_to_le32(ucontrol->value.integer.value[0]);

-		ret = gb_pm_runtime_get_sync(bundle);
-		if (ret)
-			return ret;
-
 		ret = gb_audio_gb_set_control(module->mgmt_connection,
 					      data->ctl_id,
 					      GB_AUDIO_INVALID_INDEX, &gbvalue);
-
-		gb_pm_runtime_put_autosuspend(bundle);
-
-		if (ret) {
-			dev_err_ratelimited(codec_dev,
-					    "%d:Error in %s for %s\n", ret,
-					    __func__, kcontrol->id.name);
-			return ret;
-		}
 	}

-	return 0;
+exit:
+	gb_pm_runtime_put_autosuspend(bundle);
+	if (ret)
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
+				    __func__, kcontrol->id.name);
+	return ret;
 }

 #define SOC_DAPM_MIXER_GB(xname, kcount, data) \

base-commit: fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
--
2.27.0

