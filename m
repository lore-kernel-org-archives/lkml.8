Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2906922D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596653923;
	bh=JPzNQBGce2yeRBowIzU6pEVT+PgSjXh+pta/6Jv8y74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mQ5HhARy2s8gwh2E/5pTgq1NrwY1WuYP90BuKGpy1Fj1ypHtco5uBRtF9tpDYA5RY
	 /ZESiecZzlJCfAET3yz6EeXuzVAxYAEjQi9cGK5O79zvN/gDbi98VxiYdFMXbZSjnD
	 buTaTWwZyiAcIKG3NHTQBdJi7PcIDiIgHjVRiKMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHES6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHESit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:38:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB2C0617A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:37:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so39167846ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKsScY2SqSaUIDsji3DbH9vARZk9m+RN1f7vMYsfm00=;
        b=iAliQHEzDRAQlVI4XXSIEEBg6aUSSqeUoOj5qeHelfslSrZjysk8SyFIWWp/lX6uob
         Y8tkVHXeObZH8duByODMzQ/D2ShBAyXocCIroPsjHVj8OZ4FmcQmee7YLXFV+OzoqNW2
         aU7z0qneabKk64K5/XBM2l0UNPBabO/B59bN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKsScY2SqSaUIDsji3DbH9vARZk9m+RN1f7vMYsfm00=;
        b=RiVapZVonZRpBe0jDxvoPTC2PFu1+/A8z4l5+5RnmufPMYuhGMHsmxOiYbJ5hFctf4
         WkqFzLcOgi+dm4kIU/2glBK8sQQd7ouaUjUD3Jx7vUaPp36LJf9j7ELaxrjOsO3st9SA
         XomLMQnlNUJpJONNyMJmPyWUDh25VKbZJvTniaUfJqUInwyh63dOFHWkbOGZPeztkos6
         XECdoXBvf7Xsm4PzRphneHq1dlmspa+01gM1BWR/NJS6JqD6lLfTJQ6kzsSnvHUQFNcV
         qD+xDkdf0W1RF0AOEJSMoW3uRvSVSGp5CsyPKg7kxXW0rDFeFkko16I6zqlXBR7rLmIR
         34Qw==
X-Gm-Message-State: AOAM530N1xuNZkFe3vrttbLYHO0yzVsOxbk7I5tcFF2qSKJ7MLL72gA4
        7b5wBAk/DNBozbg0qxvu12AnYKmKliA=
X-Google-Smtp-Source: ABdhPJzXYlUR/49PQasmpk9i0vhB3xmqqxjOUPQRgOltDQaO/ywhqMslWNq8Bowbskpi8D6BzpWRWA==
X-Received: by 2002:a2e:97da:: with SMTP id m26mr2238024ljj.9.1596652656307;
        Wed, 05 Aug 2020 11:37:36 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p1sm1222158lji.93.2020.08.05.11.37.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:37:34 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x9so48881032ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:37:33 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr1797749ljk.421.1596652652831;
 Wed, 05 Aug 2020 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153506.978105994@linuxfoundation.org> <CA+G9fYv_aX36Kq_RD5dAL_By4AFq=-ZY_qh7VhLG=HJQv5mDzg@mail.gmail.com>
 <71a132bf-5ddb-a97a-9b65-6767fd806ee9@roeck-us.net>
In-Reply-To: <71a132bf-5ddb-a97a-9b65-6767fd806ee9@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 11:37:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0WGMs6+Jz6rXbQO4mfzf8LGVc3TwmCdz0OwRtj7GgMQ@mail.gmail.com>
Message-ID: <CAHk-=wi0WGMs6+Jz6rXbQO4mfzf8LGVc3TwmCdz0OwRtj7GgMQ@mail.gmail.com>
Subject: Re: [PATCH 5.7 0/6] 5.7.14-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 11:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Same with older versions of gcc. I don't see the problem with the
> mainline kernel.

  https://www.youtube.com/watch?v=-b5aW08ivHU

> I think this is caused by more recursive includes.
> arch/arm64/include/asm/archrandom.h includes include/linux/random.h
> which includes arch/arm64/include/asm/archrandom.h to get the definition
> of arch_get_random_seed_long_early (which it won't get because of
> the recursion).
>
> What I don't really understand is how this works with new versions
> of gcc.

Is that the only place it triggers?

Because the trivial fix would be something like the appended, which is
the right thing to do anyway.

              Linus

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 07c4c8cc4a67..9ded4237e1c1 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -11,8 +11,8 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
+#include <linux/random.h>

-#include <asm/archrandom.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
