Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C32AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D3820724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Obfep8GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgHTR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgHTR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:27:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008FC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:27:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so3456291ejx.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ewf+8/r8T+ocxKAIGX5h4PS/z3AFtkho8eATC5y+uhk=;
        b=Obfep8GDwJOj8YMmWlFSdQIaFfUZJNxuZ5wnp6NBFTdGC1SWtA7KpTHvf8PBpiWPAn
         JqBBAh1AwFctNZhfCq+fpMqkU79ayvttXSKA9YKcYkbispcHyReyR43IT1odLe623ZdL
         WxHmxQ95LGYxJkWiSyFsTSKr347gPRgj0DMF5OmyTL74Sl/Ug0zxcC4voImal8izbf+V
         WXCvCHG2db4v6DoE1dkkXT8UFoIy63ZFuOhfHawK8hOlKM9m43nkhJd59QFhM7a8N2yO
         OWF6GLQHwH5KMB1q5GdRLrsxztCQUjBdlwhB+IWWjLze8q0LHgLzQDsEztxo62B438eZ
         Dtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ewf+8/r8T+ocxKAIGX5h4PS/z3AFtkho8eATC5y+uhk=;
        b=cm9Ck8ZzfAhjIAUUiyQiuCu5GFJkvFvQj1FXpIv/ISM55RnKB7zJYTVQB9CnUq/uSY
         5cKM1uSdnsfEE3VJ6XgdlyGGXITsu/MAbN3Ny6xz5zVj09OBBziO/kVYnF7JvnC3nSnX
         srYspwTtpmM5nxb4YLdYzBajc7W72RjZs7DBBGx7gzt7bICukJIy3DVQZeiVrkuDtCNj
         pD/yTjJBkQJZXukDAQch9rAF/2RtATfr4BdvLpuMfjcofzndunuA6iT7aSORgnDEQLKY
         5GFL41DqpVvhjWnTOrBdMw18a4klT99TkYSk1PkhadF5YtxVnzBTVOL0/x36uTBy1ztA
         ldkA==
X-Gm-Message-State: AOAM532UhvUbKsAwR68W0b8Na0wa1jWuqFluHJMvfVTq8Ypm9yzSBsmH
        wmaoCmdeibFdlpjEozbYgP6uiXWxxJAkqXJBZNHFdA==
X-Google-Smtp-Source: ABdhPJxvAaKLLKKwXl1PefuwOJJemDCdpMhoIxK+ZZQ0EotjoFeAdC2HBCnvUkCHnM+WkXakEtqpibQt5p8Q6LwTQbc=
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr4456457ejz.196.1597944421480;
 Thu, 20 Aug 2020 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 20 Aug 2020 10:26:47 -0700
Message-ID: <CAP045ApB9Ju+V2HsTb=z19Y5+AgB9eHhS_QEiv1E8cLdreewzw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to
 change the syscall number at entry via orig_ax
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Aug 19 2020 at 10:14, Kyle Huey wrote:
> > tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
> > modifications to orig_ax in a syscall entry trace stop are not honored
> > and this breaks our code.
>
> My fault and I have no idead why none of the silly test cases
> noticed. Fix below.

That'll do it, thanks.

- Kyle

> Thanks,
>
>         tglx
> ---
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 9852e0d62d95..fcae019158ca 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>
>         syscall_enter_audit(regs, syscall);
>
> -       return ret ? : syscall;
> +       /* The above might have changed the syscall number */
> +       return ret ? : syscall_get_nr(current, regs);
>  }
>
>  noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
