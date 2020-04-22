Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E14C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E8520780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549732;
	bh=xS2qjSIVlgxZaq79xMVbraTGF6inSfpcUVhPZC/G+uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1csb/T3iBVSBzNli46axrmh90MgYCiAAXOSBC2oD2P9EecBkYMOQWOvJY4aIdq6BQ
	 KEXWFLqHSuDuY07G2zvj3QywQgfdGhmCcQfNU6G1ifWNqESdW/ZCTx9jsuIlpbI9LQ
	 jCn2k85GuxU3Dv+R4wZ+mn9u4hgFyxikj2f9Yp78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDVKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgDVKCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767032076C;
        Wed, 22 Apr 2020 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549727;
        bh=xS2qjSIVlgxZaq79xMVbraTGF6inSfpcUVhPZC/G+uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cANmiraU+XYfNHZfuX5JokDXKQ7+U8JiIz5Jq8yuAWOa/o9WxRCCE34+Y8DKFRtJf
         MfGohxlHoAMODr2iOyEEO3MfUnUHADomJVgI6xvBUGpZgDjee03Zbrdp75qp0NPdmJ
         xg7GawFfw3XSouY29j2XHO3I6g6SfkqUXdo6h9/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 082/100] of: fix missing kobject init for !SYSFS && OF_DYNAMIC config
Date:   Wed, 22 Apr 2020 11:56:52 +0200
Message-Id: <20200422095037.805280812@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit bd82bbf38cbe27f2c65660da801900d71bcc5cc8 ]

The ref counting is broken for OF_DYNAMIC when sysfs is disabled because
the kobject initialization is skipped. Only the properties
add/remove/update should be skipped for !SYSFS config.

Tested-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/base.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -167,9 +167,6 @@ int __of_attach_node_sysfs(struct device
 	struct property *pp;
 	int rc;
 
-	if (!IS_ENABLED(CONFIG_SYSFS))
-		return 0;
-
 	if (!of_kset)
 		return 0;
 


