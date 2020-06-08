Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E172074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591654334;
	bh=MdIzGLv9I80UNxTGOqTFO0/YhkX9e3Wi16ba3p9F01A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wgQzHN8HmYmgGSqE1UT6hkg7zUNS+/+/hBhwLv+bVcXgOaJGt2lhuXWw3vz2tLSE+
	 +bG4NEmOhbk3B385ZiPwjlhvB8WsNPmae38vMz4QDj+Q7DQVBJCN+7AGfg+TJpElAi
	 ZdKpK/xy0GaUVQT6OTbQ+GSBHoGIumPGdFNhDcL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHWMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgFHWMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:12:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E60206D5;
        Mon,  8 Jun 2020 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591654332;
        bh=MdIzGLv9I80UNxTGOqTFO0/YhkX9e3Wi16ba3p9F01A=;
        h=Date:From:To:Cc:Subject:From;
        b=2ljm5wis4+a4ngtn74BBfgckBP6UFZHWcQLN/WpclaXMFk98SpoM0JOM2KAPXwhrO
         8Ld36qLno58XrSujIpJfGn5f/FIHWGphw+QWbTsDPC2s7C6Edrei3rfrN+SwQPwYIA
         e07OCuBDZ793txLsukmAMbyAD5FDD2feJr4ozFOY=
Date:   Mon, 8 Jun 2020 17:17:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] overflow.h: Add flex_array_size() helper
Message-ID: <20200608221723.GA23644@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flex_array_size() helper for the calculation of the size, in bytes,
of a flexible array member contained within an enclosing structure.

Example of usage:

struct something {
	size_t count;
	struct foo items[];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

memcpy(instance->items, source, flex_array_size(instance, items, instance->count));

The helper returns SIZE_MAX on overflow instead of wrapping around.

(Additionally replace parameter n with count in struct_size() for
homogeneity).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/overflow.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 659045046468f..473af79f11ccf 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -304,16 +304,33 @@ static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
  * struct_size() - Calculate size of structure with trailing array.
  * @p: Pointer to the structure.
  * @member: Name of the array member.
- * @n: Number of elements in the array.
+ * @count: Number of elements in the array.
  *
  * Calculates size of memory needed for structure @p followed by an
- * array of @n @member elements.
+ * array of @count @member elements.
  *
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
-#define struct_size(p, member, n)					\
-	__ab_c_size(n,							\
+#define struct_size(p, member, count)					\
+	__ab_c_size(count,							\
 		    sizeof(*(p)->member) + __must_be_array((p)->member),\
 		    sizeof(*(p)))
 
+/**
+ * flex_array_size() - Calculate size of a flexible array member within
+ * an enclosing structure.
+ *
+ * @p: Pointer to the structure.
+ * @member: Name of the flexible array member.
+ * @count: Number of elements in the array.
+ *
+ * Calculates size of memory needed for flexible array @member of @count
+ * elements within structure @p.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define flex_array_size(p, member, count)					\
+	array_size(count,							\
+		    sizeof((p)->member[0]) + __must_be_array((p)->member))
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.27.0

