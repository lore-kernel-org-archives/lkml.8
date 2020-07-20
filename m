Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60675C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4025B20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261679;
	bh=MhcG9Eu1gTs1v6u85YuZRklkvqs+KTdBsm74sjM0zPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OFuKjiT7enN8zVWitv1D3Qroq0iT7+/dAQGKDXIlucBazrs5K7YoQBM9uWl/qyue
	 t/F3wP2b+KIpodpKorTnbZj2IsPizSaeFPUGUsQmzsT9gE8OOTGYYlGXkqIsuLGJes
	 Kv4O25R5edAcfZgEQ2007naBODIazD8INtJEwZzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbgGTQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbgGTQOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8057B20684;
        Mon, 20 Jul 2020 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261675;
        bh=MhcG9Eu1gTs1v6u85YuZRklkvqs+KTdBsm74sjM0zPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4Zup3YUuTUYK22+sZEbZoDT7feDjwRTkS8hJLJ+X1snunb6tv3eHEhnF3xDqvVH0
         0PZgO+tK0N3bQoUKVdg26BYJ5ctPKHc21MT7rnD81F9eWTpbkrw4gmdMdYhMCRMksS
         M711+m7fpHHJcDNXHnc/Ry+QBxNYGY/Nym4xf/g0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.7 201/244] intel_th: pci: Add Jasper Lake CPU support
Date:   Mon, 20 Jul 2020 17:37:52 +0200
Message-Id: <20200720152835.411880204@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 203c1f615052921901b7a8fbe2005d8ea6add076 upstream.

This adds support for the Trace Hub in Jasper Lake CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20200706161339.55468-2-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -239,6 +239,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Jasper Lake CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4e29),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Elkhart Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4529),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


