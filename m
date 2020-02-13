Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC75C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB1A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608435;
	bh=8o5e555fo6HVVk33P4Q8tLT7prYOfmlPR4EsrzZIo9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tZGAYAW6DOfW+ftPTjFr2bvqkqJckq4iePmYk+eCpy2920G4y5tcJ/+nFAe7R2OZ1
	 a/thPMGZTiSaj4AYhLaEXtL6D0i4+aG53rmP4dn+yYAuPWMqvuZdfkN6oSG07zSpXV
	 qVibB1NYhHUROzFnRiVVk/J5c6GXx35UMymuS8Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgBMPke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbgBMP2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:43 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C9824685;
        Thu, 13 Feb 2020 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607722;
        bh=8o5e555fo6HVVk33P4Q8tLT7prYOfmlPR4EsrzZIo9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOl02q+vgrPHXFl10J+sm8VIBOfCk9LQjegoiqntKi6jyCV4sZRCM2JYoHKxbPkSN
         g6Sg1x9LvbyqT7CVeEs2i3beLHwJUr6vWMPV0Z0VZqJRsZs7S9q8xBS/IM07mDKp/4
         GjqymTVrUN1zq40qnkITTkKy48epoJcGU+aNvixY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.5 067/120] soc: qcom: rpmhpd: Set active_only for active only power domains
Date:   Thu, 13 Feb 2020 07:21:03 -0800
Message-Id: <20200213151924.186987996@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit 5d0d4d42bed0090d3139e7c5ca1587d76d48add6 upstream.

The 'active_only' attribute was accidentally never set to true for any
power domains meaning that all the code handling this attribute was
dead.

NOTE that the RPM power domain code (as opposed to the RPMh one) gets
this right.

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20190214173633.211000-1-dianders@chromium.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rpmhpd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -93,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
 
 static struct rpmhpd sdm845_mx_ao = {
 	.pd = { .name = "mx_ao", },
+	.active_only = true,
 	.peer = &sdm845_mx,
 	.res_name = "mx.lvl",
 };
@@ -107,6 +108,7 @@ static struct rpmhpd sdm845_cx = {
 
 static struct rpmhpd sdm845_cx_ao = {
 	.pd = { .name = "cx_ao", },
+	.active_only = true,
 	.peer = &sdm845_cx,
 	.parent = &sdm845_mx_ao.pd,
 	.res_name = "cx.lvl",


