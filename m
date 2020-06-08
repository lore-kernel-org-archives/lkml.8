Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAC420760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="TbEEcd0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFHUoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgFHUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23346C08C5C8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so18708532qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdQIVrxrcWgdEfMxOy8k0QA3bySSLO8hLrFtwiG/Nyg=;
        b=TbEEcd0epDDJxtIhsogl5/yVZrtqN8SILEvvnLZ04uF86KSRpPvl6jjeQ5Bs6pzHzZ
         5UFr1cbWg585VsBfEbgtnx25trM0iBAtoajfQf7SxJ0uNRyDzLxGyb7xdDwNpixUcQrm
         ogVx/qiWyyCfviUbwYRvXxLOFfwhEgNFigF5l4XH8xjImCG22+dhmbJFPyfWcomU5grl
         3rKuZ0VJlJbOoVufDpACJ1IqJ9lYJo8Nla5Mg1u5r82zlbljt7746AHKw+mWX5n7hLrm
         GerYChWxLd9wH/y9cIhGmE0c4nomibogPkmtXbbUJx6i4AJ1P/TNHdYIRvNVb3ENX92y
         LrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdQIVrxrcWgdEfMxOy8k0QA3bySSLO8hLrFtwiG/Nyg=;
        b=NP63kgL9XwIepov3EQMAQzwLUOXkL2VQ/wtrjtnjUkt6RIOA5LMspUZSFu4kjF0SUL
         z88RmVXodU+n6I9bl8BlkdUj49/DqfUmIlSsEZ9Hqup5nH/JgfqUtyY7SNMMm0RGEnyy
         VJQpGvYvEp589S9tugl1Hg47e8o9FjU6JPwzznk0cE/sfiS3fEn+9YoGSsxqweYT3bfd
         Eb+kmTMof6usOo42waXrNR0tnL9wyBk9U1p3ZEMB8jL0Kmn0ycl71cVyZdQTSo24KvR2
         ahPMsiNRsWyi4ndzoBU+Z8naiEsyHJzPUHfUfzwraO4gDhcS3cyJXTOVdHw8cOzlLhlr
         aL6g==
X-Gm-Message-State: AOAM533En0dSjZRHd5kRfr5srZrx1MTkjgL2ovXQRM424+M/+eeYrK9J
        cS/LrRLfwDfE5Qe7e2+An+S4QQ==
X-Google-Smtp-Source: ABdhPJzI8WbUQ4+5LY+YoO9q2MUZma7oEMCKrRsz1GX/pV0LBOaUljnGhawiLinbYjlLdD5jPvsB7Q==
X-Received: by 2002:a37:b14:: with SMTP id 20mr24490042qkl.401.1591649054370;
        Mon, 08 Jun 2020 13:44:14 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:14 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] soundwire: qcom: add v1.5.1 compatible
Date:   Mon,  8 Jun 2020 16:43:44 -0400
Message-Id: <20200608204347.19685-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
References: <20200608204347.19685-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for HW version v1.5.1 on sm8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 628747df1c75..14334442615f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -880,6 +880,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 
 static const struct of_device_id qcom_swrm_of_match[] = {
 	{ .compatible = "qcom,soundwire-v1.3.0", },
+	{ .compatible = "qcom,soundwire-v1.5.1", },
 	{/* sentinel */},
 };
 
-- 
2.26.1

