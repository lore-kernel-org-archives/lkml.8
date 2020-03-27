Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6347E20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B1wZOt6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgC0JmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:42:03 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36342 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgC0JmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:42:03 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 18BB64068F;
        Fri, 27 Mar 2020 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585302122; bh=5lvr85wmUB+ig2sjTf8GoiI7NOjmJtqmkcAiDXQQ+iE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=B1wZOt6pr1GmQZBOfYyL6GDT84QfA2uWCxy6qb5oiHj5dWC4VVSITpzUIz47GmbE6
         RNhcBq94gwBo7de+qS8l2YqD5NzZ2hQlRjxe3LaUZXXwhhPmWjwNyHX/1dF5g3dq6Z
         bq3oIFGNv/oJTMQQ6pBkDWK+wHFzfbmnBtM0OYscfMKoDOp2j/UQq2pOdtU2JCnxUD
         yCS7f+Mm73Ds+npbdbuKYNLPIJBl7onyH7S18AkRqP2PSS4dN9KCk7VUiZKmGpkIdO
         CoAukWT0VIbpsx4Sw/Ag611E1o0aoJ3G19F1aAht1W2YmMQzYlaLymxXiEV65ULe2l
         6MnBefEg3GaIw==
Received: from tejas-VirtualBox (joglekar-e7480.internal.synopsys.com [10.146.16.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 446CFA005B;
        Fri, 27 Mar 2020 09:41:58 +0000 (UTC)
Received: by tejas-VirtualBox (sSMTP sendmail emulation); Fri, 27 Mar 2020 15:11:56 +0530
Date:   Fri, 27 Mar 2020 15:11:56 +0530
Message-Id:
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
In-Reply-To: <cover.1585297723.git.joglekar@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Subject: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add snps,consolidate-sgl & consolidate-sgl
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     John Youn <John.Youn@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200327094156.nKO6qVohHZcNmBEhEglFxak_Pj27-KNL0lrDLrwiLpw@z>

This commit adds the documentation for consolidate-sgl, and
snps,consolidate-sgl property. These when set enables the quirk for
XHCI driver for consolidation of sg list into a temporary buffer when small
buffer sizes are scattered over the sg list not making up to MPS or total
transfer size within TRB cache size with Synopsys xHC.

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt     | 3 +++
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9ba735..292d1f7969e4 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -104,6 +104,9 @@ Optional properties:
 			this and tx-thr-num-pkt-prd to a valid, non-zero value
 			1-16 (DWC_usb31 programming guide section 1.2.3) to
 			enable periodic ESS TX threshold.
+ - snps,consolidate-sgl: enable sg list consolidation - host mode only. Set to use
+			SG buffers of at least MPS size by consolidating smaller SG
+			buffers list into a single buffer.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
  - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 3f378951d624..a90d853557ee 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -43,6 +43,9 @@ Optional properties:
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
   - phys : see usb-hcd.yaml in the current directory
+  - consolidate-sgl: indicate if you need to consolidate sg list into a
+    temporary buffer when small SG buffer sizes does not make upto MPS
+    size or total transfer size across the TRB cache size.
 
 additionally the properties from usb-hcd.yaml (in the current directory) are
 supported.
-- 
2.11.0

