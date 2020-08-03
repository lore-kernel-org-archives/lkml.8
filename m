Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F12B20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHCGpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:45:53 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:11120 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHCGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:45:53 -0400
Received: from wwh-vos.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id AB959108499;
        Mon,  3 Aug 2020 14:45:48 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] doc: kcsan: add support info of gcc for kcsan
Date:   Mon,  3 Aug 2020 14:45:12 +0800
Message-Id: <20200803064512.85589-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkJPSB4dHUlITB5CVkpOQk1PSExKT0JLQkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6FRw4Cz8eDwEjIQMxCT4T
        Dx5PC01VSlVKTkJNT0hMSk9CTU5JVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUpMQ0s3Bg++
X-HM-Tid: 0a73b311b53f9374kuwsab959108499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN is also supported in GCC version 7.3.0 or later.
For Clang, the supported versions are 7.0.0 and later.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 Documentation/dev-tools/kcsan.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index b38379f06194..05a4578839cf 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -8,7 +8,8 @@ approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 Usage
 -----
 
-KCSAN requires Clang version 11 or later.
+KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0
+or later. With Clang it requires version 7.0.0 or later.
 
 To enable KCSAN configure the kernel with::
 
-- 
2.17.1

