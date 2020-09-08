Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01887C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE65206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587439;
	bh=EfFMKUnQT7gcogjxEmAwuFcSjOPw42eHWHrJ99Oy9mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9krS3tdcUAGxakrtLsDDV5H635Jc+pI8t/louFdIfCAMSHdEGeF9nO2SQD0hd36g
	 SpA+qETtq3HsMXoHjJVK7LzMVpZWCXMK99b1Gw9b3MDxcCCqd/2lgCs/2XwXGluqDq
	 Y4L/lhAqYrXgJXHiUGho4gvyUW7hLZiiA/Uw+eMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgIHRuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgIHQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCD4248D3;
        Tue,  8 Sep 2020 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580369;
        bh=EfFMKUnQT7gcogjxEmAwuFcSjOPw42eHWHrJ99Oy9mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fueYge/6+O9B0mPRl1dPeEqbwXN7Q3Ew/tHv2/9+YPgOZ2FLHKnWzUjbV0nlXbqS1
         aN01zGDr6Ujqs/7U+IqFwyIy4lfAVUgaiBHcJ3AtR5bzgCjb9HzHdOb3ArKmKoB5Zc
         +jRwfnCMPphq47DOT48L4la2YbYUXF3eVSTtIvTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/65] netfilter: nf_tables: incorrect enum nft_list_attributes definition
Date:   Tue,  8 Sep 2020 17:26:04 +0200
Message-Id: <20200908152218.024319876@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit da9125df854ea48a6240c66e8a67be06e2c12c03 ]

This should be NFTA_LIST_UNSPEC instead of NFTA_LIST_UNPEC, all other
similar attribute definitions are postfixed with _UNSPEC.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index a3ee277b17a17..49b6997c32550 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -125,7 +125,7 @@ enum nf_tables_msg_types {
  * @NFTA_LIST_ELEM: list element (NLA_NESTED)
  */
 enum nft_list_attributes {
-	NFTA_LIST_UNPEC,
+	NFTA_LIST_UNSPEC,
 	NFTA_LIST_ELEM,
 	__NFTA_LIST_MAX
 };
-- 
2.25.1



