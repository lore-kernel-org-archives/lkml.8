Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F9C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B3520663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584989640;
	bh=TpgeFsk43ZnYIDWz2FkvZMl3oqHEn0h/sG8/jCn10u4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0sH/VE0uB8rWOLfegQUCMa0MY6q8yd95LuWex0u7eA65JOlRakMTWazTMuju3CjYk
	 iLABPCUMiCcTrxi2i7Uvr3OvnXL8DGKL5yih2wK0ZcMRPUvTbMKUPkf8qwUWOwk6K+
	 4VGlIzRnKRtWXyvJGikocqt+uDZiA/MtiSpPx7fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCWSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:53:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33515 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgCWSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:53:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id r22so8789921ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xT9WWuFFW8pieKRahEfsWg5SF019+QS1+JnL4E8cCB4=;
        b=YNgFrfR7Mw5tLDwwUjvn75Ca7fv4Jf7SSpvUs/3TCabeAEfODE+ZjmS2lPsyispPmf
         rG6KCK7cV5m84l6/UlMlQXTeNN3zvhPV+Uxi/jPFG/cbGxkZ/LoMP7fCgt23E4zzAimN
         WuHzIY3PXnQzuJM0SID2wsIKuKucaWBDZ6mtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xT9WWuFFW8pieKRahEfsWg5SF019+QS1+JnL4E8cCB4=;
        b=YY09iuZK9tfB/qW8eLCtYbH2HsFOHowW/XELK2iXw3oELRA2WPHi8uyqX6sNF7CVdY
         FkaiLaMBr+rLfCJaXm/AdXQPzmqF6V+IHMtWurlmD64Wu30pkTOxx4yuGrgy9O/iT78N
         rCZR6qlbQ72jNgUffGqnAW/LGXjcPhuz9axanksqzBFsphBBDO29dAr9EY9h3oAlZOGN
         vxpLAoyFUd2jj7Zyvavn7paHUaOsTzgRTF+WDufNsCOa8wLGBJDNGdVrLzCXpimx3zKL
         e2Oy1PLDGnpTxRyOJkeK+Frw0/z4hAFkhRqjlAoP6QpPuVKcKhb9A0kJaoNkB0ocj3Ui
         5tkQ==
X-Gm-Message-State: ANhLgQ172X2b2H9CdEgVGC8OCTh7tdSG8IhXezcPmPmXIc3bTeEQDl1k
        QxJBNeLQfA935bZ1fD9wHmWD+/w19IM=
X-Google-Smtp-Source: ADFU+vvVPbtkkFtLVId5it/C71kPTwMvc08akduYZWNcjnJG8px/hC8X+gS1vl6wK9xnxX2zQkrRNw==
X-Received: by 2002:a2e:9bd7:: with SMTP id w23mr6460001ljj.47.1584989636980;
        Mon, 23 Mar 2020 11:53:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t136sm4758740lff.48.2020.03.23.11.53.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:53:56 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y83so3342534lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:53:55 -0700 (PDT)
X-Received: by 2002:ac2:5203:: with SMTP id a3mr14110898lfl.152.1584989635550;
 Mon, 23 Mar 2020 11:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200323183819.250124-13-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200323183819.250124-13-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Mar 2020 11:53:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQjm2=Z6e9ZLffsNmnc_e2wz_W3SYTD2_EXZT7yYYbRA@mail.gmail.com>
Message-ID: <CAHk-=wgQjm2=Z6e9ZLffsNmnc_e2wz_W3SYTD2_EXZT7yYYbRA@mail.gmail.com>
Subject: Re: [RFC][PATCH 13/22] x86: ia32_setup_sigcontext(): lift
 user_access_{begin,end}() into the callers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -static int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,
> +static __always_inline int ia32_setup_sigcontext(struct sigcontext_32 __user *sc,

Please rename this at the same time (to "unsafe_ia32_setup_sigcontext()").

I absolutely _hate_ how we have historically split the "__get_user()"
calls from the "access_ok()" calls, and then have had bugs when we had
ways to reach the user access without checking it.

Yes, we have static checking for the unsafe stuff in objtool now, but
I still want this to be explicit on the source level too: if you do
unsafe user accesses, you make it very very explicit in the naming, so
that you can't possibly even by mistake have a "let's call this
function withou having done the user_access_begin()" calls.

             Linus
