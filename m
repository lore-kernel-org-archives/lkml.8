Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59836C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A5F22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220486;
	bh=6QPJnlWiwIuhPmfIE+phg+GH1Dc6EoYBLQGTnVyj/sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgyE0ohLl56rYDhiv8z/rJL8FFxw0LEIni51qY7Agig+2ND48KggrA/Zm9Bfjo+a3
	 wIb7+4Azqljn762iw6z83xDSzuxPFM4gzYPYTdLMoGhMf5J6OOl525x/95Z2EgXrsb
	 Ja0K4NHOvqPimqpkeJWFkExtKwGoYPNlIp0sOrLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgA1OIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgA1OIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:08:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682D222522;
        Tue, 28 Jan 2020 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220481;
        bh=6QPJnlWiwIuhPmfIE+phg+GH1Dc6EoYBLQGTnVyj/sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9WQnV2R9Me8i9IcqNR7KBAnEa/Nq7ZwzsdnrGK4SVNvebanINqR+K0AIWYVi3rT6
         LeIXEsg8fSwski9PZQx1mB6VxQoMVbvZ/6DXRh7QJL5Otgg95xTXY9AJ06EMTr/qzn
         DrgI/bS4mMGYmPB6VPGkIxk/cqWHRekcME+iWW2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 024/183] clk: samsung: exynos4: fix refcount leak in exynos4_get_xom()
Date:   Tue, 28 Jan 2020 15:04:03 +0100
Message-Id: <20200128135832.408251819@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit cee82eb9532090cd1dc953e845d71f9b1445c84e ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: e062b571777f ("clk: exynos4: register clocks using common clock framework")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7f370d3e09837..6c8e45e007c84 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1224,6 +1224,7 @@ static unsigned long exynos4_get_xom(void)
 			xom = readl(chipid_base + 8);
 
 		iounmap(chipid_base);
+		of_node_put(np);
 	}
 
 	return xom;
-- 
2.20.1



