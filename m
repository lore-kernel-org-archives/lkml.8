Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25373C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E049E21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216853;
	bh=jEXdECnlLIefFpJVIEX2EHoI2AjLb9ng3RN7Y22in+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1LtWzFAQ7EEjW8cn1XPH1jU4ILqwHzU9dYkVNNeCGYKCLMavKiXxchvUlj8g74hg
	 Fqu+GkkIkGC20e6W4c3IFDgMiYGdnm/Q5XnOxaz8FZYXJls2YQg17Y8AfcrQmunhpW
	 LZmyJSivmiXcITgTTMGfu0en0vEjarZXgvA9NhsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgAPXUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390695AbgAPXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A28F2075B;
        Thu, 16 Jan 2020 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216845;
        bh=jEXdECnlLIefFpJVIEX2EHoI2AjLb9ng3RN7Y22in+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T411LFzbkqF6V44vXk1kRSBlLkF228hTxHygFx6kHOceEjFqT7zNX5wA7PWAw/GAg
         k0Se5upStPs0HZkDk5zHreGUfNQjMYFcUrG5m4xJ/ftXPS6qgY58pMZ+vVZXrrySpv
         p7DRcuUwUBudyFtL+VH/SUnNjEPRD5TJJX+iIPFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 5.4 043/203] dt-bindings: reset: Fix brcmstb-reset example
Date:   Fri, 17 Jan 2020 00:16:00 +0100
Message-Id: <20200116231747.776520697@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>

commit 392a9f63058f2cdcec8363b849a25532ee40da9f upstream.

The reset controller has a #reset-cells value of 1, so we should see a
phandle plus a register identifier, fix the example.

Fixes: 0807caf647dd ("dt-bindings: reset: Add document for Broadcom STB reset controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
@@ -22,6 +22,6 @@ Example:
 	};
 
 	&ethernet_switch {
-		resets = <&reset>;
+		resets = <&reset 26>;
 		reset-names = "switch";
 	};


