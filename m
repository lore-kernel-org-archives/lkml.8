Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A36AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95FD206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979031;
	bh=aXpEuyQ/p1Qd1rdpw+8abJdNj/g6K6GnX7Nll9ucIto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JWB82Nh03J6B7Ep/hbeYzipBJU3Ukbh2HyOhFvPDdplcLrndjoC6c37fE68YwxC2q
	 B+iAQ4c0PR2NTsXLLvy4/GFwi2WyzsZscVMdVECzCtoANngGmfCF67/fEuv7OgO3y7
	 qSCVvIU2F3eeh3yrDkBmUX12hFYgTA5y8hC33Fo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgIAQuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbgIAP0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC10120684;
        Tue,  1 Sep 2020 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973991;
        bh=aXpEuyQ/p1Qd1rdpw+8abJdNj/g6K6GnX7Nll9ucIto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8JTzfQPAnA3YCIUfAm4xKv0Zr6/VN7dfAqGD4EFbeOTbxLbZafoyf4NhNp1C/5uZ
         sk4n8OzFJ4pL6IDBkQYRI/U8agZNzepM55A0aeE9Dh6sT0KjZKm1wBYvs77vwWIkdB
         9EMjjCu1cTcWBHjEc5ucFpg4SgoPutNgcuzHf0f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Jun <jun.li@nxp.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 098/125] usb: host: xhci: fix ep context print mismatch in debugfs
Date:   Tue,  1 Sep 2020 17:10:53 +0200
Message-Id: <20200901150939.406034731@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

commit 0077b1b2c8d9ad5f7a08b62fb8524cdb9938388f upstream.

dci is 0 based and xhci_get_ep_ctx() will do ep index increment to get
the ep context.

[rename dci to ep_index -Mathias]
Cc: stable <stable@vger.kernel.org> # v4.15+
Fixes: 02b6fdc2a153 ("usb: xhci: Add debugfs interface for xHCI driver")
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200821091549.20556-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-debugfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -273,7 +273,7 @@ static int xhci_slot_context_show(struct
 
 static int xhci_endpoint_context_show(struct seq_file *s, void *unused)
 {
-	int			dci;
+	int			ep_index;
 	dma_addr_t		dma;
 	struct xhci_hcd		*xhci;
 	struct xhci_ep_ctx	*ep_ctx;
@@ -282,9 +282,9 @@ static int xhci_endpoint_context_show(st
 
 	xhci = hcd_to_xhci(bus_to_hcd(dev->udev->bus));
 
-	for (dci = 1; dci < 32; dci++) {
-		ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, dci);
-		dma = dev->out_ctx->dma + dci * CTX_SIZE(xhci->hcc_params);
+	for (ep_index = 0; ep_index < 31; ep_index++) {
+		ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, ep_index);
+		dma = dev->out_ctx->dma + (ep_index + 1) * CTX_SIZE(xhci->hcc_params);
 		seq_printf(s, "%pad: %s\n", &dma,
 			   xhci_decode_ep_context(le32_to_cpu(ep_ctx->ep_info),
 						  le32_to_cpu(ep_ctx->ep_info2),


