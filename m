Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC26C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3A62075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360890;
	bh=Xa4eCTaLzmS4b0NF3iSeiftCTKHdHpFXSyP6M3NqjHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ju86czLtPkyCxEC2TNNei9qpZ/dw8r8A66tOwpjnh7m/pLg6ChuhLrDWfONaUqGb1
	 lKWUCotzu7X89Ydac2Q1MIyCyfrE65Q1eJlU0QyYTD3Cfr4w2nSoH3XzanZ4L0g/W3
	 oifjGiNfzZeKN61djexK28DLI7tbqV53AKKEcDnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgDHPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E2D21D94;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=Xa4eCTaLzmS4b0NF3iSeiftCTKHdHpFXSyP6M3NqjHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYWVR586PG8Ywg1wb5n7FKJelTpA/WRuT4jxsE7egnNhDS7CjuqUocNExkiRzS4g0
         LgXWwATb6piN5Q6oAO0YyJcKeTguD/wIRRajWxKiNnOkeW1AR0FXKQTYfojnguDhSi
         thjfaAmx1pBvB0zG7WWx38KrnNdM+CzXsFhpHgaQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCQ-2q; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 27/35] docs: vm: index.rst: add an orphan doc to the building system
Date:   Wed,  8 Apr 2020 17:46:19 +0200
Message-Id: <2fee2799eddb99a154eee8c6c97dfbba9ca10222.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
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

