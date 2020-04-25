Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F523C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287682076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDYKG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:06:26 -0400
Received: from sauhun.de ([88.99.104.3]:60158 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgDYKGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:06:25 -0400
Received: from localhost (p5486CACD.dip0.t-ipconnect.de [84.134.202.205])
        by pokefinder.org (Postfix) with ESMTPSA id 9B2402C1FEE;
        Sat, 25 Apr 2020 12:06:22 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-doc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [RFC] Documentation: zh_CN: convert to use i2c_new_client_device()
Date:   Sat, 25 Apr 2020 12:06:16 +0200
Message-Id: <20200425100616.3363-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and advertise the new one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I can't read Chinese. But given the context, I think just updating to
the new function name is enough. Please let me know if not. Thanks!

 Documentation/translations/zh_CN/video4linux/v4l2-framework.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
index 4d2af480a112..a88fcbc11eca 100644
--- a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
+++ b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
@@ -488,7 +488,7 @@ struct v4l2_subdev *sd = v4l2_i2c_new_subdev(v4l2_dev, adapter,
 
 这个函数会加载给定的模块（如果没有模块需要加载，可以为 NULL），
 并用给定的 i2c 适配器结构体指针（i2c_adapter）和 器件地址（chip/address）
-作为参数调用 i2c_new_device()。如果一切顺利，则就在 v4l2_device
+作为参数调用 i2c_new_client_device()。如果一切顺利，则就在 v4l2_device
 中注册了子设备。
 
 你也可以利用 v4l2_i2c_new_subdev()的最后一个参数，传递一个可能的
-- 
2.20.1

