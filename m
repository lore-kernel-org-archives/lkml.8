Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0551C208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iImtYUMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCESRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:17:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35547 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCESRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:17:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so6793454wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ur7gy1iBTjpshiGwn7PHFKRCZKN/EqCC/bRu0X/qyjI=;
        b=iImtYUMXg9gyEfPpN6j0wtKnybFmfih1SfNntEvPgSKVqSNzIWYwqVA5ucEiEzTvpD
         yZqKFDabhXvjfFheAMTPtlVso8ONAcoo+XtdsuRau0kiq7I3tS22meFiHsUCPX9eiUIq
         qDHif+8/lmfO05BuZJZpnk8Wuf8ZHkfZu1QZVtzlCn0sK2aKyP01FAoOFmJJLOppsA4l
         ZZJfyLFF3rcy1MUWvP79OmIFsx+KiYAzavZdud4ulwIY/zQQXdSEqImdcaJB4nuavcjy
         YTFsnhVjhRjxjVxYVqmZJ1b1WAbmeRnIrI4YNGhCHFN4ifXVPLL7qKzz+z1+4RB39U6N
         mY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ur7gy1iBTjpshiGwn7PHFKRCZKN/EqCC/bRu0X/qyjI=;
        b=kLh5aEy7DFpIU6g50gXVyZplQe33Gxp7ENGSDsNrLeWEOSIol2tp0E39zSpt5rHzUX
         mHzLWxolV2Gl7YEupwHH5EOFf80dB97b3Y21sdBwcnGDJ+k+X5RyjyC57x4Y/DNuecED
         MJSvVNSVjX8I3MmuwBDHrerL3BuqM2l+LOSdbsgohMcyYO2yvEons1WiN1Q0rjn6e/Vj
         wvz6xRSDwhK7QhofvxgH2jGG36n+2YXzTCr36TsJFYDx33DJ7iqIV6nXEwrW0SZrlJfR
         xCngysC/Zw8lo/RKuK48FSTE0ktr/tOY78h8UZrpnNf1RhZjgU9Mx3IcQFQPwFYgPjuR
         yF7w==
X-Gm-Message-State: ANhLgQ2iWbkH606Asd1xpQuTc+E6BBuzGK7GQWlTs6frtHs8AIqcUxGN
        Url7C0T0Le6UwANxLO6N+Q==
X-Google-Smtp-Source: ADFU+vsKpOKjyZZ2sdfPleEssK0P/iXY3amRp8rqYqgctOT1C2k+RMpUAPE2OoUVfiaY5pyfPriW+A==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195mr26937wmu.167.1583432241952;
        Thu, 05 Mar 2020 10:17:21 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id v7sm38843379wrm.49.2020.03.05.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:17:21 -0800 (PST)
Date:   Thu, 5 Mar 2020 21:17:19 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: fixup TASK_SIZE_MAX comment
Message-ID: <20200305181719.GA5490@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment says "by preventing anything executable" which is not true.
Even PROT_NONE mapping can't be installed at (1<<47 - 4096).

	mmap(0x7ffffffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM

I wonder if CPUs with wider address space carried the bugs...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/processor.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -887,7 +887,7 @@ static inline void spin_lock_prefetch(const void *x)
  * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
  * address, then that syscall will enter the kernel with a
  * non-canonical return address, and SYSRET will explode dangerously.
- * We avoid this particular problem by preventing anything executable
+ * We avoid this particular problem by preventing anything
  * from being mapped at the maximum canonical address.
  *
  * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
