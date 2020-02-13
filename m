Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667EFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5C220675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608448;
	bh=PiBdcD+Bje6p3RdBSrjXgWJm4Gd4Cq0tAJ6WKxdJb8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nbl9Pwrn8l0l81+sQNDLIGLEAntQciAY+22ZzRS22R3RBrtgPFPNvkbs+YWceTaXg
	 TH0lV5UZpPqMRatJBeeK28lnA2saKUI/7qPAGSHZ9ODdxUwFIgD6dwo0oEE7xbZDbg
	 JaA1900qpqpVspUVTWBt1VXDua/zvYj8wr4jMXyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgBMPkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387749AbgBMP2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:38 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500812467D;
        Thu, 13 Feb 2020 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607718;
        bh=PiBdcD+Bje6p3RdBSrjXgWJm4Gd4Cq0tAJ6WKxdJb8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPU12V8meH2xefUYncCHTXDHRW95IPJXc4tJZtL6sUSXuTR/rbpB83LM04i/pZvou
         +zt/WxmW44KsEAM7DXrlcG/mBJ94Y2xY3I5orGWPyrxEQ4khjiESpbwAhZKQ/C7E5e
         vGGb8kD6GWp5QzCjJ/R++ONL5jXOmPJU36zxsWBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH 5.5 052/120] MIPS: Loongson: Fix potential NULL dereference in loongson3_platform_init()
Date:   Thu, 13 Feb 2020 07:20:48 -0800
Message-Id: <20200213151919.611428309@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit 72d052e28d1d2363f9107be63ef3a3afdea6143c upstream.

If kzalloc fails, it should return -ENOMEM, otherwise may trigger a NULL
pointer dereference.

Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/platform.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/loongson64/platform.c
+++ b/arch/mips/loongson64/platform.c
@@ -27,6 +27,9 @@ static int __init loongson3_platform_ini
 			continue;
 
 		pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
+		if (!pdev)
+			return -ENOMEM;
+
 		pdev->name = loongson_sysconf.sensors[i].name;
 		pdev->id = loongson_sysconf.sensors[i].id;
 		pdev->dev.platform_data = &loongson_sysconf.sensors[i];


