Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DEFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0875B208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NhrZSjkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGCUv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGCUvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:51:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA7C061794;
        Fri,  3 Jul 2020 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b0Kmbj/fGlJi66vsbBQazyesE+Xz16KWPQC+7mxEkm4=; b=NhrZSjkbLP4RwEm/hRYpsBp/s8
        w1R7Gwe1XjuG5NHAm9SCeAtrjjCKA43z9ffEsafPkXf7AGGnyp7Be9ydrIYHGmvnMa5/MGyi1BeHS
        aDt/oz8SDU5xDb0KwiCAB9pw8Qp5WY5QjbztQjkT9bVAwIXddRk7b1WwOky6+Ck4w15YbFTsScowe
        2Unpc0znflUFiAlX4gXPcI6tRL6CjIqUjU2b/l4/LfP8Zoxem7yQ17jz7njoxS2GDPY9gPlJGvxW3
        f4HxLZOiDVhnqxN/b+bAL7VQA8zN2x7tKyy1P7eSgM3cH5AAPbxvSxoJkZIBG+onzmJP6hECfFk4r
        mxjEYLnQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSeX-0001yn-J2; Fri, 03 Jul 2020 20:51:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 1/3] Documentation: arm64/arm-acpi: drop duplicate words
Date:   Fri,  3 Jul 2020 13:51:08 -0700
Message-Id: <20200703205110.29873-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205110.29873-1-rdunlap@infradead.org>
References: <20200703205110.29873-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/arm64/arm-acpi.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/arm64/arm-acpi.rst
+++ linux-next-20200701/Documentation/arm64/arm-acpi.rst
@@ -470,7 +470,7 @@ likely be willing to assist in submittin
 
 Linux Code
 ----------
-Individual items specific to Linux on ARM, contained in the the Linux
+Individual items specific to Linux on ARM, contained in the Linux
 source code, are in the list that follows:
 
 ACPI_OS_NAME
