Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B06C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DF02074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883316;
	bh=Xa4eCTaLzmS4b0NF3iSeiftCTKHdHpFXSyP6M3NqjHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Po+GoipM2Qes3EqLlTFoeAtPf4UGT+x2eGXLVssAWocAzYj6m7XQrsbCDmAl6sJ7H
	 3743DW/nZ7G9wZpzt22QEs1gzVEgTOhrf/zAZSALsn/RJRgsrHZOtlV47nozjms1te
	 eBv84IPuTxbV6VEHaf2NoFN0qsEij+/qC/vTfE98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391324AbgDNQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440303AbgDNQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106E321D7E;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=Xa4eCTaLzmS4b0NF3iSeiftCTKHdHpFXSyP6M3NqjHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkbPpxxHKM6zyF0AoWTSyC8aiyGS9V6CJGQmtxzTnbYA7gn3IYZ2A+JmOg9h/Vj33
         Ao4ltwSKN3w02ctU5lH09ImGFI+styAgN0N7C8tuVIxyQRemVn9+RpT5TrU+bi2k8n
         T984BihHbFtfEdJlQX+iiuh88hdOsl4gO+PhiwGA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068mf-9U; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 22/33] docs: vm: index.rst: add an orphan doc to the building system
Date:   Tue, 14 Apr 2020 18:48:48 +0200
Message-Id: <146432ae6965a2bb62c929a6b62f9d4010986622.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new free_page_reporting.rst file is not listed at the index.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/vm/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index e8d943b21cf9..611140ffef7e 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -31,6 +31,7 @@ descriptions of data structures and algorithms.
    active_mm
    balance
    cleancache
+   free_page_reporting
    frontswap
    highmem
    hmm
-- 
2.25.2

