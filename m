Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78650C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E36020575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100306;
	bh=j9sdgf05W3pEdBzaJjyGLMM/zKtfpyU1LqRL9WdZ+3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fGG4ngJ1qn+BAeZrhyGy1VIVx1dypEpKst7gfosRdqADv/upOSO7dDvIoRMqOBcl6
	 zZ8irlcx7t4ZZMjOz1ktsPbC0fjcOcCbE6XP5XiPA1PDODITIYsyT+Ehk/FYgozrzz
	 BgU9o/Cf8Ef0uS1rsLuKTWvDJnj3nX5hIsZWDqJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgD1S3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgD1S3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898BD208E0;
        Tue, 28 Apr 2020 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098551;
        bh=j9sdgf05W3pEdBzaJjyGLMM/zKtfpyU1LqRL9WdZ+3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJnwlIzPyfAw6jT8EYm+VdZ+tGhZeywYEQyhVyKhZds1BIvsX0bM/T2JEzL3FoWv+
         oUrUV32csHD1ydUswIOFf7aiBjWED5FMGAG75eLf8Ol9sQuxb2GY+JrtZihJhQmcU+
         gnoUS11uczj5MsxdznT5rO6LnAPiR5ptpupBMpws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 071/167] geneve: use the correct nlattr array in NL_SET_ERR_MSG_ATTR
Date:   Tue, 28 Apr 2020 20:24:07 +0200
Message-Id: <20200428182233.921860950@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 9a7b5b50de8a764671ba1800fe4c52d3b7013901 ]

IFLA_GENEVE_* attributes are in the data array, which is correctly
used when fetching the value, but not when setting the extended
ack. Because IFLA_GENEVE_MAX < IFLA_MAX, we avoid out of bounds
array accesses, but we don't provide a pointer to the invalid
attribute to userspace.

Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1207,7 +1207,7 @@ static int geneve_validate(struct nlattr
 		enum ifla_geneve_df df = nla_get_u8(data[IFLA_GENEVE_DF]);
 
 		if (df < 0 || df > GENEVE_DF_MAX) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_DF],
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_DF],
 					    "Invalid DF attribute");
 			return -EINVAL;
 		}


