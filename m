Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972442063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759750;
	bh=pJ/+w4JUb9p/7brWKw3eaPnJiSGLDotbZnSUw8RPCQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXIznbL1JfrA6BXRi6/wqTqwXVvySZ33UxDUPRn+IufKnF2QiAI6ikqqc2ZFXVU5K
	 V9e4SXwbzxMQbvKICTy9OJ8sGGFl0s763DF0o3GYZSz/qaxe0Ln/ESCiA9eQCh90Bg
	 3b5sGB8gS6PmkYOi+rJB2fUa3CrKSPaZFQHzNB0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbgDAQoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388929AbgDAQoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4BC20658;
        Wed,  1 Apr 2020 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759447;
        bh=pJ/+w4JUb9p/7brWKw3eaPnJiSGLDotbZnSUw8RPCQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcfb1HVn8Jhc4dmD76q8bRkPhtPuz+l+h/J9gFIMObEH3TdajLjpYRuxjIhO7lalQ
         76HghaxF2wl0t88HWBCVHXM7zLsLUAckNi6OqhGn57XA8F06z53RbDYbXMq9Uy+pBq
         8bxFbAcYp/ABts55gzVuTxApgGpdVCnNf+0vKRMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 032/148] intel_th: pci: Add Elkhart Lake CPU support
Date:   Wed,  1 Apr 2020 18:17:04 +0200
Message-Id: <20200401161555.684596226@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit add492d2e9446a77ede9bb43699ec85ca8fc1aba upstream.

This adds support for the Trace Hub in Elkhart Lake CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200317062215.15598-7-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -219,6 +219,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Elkhart Lake CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4529),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Elkhart Lake */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4b26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


