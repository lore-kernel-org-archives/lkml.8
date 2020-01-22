Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E8524694
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699527;
	bh=fCIJuCwbP3GeGUag2GXGI+Y0xJ8Y2Pe80IWo5Xlaxi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffCxT8oV/RWcWocYrAPfsio59MwNPZDwVQLBK62Z1jmvzxSPjZ1VylYhhEgCRcwzK
	 tiKs5ovuGYudiOec62bfwc/H1qd8WOD1lAftj79bTg3qd0xat6+zT4ZGt6293hQ8PJ
	 t4O6tr+lomxqA409dH8m9liqz0B7sWriL6BenBuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgAVNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbgAVNZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:24 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155F22467B;
        Wed, 22 Jan 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699522;
        bh=fCIJuCwbP3GeGUag2GXGI+Y0xJ8Y2Pe80IWo5Xlaxi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVkoyk6jfvqldGmYEi07Uw245tO7JB3pgL06bAxdqFwJkyxSCDK+F5y3LHvuuoJ3J
         rX3+bjwZ5Mqbe7Cl+KsGm9/puZDziHwUB/i6nzyFcdQFhV9+G4ZPy2mHZgu73DpM4O
         sIMi3d33kdBRI+dcdOYMUXx8BfZPYoY5eDWj/1LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 171/222] dt-bindings: Add missing properties keyword enclosing snps,tso
Date:   Wed, 22 Jan 2020 10:29:17 +0100
Message-Id: <20200122092845.950277758@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

commit dbce0b65046d1735d7054c54ec2387dba84ba258 upstream.

DT property definitions must be under a 'properties' keyword. This was
missing for 'snps,tso' in an if/then clause. A meta-schema fix will
catch future errors like this.

Fixes: 7db3545aef5f ("dt-bindings: net: stmmac: Convert the binding to a schemas")
Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -347,6 +347,7 @@ allOf:
               - st,spear600-gmac
 
     then:
+      properties:
         snps,tso:
           $ref: /schemas/types.yaml#definitions/flag
           description:


