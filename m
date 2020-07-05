Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F59320739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593979877;
	bh=nui5RTL0WQHaODjblCmuPuKULAuM79jU0eVBWbi+jGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y0U4fzsetd9lNyr8PaRLB/RYvX5cKd+0+GxZu0ENrb0Qs0HTFZHcrjgwF9CNttg+b
	 8kbs3cKuOhvhcBc4mRLbhtuOwk36FcYvqFoV8ixzkHRqytYYjSrXcB3sqztp3y2+NL
	 ODBnBlcYTHXIobqQxK5oC2mOgmvAj1HRGEyfMCiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGEULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGEULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:11:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED977C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 13:11:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so40372693ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bli7823nzgPd4+zzTvhEWYIQlQOolCEdTUm/wr04xHI=;
        b=R7tVqK4S06XyeSJoTsJjrNQfFwww4cEHoPm/CtrrugENTDy1vqCVO+sDyMGWTFks1W
         5RawwMRBiS/INbOjWFg3B9vdk7NUoOnjuO+5/kBRz+Eb+sT5BIBi86j23t13MrcW941E
         tjh8GC9eV5hPjYuXImtn6v1yDp1zlaW2xJOOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bli7823nzgPd4+zzTvhEWYIQlQOolCEdTUm/wr04xHI=;
        b=V+/9J8qZHHDarXX1HyF6eRPAlseBsFwONbxjb5VdTxFOXb1kjWe0FOFIDzZLXa7rv8
         wVeDApou7U6+I1tjlhsM4Z0S0lKPD78i1gAcK6ev7HCsozdUJQFbz2mRFdON+NPqlOkY
         gJcjm3WDFDUo+awSp/6800DWfXKpuldwThbJcL2PXbP8RHPQqNU5PXzKQvtSKKSJ2DLy
         ntyDWvCt+vnNASKt0Tcs1P2sl0HOx+hU8vjbLrJJVFL5HjmEUUQNphq9+99H8pApqsAt
         S2K0/H/pKxJZxNGZII1wjTKB+XmKuua44fIwTwuhpLvhHeDnYV9Qw0ehTYGZNQ4YT1Z+
         jkPA==
X-Gm-Message-State: AOAM530UQugUHGdzPUSa3vBcu9zkpoFmSem/MIq8Q6vpMiF99mp0wU5e
        Qc+jYZKsnL+Dl81jIUAzQeDfRPT8aww=
X-Google-Smtp-Source: ABdhPJy1to8OWj7NdCwNp/KKO1EII+oJbDcQYxDZ8Sba/2lK73FAzTWnVaALlJshvTTOy97Lo8+3tA==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr40424866ejc.1.1593979873474;
        Sun, 05 Jul 2020 13:11:13 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id o15sm20892970edv.55.2020.07.05.13.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 13:11:12 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id f12so14145185eja.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:11:11 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr24759339ljj.102.1593979869955;
 Sun, 05 Jul 2020 13:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200702232638.2946421-1-keescook@chromium.org>
 <20200702232638.2946421-5-keescook@chromium.org> <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
 <202007030848.265EA58@keescook>
In-Reply-To: <202007030848.265EA58@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jul 2020 13:10:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEkTsNRvEM9W_JiVN6t70SnPuP=-1=LyhLS_BJ25Q4sQ@mail.gmail.com>
Message-ID: <CAHk-=wgEkTsNRvEM9W_JiVN6t70SnPuP=-1=LyhLS_BJ25Q4sQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
To:     Kees Cook <keescook@chromium.org>
Cc:     Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        stable <stable@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 8:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> With 67 kthreads on a booted system, this patch does not immediately
> blow up...

Did you try making read/write inc/dec that thing too? Or does that
just blow up with tons of warnings?

                 Linus
