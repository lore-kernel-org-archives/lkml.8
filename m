Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D4CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28689207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8FZpf9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgESTBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:01:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF04C08C5C0;
        Tue, 19 May 2020 12:01:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ci23so81626pjb.5;
        Tue, 19 May 2020 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4feI+F4dRQodabQ0vztzMEpXoHHqdtslcAebc48QhuQ=;
        b=V8FZpf9QB5HvMPWR4n2yipk9nAHt9lzvzrk6aQhYx4qGZGtM8zGW1kD1vlNBWhqXZD
         UPT+1NbzpBylVFdJmd8Q3sh0r5J+rSQ8xaecm827s7eZ6aWHsPfJUB07EMSWZTkH2Dgl
         kSEa40EoyZYqiUZQxNeTFf5JrRXjZ2grV/m5Hua+0lvcXNZ2uhdupCi/eN1jQltTJnVi
         C1vPOZ8S8IqyFZu8i1Z1zvPJtgSRX9mRcWgZ8dqpnaJujEOu0u7QyWykd8c6KZGoCoy1
         aSwRfyDC0sGTpFfPXRJn++C+NI0w5ouPjaCuWxY9box11Dzy10potOHKjUcOKCOgA6GS
         LkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4feI+F4dRQodabQ0vztzMEpXoHHqdtslcAebc48QhuQ=;
        b=iZ7Z4ZgFG1xLS3/qkez3YztjprLsXjTCfV4LkRkdfj6cSwLC9IcLz4ypEM2gmAxlyi
         TfBGyF7KuyMzjKt28EqzzBNcKLu7by7zOlODkZn/mUk5SYgYBnx3QqHpecqjh5VTzg0z
         5WEIeFf6VVlzxqJUIypv5Oa4CuI+qZ0dn05XHsUCgQppQPX/yvR8foD+DycqfjnX+i+n
         xzULBfyOiIqZVA8h1CFxB2uiAhmOZrZuEYRAR3UAz1wrpSHm4zZ15GQWhZS2T1mze0Jh
         493IaN2KsR2UyZpu54vwv2zjODFdVC/hR/WOGGdcCCT2yAYFMj/+KOvv+YMFla4hARao
         qwuw==
X-Gm-Message-State: AOAM533TMmsU1wFihVgksKjiR9G8GN+R5WF3N4pBEOHpGIl+om0QhpjB
        3p0xjoqD/rAVhye1psFhZAA=
X-Google-Smtp-Source: ABdhPJyiZ6GUF3NCEj+eBq7SSQdZCUNXewKkRllO1OxTLTo3bNYNftWhBN68lnt53o3fngDWu1RNpQ==
X-Received: by 2002:a17:902:465:: with SMTP id 92mr836874ple.227.1589914859887;
        Tue, 19 May 2020 12:00:59 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id k65sm196128pfd.156.2020.05.19.12.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 12:00:58 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Wed, 20 May 2020 00:30:34 +0530
Message-Id: <1589914834-1728-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-8-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-8-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v1:
	* No change.
Changes since RFC:
        * added Rob's acked-by tag
---
 include/dt-bindings/reset/actions,s700-reset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..a3118de6d7aa 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -30,5 +30,8 @@
 #define RESET_UART4				20
 #define RESET_UART5				21
 #define RESET_UART6				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
 
 #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.7.4

