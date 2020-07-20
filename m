Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F6B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gs4QCxzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGTUuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGTUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:50:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D43C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dl10so1946115qvb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N5jd+pSQ0JxE9XvTtwZnQjvUf1dPBeQ5IDjxob8l6P0=;
        b=Gs4QCxzAMdw5XWTuxVJdzIGkIbn4dOs7Gz4o7ij6qiPF8ER3jysihQyoF1b/vFzRts
         ffGrHYjBkDaNmgb5P8bJRBzqvoSFsBDm/F3vmQjm7aoBDy6UfdjdzrEVRQYCecrzwcJm
         0lG/zuG02JAnlHqVUKQC2AaCWF8NglY9Bha9cIP4IbFktuEFtgBtf3slFupsiNR8sZ38
         GE4O6ffwyB/FfBZOVz/ysNXecEECcj+A3Tkio2kiJ5SKRbtDimRd517xVt1EUfdBEPsc
         HtOOh7XBBNmxRV1S6x9Xb4IetySmOfo2GTRGk8R+3ohYlqwrcOq9Z0ILMPFuHw4MhKcg
         PNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N5jd+pSQ0JxE9XvTtwZnQjvUf1dPBeQ5IDjxob8l6P0=;
        b=psQFn9oOCZ4rfxKSvrSWc4UlGSnHWDNEehlHvXV8Pfg4CQfnuJpQmjDvnzs2EoeGxE
         VXiQYIGb94TbWQd7szLsFbDcPGqteTIsJNYBFtz+VGu4oCD9C9qaQjzI8Oc+obMqTEW2
         RvykjDPCf48JR1i5/FWaHrgym2fEpoYa+TGcrXcOy5yf/0Zf6ZpQJ76VbaOvAXIpz2+l
         6qC09MrF6ym40maDaEvuzAdWHw2ahO5fAI5rldkX/uQGwwo2GSVXfPnt+eKCirblGy7S
         r4MSGwLBB+iXzlCurBY25fo12gLgmnb5dfhKtLDzo19cy3wmEmHhKsDDo+feNK5iDeqb
         MzKw==
X-Gm-Message-State: AOAM533n3Lzg3PiqgAV60AptyTHEXDaPO5Gh67oqJ8Cm3dh7U9IH9dh3
        KbLZ6N1s9oVSvfaJKxCY3NuWCVaUsgBAolKdJ2A=
X-Google-Smtp-Source: ABdhPJyTOuZy7eEPyqwdPdBUxV48dSXqlH0y50EAcB6MaSgdYtc1AOTV85M4t4oH/aql0Zfp/dp7gG2hG8XBLr/+ZUY=
X-Received: by 2002:ad4:4903:: with SMTP id bh3mr23645134qvb.17.1595278213791;
 Mon, 20 Jul 2020 13:50:13 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:19 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 05/11] x86/percpu: Remove "e" constraint from XADD
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

The "e" constraint represents a constant, but the XADD instruction doesn't
accept immediate operands.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2a24f3c795eb..9bb5440d98d3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -220,7 +220,7 @@ do {									\
 		break;							\
 	case 8:								\
 		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+re" (paro_ret__), "+m" (var)		\
+			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	default: __bad_percpu_size();					\
-- 
2.28.0.rc0.105.gf9edc3c819-goog

