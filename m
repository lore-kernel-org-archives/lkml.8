Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739FFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1422206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQMfwnMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgHFRx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgHFQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:30:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B7C0086A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:22:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x6so11885720pgx.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nR6p+azSrG4y2Tef6cprsCVi44IERGjpbRkmYO5cRCo=;
        b=oQMfwnMBo7iIyU3XgTKjs+tm2fwISj9oPIXtpEOq4WbZyW2p7xX7jErO6D6GEq9RTy
         wQ+Sksn3rn0kdhQfVBPHDpQ+mM+C/fLwCMcW8Sh98adiZ2CFeDNwk0iLXc3tFeIzFmjU
         kjVnpRQRW0O/YafrCjyofizkbKWBbD7NcPpxyk+2FVMUH/MqbxGdtqY5XlMBqJbrGE5g
         kqp87WWAchGt1Vr2wNBeLBdWEspXIVxxLzDQNQqQtUqwvXudlGcIRBzChNeJaqU//GvA
         ee6Jeefgj9xc7wF3iyS+lLjG7EYrRyqDwCK4j7TTfmWqrNYythuMiKS/gWcf8pJRuTwm
         IP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nR6p+azSrG4y2Tef6cprsCVi44IERGjpbRkmYO5cRCo=;
        b=nm9RZ5P9Z0gUkMVKaSkVHjsLLHcx0x6h8pSE1SkgMrKfstTc6Yhz3DXothlu1jcDWL
         TeomOryVsM3L0D5TqmpRPDi9p06Z0Bm9zA1hQWK1fSgWeP2LS+muxLa0QFZVwRmjCJGm
         Q1xxq4Y1eckWtpCdVMQ72AAKGPb0HoWjw8Z812PZ5P4Pn8iI/KXTKakAZMsU0p6Yl/2n
         I4T3Yh3vR3ZQTBmCr2j0rUCowyH2NVPHWsNEXr8xmfDxD4CTfa5sqLQxCUuU1m1GgFrH
         RI6WJ3LRUm8vfCkhnuYAV/mN25jXri2NhRrnqitS3e7moTMFZU/FLtHPRNqBV0VAs2qY
         sB5g==
X-Gm-Message-State: AOAM532qyBErueH0JLUdr/c3Z/YBLUMjlk/IOxO8ZNDFyHVA2em+t164
        8tRXwggUEdt9lRxKXOUpCkk=
X-Google-Smtp-Source: ABdhPJzzoRuSmi+2TOb+YGFPFJ3J09xwFNwGYghnAUhqbdTk5IO8ZOcSsIr6O8leoTNYiO6KUU/fDw==
X-Received: by 2002:a65:6093:: with SMTP id t19mr7822568pgu.13.1596730936624;
        Thu, 06 Aug 2020 09:22:16 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id e22sm7393556pgi.62.2020.08.06.09.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:22:16 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v1] staging: greybus: audio: fix uninitialized value issue
Date:   Thu,  6 Aug 2020 21:51:57 +0530
Message-Id: <a5d4bb540e606d7980d4127a82e6af9b436e0642.1596730667.git.vaibhav.sr@gmail.com>
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
 drivers/staging/greybus/audio_topology.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 2f9fdbdcd547..4b914d0edef2 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -456,6 +456,13 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	val = ucontrol->value.integer.value[0] & mask;
 	connect = !!val;
 
+	ret = gb_pm_runtime_get_sync(bundle);
+	if (ret)
+		return ret;
+
+	ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
+				      GB_AUDIO_INVALID_INDEX, &gbvalue);
+
 	/* update ucontrol */
 	if (gbvalue.value.integer_value[0] != val) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
@@ -466,16 +473,10 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gbvalue.value.integer_value[0] =
 			cpu_to_le32(ucontrol->value.integer.value[0]);
 
-		ret = gb_pm_runtime_get_sync(bundle);
-		if (ret)
-			return ret;
-
 		ret = gb_audio_gb_set_control(module->mgmt_connection,
 					      data->ctl_id,
 					      GB_AUDIO_INVALID_INDEX, &gbvalue);
 
-		gb_pm_runtime_put_autosuspend(bundle);
-
 		if (ret) {
 			dev_err_ratelimited(codec_dev,
 					    "%d:Error in %s for %s\n", ret,
@@ -483,6 +484,7 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 			return ret;
 		}
 	}
+	gb_pm_runtime_put_autosuspend(bundle);
 
 	return 0;
 }

base-commit: 5bbd90550da8f7bdac769b5825597e67183c9411
prerequisite-patch-id: 2b8901339222ff7b94f10cf2341734c0fb82591c
prerequisite-patch-id: 38dad8879a2b73bce6e89481973c7c5b82bd7145
prerequisite-patch-id: 5f0042ccedae292395ec617789be6bf465463c1c
prerequisite-patch-id: 35d001c366dfa4b567e59abbb37bd691a18f5e14
prerequisite-patch-id: f13ce918ebc3796cd3c81716a7b2adf4519e7387
prerequisite-patch-id: 0fcc6d38699a9b72ca94280d7a4dc18f0823b6f7
prerequisite-patch-id: 8074e935bdc3dd7b114245b0648552d0ff6871c9
-- 
2.27.0

