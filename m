Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB552C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B60A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlE6Cl55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHXXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:25:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:25:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i26so9598171edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leNzp0BVSWaCYIsUQGa0YHH6B0YPMhR+0il5io3A2Sg=;
        b=TlE6Cl55UgZQA8D9VXJcZmrReFdPXDTeBHQWiqiInSqZS0koZKbDVTHPjlmzsZ7+mc
         M7DIwPR7bcBtjLPM/P5G+k4QVgIdiXcCkLHHahTVzpOr/aGqfXSy3TXM4NKQvQqAGELc
         aiqbvnV9mYISpvkRoIWascOZ1UUFVwiz+u3G+5MLusS0CXY4bjGgTNA/F+RWRBAlPVRe
         wAGCNRdb0gHw7jDuuI7XiHLfZ0J86w1sJFWJNWymVJQdMGjYieQcUHvIAUXQ1R5ykv6c
         VrQST9BEW4L0R/bJ44xNL306VS3fGNRprkwJVoJ1pIbLmcgjvQv+5xDWGaq6Pu8MgOWu
         zP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leNzp0BVSWaCYIsUQGa0YHH6B0YPMhR+0il5io3A2Sg=;
        b=t9s0aUCNeYc2l9CaE2B14Fj0BL+icnaTryuIHZr0/N4HmegV9GXLF5EXxEfOrLfcR9
         k97qBsTi+5KHSbi4LYNtl8ap1OkDYRp2cCe7GLgYWvNwVTnR/ZpqFZJWfcMga9oxWy0b
         hV4AOyWMjAYqA0ZFgUs/AO5t0o8oFhWK+YK5EDSWD1AzBmNcgUSI8eNliqnxwszQelaX
         kfFhSjhKwUgiJWYva7fxvhieNZuBV9Y7tQq55xDpsLjzbOXq24LigjIEDX0kVImWFk2H
         YKqUFGmCZ3/ZtIXgWbAkVqPXTq52Tw9hMFXtzI/izvRwXGC2yaq1kuJjzbBoY3GKr9ms
         zVBA==
X-Gm-Message-State: AOAM533acXBo/59SrKnA2oplmmYrArPHMZrNYSWtiegMQZlzu2cqbYU0
        W9yiH3YKLDHmNZiDibj4xYY=
X-Google-Smtp-Source: ABdhPJwoa/vEZgNpxO1pcFTJ1v3oUd3+KXIewprtvkTe7zA2hQadFAn59nzp3GgEXwErOz+BcL6SHA==
X-Received: by 2002:aa7:c682:: with SMTP id n2mr7873060edq.379.1598311518942;
        Mon, 24 Aug 2020 16:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:cc20:f2c0:9426:e440])
        by smtp.gmail.com with ESMTPSA id a26sm9990380eje.78.2020.08.24.16.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:25:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove comment about sparse not supporting __has_attribute
Date:   Tue, 25 Aug 2020 01:25:11 +0200
Message-Id: <20200824232511.16485-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse supports __has_attribute() since 2018-08-31, so the comment
is not true anymore but more importantly is rather confusing.

So remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_attributes.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6122efdad6ad..af7a58c19e20 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -24,12 +24,6 @@
  * __has_attribute is supported on gcc >= 5, clang >= 2.9 and icc >= 17.
  * In the meantime, to support 4.6 <= gcc < 5, we implement __has_attribute
  * by hand.
- *
- * sparse does not support __has_attribute (yet) and defines __GNUC_MINOR__
- * depending on the compiler used to build it; however, these attributes have
- * no semantic effects for sparse, so it does not matter. Also note that,
- * in order to avoid sparse's warnings, even the unsupported ones must be
- * defined to 0.
  */
 #ifndef __has_attribute
 # define __has_attribute(x) __GCC4_has_attribute_##x
-- 
2.28.0

