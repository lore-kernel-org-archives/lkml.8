Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F2CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591B246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgB1ASr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:18:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgB1ASr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:18:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so1410600wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Ru4d08QosRwi5UKUDayggsg8+1o9m63515MgXLmokW8=;
        b=N7Dru5GqzE/OcdgfSN1/3BQ3NNZiOLaahIZAlit1v1rOTfMl+hLle2Dd4GfdXlRShG
         zLy3WZ7d4KLAYpe08uYHhobMYV+WnOcgo1bTmnhn377N4G++WURA/DEOtUyBn3Gf4SHa
         9JjrLLgP8R2LUObI2Q5wYuvsepZWJT6vSsc1sATgGrBJY6A0i/DkfUnb0P8XQQ11PjuE
         zMduzVfK6WDh72Bny18D5qiKhXNava/vOVIxnWKJcL896GGj8zsom+yJVvTDDYmSIY3f
         IK66bOijoZoAXaK4GQzyWjfnGIIRhyIKi1PQzDl9zmWRWwVLtS9FK7VZeDJcbnqUXEUh
         hPAA==
X-Gm-Message-State: APjAAAUVU2KINzY59BN3PhqRqLArjHv5T8o9RPFd+XfbIe9anpP9FJzm
        DIxokg8gqsaGrz44PRWng3RgYw==
X-Google-Smtp-Source: APXvYqy+BY8r4CAlQjGnmuK0o8k329k009mLT7m3y33mtID+0H5FRuAG3RePEOUn51L+FOrcaJrpKA==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr1383321wmd.39.1582849124239;
        Thu, 27 Feb 2020 16:18:44 -0800 (PST)
Received: from Google-Pixel-3a.fritz.box (ip5f5bf7ec.dynamic.kabel-deutschland.de. [95.91.247.236])
        by smtp.gmail.com with ESMTPSA id d17sm9543105wmb.36.2020.02.27.16.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 16:18:43 -0800 (PST)
Date:   Fri, 28 Feb 2020 01:18:44 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr>
References: <966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] selftests: pidfd: Add pidfd_fdinfo_test in .gitignore
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <DB631DFB-DF8B-4B95-AC50-74F1ED733CAE@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 28, 2020 1:00:08 AM GMT+01:00, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>The commit identified below added pidfd_fdinfo_test
>but failed to add it to .gitignore
>
>Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")
>Cc: stable@vger.kernel.org
>Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>---
> tools/testing/selftests/pidfd/.gitignore | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/testing/selftests/pidfd/.gitignore
>b/tools/testing/selftests/pidfd/.gitignore
>index 3a779c084d96..39559d723c41 100644
>--- a/tools/testing/selftests/pidfd/.gitignore
>+++ b/tools/testing/selftests/pidfd/.gitignore
>@@ -2,4 +2,5 @@ pidfd_open_test
> pidfd_poll_test
> pidfd_test
> pidfd_wait
>+pidfd_fdinfo_test
> pidfd_getfd_test

Thanks for spotting this.
I'll pick this up along with other fixes I have waiting.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
