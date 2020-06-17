Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E63BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5155D2158C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHAAsl6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFQQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgFQQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:10 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5258C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e5so2079541ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=fHAAsl6naqKyGruMnIBUD9m3HqhCSMMQ+6ON9BSP2ZV7/Xc1Gj/K4w1ydJw4tiP/8w
         5Z/50mpqmxXD1AZiJ6MtAmRfQCXwb284im+78TQ3P5uMlBwkgXuGMv3VpI9jpD7z95BS
         9DUKJxp7xvcdjQODtkHTqXop4CntdW1kqrSf4+J1XLgT4hs6/f53X5HLG+LwTG5gjPOT
         wZibGBVsLQv7YeTUoLDFx9E08A+t0SdYxmv6Gybhwk5G0gZb9GUTqwKfuIxxt1lzq/AZ
         ETfCxvXNGvxBSgx0riF36acI+EMC8+GCH9B933uzhkpJDFprNkD7NSmdFjn+vSbD8mfm
         8agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=OMcRaYvWsdO1zP/NbxSzG9v1iJrrhSTl9WNqM++dMjKLk2gs6o7fuOO15akQOkAp6b
         hFKguKdQ4DOaHLSuZcjSLMVBqBouDGfmBFgw3Rdsja15xz5iTEq3hIUuQtbcgzz5j3ou
         BBdCA1sDYVNRcob78KnuIL3APXavwoCQkMIeHPaev/bD4wrILAclpSw/Xxm9Ge0IUSiB
         A4zs5rGYQ7PNJdashK77xXKOd4ReSLWatih+2SrQaRK9fJjYBn5Rl63zuQbsB971xQ5G
         OHTGjTKuxo0uBxtZ+SNlf8avUW8vDQ2EpSzFynEM+yIQDeFI4vbLeQyr79qlRl/v4PGC
         4GFg==
X-Gm-Message-State: AOAM530f6jwL5kHNLKniJLfNzvavxW/5mPPGB5raFCh9/bF3l66PgVl4
        1XT1FygvOteiIxV9IN8VvuQ=
X-Google-Smtp-Source: ABdhPJzRO6IfgXg+oRo0/e9T350Bh513WjlQHQt4oQQ3r0qni5CVympmGQ7ssd+/mdEwqF0DcKHtmA==
X-Received: by 2002:a9d:d13:: with SMTP id 19mr5889753oti.83.1592411170056;
        Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 08/21] dyndbg: fix pr_err with empty string
Date:   Wed, 17 Jun 2020 10:25:21 -0600
Message-Id: <20200617162536.611386-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this pr_err attempts to print the string after the OP, but the string
has been parsed and chopped up, so looks empty.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0cb5679f6c54..1d25a846553b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -420,7 +420,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			}
 		}
 		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			pr_err("unknown flag '%c'\n", *str);
 			return -EINVAL;
 		}
 	}
-- 
2.26.2

