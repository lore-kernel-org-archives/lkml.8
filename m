Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504322071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261931;
	bh=YyAY6cc7QTViLWyp9xxjMzcu4icKEU23qQoNGK7Dd/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DusRFe9CN5xrnwkp7nA+VCtihSfR8/KaZcKNcTzpIKwiQEEZe9NQco389NxdRKpYN
	 AsPI/Yw3FmK/e5kZ+/pFJpiQTvyaqbEeBI83K/WpUo2uJALTmtiTjtsMkrTY4H6wfS
	 BEykqS0dNQ3nTaxvqXs6ZGumc7dZ39+m32oKJk7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgHXJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgHXIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADD2204FD;
        Mon, 24 Aug 2020 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258825;
        bh=YyAY6cc7QTViLWyp9xxjMzcu4icKEU23qQoNGK7Dd/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj21cYnMjY/zly8e4TVNy2lIcdIRLAGaoBW+Lpj0H+qy3iCL99u27SQi4hUssAG50
         dLYnK9b3DeP3+CTo6zUf1tcuqwtvC23dVg/Abyf6bM9yXAUtPcQeLa4xCo74A7JdR/
         oXxwOMdGIC/Hgnor/ZYr2kIlm3CivxU49yOuLGoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/107] media: camss: fix memory leaks on error handling paths in probe
Date:   Mon, 24 Aug 2020 10:30:24 +0200
Message-Id: <20200824082407.993320333@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit f45882cfb152f5d3a421fd58f177f227e44843b9 ]

camss_probe() does not free camss on error handling paths. The patch
introduces an additional error label for this purpose. Besides, it
removes call of v4l2_async_notifier_cleanup() from
camss_of_parse_ports() since its caller, camss_probe(), cleans up all
its resources itself.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Co-developed-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 3fdc9f964a3c6..2483641799dfb 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -504,7 +504,6 @@ static int camss_of_parse_ports(struct camss *camss)
 	return num_subdevs;
 
 err_cleanup:
-	v4l2_async_notifier_cleanup(&camss->notifier);
 	of_node_put(node);
 	return ret;
 }
@@ -835,29 +834,38 @@ static int camss_probe(struct platform_device *pdev)
 		camss->csid_num = 4;
 		camss->vfe_num = 2;
 	} else {
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free;
 	}
 
 	camss->csiphy = devm_kcalloc(dev, camss->csiphy_num,
 				     sizeof(*camss->csiphy), GFP_KERNEL);
-	if (!camss->csiphy)
-		return -ENOMEM;
+	if (!camss->csiphy) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	camss->csid = devm_kcalloc(dev, camss->csid_num, sizeof(*camss->csid),
 				   GFP_KERNEL);
-	if (!camss->csid)
-		return -ENOMEM;
+	if (!camss->csid) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	camss->vfe = devm_kcalloc(dev, camss->vfe_num, sizeof(*camss->vfe),
 				  GFP_KERNEL);
-	if (!camss->vfe)
-		return -ENOMEM;
+	if (!camss->vfe) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
 
 	v4l2_async_notifier_init(&camss->notifier);
 
 	num_subdevs = camss_of_parse_ports(camss);
-	if (num_subdevs < 0)
-		return num_subdevs;
+	if (num_subdevs < 0) {
+		ret = num_subdevs;
+		goto err_cleanup;
+	}
 
 	ret = camss_init_subdevices(camss);
 	if (ret < 0)
@@ -936,6 +944,8 @@ err_register_entities:
 	v4l2_device_unregister(&camss->v4l2_dev);
 err_cleanup:
 	v4l2_async_notifier_cleanup(&camss->notifier);
+err_free:
+	kfree(camss);
 
 	return ret;
 }
-- 
2.25.1



