Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25CAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDD224694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845398;
	bh=E4+jEyMYuhjupVCxdPlkRRITjFRu6tw0fqfShzaavM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xt8BFNJ8K2fONp+fDm1EP9zUyJwe+7VMcZFkh3CCRYoGC3swQBhM9ti4GuPuXphav
	 DgdYeLuiC1MpBFl5COf600qDKB+kDXNrbMGWpEnZd2NptaW00LvBU70UvvObUV5Ebp
	 yf3MsIbzgTsKUfr4NotOUHsgfDtPV9ukmNHLOXDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgCJNDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbgCJNDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAED424696;
        Tue, 10 Mar 2020 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845392;
        bh=E4+jEyMYuhjupVCxdPlkRRITjFRu6tw0fqfShzaavM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWQnH7Ao0HhAanbj2kk/XrS21QnA+Z8FxWQz6ltPJZAi6pe4mdQ8GrvuDIkHujSn4
         craoVDGkq9L/jZl3qPB2SpkZRl4MdneaA+noLJiLDHOAUXUvMPntbEIbwc92Tbolus
         WJcT05ZSdSLV7xtpOX+U0jZQkWfGL1HqaOkvsdyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 167/189] regulator: qcom_spmi: Fix docs for PM8004
Date:   Tue, 10 Mar 2020 13:40:04 +0100
Message-Id: <20200310123656.833249838@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

commit a5b0cda136f4f420a8e24e50d19dfcef2f81df2e upstream.

Fixes: 2e36e140b8b8 ("regulator: qcom_spmi: Add support for PM8004 regulators")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Link: https://lore.kernel.org/r/20200127231439.3562452-1-petr.vorel@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -161,7 +161,7 @@ The regulator node houses sub-nodes for
 sub-node is identified using the node's name, with valid values listed for each
 of the PMICs below.
 
-pm8005:
+pm8004:
 	s2, s5
 
 pm8005:


