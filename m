Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B447C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF3E2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917114;
	bh=k640J9cqOEVPJ1orsTEWIBrNMF4F3K4Xs6YwxMvaSG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dBfCVa4sSkZnvqs+zneiWkXwRUSYqmzysYdLgkQyA039OxH1cOZV1lgQQ87I60ITh
	 eDYl9OYvK0YS1ufCbUqkrkYKvIb6kbk/Kryfz6Vm1GOWcNnF659MTRNwJYYi9n49hM
	 zFw+jMuL+jQOqIotKWASAKM2w0xO7+S42H3oX6yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgHTJvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgHTJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:51:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE17207FB;
        Thu, 20 Aug 2020 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917106;
        bh=k640J9cqOEVPJ1orsTEWIBrNMF4F3K4Xs6YwxMvaSG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsTv+3BN/PugH1ee2IJ/X8Qv+wViH7gS+RSpuGIqI9Sp1DVJUotEUrhTB9b+/UBCP
         BTw6raWCysfcJEgpIOzn6rdrJnW453aDYcPWZug8UO7CCZez0O0bJgv9v1ukoyBP/p
         SdFdpyDUMkup3fZbp6r8iRY5LQ1UT2gLMrSFd+bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 147/152] drm/radeon: fix fb_div check in ni_init_smc_spll_table()
Date:   Thu, 20 Aug 2020 11:21:54 +0200
Message-Id: <20200820091601.353769890@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit f29aa08852e1953e461f2d47ab13c34e14bc08b3 upstream.

clk_s is checked twice in a row in ni_init_smc_spll_table().
fb_div should be checked instead.

Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/ni_dpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2125,7 +2125,7 @@ static int ni_init_smc_spll_table(struct
 		if (p_div & ~(SMC_NISLANDS_SPLL_DIV_TABLE_PDIV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_PDIV_SHIFT))
 			ret = -EINVAL;
 
-		if (clk_s & ~(SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_CLKS_SHIFT))
+		if (fb_div & ~(SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_SHIFT))
 			ret = -EINVAL;
 
 		if (fb_div & ~(SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_MASK >> SMC_NISLANDS_SPLL_DIV_TABLE_FBDIV_SHIFT))


