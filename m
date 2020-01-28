Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E00C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF520716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222834;
	bh=H3cmjn2qBhuY9aCdYfIFQhA8ZeD98oKCjUb7CNOfBtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RnIYDb3fdBnLI/j7Jg1z1/Vc4QxCneSigKULLj+HtrCvVr4OpipGedYHm9xbj7pED
	 Mb7ByrhGE5+n1l4YOl4PNSokS5yjmNHwuJuuaBAIAbQIXW2IhfjOF5yBs7xxmfKwd6
	 /MbRKemGf2YlurbR71se67GoEM1SLT+ijGsfeNao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgA1OIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgA1OH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:07:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C0BB24681;
        Tue, 28 Jan 2020 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220477;
        bh=H3cmjn2qBhuY9aCdYfIFQhA8ZeD98oKCjUb7CNOfBtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wiSF6nGlFgQzxe0VFj5BC7OjqIdtOp37Uo7Bnr7rE9YNHZtoqr7/0WR02CU9r26R8
         Qf8I4EeeeAH8pM3uidbQWGVqi5iwY/qb2PMn8gp3c2FqxVSbz09YqQoPmA6Y8/NZsp
         UwYXpiqgr0rdCmMM4GJz/9c9oSNwNVNFkYeh3PeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 022/183] clk: qoriq: fix refcount leak in clockgen_init()
Date:   Tue, 28 Jan 2020 15:04:01 +0100
Message-Id: <20200128135832.185313675@linuxfoundation.org>
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

[ Upstream commit 70af6c5b5270e8101f318c4b69cc98a726edfab9 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 0dfc86b3173f ("clk: qoriq: Move chip-specific knowledge into driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-qoriq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7244a621c61b9..efc9e19732957 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1244,6 +1244,7 @@ static void __init clockgen_init(struct device_node *np)
 				pr_err("%s: Couldn't map %s regs\n", __func__,
 				       guts->full_name);
 			}
+			of_node_put(guts);
 		}
 
 	}
-- 
2.20.1



