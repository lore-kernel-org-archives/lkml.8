Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC44AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97003206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360835;
	bh=LQ1AB7uAXbAwFOOYknVy0Mvjy9Vm+u/u7LD9snOopLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xnj6H3UheY8Dm9KZ4ZQLMbQOPP6Na1NA17PiXg4x+Lo7GbkB1VFt9WZhzebmDe4Vv
	 tZ4YcsJT5+J2Eau0aK2tEppdUqwr3mNdgaYgzy4VvDpZe+TAeaXZ0QNUfK+aSPBs0l
	 uVRiRmh7vn21MgNfg6eGxypruXBPtPeBUB5JcaPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgDHPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C974821D90;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=LQ1AB7uAXbAwFOOYknVy0Mvjy9Vm+u/u7LD9snOopLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cd2++O+WPIQWFWzi8C0poVO/bZNC2rrB1Y06Qb7ZKqBsuGrywoWYrfNUziy9DE4Mv
         H4SugkdldKynJUxyN+2f/1/fJbktC4rVzMYvybF1QMnMnNztxFl9af9mrswoyyY5EH
         vlINSaxLC5cU0m7lL5hFizDba9y5It4XAMZKBSow=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cC6-UW; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 23/35] docs: fusion: mptbase.c: get rid of a doc build warning
Date:   Wed,  8 Apr 2020 17:46:15 +0200
Message-Id: <9ca049c2d25689c56448afddf4f0d1e619fa87f7.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a table for the enum list, to avoid this warning:

	./drivers/message/fusion/mptbase.c:5058: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/message/fusion/mptbase.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index c2dd322691d1..2ef6506a3bc5 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5052,9 +5052,11 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@persist_opcode: see below
  *
- *	MPI_SAS_OP_CLEAR_NOT_PRESENT - Free all persist TargetID mappings for
- *		devices not currently present.
- *	MPI_SAS_OP_CLEAR_ALL_PERSISTENT - Clear al persist TargetID mappings
+ * 	===============================  ======================================
+ *	MPI_SAS_OP_CLEAR_NOT_PRESENT     Free all persist TargetID mappings for
+ *					 devices not currently present.
+ *	MPI_SAS_OP_CLEAR_ALL_PERSISTENT  Clear al persist TargetID mappings
+ * 	===============================  ======================================
  *
  *	NOTE: Don't use not this function during interrupt time.
  *
-- 
2.25.2

