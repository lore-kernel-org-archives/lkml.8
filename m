Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0676D206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="lauG1FI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDjhzTvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFDFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:51:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42181 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgFDFu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:50:59 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B06E5C0097;
        Thu,  4 Jun 2020 01:50:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Jun 2020 01:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=CTralpIdYxIiZtqvW6bRThjsFf
        dOktVXY3Izef1+RCc=; b=lauG1FI+bcF0kd6b78sqb0nBEZBBQVqiaFdII3fjW7
        9eo3eI4HuxfHTXyxs7Ra/OqBNNcMFXoy6D8KI6T+v44yQvQxJMTU5dLSLX3PNVWh
        hlwge95O7QIYiCcBeYv2nGVzIHSqUM+7+1SHgr4RpypGp8o+DFFcNM6c3wo7cScp
        rD/fFXzA/4UaiTBoTaBo1rWOIZqWTvWw3/FyVbc7zys+W+gd25xVjDH11VvfrwlD
        U5tH76RnfX+ZGIohW0E9TxsEC+L0nltdhjFOC75qY3qpVBQUJJFKZs8VLOIPIErl
        yvpcnCJJQDshUu23nQemyAEi+OEHGASHTW9ExLPFlYGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CTralpIdYxIiZtqvW
        6bRThjsFfdOktVXY3Izef1+RCc=; b=NDjhzTvc7/DuH6HLYp0B1A+dvIIF4WkZK
        pwFBnXL3YM0kbymaTQIVrM+piiivUSDytZ8pLVDsQJCe3J9PujUgTEoMB3eAm1LG
        d5OcftRBsPbeokLPuzloseCvClRfKJtbYqWBGH1Dg0Lhv/cWfrOPteQbU2g6iRhw
        x2LOxPoycpP7LCvhAvRexEhBMKf93W5FtA33X1QYMnqVIFZLAFTBb/CEX+xhzZq/
        KjHmbfZ04Qn/lsz6X9I1R+889TJZNe6Uhh5iW0X3rLOjabQ6TBI2M7TVzLcF2a8n
        CCjUVciB4gTKpsESUHHjtirn8vYCOnYGgcr1E9QLbw9AiTWL1eQ2g==
X-ME-Sender: <xms:wovYXiiuDokiKrqfkFEAgg1hcJRPWfwxfOdb1kJcTy8_CExXPQ48MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegtddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepffgrnhhnhicunfhinhcuoegurghnnhihsehkughrrghgtdhnrdgu
    vghvqeenucggtffrrghtthgvrhhnpefhiefhgfelgfdufedvudelvdefvdefgfeiueeufe
    egteffudekgefhvedtieefteenucfkphepjeefrddvvdehrdegrddufeeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrnhhnhieskhgurh
    grghdtnhdruggvvh
X-ME-Proxy: <xmx:wovYXjAzjhDln3rsuUa_99wvYQDqmmcuFSAC_U22KdJVRUVSEAQckw>
    <xmx:wovYXqFDKZYSsXiB11qCh3zPDdfQeE3ppoyQvfsuXm5duFLJflEApA>
    <xmx:wovYXrTdoz01oiRKiuZJpNKWEgxbOr6rDTb2a69jLcxvuPy8jFvQPw>
    <xmx:wovYXoprLaslCBaFLnbntHPxCi_3zVeyQQJSyXzdibZTsN2-3mmwqQ>
Received: from pinwheel.hsd1.wa.comcast.net (c-73-225-4-138.hsd1.wa.comcast.net [73.225.4.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95CC13060F09;
        Thu,  4 Jun 2020 01:50:57 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danny Lin <danny@kdrag0n.dev>
Subject: [PATCH 1/1] of: reserved_mem: Fix typo in the too-many-regions message
Date:   Wed,  3 Jun 2020 22:49:00 -0700
Message-Id: <20200604054900.200317-1-danny@kdrag0n.dev>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fix for a missing preposition in the error message that appears
when there are too many reserved memory regions for the allocated array
to store.

Signed-off-by: Danny Lin <danny@kdrag0n.dev>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1a84bc0d5fa8..e648904347a0 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -54,7 +54,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
 	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
-		pr_err("not enough space all defined regions.\n");
+		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
 
-- 
2.26.2

