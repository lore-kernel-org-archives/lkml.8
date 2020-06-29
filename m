Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39971C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121AA206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTyujLIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbgF2Uyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgF2TNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:19 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DBC030F2B;
        Mon, 29 Jun 2020 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oWEN2HrEZzshPalh9h22/5jMAlzNjCxPZcOlTdfCeRk=; b=FTyujLINoEFwJfBDDiZffiOYsS
        BOZP0lNNqNQYgm81MQzrN1dTB2zSgzMXpMKBMzAKqBNSUZjhWXDFzD5ix5SK/nr78EDMCww3KCtYB
        FVZUrBmG/cFO4/WkHupIYCl2+9csBo+VKzxgGjSUHP5Hl7/tiAh/Rt6pXem1fYakk7QoB7Y5Lr0Bt
        0f3Aip0bm2DWmWmW+X3rbSponeDdqXM8GfhOQVcue2706h9IT/uj1yo/G4cNfkKlcYRcA9KnQnkvB
        ++WwoWBDi12ybggpNRY2O1AVJGlouzsl1v5yyiS/nOpk7i4e6bQDZlDQN+onRwDuINNv4lY0WR85S
        c8vgyHMw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpwsu-00016O-1q; Mon, 29 Jun 2020 16:43:56 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] <linux/of.h>: add stub for of_get_next_parent() to fix
 qcom build error
Message-ID: <ce0d7561-ff93-d267-b57a-6505014c728c@infradead.org>
Date:   Mon, 29 Jun 2020 09:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a (COMPILE_TEST) build error when CONFIG_OF is not set/enabled
by adding a stub for of_get_next_parent().

../drivers/soc/qcom/qcom-geni-se.c:819:11: error: implicit declaration of function 'of_get_next_parent'; did you mean 'of_get_parent'? [-Werror=implicit-function-declaration]
../drivers/soc/qcom/qcom-geni-se.c:819:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 include/linux/of.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20200629.orig/include/linux/of.h
+++ linux-next-20200629/include/linux/of.h
@@ -630,6 +630,11 @@ static inline struct device_node *of_get
 	return NULL;
 }
 
+static inline struct device_node *of_get_next_parent(struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_next_child(
 	const struct device_node *node, struct device_node *prev)
 {


