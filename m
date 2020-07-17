Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E791C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EC020717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7jlHwYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGQXiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:38:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759BDC0619D2;
        Fri, 17 Jul 2020 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=96aBAHtLKdBC2VwojouZn6K03koQjhStwORAP0VMM+w=; b=B7jlHwYlzzowyV5+cn6bMib/mN
        WvHliL1k5bLvlUutlU9B9VdyQ4WICXiyJ7uP4p3oyh7gfLzjrK2V4vEbWDj+005VVj6/+2SjI3gcZ
        nwlZ5iKUuCk5K2ckPcXAIGZX/lv5Thrh/fxQ2CWETvXxR+cesD/w2eClzhC0XsbbtLU6rRpU59Z+W
        dJoybI7xpZd3I70HufEdF7aDmGEbT6OCE7Ho+utnLVu/AIvLt59E5iOELRdhUFPZz+vYx4bTJBEVZ
        Nc23SF6LtF0a/B9MdEYFG0cDZ1uCIuIfAMHKehD+VX4hx5GDzsNgLjlhcGBztRZ7mrRlJv8K/8EdP
        TQcsSpfQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZvm-0006gH-8D; Fri, 17 Jul 2020 23:38:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] I2C: linux/i2c.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Message-ID: <1d07a587-83b5-0bcb-2185-48ddb5dbc9d0@infradead.org>
Date:   Fri, 17 Jul 2020 16:38:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "be" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org
---
 include/linux/i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/i2c.h
+++ linux-next-20200714/include/linux/i2c.h
@@ -56,7 +56,7 @@ struct property_entry;
  * on a bus (or read from them). Apart from two basic transfer functions to
  * transmit one message at a time, a more complex version can be used to
  * transmit an arbitrary number of messages without interruption.
- * @count must be be less than 64k since msg.len is u16.
+ * @count must be less than 64k since msg.len is u16.
  */
 int i2c_transfer_buffer_flags(const struct i2c_client *client,
 			      char *buf, int count, u16 flags);

