Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BD520639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcFFmKUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgHNHhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgHNHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:37:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4EC061757
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:37:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so4129550pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qQEvmAR62GYDUGcjtyyYwaSTs1R61v49x6rNj3a0A0=;
        b=bcFFmKUSlDpsEhOY4HztU6IuqIVSzxrXNgQXU5P9AJhsl9xyZjEhPbBKHwuBM7Q6C7
         akmedoqKlKV9XzzQ9CGQNcK/DmrneFbqVnuz9Hf6lH1WpUcwcntKPVuc3iJ5MgOqnlDr
         urCZULAr++iAxadve83tWeD7h6jQ83VZJkEmRSzq0NfVL4lyOiU8Qr/puO0LUxGMwq3H
         nN7AROI++0GTVuPzO5E5fcZ3meHLsK4bk4i7Q8tGc/9ht/Q9PfyYWphlVyxePuBfFmDz
         0MjPFpmN2vI1T0urWqqKlJuUzWHrrPRZws262AvMUu+RIVbNZmusVWr3O5hcqU6tT7Pc
         +sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qQEvmAR62GYDUGcjtyyYwaSTs1R61v49x6rNj3a0A0=;
        b=WR62CWXj+dVtgihC0q7F8IaC0iG4dkKD1CZFp+M/D9+MzN8V7iPTenHS/q1dh236Fx
         p2H9n1pE2RyWlnIAEhhP7b3thyAJTN4HLi6o6L8tMSn93bT8scsELj+grw4OCtaHkbG+
         3yH9Mi9WZiwsihAHmDW0l+u+nmKJE0QHYIB2gkAy0v5ug5jBxpzuVxB+h0ehjTRqcvb9
         6BKTMr3I4O55lYvIK0Ik3cmNOelrt1dPpduC63JF8WKZva2dEuiLCrX70JM3o/6Y5jM8
         9w2FSwqBt3/JkcOR/si2btGHXNCGXkE29fUVAoRaFqn6E9OZ0Qt6mv7s0lgt9GmbFAw9
         hyuA==
X-Gm-Message-State: AOAM531TQX+8mtx8L0rGbAjla0nQ3a3ui+TF75d1b/mf/UsCShMRMZIl
        Y+P3kB9ZiUvfqVXQH9TuVrM=
X-Google-Smtp-Source: ABdhPJwuJtg7q6zWnIWfRPGEDNZWdUlEd2nFd7+Lyqi7y7Ey08MdAi3nWt7PpbhOTaFlsZciLqao2w==
X-Received: by 2002:a63:5623:: with SMTP id k35mr1013550pgb.325.1597390657484;
        Fri, 14 Aug 2020 00:37:37 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id s64sm8473629pfs.111.2020.08.14.00.37.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 00:37:36 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v2] staging: greybus: audio: fix uninitialized value issue
Date:   Fri, 14 Aug 2020 13:07:20 +0530
Message-Id: <b6a5c28b6812232c90426f77cbe60600f9a91019.1597389343.git.vaibhav.sr@gmail.com>
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
---
 drivers/staging/greybus/audio_topology.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 2f9fdbdcd547..9f98691b2f5f 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -456,6 +456,18 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	val = ucontrol->value.integer.value[0] & mask;
 	connect = !!val;
 
+	ret = gb_pm_runtime_get_sync(bundle);
+	if (ret)
+		return ret;
+
+	ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
+				      GB_AUDIO_INVALID_INDEX, &gbvalue);
+	if (ret) {
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
+				    __func__, kcontrol->id.name);
+		return ret;
+	}
+
 	/* update ucontrol */
 	if (gbvalue.value.integer_value[0] != val) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
@@ -466,16 +478,10 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
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
@@ -483,6 +489,7 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 			return ret;
 		}
 	}
+	gb_pm_runtime_put_autosuspend(bundle);
 
 	return 0;
 }

base-commit: fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
-- 
2.27.0

