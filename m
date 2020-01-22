Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA3AC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41905205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699687;
	bh=26Ag4a84Mxj1MhMUUa7Ze9eS9NWvIpZnvhk2RsY/vXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a0uII2640B7AMOXtnVETnwlbgyOnyBC+cGtC1dk1tE82q5tVa0PBY2DzMjgL6EVvm
	 923mMo6m2n/aTuNIV11xt9YpCB+yKPrOR0nIyvo5VR1NPqlM+rEv4eAUo+hZanU4uV
	 1bnAcHycAAmGrwSIaAWKnqInnUcL/mspBIjK7PEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgAVN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgAVN2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:28:05 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2A0205F4;
        Wed, 22 Jan 2020 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699684;
        bh=26Ag4a84Mxj1MhMUUa7Ze9eS9NWvIpZnvhk2RsY/vXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/YdqlYaOpPZ2yX77ez8VnX7xeSA9NmgPgj8GCzV2Ose9MpQquacKkn+nIBvbqAsT
         6epKaISnqHBKqSs0sRVVI+oL6jX3jrQ8dF/Oig+x3FkGKJ4Xd84pdMOOglgFpbDHEn
         sYN4FdRfzQkD0TsNOVkpfwD3b4eXenPr8gDmSf+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 217/222] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
Date:   Wed, 22 Jan 2020 10:30:03 +0100
Message-Id: <20200122092849.228738922@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

commit 9629dbdabd1983ef53f125336e1d62d77b1620f9 upstream.

The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().

Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lkml.kernel.org/r/1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sprd/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -46,7 +46,7 @@ int sprd_clk_regmap_init(struct platform
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
-		if (IS_ERR_OR_NULL(regmap)) {
+		if (IS_ERR(regmap)) {
 			pr_err("%s: failed to get syscon regmap\n", __func__);
 			return PTR_ERR(regmap);
 		}


