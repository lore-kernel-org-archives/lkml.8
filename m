Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7683625358
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdoVPiFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFVCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgFVCEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:04:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC3C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 19:04:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i3so2056949qtq.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=T9ruRtjScrhQOEGuZPPmv1vIChUuWjpbNJJwO4pbNvQ=;
        b=gdoVPiFUytVJUybTuMhXWJuTWY749YKQM9niJn7AizMzyyjmipnV7fkCxvOekslzzq
         GpH2yAVwbL+FY+xD7TnzL1/fwbG8/W/1V7+PeGBqH9k1QA0aUnaa3hmG8kqvVwNae83F
         A7/KSnAYO7NnVvI95RPTgDb5833KTozwelOWTR3bJ/fJl8mvQ+Br5evhUz1G+9x0S0v+
         TlTDUlPPJj6qiJZHn15hRk76OrYFOUoXcd/87tJkWHpFFtXy2CbhmihWvQirKJJxJU0p
         6AI6XpybSLzJBMUWDWDUFp2nxlKVis/Qew7SdFi3KPmRK9WhTJxfBYSIfTh5kOsZjPxb
         hJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=T9ruRtjScrhQOEGuZPPmv1vIChUuWjpbNJJwO4pbNvQ=;
        b=PaYyjewHdz1w07Y4XqejAEBuR86salsToSks8Sp7qei2ljKW0loxkHpw0Ikj8Jo6r/
         rc2tFbHhHG1+AEKAGLisTAIHsdIhEFmGN1Orcm2GtHI7XMmdhfEfpr+836Bdduxud6I+
         +Em/ISbiyV4VCb/Is4O97iaxxQ+bZdQWvWatt3NR/1ky+MmfXDAQQAcOewNZMD4Il2IE
         j2ACtqkTAIkYwg65swiAGMuYlRdvamtSQ0AWR2BgJBtVHO7s3b45M/e3gxYGLAxUkACG
         B+NBF7fH1KPOdu9kasTk6vR0FjWq8wvw+bOtYa5QhIXFxYBslJK3g3mwAAheXhFJHKQE
         VO2Q==
X-Gm-Message-State: AOAM530xT/YoVS7zsj9VFZ99YfFzD7iLL+TSQn6wwqBxEqWQXJHkwdHU
        6l3A9XXai5zwkCUIS9N0TpY=
X-Google-Smtp-Source: ABdhPJz5KlAWVrXaNBuWpnParA/Rh3NNvuWECfB8CNtauuSqmEfijZxCeXlt5jYG9F5x3EfbpO1mwA==
X-Received: by 2002:ac8:3778:: with SMTP id p53mr3505416qtb.228.1592791481746;
        Sun, 21 Jun 2020 19:04:41 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:c0e3:b26:d2d0:5003])
        by smtp.googlemail.com with ESMTPSA id m128sm11764351qke.90.2020.06.21.19.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 19:04:41 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [objtoo] fix memory leak in special_get_alts
Date:   Sun, 21 Jun 2020 22:04:34 -0400
Message-Id: <20200622020434.18159-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free alt before returning to avoid memory leak.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/objtool/special.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..f6f7dee1ba77 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -188,8 +188,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret) {
+				free(alt);
 				return ret;
+			}
 
 			list_add_tail(&alt->list, alts);
 		}
-- 
2.17.1

