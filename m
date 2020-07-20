Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554A222CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260491;
	bh=9D4BKhxX91QDi37+vYRhuOfxXIYVo+HlAafW5fRwI78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pLrlpS+lodcO/lHQgOScIK4mupJbkH2+VeTyj4WRK7Xj14tFPnOvm2owBKgGbprAJ
	 p0xdYRXs8e6rJ3k193zxmeFkte0OvGLe6K1rs6r4YbIenHIilhq1ueAxMuDC/1ABOy
	 7gBbUCD0939SBJyiBYSyM04WZe4wr1Ffdor0iYIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgGTPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbgGTPyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF16622482;
        Mon, 20 Jul 2020 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260485;
        bh=9D4BKhxX91QDi37+vYRhuOfxXIYVo+HlAafW5fRwI78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaiYmwmpJyyEj42p1HIWLktMHHTK5SH5+FUupxTTONs5ZF1h/PJSAqX410eL700QB
         UPNoKbN2JlzWwJfwPHsX+j/aFy2QzDbW5deMnqtNdcdciZIP5B2WkN1sS/FoBheFJz
         Vw5+XSYPgEedcgklbIWshWWyYEIig8hZdUYS4LNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 119/133] intel_th: pci: Add Emmitsburg PCH support
Date:   Mon, 20 Jul 2020 17:37:46 +0200
Message-Id: <20200720152809.489521397@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit fd73d74a32bfaaf259441322cc5a1c83caaa94f2 upstream.

This adds support for the Trace Hub in Emmitsburg PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20200706161339.55468-4-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -230,6 +230,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4b26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Emmitsburg PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x1bcc),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


