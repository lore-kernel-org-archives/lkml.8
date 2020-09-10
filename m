Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9607C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A4020829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733486;
	bh=QtVsdijgAZcdE3kTpy6dLQb5cyC+X4NHcdeK4YFG4O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GR09S+y4OAraX84GkhNx0kVa1mjFkonw1I0RElDWMiMhQBaHrHdV6R73Fs0gKsRae
	 8lBypgCzktZQfLE9TmM5VNcLXlR4Pk0brgHfwN6i/iVPNIAXRolow6gW6kjpVtQxtY
	 c7Sap3V0gJfEqdp2gotQXBPoFWMq+KFLsL98IzZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIJKYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgIJKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:11 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D8F20829;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=QtVsdijgAZcdE3kTpy6dLQb5cyC+X4NHcdeK4YFG4O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+wU7E/AN96tOHkRolHBhZjrIyh32gSQUFJa6pO/LLulx3Q4rvQFVEPmHCt0yawHc
         nxAD284+r28N011/UJrdqS2R4bgXcYwJRMKWFEhWMrgKO87q7FA+xMcFx8DBzxuxE2
         VUuim/q6fla8DB1md78s2JaWLiiq+IAua+pAS8mI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINn-Dz; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] iio: docs: add description for a new function member
Date:   Thu, 10 Sep 2020 12:23:58 +0200
Message-Id: <8e84ebcc9ba1e0f4faae4cc2edee9c9d71270da8.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 78289b4a58b5 ("iio: core: pass parent device as parameter during allocation")
added a new parameter to the allocation function, but didn't
add the corresponding kernel-doc markup, as reported:
	./drivers/iio/industrialio-core.c:1531: warning: Function parameter or member 'parent' not described in 'iio_device_alloc'

Copy the parameter description for the devm_ variant.

Fixes: 78289b4a58b5 ("iio: core: pass parent device as parameter during allocation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b05ff9154310..f60e7bda7f38 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1524,6 +1524,8 @@ struct device_type iio_device_type = {
 
 /**
  * iio_device_alloc() - allocate an iio_dev from a driver
+ * @parent:		Device to allocate iio_dev for, and parent for
+ *			this IIO device
  * @sizeof_priv:	Space to allocate for private structure.
  **/
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
-- 
2.26.2

