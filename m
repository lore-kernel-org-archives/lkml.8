Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27338C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E410320724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456901;
	bh=nySOsKkoUYQ47L/SHkzG+vE0pXfsClvzXSARZ2FHIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hW0XrAaSEnl+ND8Iy/DB5Dli6AL3yoyqcG0Y9unduMTpVcLO9EiUWV98hZ1b4/eyl
	 DMI54DM1GTtcKwaThjb1G+HSvUWlXlghFLC3EhGIkWbTZc7zApLd578Z0LtO07ecOs
	 xmpKe0OJSWoZiomcsGh143/tWc7W8MCpVmE6noFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCQOy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgCQOyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33CD2077B;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456871;
        bh=nySOsKkoUYQ47L/SHkzG+vE0pXfsClvzXSARZ2FHIW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKbtIA+pYD8zJUgRZwnorsHRu3vt1s3CZiZTGxUgFHXNjHCvzEBNInjsVhSGdxNR8
         gR4rmVJjz+eTGCmYeCa58o4Bq3Mo2xR0Ol9d46s9yUP9+RptX/JQeEfoJ/f3aYxput
         KhWOrNlegoFbOThMilGNVcEQ4G9e1fnAUaWkItb4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbx-000ANR-02; Tue, 17 Mar 2020 15:54:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 17/17] regulator: driver.h: fix regulator_map_* function names
Date:   Tue, 17 Mar 2020 15:54:26 +0100
Message-Id: <b9f5687bcf981a88c9d1fd04d759a540fda53a99.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The toolchain produces a warning on this driver when building
the docs:

	./include/linux/regulator/driver.h:284: WARNING: Unknown target name: "regulator_regmap_x_voltage".

While fixing it, we notices that there's no function names
with the above pattern. It seems that some previous patch
renamed it to regulator_map_* instead.

So, change the function name, replacing "x" by "*", with is
a more used way to add a wildcard, and escape those with
``literal`` markup, in order to avoid the toolchain to think
that this is a link to some existing document chapter.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/regulator/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 9a911bb5fb61..29d920516e0b 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -277,9 +277,9 @@ enum regulator_type {
  * @curr_table: Current limit mapping table (if table based mapping)
  *
  * @vsel_range_reg: Register for range selector when using pickable ranges
- *		    and regulator_regmap_X_voltage_X_pickable functions.
+ *		    and ``regulator_map_*_voltage_*_pickable`` functions.
  * @vsel_range_mask: Mask for register bitfield used for range selector
- * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
+ * @vsel_reg: Register for selector when using ``regulator_map_*_voltage_*``
  * @vsel_mask: Mask for register bitfield used for selector
  * @vsel_step: Specify the resolution of selector stepping when setting
  *	       voltage. If 0, then no stepping is done (requested selector is
-- 
2.24.1

