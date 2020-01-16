Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C78C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A272072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217270;
	bh=N/QN/ij5fYfNnTaD8hmAyebH+F69SGmNtuesq+HI5Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxVlzT/gEvcNeDA1jEq+EqWkg/xJT57bqUsDXXENy9pZMlxzFtl5BMFsbiHq5EVqm
	 3AwBz3qyGSq3jYhoW5VpXcx7/FX1PgrfdFwrustN3KOh5F053R4iHDfD99nvBLlzE3
	 zjTOMyKIbGOAiurrW6USkrMXYu2Shh9+I5VPkF90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbgAPX1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731453AbgAPX1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F7520684;
        Thu, 16 Jan 2020 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217264;
        bh=N/QN/ij5fYfNnTaD8hmAyebH+F69SGmNtuesq+HI5Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ii/fUctgJCnLR9NHjzfMlSM8WWDW6RDBjFmRL3/QOU0xoCb2uBnBT+MjMm4p4MtS6
         gP8RMVt6utlAGrYc/4LNpnBNqBnSUyDs4CEYAu8ZpygEvDsCKlSqxIUV8oA6PBZiAu
         acjxVhcoo19Vk5E4gCR+Dzp9Narui9nXJuN3nq8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 12/84] iwlwifi: dbg_ini: fix memory leak in alloc_sgtable
Date:   Fri, 17 Jan 2020 00:17:46 +0100
Message-Id: <20200116231715.043619927@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit b4b814fec1a5a849383f7b3886b654a13abbda7d upstream.

In alloc_sgtable if alloc_page fails, the alocated table should be
released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -547,6 +547,7 @@ static struct scatterlist *alloc_sgtable
 				if (new_page)
 					__free_page(new_page);
 			}
+			kfree(table);
 			return NULL;
 		}
 		alloc_size = min_t(int, size, PAGE_SIZE);


