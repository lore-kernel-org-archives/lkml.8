Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD3BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0E720714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glY6/t/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgFOSYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:24:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6CDC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so525510wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vagjLM85limRbxyXyVHX0TSnNF9zsB7X2Y8Y4Et4BOY=;
        b=glY6/t/WwLElMv/oEVgGFjkQY7EvIKntyrCHuL1JbyLbIAajX+1XZftFhfF9gQ0FWV
         ZwfWtgfKYnyGj5Nn0WxgwpUK300o+wuvLqFVxeug9l8M/FIi9sax9N2blHv3AyBzxBTW
         VAnJbYklre93FZPdD4vQBsbGOroHtJEUhkWvL/zVityy/R+0QM6s9MtRP54MtMlntdMA
         ymW4Vkvf9cF/8jvn8nka0cAiLXq0YtHrN2VjdbiDGMpvtf7s4cFt64fbkGn7xHsxgIi4
         Mawo2ZSXxVYsmJNj1eWJKRBsQD3hiaviqfWYtHG/Je5Qosx1A1gTjL0mK6Ki8rQ8aQXR
         NswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vagjLM85limRbxyXyVHX0TSnNF9zsB7X2Y8Y4Et4BOY=;
        b=WCjzV+DfT4FTN6/I4HHge3yjEuzC/Qp361/tK2sLvEJLp2zIXcvDmIbC4TlVzxB9Cz
         vvQx3parLEbKUrARsZOFRCJKLUVlpr/siDQWc+0rOSGOpR+f4mEEdAMpD3yg6ZSQe7mL
         pcm6JrYHGIi8qM0XXMwZQoh2QS3nFiy/mCXvtCcJxdTSR4YoM21MKVDY0ABoVgrcEA9x
         c4Hm8IUQsDpZsj/F4+GNbdSXFr761vA3FSFiHv2mUxx8FakGst1J7RCf66m810NBtqiR
         +X0X+YO+eMoBjNonSK+dRwA1Z97KZV4WQ3XA6Pl+2aV5Ic5m/2aqgzK4c2vtq7nSL4md
         RJLw==
X-Gm-Message-State: AOAM531O5K8DbDpq0UWlp4rzwHz9wVJYkeJjbdwUHlmjnhYVdlDnEp5p
        c+hUBdzdRJ24gLMX2iR6gU7cCw==
X-Google-Smtp-Source: ABdhPJxbPq6bAw7rakKqM0BnaYizUh9HT1mRAHuJQR96x2qsa7ay6oODpuughSKUURyOJ6tbpgj04Q==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr605435wmm.189.1592245454105;
        Mon, 15 Jun 2020 11:24:14 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id g25sm481988wmh.18.2020.06.15.11.24.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 11:24:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     svarbanov@mm-sol.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, sanm@codeaurora.org,
        mgautam@codeaurora.org, agross@kernel.org, bhelgaas@google.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] PCI: qcom: Disable power management for uPD720201 USB3 controller
Date:   Mon, 15 Jun 2020 21:24:13 +0300
Message-Id: <20200615182413.15649-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uPD720201 USB3 host controller (connected to PCIe) on the Dragonboard
845c is often failing during suspend and resume. The following messages
are seen over the console:

  PM: suspend entry (s2idle)
  Filesystems sync: 0.000 seconds
  Freezing user space processes ... (elapsed 0.001 seconds) done.
  OOM killer disabled.
  Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
  printk: Suspending console(s) (use no_console_suspend to debug)
  dwc3-qcom a8f8800.usb: HS-PHY not in L2
  dwc3-qcom a6f8800.usb: HS-PHY not in L2
  xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
  space inaccessible)
  xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
  space inaccessible)
  xhci_hcd 0000:01:00.0: Controller not ready at resume -19
  xhci_hcd 0000:01:00.0: PCI post-resume error -19!
  xhci_hcd 0000:01:00.0: HC died; cleaning up

Then the USB devices are not functional anymore. Let's disable the PM of
the controller for now, as this will at least keep USB devices working
even after suspend and resume.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..c1f502682a19 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1439,6 +1439,13 @@ static void qcom_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
+
+static void qcom_fixup_nopm(struct pci_dev *dev)
+{
+	dev->pm_cap = 0;
+	dev_info(&dev->dev, "Disabling PCI power management\n");
+}
+
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
@@ -1446,6 +1453,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, qcom_fixup_nopm);
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
