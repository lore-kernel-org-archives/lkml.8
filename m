Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291AAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41D12064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261449;
	bh=KRSfA+jnKhFwQqzGs3zFZ+9Ar3w5EbuRb+RO9Dsmcpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X19eCWojpxT0B5wq/6u0b4bT7eePMOBB0QTIou/OzhtcxjI8Go7lydR74uLxh8CBt
	 56cSB+6fjLaKE96/64WDkY1csoMY4Jhy3NZJiPsXRpSTSj+XL4Bit5uzzkxR/opGx6
	 Cm3/WRuQbq3AuRvrXdhgoDABFdruGouiCDYGmx9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgGTQKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbgGTQKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7649220684;
        Mon, 20 Jul 2020 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261445;
        bh=KRSfA+jnKhFwQqzGs3zFZ+9Ar3w5EbuRb+RO9Dsmcpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEHlGyYFVtR6sQia6c4NvFLnAnBVO4hyqlgBfF3AdCT6LJiWMZOk5Po0WbIox2LJy
         yMW5nVsiEgWMpVHPPjOwr4t/KivOItSEOxUCtOsgmF4cjFQiyFqhbXwIpXOQOFH3gD
         0hk3dtFFYIPZ6D5UgUmFGfk7QUQIptR/7e6AXx0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.7 119/244] soc: qcom: socinfo: add missing soc_id sysfs entry
Date:   Mon, 20 Jul 2020 17:36:30 +0200
Message-Id: <20200720152831.496783573@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 27a344139c186889d742764d3c2a62b395949cef upstream.

Looks like SoC ID is not exported to sysfs for some reason.
This patch adds it!

This is mostly used by userspace libraries like Snapdragon
Neural Processing Engine (SNPE) SDK for checking supported SoC info.

Fixes: efb448d0a3fc ("soc: qcom: Add socinfo driver")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200319121418.5180-1-srinivas.kandagatla@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/socinfo.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -430,6 +430,8 @@ static int qcom_socinfo_probe(struct pla
 	qs->attr.family = "Snapdragon";
 	qs->attr.machine = socinfo_machine(&pdev->dev,
 					   le32_to_cpu(info->id));
+	qs->attr.soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u",
+					 le32_to_cpu(info->id));
 	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
 					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
 					   SOCINFO_MINOR(le32_to_cpu(info->ver)));


