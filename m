Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F04207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 02:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQzS1Fs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFECrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 22:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFECrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:47:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13241C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 19:47:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so8671304iow.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2pmw9jtHBYThXBzZGschH55AoMSfqZm7enCX3fEW3qk=;
        b=cQzS1Fs+M2U5U2ajSWrbfxx1/7nnniK1lEgZNG5nxRETuQxoEdtchxKCfNsZQav5fy
         7jKjLP9QnPadDcERbNqSFMY+eMNTZC9Nr6ONaSI5Ogb9gfMwqGIVgqfS8ufUyBuNJmna
         NV/3w6SAovcJt9chzCmDcbvnhmBvhyJjMwAdPl7bCtS7dnKnhtQeeggEQrkQ8ZPWCiGP
         vvByLEJDYhn0iC6lyDupXEYiXlRg6VMwbQSOBBOXI0RGwM3SXeI/8PSdUGxNs19sMgM9
         AHUjl9EpV0x/RcqYqru81h3pXFDxHgFd/WtX786y6FrbG2rv93oixGl0Fm7wippduuC1
         9/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2pmw9jtHBYThXBzZGschH55AoMSfqZm7enCX3fEW3qk=;
        b=uJKHtn/TbVHH7xpLbgjN/Hqx4Ctnm9XFLW/bX6VAcsunPY9CFgr+BilGkgHZRX2G6d
         gXdYaJDSQlqz+wWFBBz/oNDP0LWvHH5LWGYxGi6at667kYpYHFS6ifX99YOn57PqFoSd
         HK1G2DS7Fd7UBp+v993pLJpQPGm3ze+7VXkSz6NZAfdPqTlMXTlU0P1T+Vtxg0JGE7ZC
         XfL9nMh8sN4YALVYk9ilfZbzPTLnEZ20/eNIZi+Jko6sqPNIPX4vNtMdpw45P8OoXEkw
         D4fPHNTvxjDNop9mGTF9XaKo2UArfr1Zj6vPlY5hqOIOYUIfcWxqY1Ds7qNcgn5gEJrI
         oUUw==
X-Gm-Message-State: AOAM531FMHXeRgplf1wUMnFa3TcLs/MGILlS7cJbVQ9EOg+Mu82GBk1C
        eNqAV4v3VgePmZbTd7Oa/8bYki92Yq4=
X-Google-Smtp-Source: ABdhPJwK545uMQwARoTM/irRMCqJT1zDzd4qDXXKlxsq6XmuRhUXvirALBcto6NdkxGxvmp1erMAdw==
X-Received: by 2002:a05:6602:2055:: with SMTP id z21mr6788768iod.60.1591325240395;
        Thu, 04 Jun 2020 19:47:20 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id l26sm2437601ild.59.2020.06.04.19.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 19:47:19 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] mfd: arizona: handle pm_runtime_get_sync failure case
Date:   Thu,  4 Jun 2020 21:47:13 -0500
Message-Id: <20200605024714.46178-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put_sync if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/mfd/arizona-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index f73cf76d1373..5b3191b6534a 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -46,8 +46,10 @@ int arizona_clk32k_enable(struct arizona *arizona)
 		switch (arizona->pdata.clk32k_src) {
 		case ARIZONA_32KZ_MCLK1:
 			ret = pm_runtime_get_sync(arizona->dev);
-			if (ret != 0)
+			if (ret != 0) {
+				pm_runtime_put_sync(arizona->dev);
 				goto err_ref;
+			}
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
 			if (ret != 0) {
 				pm_runtime_put_sync(arizona->dev);
-- 
2.17.1

