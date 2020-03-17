Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BDC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC92051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584444143;
	bh=X2e/lvBOOe65WYirmqSixR1W7xvyvNrvziM4TprWNck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SjgDVg/0jjwHukonzX5ReVCafcJHQSp67TNBNcYCN9mYBIL8dfhjbuWK0Vkqs8bVK
	 EQNtUmAu934PZGJE+S9wh4YDk+hguAaAZwOIIyBwbeSVl1CVGraruztHmMHDci+yfL
	 FC4J0R9PURxifKsVllAd+kB31SanktIq5LvYybfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgCQLWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgCQK4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:56:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C646020724;
        Tue, 17 Mar 2020 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442595;
        bh=X2e/lvBOOe65WYirmqSixR1W7xvyvNrvziM4TprWNck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPCtBpsJNzSlqF0vplyTFSqcOSZWQL5zOomucxdOK37ALyo3yt3UJo9+iiZfg6f3H
         lHKZZVYPupREfzslsfl4smOERKh/AgLPyzQj4YZwnLd1gnPykjIn+KYZNGfKMyQ+xe
         wxQCvqU8wX2XWhompdVD4KFv0ufhZ+NYemWqBP1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 17/89] net: systemport: fix index check to avoid an array out of bounds access
Date:   Tue, 17 Mar 2020 11:54:26 +0100
Message-Id: <20200317103301.952446186@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c0368595c1639947839c0db8294ee96aca0b3b86 ]

Currently the bounds check on index is off by one and can lead to
an out of bounds access on array priv->filters_loc when index is
RXCHK_BRCM_TAG_MAX.

Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2168,7 +2168,7 @@ static int bcm_sysport_rule_set(struct b
 		return -ENOSPC;
 
 	index = find_first_zero_bit(priv->filters, RXCHK_BRCM_TAG_MAX);
-	if (index > RXCHK_BRCM_TAG_MAX)
+	if (index >= RXCHK_BRCM_TAG_MAX)
 		return -ENOSPC;
 
 	/* Location is the classification ID, and index is the position


