Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714AFC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FFD24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZjz6JeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBSUMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:12:34 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42281 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:12:34 -0500
Received: by mail-vk1-f195.google.com with SMTP id c15so509822vko.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42MaK4n6+CrelpQTjPFZO9NB2S0O1OTsWCtSJ9pIv6o=;
        b=KZjz6JeV1vFYXt8q0wyrdwBhXZ/8rzg3LVXGgnEjLp0yccOlrd9L+Ok9CSnmEDAScF
         5DXgdCokxyl/DepQSJRvQZcSN+CE8Kcr0SWpEfzBMCL7WlKU8JPwmUJCsE2rI7Vb7lKV
         bgQULZyhEbb7MwpvmgaQHsqZa8CaNOAvokqUXRgGKlW538y3zdoMMZdFUy60Yhv2WJdn
         xOhNioYtaDA8ydHmJeTzDTHNO8vInpQ9cb9Ph5Mu9jvt5hFURbjsN43FQ7NZbkVfeBb2
         LHRWZWKArxzLHQPRZfP/szxqEcv4AqpjRJQcw8TGu10OvO3/JnOO2GhuCUA9yjJvEBPV
         ehWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42MaK4n6+CrelpQTjPFZO9NB2S0O1OTsWCtSJ9pIv6o=;
        b=Z8BhsKge4kFfCpHTxFnaYFm30Z1SnWHzVIPCHHNXPl9EXvQppcGvBILGM3DhwQIGPl
         RVbLuYoHKEm6+ZJhBXv6OUYDIB+Gw/8/pgWCFqO8gMlyhP7j2TFvzl97NWpcZUPnGXW5
         1A3cMi5ZsreplbhzGVjIA0zkfcgbAkCzNV35gZauzjQKjZ7BrB089mkdDjVhPBhrEkjB
         pUGrcSs5auicTgMRS7Jv+E7MX3/Dw+PiZbaCvnzBMb/YyqlmRIF5Gcsfbfr8Phy96/2g
         jf+zVPbcDXuwOxLkYT/DDDSc89r3EjZAH5L5DiEGDja9y7aUuE1AbX5qnfbs40g7kj41
         /APA==
X-Gm-Message-State: APjAAAX+IZrAR8pUqZgGgYYoNGLnrjD5nS6YqNbNFvkefwOsky5M5/72
        Aot86DSTWe2hLlbMeZ4p+6M3yLGReDuuNnc9KoYqEg==
X-Google-Smtp-Source: APXvYqyTw52gSQ4jw8pztzOwndZ0sk6pyQFwXTfytaf2zPfg719bU3sRcZ3Xjk3tkUfVqd3npa2/1rrBf+K/+C8JeGQ=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr12216061vka.59.1582143153200;
 Wed, 19 Feb 2020 12:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com> <0386ecad-f3d6-f1dc-90da-7f05b2793839@arm.com>
In-Reply-To: <0386ecad-f3d6-f1dc-90da-7f05b2793839@arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 19 Feb 2020 12:12:21 -0800
Message-ID: <CABCJKudAYATQSVLHbM4873Yr2EYufrBWQ7Pmv+L97uHhBQUe4w@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] add support for Clang's Shadow Call Stack
To:     James Morse <james.morse@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:38 AM James Morse <james.morse@arm.com> wrote:
> This looks like reserving x18 is causing Clang to not-inline the __kern_hyp_va() calls,
> losing the vitally important section information. (I can see why the compiler thinks this
> is fair)

Thanks for catching this. This doesn't appear to be caused by
reserving x18, it looks like SCS itself is causing clang to avoid
inlining these. If I add __noscs to __kern_hyp_va(), clang inlines the
function again. __always_inline also works, as you pointed out.

> Is this a known, er, thing, with clang-9?

I can reproduce this with ToT clang as well.

> I suspect repainting all KVM's 'inline' with __always_inline will fix it. (yuck!) I'll try
> tomorrow.

I think switching to __always_inline is the correct solution here.

Sami
