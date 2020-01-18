Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0322C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5DF2469A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c21wyCfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgARQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 11:48:25 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50384 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgARQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 11:48:24 -0500
Received: by mail-wm1-f49.google.com with SMTP id a5so10350888wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=v1MPrpX5UM37b+llc07N3hu5ZFo2kqEu8ELg7H2rai8=;
        b=c21wyCfH2LEVIja5t7JZahA2Q6Lkin9Flsmu8hN5QkUy8ZTsDAAN1cf8f7+BLE42uR
         mj860LTIzLsM3RtQMREbS6EqNUvbw9uVO2wKWMl5nPFIpFYXeSM9s72QYDaUC5ObqDhO
         5e0KM9GMT/Y0XUyRpXJXJEgY4eEqYuyvMS8ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=v1MPrpX5UM37b+llc07N3hu5ZFo2kqEu8ELg7H2rai8=;
        b=LJbdxbJqwgvCoD+z8iecHdPxQn6kYLuR4I+XrKoBpgWqE6ej6nC04YXhJ5IVFPRKl3
         7t+pN/HZeseuim7ZY1UJKYoTf9lsA7UY5+VKYd/KCQO3h2/ADsmt7MQSWVnrhzCwoPUi
         PTuiIR3VhAg9EHlTgfk9IzJtXwG6NHcHx7HMa0o1D19Q2CTNYQeZBUfRzvCMjakhmWTs
         jLhrvVsiGgJkgwwtvCFgr0/9MFHpjxIdD715aiyHTYtzuBc3nv9BRFVItxtNZVjzhijM
         kCrnfe/11gPELzDCtB+gxVbAAVNRLFvTeiUgI/nW5zdp5gMfue+8BNOGQjyXDwxXdrJr
         8Fqg==
X-Gm-Message-State: APjAAAW6zRvX8qCIy6NWAqLNMhFGg5KBls0S9oUjWqDtH3ofWaVGX6Em
        2TNp4lKROktwubmZy6XvqLPtig==
X-Google-Smtp-Source: APXvYqzTy+N02WS0E0WYHsBPK35MSFt8/EysPCPGrZT9S0qs08llU/rfXcedDWx0816DIOzNlG5D8A==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr11146359wmb.137.1579366102273;
        Sat, 18 Jan 2020 08:48:22 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id p5sm37448454wrt.79.2020.01.18.08.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 08:48:21 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: getrusage(RUSAGE_BOTH)
Message-ID: <ca7a02ad-2408-0cd8-e54e-d7dbecf9f0ba@rasmusvillemoes.dk>
Date:   Sat, 18 Jan 2020 17:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RUSAGE_BOTH exists in the uapi header, but currently sys_getrusage
rejects it with -EINVAL:

SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
{
        struct rusage r;

        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN &&
            who != RUSAGE_THREAD)
                return -EINVAL;

getrusage(RUSAGE_BOTH) is used by the exit code in various places. But
is there any good reason not to allow userspace to use it? Of course one
can get the same info with two calls using RUSAGE_CHILDREN +
RUSAGE_SELF, but that seems a bit silly when the kernel already has the
code to do the summation.

Apart from the obvious addition above, I think the only thing needed is
to adjust the conditions where mm_highwater_rss gets updated:

        if (who != RUSAGE_CHILDREN && who != RUSAGE_BOTH) {
                struct mm_struct *mm = get_task_mm(p);

                if (mm) {
                        setmax_mm_hiwater_rss(&maxrss, mm);
                        mmput(mm);
                }



If RUSAGE_BOTH is not supposed to be used, perhaps it should be removed
from the uapi header?

Rasmus
