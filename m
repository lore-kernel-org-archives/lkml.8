Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1464C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F39A206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USs1td2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgF1Jum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgF1Jul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 05:50:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FFC061794;
        Sun, 28 Jun 2020 02:50:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so13361871ejc.8;
        Sun, 28 Jun 2020 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfr2aGGQYCi1OBcYJwYVyRR0s+ow2RNYRbf369d5eIM=;
        b=USs1td2Ju7+gYidHoQNcqMMzmJ6RgRroMs0GEn1BoBqWpMHzT+o7bALH696lXDro3J
         M9anXAQEa3I97vT/oN/yLZSck0hkAGtQt7YlLwbD4eDoOChldaFzKAkXi+Ra2cqH+xMk
         zEwfwu6dXZjYqHPyTGuJdnFWKFw83wsZ0owAvaRu+E+FpHRH6Zs0vfV6oa0t+OHrX/KI
         nei9fHxeu0hgRbGtwzypG3pE8vdChSl4lTJhO5QAgUrEHUbUrs01Q8zRXOZSRE+CGyv/
         IgkrkNAfFgQ02svtR2pEhbeFrYNxK3mHa1ASi3GSZJ//I8WQzD6A1lgWkRkgGmhkeUIX
         9Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfr2aGGQYCi1OBcYJwYVyRR0s+ow2RNYRbf369d5eIM=;
        b=HbrSwwApPpOymNaLQiVHvQhbWK5DeVSL8F13vKaizFeHKItX1Obz0CUHPmu1dLd598
         2P02kjzCCOaED2oGedxeJGSys7epU1H/B9d/JvX5kf5oBArpGgohThxURa8LbHUqQhWS
         5XnaOtriKY1PWRrlrgASyvJSL1IwaKwX1GR1j5mua50U+leUUifWOTeWjvY95UtGpzbW
         WmPmbgDkECpUGnwx+KCTSWOzs1VdPCXGiNAAFXPv7PWDIlLnUEyCWSce/FOMwWERAnRd
         AtDtqtH1iAT/dxk9QKLFvgn84dq0SLMGk49APajvBnJGYPevCkWpPoj0cZXnyyFwomRa
         r60Q==
X-Gm-Message-State: AOAM5329816ts2FaD7wZLr+KmyNzOg8QO4l5XUX1aoizvMsy4AYwxeQC
        /T08C+Oep4/GhcWxiAJ9Wdo=
X-Google-Smtp-Source: ABdhPJwGhhv5So5Hz7j9nfv2pcFu2L2HkphZe/Oww+j5SM8cnSXf5iXUrD2FWhSiOJ+9z1VaQzdqlw==
X-Received: by 2002:a17:906:c285:: with SMTP id r5mr9332627ejz.153.1593337839901;
        Sun, 28 Jun 2020 02:50:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:f51f:7c31:2fc7:f95b])
        by smtp.gmail.com with ESMTPSA id s21sm2327055edw.37.2020.06.28.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:50:39 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add link to sparse's home page/internal docs
Date:   Sun, 28 Jun 2020 11:50:34 +0200
Message-Id: <20200628095034.69520-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626112349.1292a654@lwn.net>
References: <20200626112349.1292a654@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse's home page used to be a wiki (sparse.wiki.kernel.org)
but this wiki only contained a short intro and the release notes.
But nowadays, sparse's main page is sparse.docs.kernel.org,
which contains all what was in the wiki but also other documentation,
mainly oriented about sparse's internals.

So, add a link to this in the kernel documentation.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/dev-tools/sparse.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 6f4870528226..e20b8b8b78ed 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -9,6 +9,8 @@ Sparse is a semantic checker for C programs; it can be used to find a
 number of potential problems with kernel code.  See
 https://lwn.net/Articles/689907/ for an overview of sparse; this document
 contains some kernel-specific sparse information.
+More information on sparse, mainly about its internals, can be found in
+its official pages at https://sparse.docs.kernl.org.
 
 
 Using sparse for typechecking
-- 
2.27.0

