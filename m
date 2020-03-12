Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87566C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3D020716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuWZb5OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCLTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:12:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38928 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:12:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id a9so7490376otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=br59p/WxMJzApfSDzFUy2rH5chEfRS0gRgX+QpI5TQI=;
        b=YuWZb5OUvfP4UiF3Q79CPA0Rl8/VZg6BHOSb78QspySHoIe9nZcqFo4h/M30o4lNCX
         QC2QvvP6RXCBK95Wau/qcfJdctdqvWNntHly5AyTrbSmksEv+xqQ/GNQVTQkVMpCCHc3
         SMZaC7hX3Ly8VznrMv0SFEOMF/P025dSbjgKbK1ns/Zef41YwkTXCIk0wLeuRj5skm0P
         4WgVbLZa/mE6u+ZmVdpdZVzK26HUSsJzgnFr5ASttT+1WNtaQTKjar3HktLfGyexTa5R
         CxhNv90tWxv/gY2/ZbNOSWZF9/0Wqr5JlcR8QjsMHYl/9UP/yoAW1j7N8NL1Tr5pODO6
         Gkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=br59p/WxMJzApfSDzFUy2rH5chEfRS0gRgX+QpI5TQI=;
        b=FxuYXXPgpQGBdcm+TWjmFt6FMc3yAzQFGRSi68YFFdGR1ZPAxlGrfBXD+CF3Y9KoOr
         ZxAarR8JUMBBNYtMrhMSuY+IHP02een2nLTaiGsnQP+7TKfOKoLgzoQSXZsHSo8CN+Xq
         aYdw6OGGi/0cuOK5wG4wm2qSktzYVumi5lqxOimWkEvPvCLnIKRE+VtMmzGorB9lwsuX
         S2VeYqc4HFbuuiyq/JEfwyqlfXCZuApN+3eVbhTWLeYAgptpNsJE8A4Iz0yBdsb6MSzp
         ib36LbSmMEJHmFtp4fyndKp9VGmNo0ABl1DiJ1LYKjnab9gVOSEKCILggWi/BaO9gba4
         pFBQ==
X-Gm-Message-State: ANhLgQ2nQeK5880w6/2NujTTXjmqrQl71Jg1vWatkv3M+UdYx8Pi5LZU
        trTeVyR+0suachrmzPPH7lpDmfkf1L57n27Cocmojw==
X-Google-Smtp-Source: ADFU+vv1VI2nO9cb9OiwG6iHScK+zvC8SCjM2CzU4HHKXK9MyYRonPXHML9v+gxI0G1Wvz5unyZiuUrpfI4M4YR8jgc=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr7862081otl.110.1584040362686;
 Thu, 12 Mar 2020 12:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584033751.git.jpoimboe@redhat.com> <45505e1a05d93f0b80a50868dc8d2c1570f92241.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <45505e1a05d93f0b80a50868dc8d2c1570f92241.1584033751.git.jpoimboe@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Mar 2020 20:12:16 +0100
Message-ID: <CAG48ez2L5eBfU57_bFnSPSN7DUrocJB56wBLR6cE0e_5DdkURg@mail.gmail.com>
Subject: Re: [PATCH 13/14] x86/unwind/orc: Add more unwinder warnings
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 6:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Make sure warnings are displayed for all error scenarios (except when
> encountering an empty unwind hint).
[...]
>         /* End-of-stack check for kernel threads: */
>         if (orc->sp_reg == ORC_REG_UNDEFINED) {
> -               if (!orc->end)
> +               if (!orc->end) {
> +                       /*
> +                        * This is reported as an error for the caller, but
> +                        * otherwise it isn't worth warning about.  In theory
> +                        * it can only happen when hitting UNWIND_HINT_EMPTY in
> +                        * entry code, close to a kernel exit point.
> +                        */
>                         goto err;

But UNWIND_HINT_EMPTY sets end=1, right? And this is the branch for
end==0. What am I missing?
