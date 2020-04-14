Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE3C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BB120678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883005;
	bh=ZPSVcP5kqhLVox5r53x2+oMdFzo1HtLR9szo3WYjEf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v+b3pRb1+AgtA+jGoPsNVdPihSqw2B6qlsCbBQRDKTbDwIxMM6bqF/k+5MEgoB9D0
	 T8iVkKk5Kzh+uBZfUD1YW8EbddiARBGEFpK4zWUjtKCXYvsf5yQkrx/IzYg9zFEPx+
	 9s+ZrylOJQE3zKJkt/nzLEEsgfqx3+tVIw1CGFOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440545AbgDNQuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440335AbgDNQtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E9321D92;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=ZPSVcP5kqhLVox5r53x2+oMdFzo1HtLR9szo3WYjEf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxxoDouEddUGCNG+T2+RJ5rLqxo4V6RdUzhonbAc6cy9pwtJJHgiikZGIHQXvUHrB
         qXKzEaiMeDJfYJNkOZR3PLrc8+3u9Cc+d0nVO3aWAfDr8rQ/2j1W0AftIkHlxMng8M
         DhzgW6El+XUbQu9fPGERnjDFILRD1Ycy+9SvYWzI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068mk-Ac; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 23/33] docs: dt: qcom,dwc3.txt: fix cross-reference for a converted file
Date:   Tue, 14 Apr 2020 18:48:49 +0200
Message-Id: <a055c564f2a79aa748064329d938db8b3c8edd58.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom-qusb2-phy.txt file was converted and renamed to yaml.
Update cross-reference accordingly.

Fixes: 8ce65d8d38df ("dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings to yaml")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
index cb695aa3fba4..fbdd01756752 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
@@ -52,8 +52,8 @@ A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
 Phy documentation is provided in the following places:
-Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
-Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY
+Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt    - USB3 QMP PHY
+Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml - USB2 QUSB2 PHY
 
 Example device nodes:
 
-- 
2.25.2

