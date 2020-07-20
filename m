Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6686AC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F4922482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260138;
	bh=+xqjmGS6nKbWQ5Dn5BW8/Yc2jceefTSn6AOCgYaytNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQmghkDWbqtJKh81ZiTXgLhKyBtUcaF9KSeJtTncLzXAWsBiVNlXOyPFPOpUNZ13h
	 47SDLtTJxgUq1KudomjraYzf3cJMqMH1GmTdZ90mxJy75C1fPOdiAWHwt4/sAd/kXy
	 UM/b7lrV8HIK8TBJUpKpaAGWeLCbX45mYUPY0Cik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgGTPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgGTPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:48:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F31222CBB;
        Mon, 20 Jul 2020 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260130;
        bh=+xqjmGS6nKbWQ5Dn5BW8/Yc2jceefTSn6AOCgYaytNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnG18Ehnw2Da4A4iFBgC/G/iS7QqCDoggthqA7+NUQ3byuY2B7Yop/r6ISt8m64Gm
         gFVM4YkjknS+QCIOkfrnJWywn7RAghHdJyFXdhP+EwQEpUXMVhXe8qFHOKwCwMwVSV
         2nkbRtYwJ9hTGg3MB1KvCTbEo3XsDs/Lx0qHjJis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 116/125] intel_th: pci: Add Tiger Lake PCH-H support
Date:   Mon, 20 Jul 2020 17:37:35 +0200
Message-Id: <20200720152808.635317396@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 6227585dc7b6a5405fc08dc322f98cb95e2f0eb4 upstream.

This adds support for the Trace Hub in Tiger Lake PCH-H.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20200706161339.55468-3-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -214,6 +214,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Tiger Lake PCH-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x43a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Jasper Lake PCH */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4da6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


