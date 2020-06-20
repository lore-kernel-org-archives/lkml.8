Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1EAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6562417A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6HmakzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFTSIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32791 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgFTSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id n6so9876352otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=Z6HmakzGv0zZTAttjYpV1nbkxCtDj7W1R7RLiV3QqQ9YYfLyeimnAmAJbZe7ifhGlF
         YK+Oat+L5PpYGsP7bolGRAhCNSnd3/vKPyqKSYL5TZnWCFzaidfK0uZI4f5hSkhNEMhg
         p595dKO4M2gmo2RFB9arpCK1+MPmoPRA2M7CUx51FdPRwe1q2VOtXjIRqHts38h6p94L
         oK/CtCL3GrcNEhWZ6d77VK+1zxuCIQ8844IlsCRbfCHeJAhuxw/sHJcqprjklcBBB5D0
         gzsT8tPJfvxoQiQ9nXGW1KeYqkD1871J/JFIxMyyGibvb4ZnrC9P05XYOLOdG8v5RXJd
         Nqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjkiLR+60k9QfvgBZn9QHWt4cqJyvhTf2cZ66HgG/g8=;
        b=SkAHhs+a63CFtT33tLWjHMlOEJQLAUK3PoRemIxtfS3iy6wral5zsquoT6cnR/v2c8
         pk7oiEgL5fkCqJ1C2DY2dcq2IUMyOXCdbTTautoX0KmwgfGJMYqjwCVecSqnwPA8Z6ue
         Qlb8hwkzW6zNHqok4KhOBvePi3TK+LnCMMJvEF9TPAMFEosiGP/B7uqroxOXac6Vsu2I
         mFeQejnx4onenb8oPT3lxG4xcDzKWVn+AI/ALDdwEDEptG7ZSacOyFFtG4bmZDIsWMZE
         W+AEuw4W3BhNmPkgjW2KrQjKlxA5MZQek5OXkwErcdNBRD0qQcY6mve0nRhxPIYHuShd
         +nfg==
X-Gm-Message-State: AOAM5334Y8/YCCfOYmKpPeXHQov8n805meygP+87eEo9N2KuKPjOCL6l
        PqRhGcqKtogc+eG3M8zm3/Q=
X-Google-Smtp-Source: ABdhPJwN4TYhPMa/co0iUkvCyP8CMUglVBnxcV3mb3+d8B5nxnp3qhxzXwFVlqlZ4Uz13KNicK89oQ==
X-Received: by 2002:a9d:4716:: with SMTP id a22mr1914336otf.267.1592676430450;
        Sat, 20 Jun 2020 11:07:10 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 08/17] dyndbg: fix pr_err with empty string
Date:   Sat, 20 Jun 2020 12:06:34 -0600
Message-Id: <20200620180643.887546-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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

