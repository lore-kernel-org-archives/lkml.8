Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F45207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbgEYGa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:30:26 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:61732 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbgEYGa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:30:26 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 386DF1086E6;
        Mon, 25 May 2020 14:30:22 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     davem@davemloft.net, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] drivers: ipa: print dev_err info accurately
Date:   Sun, 24 May 2020 23:29:51 -0700
Message-Id: <20200525062951.29472-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VMTUpLS0tKTk1PS0lOQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6Cyo*Fjg8Iy0IPApOQhAZ
        KFYKCUlVSlVKTkJLSENDSUlPTk1DVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpOTk43Bg++
X-HM-Tid: 0a724a8669f89374kuws386df1086e6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print certain name string instead of hard-coded "memory" for dev_err
output, which would be more accurate and helpful for debugging.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Alex Elder <elder@kernel.org>
---
 drivers/net/ipa/ipa_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index ddbd687fe64b..749ff5668e37 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -66,8 +66,8 @@ ipa_interconnect_init_one(struct device *dev, const char *name)
 
 	path = of_icc_get(dev, name);
 	if (IS_ERR(path))
-		dev_err(dev, "error %ld getting memory interconnect\n",
-			PTR_ERR(path));
+		dev_err(dev, "error %ld getting %s interconnect\n",
+			PTR_ERR(path), name);
 
 	return path;
 }
-- 
2.17.1

