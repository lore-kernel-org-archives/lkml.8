Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648342072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218223;
	bh=7B1EOlLDludjXlLZ7//cLe91s76Yky9irgWvaNKzMdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kw6IhmUTbXDi0tKTPibI3MThKQOefCsBr+wQAsNWuDyAswGTXpwcGSRszfnntlIrV
	 Emr7ltfmLvaipz5Sl8rXmhIcpV2peXUSLPyOWUkbG47Y2bG6cq4jqkCzQqTmVmG87C
	 IAlRYpn5yZss1Po+f6GEHeCOKyDqd3RjJ28R8i10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbgAPXnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbgAPXYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CB12072B;
        Thu, 16 Jan 2020 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217091;
        bh=7B1EOlLDludjXlLZ7//cLe91s76Yky9irgWvaNKzMdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIwNsO4DG21UyhT05hzclJus9yuhx+WDvnYRt5c+IU034iZKOjoj+Jwq3QZSC2+5D
         jMQ1DUDSTh5QG+ws8cNGgtFYOYrgtrBzEcjlwOXIT9XuQjn0ccfnxCv9efP7LaDriY
         xYnETEJzKajP26R7/SqbEpYG0BTOLPCc+j7glvvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 5.4 128/203] arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD
Date:   Fri, 17 Jan 2020 00:17:25 +0100
Message-Id: <20200116231756.383426794@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

commit e38161bd325ea541ef2f258d8e28281077dde524 upstream.

In the same way as for msm8974-hammerhead, l21 load, used for SDCARD
VMMC, needs to be increased in order to prevent any voltage drop issues
(due to limited current) happening with some SDCARDS or during specific
operations (e.g. write).

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: 660a9763c6a9 (arm64: dts: qcom: db820c: Add pm8994 regulator node)
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -623,6 +623,8 @@
 				l21 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
+					regulator-allow-set-load;
+					regulator-system-load = <200000>;
 				};
 				l22 {
 					regulator-min-microvolt = <3300000>;


