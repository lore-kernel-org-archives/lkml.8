Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442FDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055628;
	bh=c8Ossrdy1Yc5s1av6pvM1gV6hSja7f5RxRWIQRqnYt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/Et52biRSPW4qiNBBrtU4G+5v1y8YzSNjRuuf70cOBmoBqt3hD1Tu4NWupqnTCWR
	 UUNVUl29YG/QvhwyY/7EjD1LjHCjjbYp5y3OenG1Ft2hvFPVc1SF4ZUqcFY+BfitB/
	 Tm6nv73oTBgEKHqDYcFooBENedhaVntmaT5vvy3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgCXNNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgCXNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:13:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1653F208E4;
        Tue, 24 Mar 2020 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055623;
        bh=c8Ossrdy1Yc5s1av6pvM1gV6hSja7f5RxRWIQRqnYt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToVcoIw1JQWTHXXqifBbChQBIrwiz7wAdT5nAf39grcdELJGLAIlt35FADTJ+8fEh
         hsEr5CWMVzAQgWZj8JLMbf24H8TRAJB+1V15gx30hSyQEHYvTvlNJbqimPpMdd+vOs
         Ddl9Jk3SdKCgm76ZO/Uz9glnFLemTMQC7tgDHCa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 41/65] intel_th: pci: Add Elkhart Lake CPU support
Date:   Tue, 24 Mar 2020 14:11:02 +0100
Message-Id: <20200324130802.323936604@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
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
@@ -211,6 +211,11 @@ static const struct pci_device_id intel_
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


