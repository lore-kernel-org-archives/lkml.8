Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E87207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821969;
	bh=5bcWPbVOrG7j+OP6Xyz7uIKyWpwnQnhVLv2vj0C97fs=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=LO35SEmQnVja9Szar7NcvuIfaUu2eL4ClcTQegHcueBzgtUMIgPqrNOvXlvurNr+x
	 s3XpSxtyD0FKfVqbRkZOGVaabf/Pc7q7B0koBO87pQPgzfT53GDoEhClbl3TcP7W5W
	 43UEa/mmWSEMVVyway+CVsrXqrGSrOnrwTDCtKLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgE3G7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgE3G4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA2021534;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=5bcWPbVOrG7j+OP6Xyz7uIKyWpwnQnhVLv2vj0C97fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCqQPQX6tuEKE9sWbP4thIvVSFBRDrjLG7KuASo0RrQBSXTsv3eKrld68NtPbRWlx
         9Ra9PAJq8uE9lBwsfrBN2igc6Q1P0Fj4f9WLTJ71SBVhOfDbrhvou1diC4tbMn2iL9
         DjUjeql1aJkWrCs8nDtjRKsStxAPvEZFnncjnfGA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpE-4k; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/41] media: atomisp: add debug for hmm alloc
Date:   Sat, 30 May 2020 08:55:32 +0200
Message-Id: <6b9fbe34195df5a2ef410f0e877b47ba90bb2aa3.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hmm code is still complex and has bugs. Add a debug print
when memory gets allocated, in order to help identifying what's
happening out there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index 5e983442ca80..c8a6e2d6e498 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -253,7 +253,7 @@ ia_css_ptr hmm_alloc(size_t bytes, enum hmm_bo_type type,
 		goto alloc_page_err;
 	}
 
-	/* Combind the virtual address and pages togather */
+	/* Combine the virtual address and pages together */
 	ret = hmm_bo_bind(bo);
 	if (ret) {
 		dev_err(atomisp_dev, "hmm_bo_bind failed.\n");
@@ -265,6 +265,10 @@ ia_css_ptr hmm_alloc(size_t bytes, enum hmm_bo_type type,
 	if (attrs & ATOMISP_MAP_FLAG_CLEARED)
 		hmm_set(bo->start, 0, bytes);
 
+	    dev_dbg(atomisp_dev,
+	    "%s: pages: 0x%08x (%ld bytes), type: %d from highmem %d, user ptr %p, cached %d\n",
+	    __func__, bo->start, bytes, type, from_highmem, userptr, cached);
+
 	return bo->start;
 
 bind_err:
-- 
2.26.2

