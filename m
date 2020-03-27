Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE24C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605DC20774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDAvIh3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgC0P3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42207 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbgC0P3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+3RJDq2ht15hSk6zYEj33Rmqj/GifGJwn2jV6Vb9+I=;
        b=CDAvIh3yrOFMddnQlFNTyksnbdWd2ewuTkkxkrJeOwzLFmaNCqH9+szUnlodx/m57Tooo8
        AIKQ7/6BVoep/lF2ebPQZ2eo7ANXUE8+/JcPuGe3/AcvjJIoeKy5kr12kkczxsiJGFlBO5
        sAjQ25WhALOWFhSWHmWwvEiXd8e3HjE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-i5eKsjtROmmP4anlqK-faA-1; Fri, 27 Mar 2020 11:29:05 -0400
X-MC-Unique: i5eKsjtROmmP4anlqK-faA-1
Received: by mail-wr1-f71.google.com with SMTP id f8so4724121wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+3RJDq2ht15hSk6zYEj33Rmqj/GifGJwn2jV6Vb9+I=;
        b=qI19GmWXMM8RCn4WlO9u9528uiHKPoI43U9DftgnnoLJbdeZpZx65BlePgCoJv3JcJ
         e7SvW2+uHQPIP5yeA4KJ2xY0qFm1eKqlSEXBYriKgiV410EDVU69f9Po1Y/Etv4/yiq8
         Qe1e6zcJbv3AR+Pudyu8eBYkXVNmP9Ixoq9Go+8Mrp2SO5ZBj5OrsDhi2SVsh4xXtYGV
         r3bCH9/liqT0l0rZiSPbR+lA3kpWdlpBCm1CK+EgrtQCfbJtQ0jlbfCkbudiGJtDqhd/
         dPfmc6kGVMQvlsHyn9pc86rnAiYBfdSWP5OzTLfsM5MJ3XWKC3+P9jEUwngDaiXnR3tB
         1OYw==
X-Gm-Message-State: ANhLgQ2cEqv3ghknLpu7hpuWnLkwr2VYKQFwjjD4pIjfYxXZcDRV64ug
        c+HE+3NAblozPffn/FbNnVxoWkB2/B+WsuqQ3lHLIAU+VpMItpEx4/pke8zF0xBeIEuEXii8b4N
        ASrU9NrwbpfTYQ24529H1hTPJ
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr5685975wme.62.1585322943488;
        Fri, 27 Mar 2020 08:29:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsrbognTjYwhEkme6Ajvwr7DD+SZHdcowhDQQa0ghYDmHnU15Dsybf+XpVJyZl+bp1DnEHLcQ==
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr5685960wme.62.1585322943300;
        Fri, 27 Mar 2020 08:29:03 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:01 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 04/10] objtool: check: Ignore empty alternative groups
Date:   Fri, 27 Mar 2020 15:28:41 +0000
Message-Id: <20200327152847.15294-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atlernative section can contain entries for alternatives with no
instructions. Objtool will currently crash when handling such an entry.

Just skip that entry, but still give a warning to discourage useless
entries.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 74353b2c39ce..5c03460f1f07 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -904,6 +904,12 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		if (special_alt->group) {
+			if (!special_alt->orig_len) {
+				WARN_FUNC("empty alternative entry",
+					  orig_insn->sec, orig_insn->offset);
+				continue;
+			}
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.21.1

