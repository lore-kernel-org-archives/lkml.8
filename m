Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4AC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B884F2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RT8Ou6ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBZNIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:08:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37190 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgBZNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:08:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QD8KRu097208;
        Wed, 26 Feb 2020 07:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582722500;
        bh=U2/8MofG7oIU/EBLKqUbVXsN2VlldAOoMRTLHW4tTgg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RT8Ou6ueGxFz9OE7DoSdeK399eoXe1tRq3NGVKavsPyI6d4WOEXY241aCe91/vpUi
         3IHitAzsi0Ya5q3YZEEs+7Vpyea+bRwABZo1fKli1w2B8DgyTO27Zu8OHXBbnAYyAf
         kp/dwk9YmImgD5HvKrVyDxsl0NIm7u3voWMwzxjI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QD8KKF021752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 07:08:20 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 07:08:20 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 07:08:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01QD8JJN121280;
        Wed, 26 Feb 2020 07:08:20 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH for-next 3/3] ASoC: tas2562: Fix sample rate error message
Date:   Wed, 26 Feb 2020 07:03:05 -0600
Message-ID: <20200226130305.12043-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226130305.12043-1-dmurphy@ti.com>
References: <20200226130305.12043-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error message for setting the sample rate.  It says bitwidth but
should say sample rate.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 79c3c3d79766..6b7f7a18da36 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -276,7 +276,7 @@ static int tas2562_hw_params(struct snd_pcm_substream *substream,
 
 	ret = tas2562_set_samplerate(tas2562, params_rate(params));
 	if (ret)
-		dev_err(tas2562->dev, "set bitwidth failed, %d\n", ret);
+		dev_err(tas2562->dev, "set sample rate failed, %d\n", ret);
 
 	return ret;
 }
-- 
2.25.0

