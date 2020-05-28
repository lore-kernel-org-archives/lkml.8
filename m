Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A168C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AEA208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fine7BNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgE1KU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbgE1KUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:20:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B2C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:20:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m1so7022407pgk.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4iqIqjqfcu2jYuHJ8gHDSAYpn6BV5cK7NWla5/OpCc=;
        b=fine7BNps1tLaqQpOkYNnOzDQ8/3ewTYSNJNWmUlgZB+nOK9oFRr6YO+6eNAYgefpj
         3toBPNdcodrpawwGpPOxJ/z7QtFW2O/syKMeDQ33u37dXb9HNvsJ4JdVhtqhlARAbems
         IP0PMiW9mI132tXfYZwvp2J1KqunBZ+zIewl6NoNpa6ltMsEgdwpBSNEj7U9rWm2ggqX
         +H5YPpSRz7ZT2uI6l8AJlBai98juS7J36UFJIX1NAwkWUTzrhFTv4eit7R0S1zfkhWgb
         QMPW7sCxJLGoelFNNXt4TdFb8eM/oWBAWa8tblL/cnU1h/zqN/meyLpK/M0FT3Xxeunl
         NgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4iqIqjqfcu2jYuHJ8gHDSAYpn6BV5cK7NWla5/OpCc=;
        b=aIbFe52l09QjQgANrBcceBkL5Fqd5XV8+MifcFaei1Z+fslCzsbezhqTrjuLXzeyJQ
         4MNEpJxi3DcsfQC9SgN1UE61fPiWI08etoUDWXsOzyBmX/B5hQXzD6Jhlud9jzKdZnrK
         nGeBLhoDwxftgNbH4DabsRuR5D8/+fO/rViIE3a4LtJmYDgvAP8nXzssD5joeIKLP29G
         L4cKtSpYsPlOIqloRpR/hGpyQVfORoClHHa/9K/BbUtAB2EaRcUNkSFBw74+9HftSNly
         upnbfIOPokgKiRG8y8uXTP0p4QGbBKc5VTcWYtIb9Vl6aKWwflmefg/JNxqjJpoeTvP2
         uFVQ==
X-Gm-Message-State: AOAM533DPpO7AHQneQ26Z4SR3MvrVzpovEL90QVbYF0ddZfbHoc5jW/r
        EmZDOIYanXObFiGn2/nSM5U=
X-Google-Smtp-Source: ABdhPJwZuzNh6gjiqrMSHdQWV+rwqRu9NqCxiEoWpsPOyQ89Kk024C4ub7WOXC3CrVTFr3XeFqJzFQ==
X-Received: by 2002:a63:d307:: with SMTP id b7mr2317587pgg.219.1590661214793;
        Thu, 28 May 2020 03:20:14 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id o201sm4643579pfd.115.2020.05.28.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:20:14 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: sta32x: add missed function calls in error paths
Date:   Thu, 28 May 2020 18:20:04 +0800
Message-Id: <20200528102004.911653-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sta32x_probe() forgets to call undo functions when it fails, add
the missed function calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/sta32x.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index db4b3ec55311..e9ccebbc31e4 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -893,13 +893,13 @@ static int sta32x_probe(struct snd_soc_component *component)
 				    sta32x->supplies);
 	if (ret != 0) {
 		dev_err(component->dev, "Failed to enable supplies: %d\n", ret);
-		return ret;
+		goto err_clk_disable_unprepare;
 	}
 
 	ret = sta32x_startup_sequence(sta32x);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to startup device\n");
-		return ret;
+		goto err_regulator_bulk_disable;
 	}
 
 	/* CONFA */
@@ -983,6 +983,13 @@ static int sta32x_probe(struct snd_soc_component *component)
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 
 	return 0;
+
+err_regulator_bulk_disable:
+	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
+err_clk_disable_unprepare:
+	if (sta32x->xti_clk)
+		clk_disable_unprepare(sta32x->xti_clk);
+	return ret;
 }
 
 static void sta32x_remove(struct snd_soc_component *component)
-- 
2.26.2

