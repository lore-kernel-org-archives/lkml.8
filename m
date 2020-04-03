Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F34C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCBE206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585933424;
	bh=VJ3UvXiGIFoKcvKxye79uGqBaWUJ0CUGwyrmMoBijI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CLlH/h8tiCy4nnvk+gVPJ2+mT9Xsf1VetDaN3VGA1XmUQfgTVvbEAriMtNA0L42g/
	 W/c7zD8MDA25xRrMM/JWR9NPLTkQ79C5Nyqi2eUJS5KPDOls41A2U7hje+gZ5ltb7d
	 GlwY+iN4esuqhamNC2/yJu+X7iZ+l2mIXlCyTGBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbgDCRDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:03:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40871 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgDCRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:03:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so7658996ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osWnZTRFrERPRvjQV1oxqFtgAfM+t2aXm4BmItThVbY=;
        b=Q66SAsiyB/dcp3evAiaFZOWj2Luj1W9bWfjGrupDMZ6/ZpeHIYUWl4GYPxLoDlBaVa
         ua2tv/WvTxjS+h01PueD+2pmjE8OZUGADC79GXF6v5cp0IRMJPrP65i4xvyubqD/4Qu+
         oigARjvJzsTo1GXsZT+XxUFtlBUArDfqOh5GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osWnZTRFrERPRvjQV1oxqFtgAfM+t2aXm4BmItThVbY=;
        b=RqRen305xx//440k5RUbt+TZ++KCgLGbLh0KkaC5pCJjhWc0vXXXxHmTHgPY0xeDNw
         7qM4hH/mVoMTu8dX95lyHdkDqfew86AdI1dhtn92mqgEL7fxWilFeKSgjdOwfHuBS5wW
         TzvJRmPb9RdxYKBHJhBddd9zIf2HSgcLxD5a8jcNpZQzV3nuHYlcfS4TN6e4J8+DGn6L
         A5MABnOpcntl0bRWi3ixJsL7fZl3elA3r7qLpr8n9tnoXpZgAYmU18jlqyERe1GbpMgt
         kZNDYNyryCFYg+37UeEQB8MfO3xlTp9G7XE7XRIzo2FBYlWQN3AF35LbrHfJJIpT0R+d
         VZDA==
X-Gm-Message-State: AGi0PuYr4KOmvtQBorfwg1vwJYJXGzYc7TrF8LUZrxi0ZZ4YnrqLLGvT
        Uj+PloA7EtQjwW0wZNI4lCfwWBiWQL0=
X-Google-Smtp-Source: APiQypL75sgIoAoa5RUs4K+eseQxKJz0ggE3BJALyEFYXgwfyzxMdP2V44NxRh08f2ABaajbBF7ctg==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr5372038ljg.171.1585933419558;
        Fri, 03 Apr 2020 10:03:39 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l13sm5274571ljc.84.2020.04.03.10.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:03:38 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id g27so7630780ljn.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:03:38 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr5423949lji.150.1585933417930;
 Fri, 03 Apr 2020 10:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com>
 <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
 <87v9mioj5r.fsf@nanos.tec.linutronix.de> <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
 <nycvar.YEU.7.76.2004031546080.7494@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.2004031546080.7494@gjva.wvxbf.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 10:03:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF+j-sc98Oa8_c=tcfaVf7XfeLJGPgsWhBR+rwH5cjFw@mail.gmail.com>
Message-ID: <CAHk-=wjF+j-sc98Oa8_c=tcfaVf7XfeLJGPgsWhBR+rwH5cjFw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 6:47 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> FWIW, I am routinely using Joerg's
>
>         https://github.com/joergroedel/asmtool
>
> for exactly this.

Ahh, that seems to be on *.s files only.

I really prefer working on the object file basis, so that I can do a
diff of the whole kernel if required, and (if I care about just one
file) so that it shows the real code rather than all the odd section
stuff we end up having for alternatives etc.

               Linus
