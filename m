Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB5020663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="KgaqmYR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCRFZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:25:14 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37630 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:25:14 -0400
Received: by mail-qv1-f66.google.com with SMTP id n1so8486054qvz.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O64wy/ESKaF+5RJqOtspLBJ0FSDA/9ObyrjHNmPN+lg=;
        b=KgaqmYR2St41lAHlxVLp9N8w4CLqKe5u6LgVXhrVb6Mi6oEsShSjiCmyFlATzMPs5y
         GjbUi5RRswhmgrrJ3V/cZfioNBGLp2fvGJLwHZr6SMHHnDQ2LmiNpFr6n3Hq6mY5XtQq
         XWJ6xFfBifIRbGJUuY1W1PIVV37VA7ewwdACvKdRPxyAmT8UA1oZ9VRTnLYVc4wGvTd2
         Mrft8Soc7Z/US6BkfteKO2MW5wATwerg/iKoqVtNpzApvVuEilJuDfIT5aURPhz8vLwg
         3olEh0LWJAU9LsRvQWlFmy+mNNya00UpfwgZj9MEMwBpc4DC4xCu4gjyDX3QQlwAfPVQ
         tOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O64wy/ESKaF+5RJqOtspLBJ0FSDA/9ObyrjHNmPN+lg=;
        b=Cy+pJQWpf8M+K4pWEOpyvPRoXss7dvoy3IT2CfDTQcCYJkXMsgMA03PMFMMtYJB0tk
         aZHHmPZdMYsTHFTKEUFp6HoDSWk2YZ9sEpKTwkRYoQuDiXjif+w4BCli+3DqARxVDuHL
         PVH06BDyzjMQJLJHCWTVYLegyDalASTRiCauLO3DJya9PiJAyGiWrlNLnFqZ01u/56Pv
         xOyNUHfX1t5DpfjYnjw1Iwxoa1BZEB63xKaHpYNV/4JIhszADZeMkj6QVcJVdGwptc5S
         6BIiKvTRGkWfvEHIafjb/EbUgdBj5xyDuIm6te8DCJ01Q7GZBsriwL8K17lSOgRFGpsW
         YB0A==
X-Gm-Message-State: ANhLgQ1RntD8TdD7l4lxL+9dbxoMJQUK/l29+XLmMq4yfsyOcKt8CHRP
        qhqLGtRII2uYNUp9ezyJovcn7EpAFig=
X-Google-Smtp-Source: ADFU+vvk/NTS94esbd6fWRtkypLciFOGMHGVlxT78LuOXvFbAaOVH9ModB7+2Mjcwv+waZpqE0RtGQ==
X-Received: by 2002:a0c:fbcf:: with SMTP id n15mr2537974qvp.114.1584509112520;
        Tue, 17 Mar 2020 22:25:12 -0700 (PDT)
Received: from juliacomputing.com (c-76-24-28-244.hsd1.ma.comcast.net. [76.24.28.244])
        by smtp.gmail.com with ESMTPSA id f21sm3980163qtc.97.2020.03.17.22.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 22:25:12 -0700 (PDT)
Date:   Wed, 18 Mar 2020 01:25:09 -0400
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, cl@linux.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] x86/percpu: Fix assembly in variable_test_bit
Message-ID: <20200318052509.GA23121@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to compile the kernel with -Og for a better debugging
experience. One side effect of this that the compiler will no longer
do as aggressive dead code elimination, so assembly blocks that were
previously dce'd remained in the final assembly. There's quite a number
of places in the kernel that rely on this dce happening, so it's not
clear that this should be a supported configuration. Nevertheless,
in this particular instance, I believe it found a real issue. In
particular, I believe the `__percpu_arg` macro should be on the
memory operand rather than the immediate. As far as I can tell,
this was never correct, but just happened to be always dce'd out
because the cpu_test macro is generally only used with constant
`nr` arguments.

Fixes: 349c004e3d31 ("x86: A fast way to check capabilities of the current cpu")
Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..17c7677e6cdd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -539,7 +539,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 {
 	bool oldbit;
 
-	asm volatile("btl "__percpu_arg(2)",%1"
+	asm volatile("btl %2,"__percpu_arg(1)"\n\t"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
 			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
-- 
2.24.0

