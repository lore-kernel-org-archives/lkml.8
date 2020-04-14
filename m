Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0ACC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD60E20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883211;
	bh=658cnA0OH8PrC9rMq5PcQSeNmaQyFTHpSbZA4mdADg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7vx+eSQb7VBQGn0isjY8ji2XZCnlJ/EkbjB68SJWYzjWirRmQHaR35Af9lzsOnP1
	 TA/m5yh5vwbJKQF0ujGTG09wMHToWFi7SwynUS2TbT2Z52XRxGmCuRxXDFLv1Cjvnn
	 Z9z1X2rnrOqTP1ZLGz6UGjZXnNQ5pHiaZQ3M1szw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440745AbgDNQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440351AbgDNQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DECF221F4;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=658cnA0OH8PrC9rMq5PcQSeNmaQyFTHpSbZA4mdADg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ux/LpB9HRjt1xIte5Atu+RnAYwahLq2Sibfe1MBEvPLGL93Nb1Q63sdUZNiDkEoDC
         2aTaBwiF1tH66Eptx18/xqJ9N+Ejp+SXuz1hPdOi2Pbi7tx2H9tqJfQWFwO3L6S1RO
         WbzWZliACcPzPAG0YXJv13oykko96U8fhdf+waCs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068n8-Eb; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 28/33] docs: dt: rockchip,dwc3.txt: fix a pointer to a renamed file
Date:   Tue, 14 Apr 2020 18:48:54 +0200
Message-Id: <287bd271f5c542e9d12a132a6b6a17672c9fd67c.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy-rockchip-inno-usb2.txt was converted to yaml.

Fix the corresponding reference.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
index c8c4b00ecb94..94520493233b 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
@@ -16,7 +16,7 @@ A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
 Phy documentation is provided in the following places:
-Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt - USB2.0 PHY
+Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml - USB2.0 PHY
 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     - Type-C PHY
 
 Example device nodes:
-- 
2.25.2

