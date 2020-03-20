Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E31CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5257520709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="MJ/zE2Tg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Obczzfhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCTQid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:38:33 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34559 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgCTQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:38:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 448005D0;
        Fri, 20 Mar 2020 12:38:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Mar 2020 12:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=KZ90kr0wTIc0EZ29kZv5jxqduk
        iofzhut3YQZokNDi8=; b=MJ/zE2Tg8sQdNCDMw2dpNmCZEnaGhZInPOhYSi9USR
        H2hdfbplzGcHwREt9GjH4+0KP9c3ZeDP94ieHLMlmSUmFUxD3G+1Lh7Ln05bUJsy
        lrP+R87vkphn74IcI/qSG04m7J5tg/pqtIF0+mtdnt3zpkRm7SZ9VaOIU3lfEVsY
        wcLfuhJhhF7g4ic0I6VGuDcVRrfhaRDchsYK9mMky5NMDQRd7kX/a8aKGxCra+2/
        IgvjhDfI9t+xzetZt2+nOWZoAi87j700xb+JnRBrQvM142ION7KjiMSDaPf89qIg
        QlXQVlm15KvFH1yodfKOQThlcov5CwWtxj89IdtpJBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KZ90kr0wTIc0EZ29k
        Zv5jxqdukiofzhut3YQZokNDi8=; b=Obczzfhiupm32q3EmdahoNVGZvZArkBwb
        hcofYe1UN69auT7BN1XXsqDUReihVow71d32Acrty8zqiZBuQ4OrzGj89KDeMYX+
        oQgHX4aDg3nE4S3K1YIky5WX83VKlCZ6q5qOzpO87BG58m3CMrg3mmZD86cEVr1O
        wpZ14ZPdLIH1/JtyxNXDxLpW+KNnyCcM8FXf4N/PWMXipkr4Po1hOYE48jtMI2EL
        RI0ZD5jCh5XlfLUBzdbVeOHHQH174AdvLxvXVI4QhfrL/guNZpv6OjEycdlNKU7S
        4iV5E1B44cjOXQTUcd4hd63WLx3QG7lmfgjroXvYIzUKrZHIlYzgg==
X-ME-Sender: <xms:hfF0XiWh6HKDvmBtPmL9q-fQkicxJepVS9nIQR_YBBbiN7y1zRdjgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeguddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeggihhntggvnhht
    uceuvghrnhgrthcuoehvihhntggvnhhtsegsvghrnhgrthdrtghhqeenucfkphepkedvrd
    duvdegrddvvdefrdekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgrtheslhhufhhfhidrtgig
X-ME-Proxy: <xmx:hfF0Xh8QkSTa2duUDjB4RzTfX6pjG1sETGr0Bk4ui9uJkc1hefxjGw>
    <xmx:hfF0XtBM-9kgUayHGhpuzBWtxZCUmaPxaZeq-zmf_sq-5Cn9NfmMLg>
    <xmx:hfF0XhoEiBDZtfOa7F2u0nbUbrxD3GyUJtPKB4njEMeXHrKJ9zN6HQ>
    <xmx:hfF0XtZTQkyu-AVcgg3jyFjURB-ez6rJM_CcqV3Q2Jmo1fASxFIoEg>
Received: from neo.luffy.cx (lfbn-idf1-1-140-83.w82-124.abo.wanadoo.fr [82.124.223.83])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5B973060FE7;
        Fri, 20 Mar 2020 12:38:28 -0400 (EDT)
Received: by neo.luffy.cx (Postfix, from userid 500)
        id 86D86A91; Fri, 20 Mar 2020 17:38:27 +0100 (CET)
From:   Vincent Bernat <vincent@bernat.ch>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH] scripts/gdb: replace "is 0" by "== 0"
Date:   Fri, 20 Mar 2020 17:38:20 +0100
Message-Id: <20200320163820.3634106-1-vincent@bernat.ch>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While for small numbers, using "node is 0" works with CPython, it is
more portable to use "node == 0". Moreover, with Python 3, this
triggers a syntax warning:

    SyntaxWarning: "is" with a literal. Did you mean "=="?

Signed-off-by: Vincent Bernat <vincent@bernat.ch>
---
 scripts/gdb/linux/rbtree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
index 39db889b874c..87d4738984d2 100644
--- a/scripts/gdb/linux/rbtree.py
+++ b/scripts/gdb/linux/rbtree.py
@@ -17,7 +17,7 @@ def rb_first(root):
         raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
 
     node = root['rb_node']
-    if node is 0:
+    if node == 0:
         return None
 
     while node['rb_left']:
@@ -33,7 +33,7 @@ def rb_last(root):
         raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
 
     node = root['rb_node']
-    if node is 0:
+    if node == 0:
         return None
 
     while node['rb_right']:
-- 
2.26.0.rc2

