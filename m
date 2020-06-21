Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825B1251C6
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK+tJwE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgFUOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgFUOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:42:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A56C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 07:42:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e22so816336edq.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjWg6pIDDLSJ5juwGXRtHAbZGHWm8dpD2a7Zk0t+OR0=;
        b=FK+tJwE8GAAQZ6dUVGOWlBZb5hjs1ZsLFkm7NOre+w/UCKopOFB2a3GNqgqq0xdCDA
         jXP6eZmeCc7vhaqSqctSCscNTtMeLH4xOcBZsYvjExwzZJTBbi/7mHfMiH8fSlSrQkL0
         OvS+kPwx5atmkhA50yMTU3TW2djVGSjtYeo1AJqk+hyYM6gMxQamgOAWpN7CzDb6nckd
         T5evy9+o65h37H10U7gykbjdahOF/MfKHB8bdZQ9fzScZoP823yTnkzFxny93PYvFOSV
         rH7GrnnlwlYxXEWeMEOa6iYdsCfrd8gLtbDyzArt10tGGmjqVZSBuQniLSkrbgBnxMU9
         1zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjWg6pIDDLSJ5juwGXRtHAbZGHWm8dpD2a7Zk0t+OR0=;
        b=rF0iYqr9iq7HoR29eZeUN1hPtzZuK+2S/lxl5DjMd6SbD+yNsf78gnQZsuU6cil46X
         9gtOtd082idFbZF7g/B6SE7tGCoU1OenjVJx0N8hy6WFniRcv+akbf+D/P/t6BZTxoCT
         D3PiyjjOMaq1/0IL/KAsZMte7KbSdAXr6jHzxqeoEZTFf7MM8hQuzJacc8L5dKYsIQ2r
         WgjcO9cyICfmkEpUDuVB9e2JiCUGIhUiCKoZ0WVhL03gd6QoipZQ497DWLN+UH5887By
         dJ88tt5PhXf4fq50qUe9B6rtNpWdUIvvEm4dsTk6KOiCnxnVKBa2JdSnbXTm6fZr41+t
         FyeQ==
X-Gm-Message-State: AOAM530WrBEo5enl5gcGFXigoX1Y3btq0ayQdi9jlGJ8b4fEJYtO90kk
        Ht3gj3PbECorZUnCqK0DAKVBgZEv
X-Google-Smtp-Source: ABdhPJzE0+J2BzYlIBeoOYCAkJHEuU5hOMqA/G01NoVEwiWFqUeFcix+O5Px0Vzcapxr7UvrHVTqXA==
X-Received: by 2002:a05:6402:642:: with SMTP id u2mr12668939edx.230.1592750529880;
        Sun, 21 Jun 2020 07:42:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:5fe:4ba0:7ffd:29fd])
        by smtp.gmail.com with ESMTPSA id j16sm10088172edp.35.2020.06.21.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 07:42:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] MAINTAINERS: update info for sparse
Date:   Sun, 21 Jun 2020 16:42:04 +0200
Message-Id: <20200621144204.53938-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the info for sparse. More specifically:
* change W entry to point to sparse.docs.kernel.org
* add Q & B entry (patchwork & bugzilla)

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca..c4c7029bc463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16049,8 +16049,10 @@ SPARSE CHECKER
 M:	"Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
 L:	linux-sparse@vger.kernel.org
 S:	Maintained
-W:	https://sparse.wiki.kernel.org/
+W:	https://sparse.docs.kernel.org/
 T:	git git://git.kernel.org/pub/scm/devel/sparse/sparse.git
+Q:	https://patchwork.kernel.org/project/linux-sparse/list/
+B:	https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools
 F:	include/linux/compiler.h
 
 SPEAR CLOCK FRAMEWORK SUPPORT
-- 
2.27.0

