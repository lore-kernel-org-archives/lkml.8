Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D653F20829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733519;
	bh=18bO8d6MOtL5Fa/RGVc/YxGeCwHKjnI3HmekDYcuXzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i4CJXoZLf7I5Duziv5/hYKzHBo+ID/fAN+olIKwzCwPYMpMSknvxgGzfskmlx+bHP
	 fiGDkHSTlC4a1tcxlmuqGeB8Tz6iO8YDXaWup+wru/sw8w59Ljfctbacn5fxKZ3TTe
	 5xVboJ+cRoavWCChxIYJF/abo6oQI1N3pFwyc3ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgIJKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbgIJKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:14 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B7821D7E;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=18bO8d6MOtL5Fa/RGVc/YxGeCwHKjnI3HmekDYcuXzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDB6b/QRMluCKDbFpemYuHMDRjUG0DODdX1cTqirdjsujjsH9Gk/tZxFdGQjQCWQM
         eJ6D+Rr3Z9IfW6TXdsOsUdPZ4grIE48flujXZ/HaUOsYZykwUS/4S85gWdl8ad5jJl
         E35F5NgwgMuF4O5ryMCLHB3VGeDNLNtc8oUWaKsg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINi-BR; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] XArray: docs: add missing kernel-doc parameters for xas_split_alloc()
Date:   Thu, 10 Sep 2020 12:23:56 +0200
Message-Id: <17aed0aeb9dad9ad3a1ca97da11bec16a6283f3c.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters for such function are not described. Copy the
description from the conventions (at the beginning of this
file), and fill in the blanks for the @order parameter.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 lib/xarray.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index c2ae180bd57f..b2dea0c63dbb 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1004,8 +1004,15 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 }
 
 /**
- * Allocate memory for splitting an entry of @order size into the order
- * stored in the @xas.
+ * xas_split_alloc() - Allocate memory for splitting an entry of
+ *		       @order size into the order stored in the @xas.
+ *
+ * @xas: is the 'xarray operation state'.  It may be either a pointer to
+ * an xa_state, or an xa_state stored on the stack.  This is an unfortunate
+ * ambiguity.
+ * @entry: refers to something stored in a slot in the xarray
+ * @order: size of each entry
+ * @gfp: GFP allocation flags
  */
 void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
-- 
2.26.2

