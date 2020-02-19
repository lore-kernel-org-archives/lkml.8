Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAABC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2895A2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HCU0L7yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSJWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:22:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBSJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:22:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so27262575wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kseu72RlmoHjw0Ds52fvPmAht9fKcAm4Amcp4sUWzMQ=;
        b=HCU0L7yAvvvBNWJayyd7FYZeBYqdwM7Zf8WQ+NXdSnzvuO3j2rUxNdyyGCJkLFwhJN
         RJzLgIxfUeYzq8PjE1mPp1736eObAvyPM/SV9+m4UPeqCwIEJf7wuxFKmVNwXDY8QIn+
         rDuhD57rBSGAKQ2uF15NB9PmtVX/OYx+7SBrW4R1w8OtazouaNhGJhvWm34dhfei863G
         R49ia2NwPlIEzy5zwUSwPhHGkYWvvBsBCBH3kezDI0b2JdJ/UJz7yGvljfyUXKsoHX6C
         JNwRSpFQW2+0sFK67QK9EMSpMG2ius3kd2co7FlYju8N2KNbqjRNW7QzsMTJK69Dkqhk
         YI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kseu72RlmoHjw0Ds52fvPmAht9fKcAm4Amcp4sUWzMQ=;
        b=aYcTfh4LdEjQ7eaKEX0/elqirkt+swbs4CFsNTillVqsZhaVDxd1NX5xOhRJ5HdvMC
         1yRH1VfVuW92ftDvbI961U2N3DAtUNQUfENY2DGQBn35Fo0jeweXIKDTVeBmEUKvMNwj
         +0vjfar2J1pYQdg8HvSmUO/oomUJNemsL79lPDwdJccDyyvBhxoawWGeWQk9KGbwA3Nk
         W+rAxEaaDbmoWw0onrpi9hzsYkjBENNTDqakC9mrKeyy3nLdRvILysQZA6d7kcSbxN0m
         ByTLJoYoM7KnDyClSjiWx3RzIYLpMikUp4MpaayhDY8HLfWE43BE8ibo6TIP04LHejQp
         /KmQ==
X-Gm-Message-State: APjAAAV2DFilcKQ8nRJ2urLnPQqr9cOGKF+nS1yLi4ZohtDKHMT+Eheh
        2OnBkrH4CFHfvNWqYKSrCfLOuA==
X-Google-Smtp-Source: APXvYqz956puqcBVPbs9NYq+NZ78vLaaJccYXy+tQ4MMwlUCIqIZuO5pVR5NZzAU8Vap8m9jpsxeDA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr33087616wro.28.1582104148131;
        Wed, 19 Feb 2020 01:22:28 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id s65sm2172296wmf.48.2020.02.19.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 01:22:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 6/7] nvmem: add a newline for readability
Date:   Wed, 19 Feb 2020 10:22:17 +0100
Message-Id: <20200219092218.18143-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219092218.18143-1-brgl@bgdev.pl>
References: <20200219092218.18143-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Visibly separate the GPIO request from the previous operation in the
code with a newline.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bbdf2fe076b9..40fe5913c264 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -348,6 +348,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		kfree(nvmem);
 		return ERR_PTR(rval);
 	}
+
 	if (config->wp_gpio)
 		nvmem->wp_gpio = gpiod_ref(config->wp_gpio);
 	else
-- 
2.25.0

