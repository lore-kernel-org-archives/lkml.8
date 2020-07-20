Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C024C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70D2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261053;
	bh=ziDjWA78GexGTFmRBjgcQWCMqFaXoIEHipWA9nK9X5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VbinHw2U5ztlGJ7Ex3u1N2Q3b44j20TIRyqmJ+q2uNb5QO1in8eq8GFcQcPrirRMn
	 qMSQa+L3TiBPOaijOvWIf6SyakdKxepI86/lPdSNdR5qR0uAIy9YXS8F1FnOWnN/wm
	 6/mB9C2d+rEkls7+Gjfassmtmx45/Q+AkHBTKHq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgGTQEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbgGTQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB3F22CBB;
        Mon, 20 Jul 2020 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261049;
        bh=ziDjWA78GexGTFmRBjgcQWCMqFaXoIEHipWA9nK9X5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jk8J7g7SIq6ZLAMkAstxZHWvZ0OmPZ+I5ELdUgvmSSWI5MaLMnd8WlWTcfz0Dok6b
         7A1BOolgZb+3zTKbSqgXLDAePzpFW9kCoZiFvuXvuaGA/cFCWJrz0aVwy+9yat039P
         EEuXz9j0WaaY++lgvyEERnj2ZEh4Tj0O7TYpPw6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 190/215] intel_th: pci: Add Tiger Lake PCH-H support
Date:   Mon, 20 Jul 2020 17:37:52 +0200
Message-Id: <20200720152829.224189561@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
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
@@ -230,6 +230,11 @@ static const struct pci_device_id intel_
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


