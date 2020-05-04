Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5030C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A710C206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzRzgYc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgEDR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730336AbgEDR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:29:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F041C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SVu2p6n57+yw9WvMvY3hjWXSMSE06hBcZjyjNm6isgQ=; b=kzRzgYc1y1dX4zNUlvhmjeqjC7
        XGIoMw8OUKtuRT1UllHv1Y4hLmp/ZePmLifuMSn7/MwdXc8UG3LZoS3CP43NvhofRD9u959q86IVX
        dtmft5e3GoN8AgilCnB+eaQtf9z5kyfrt6M6a4mOI+wchpaMHB9nkhfJMdwiMcs6+y5ffmTIzLOI0
        4OCstQ1TExGZAJ6f0W21UTRHtoZsS9ZtmT6QhEmnCl+PHmnP2GNEL8XTyZCtwWQpc7ouiE4cREM7i
        Owju4WRoaqVUMuIDFNj+UT4z9jozEwXppd30TqS56fRbgXOzZ0UVLWvUlg8HvWIK92VJPwrNqHXLE
        dYeGIGeA==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVetp-0004Ie-Jh; Mon, 04 May 2020 17:29:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] x86/uv: Unexport uv_apicid_hibits
Date:   Mon,  4 May 2020 19:15:26 +0200
Message-Id: <20200504171527.2845224-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is not used by modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 8cf0e24cf8835..10339ad02033a 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -51,7 +51,6 @@ static struct {
 static int uv_min_hub_revision_id;
 
 unsigned int uv_apicid_hibits;
-EXPORT_SYMBOL_GPL(uv_apicid_hibits);
 
 static struct apic apic_x2apic_uv_x;
 static struct uv_hub_info_s uv_hub_info_node0;
-- 
2.26.2

