Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A40C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6020656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v1FnAjRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCFTVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:21:30 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:30127 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgCFTV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:21:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583522488; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lEQA9127U2ljogKt5keVCJeVLcMsmwtUZX+veS1gAXA=; b=v1FnAjRBnu2fKleL0oC9lo/5/4zWEGe3CkJuDGt18vyyZJaKJJpTHfL0czGT4OHG+IHiZc36
 TWURgLYtZC+D02Dgf/+jqNicId8jHdOza5NzyWfe8dP8HXKOIZhMKNsTYkz/XnzA/N7csl5n
 w0tpmCRetIQfPQJj1py2AcTxsng=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e62a2b1.7fd114d10618-smtp-out-n03;
 Fri, 06 Mar 2020 19:21:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 852DBC433D2; Fri,  6 Mar 2020 19:21:21 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79C1AC43637;
        Fri,  6 Mar 2020 19:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79C1AC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 2/2] dt-bindings: remoteproc: Add documentation for SPSS remoteproc
Date:   Fri,  6 Mar 2020 11:21:07 -0800
Message-Id: <1583522467-3499-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583522467-3499-1-git-send-email-rishabhb@codeaurora.org>
References: <1583522467-3499-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Secure Subsystem remote processor
support in remoteproc framework. This describes all the resources
needed by SPSS to boot and handle crash and shutdown scenarios.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,spss.txt   | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt b/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
new file mode 100644
index 0000000..79d6258
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,spss.txt
@@ -0,0 +1,114 @@
+Qualcomm SPSS Peripheral Image Loader
+
+This document defines the binding for a component that loads and boots firmware
+on the Qualcomm Secure Peripheral Processor. This processor is booted in the
+bootloader stage and it attaches itself to linux later on in the boot process.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,sm8250-spss-pas"
+
+- reg:
+	Should contain an entry for each value in 'reg-names'. Each entry
+	have memory region's start address and size of the region.
+
+- reg-names:
+	Should contain strings with the following names each representing
+	a specific region in memory.
+	"sp2soc_irq_status", "sp2soc_irq_clr", "sp2soc_irq_mask", "rmb_err",
+	"rmb_err_spare2"
+
+- interrupts:
+	Should contain the generic interrupt assigned to remote processor.
+	The values should follow the interrupt-specifier format as dictated
+	by the 'interrupt-parent' node.
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the xo clock and optionally aggre2 clock to be
+		    held on behalf of the booting Hexagon core
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "xo" and optionally include "aggre2"
+
+- cx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulator to be held on behalf of the
+		    booting Hexagon core
+
+- px-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the px regulator to be held on behalf of the
+		    booting Hexagon core
+
+- memory-region:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the reserved-memory for the SPSS
+
+- qcom,spss-scsr-bits:
+	Usage: required
+	Value type: <array>
+	Definition: Bits that are set by remote processor in the irq status
+		    register region to represent different states during
+		    boot process
+
+= SUBNODES
+The spss node may have an subnode named either "smd-edge" or "glink-edge" that
+describes the communication edge, channels and devices related to the SPSS.
+See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for details on how
+to describe these.
+
+= EXAMPLE
+The following example describes the resources needed to boot the
+Secure Processor, as it is found on SM8250 boards.
+
+	spss {
+		compatible = "qcom,sm8250-spss-pil";
+		reg = <0x188101c 0x4>,
+                      <0x1881024 0x4>,
+                      <0x1881028 0x4>,
+                      <0x188103c 0x4>,
+                      <0x1882014 0x4>;
+                reg-names = "sp2soc_irq_status", "sp2soc_irq_clr",
+                            "sp2soc_irq_mask", "rmb_err", "rmb_err_spare2";
+                interrupts = <0 352 1>;
+
+                cx-supply = <&VDD_CX_LEVEL>;
+                cx-uV-uA = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
+                px-supply = <&VDD_MX_LEVEL>;
+                px-uV = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
+
+                clocks = <&clock_rpmh RPMH_CXO_CLK>;
+                clock-names = "xo";
+                qcom,proxy-clock-names = "xo";
+                status = "ok";
+
+                memory-region = <&pil_spss_mem>;
+                qcom,spss-scsr-bits = <24 25>;
+
+                glink-edge {
+                        qcom,remote-pid = <8>;
+                        transport = "spss";
+                        mboxes = <&sp_scsr 0>;
+                        mbox-names = "spss_spss";
+                        interrupt-parent = <&intsp>;
+                        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;
+
+                        reg = <0x1885008 0x8>,
+                              <0x1885010 0x4>;
+                        reg-names = "qcom,spss-addr",
+                                    "qcom,spss-size";
+
+                        label = "spss";
+                        qcom,glink-label = "spss";
+                };
+	};
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
