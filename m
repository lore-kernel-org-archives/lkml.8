Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B2C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E3720848
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vFu1zH2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgALAQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:16:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbgALAQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 19:16:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so5206686wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/ZwSehH+63Wca8LW+bRhFH9IjAyR/Srx1YNfx4JoKc=;
        b=vFu1zH2Ow9/UtMn8FnIkbj8ye3ZG0bOu0Pf6UW3FtStq7LsxbfNrGKZexZ8gMh+R3w
         LIFytqdtv6aLFMhHeEMrc3wpr7jrdElrel5sEauFkNVjRiOfrYvXTw8u94Lj+OurjBdE
         +OfJby1/+M3z4Bp8z9LZAu6r8bTmnQPnIjvZo7ZZeipiwHJGdmNSgyLu8MW7mpmb+C2K
         BCWoY1HHgjKoR2IQ9afeWq0GbqEQWj+QiIN2BMh7MK8XyJl1gJqiMDAc8AqCo2c2d4X4
         h7wpI+lzeFs+ODa6SRFF1+RffGHidTfLvHQrdHfRWFJ/EnzEfTTrE7pAIiJ9u5jGekbg
         yf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/ZwSehH+63Wca8LW+bRhFH9IjAyR/Srx1YNfx4JoKc=;
        b=plgCIPQt5k0Bf+VpldhIFef31+JZsRscLrFpJAf8B06QHiHjwWltEnXmp4E2oiPYcZ
         yEB3YNI71WGqEMnnN1hZHSwil9VAMTqDRHmSDNV72bLNOPCzRUeDXRB1otWpKDpvT7zi
         6YjtZPv/qfsMRnBdLyNob2Jfm1b9f1NT/Vb0tdtySBcoHpX9rn6vRMSms+i43+3wZeIT
         Ku3gJNz+VPVDjkmIcJEBhdrZzuT6UzfVXTos2OMQD0/t9ln4e67uNOZvBj2gwkJKbV3V
         eWBUY0/RpGsssiXQXdJCsdwiEBDnD1n/zAIU6gwNfAVNdJf6HoejTBEDgXkV5u+JaZKB
         5+Qg==
X-Gm-Message-State: APjAAAVuiyiOBufhielUbBffcF1EV4gwXUMl7UWL3zP9pt+lDv4j74bC
        dK9EqdZrjGyXHx2AUsjWdqQ=
X-Google-Smtp-Source: APXvYqzhBnH1QtVtoGevRNkruEHHQpOM3dYTmLALFHsUQVXGJIlv0gbK5NlcKnKn5cWW9AvIFcCrJA==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr10672631wrp.186.1578788206180;
        Sat, 11 Jan 2020 16:16:46 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id h66sm8575535wme.41.2020.01.11.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:16:45 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v2 2/3] drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
Date:   Sun, 12 Jan 2020 01:16:22 +0100
Message-Id: <20200112001623.2121227-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
References: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devfreq_recommended_opp() fails we need to undo
dev_pm_opp_of_add_table() by calling dev_pm_opp_of_remove_table() (just
like we do it in the other error-path below).

Fixes: f3ba91228e8e91 ("drm/panfrost: Add initial panfrost driver")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 1471588763ce..170f6c8c9651 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,8 +93,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_pm_opp_of_remove_table(dev);
 		return PTR_ERR(opp);
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
-- 
2.24.1

