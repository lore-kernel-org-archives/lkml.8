Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56AEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F391207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Csp8fRs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgFMX1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:27:21 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34058 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgFMX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:27:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ktzW6F5Qz9vKYB
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oQWzOnbGUapX for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:27:19 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ktzW4TYvz9vKYH
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:27:19 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ktzW4TYvz9vKYH
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ktzW4TYvz9vKYH
Received: by mail-io1-f69.google.com with SMTP id d20so8742178iom.16
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MpamanQ4MpDumyihZoEEj0ayN/iNuyeJtVs/CuktPVA=;
        b=Csp8fRs7Uy+StTI+645mbkSC0XK86N68GqBqTuxWDPZaAXjTNTcW+33Yu5pnbzsUst
         2zAfG8qr16PkqUFCE5wUUSBarQFwevUXvqBNc/dEEzheHfbRxAL5wDsL6R+0fneX9z9v
         5kYteIDPnpYvILOAW9D8B+I39r+Zr+FmAiN6sI/hicPLn9k30kd54geM9NkMxnaSml9j
         5/VkPJxfcp23M59MYVMbyf9D6H0RbvUWb+olfVFljhjPD/hYLzLftYL3k3m8ahDNL2Nv
         z7hP8f3jLX4RgmHoIgpHcE8P22bCZBNuz1te4NQamwJRcRk0+DPO1ZqHouH/OfmdkRVA
         8Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MpamanQ4MpDumyihZoEEj0ayN/iNuyeJtVs/CuktPVA=;
        b=VjdDUKpAl56PJXj4HDGBysZGAmmqjMJ/nlq2ISsp6BWap/IdtQEx1dWbFsTuFC1tEC
         TWWIjwNGIzMTSSC1FO89HV3qTrVzFdmZ3O0GTTJO1F84ooJYwcPG2mponOs5+ZtqrwmA
         10bNVPkgMnj7TbXKP/4E60oip3X8jTSU97sb4p10ptjSEz/OtKLcptTcP+7e+jDAav2b
         386Ok/xscGwPrTFLxsim5+0UAlputC3tBZnDB6EtAvXiOLz8sqpz/c890RTNld0GZ0/P
         Nc6JxO0gjpkrGYise/h4Dj9rH5QIdwgVfu3Hjuw0eY7CIdtHeQwgzcqPrREP3zkFGhR2
         TMzQ==
X-Gm-Message-State: AOAM530hx9+9KDQflg6tWBrm7VO8FrBFZHyyqt8y+8IJ1H8g0t+qGr+W
        UuPwkinGqE8izBxwy8EfUK8hVmYgXcOMXhOo3i5Ieg5FYTDco4hdnIL4+/YInWyrXFjv436bAcn
        /VJxAqc+Y3YOwonBmQ++W8o4Y56Fm
X-Received: by 2002:a92:2515:: with SMTP id l21mr19014212ill.64.1592090839134;
        Sat, 13 Jun 2020 16:27:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMEDlkkWxdPrIuB4rfOhbAimbKN1+ipCveYxCE39nD1rekM86PtxYYKuvjgZnzaG6VylvRuQ==
X-Received: by 2002:a92:2515:: with SMTP id l21mr19014197ill.64.1592090838889;
        Sat, 13 Jun 2020 16:27:18 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id a10sm5441544ilb.31.2020.06.13.16.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:27:18 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:27:12 -0500
Message-Id: <20200613232713.19174-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
PM runtime put is not called in error handling paths.
Thus call pm_runtime_put_sync() if pm_runtime_get_sync() fails.

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 008afb85023b..3c5b9082ad72 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -176,8 +176,10 @@ static int csiphy_set_power(struct v4l2_subdev *sd, int on)
 		int ret;
 
 		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_sync(dev);
 			return ret;
+		}
 
 		ret = csiphy_set_clock_rates(csiphy);
 		if (ret < 0) {
-- 
2.17.1

