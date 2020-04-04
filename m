Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A1C4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A771E206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586021538;
	bh=xFBjOg7ZEVQ1n8iaFN0sM00d7h2msHl/Gi/3qHkuT3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HoF0HnepBpazpcYOUjg4ox/pGR0d37/vNludgAMyU02K7DkBbAjaO3lVFNcZl500T
	 ihT5ChI4YIIccaiHFQxhE82dnHVRoM38AaBNl6AZlrIiAoNvntLPqxd8OUY7eppExq
	 JwQqdeIDnN/GhNuhxFbghB7OaIWNFmIntzu6DxyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgDDRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:32:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46008 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgDDRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:32:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so7049869lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1ZJcdAUzE9Vyh44Y4ha24xHv2g0N2dp6kI2xhyw/Z0=;
        b=al4IMbCEpHK2m7QBBqQ1EJ+VPsWDMXq2l4L7pI8G33rKqgiEsxFUICPGPLYLN5ZXwG
         dbaL3CPhh0Wwocn+TsGgm3fayVxqJC689omLv0LnnvlWQTSirJJ5s8F35VkxNSUAWfrL
         SrcUTzj77IYVZyUJImTYLJW6+Vswz26Fme1zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1ZJcdAUzE9Vyh44Y4ha24xHv2g0N2dp6kI2xhyw/Z0=;
        b=mUalnHpKS/zkwiQrB2tGQvO8NIOD1hwzypnrFEtvJnzSR3UERe3hiaLWqfooVCwJZT
         F6d8ej2Yy4sc9lV1cMiwAcNPfamqYqyvZhYGAeUCMFBudlJXzJ/kOXIMF4pALBbvP94o
         t8iXZuu3ClM2FleBdSYOj20MDISX34rEW9Q2tKn0CJ2h7MH8qa0yZ4Z5kVX8ZI0haIci
         +sJ0LqVFPSGid0HV0E5Mv3F1Z/X6rgV68LJUe0vIfsnHslj5Z6c/vTHgEttk+9EcsIV8
         +MPbz5iFGSqwbIbDEWuT2OfCzmPWvRTS8zOicDLsIKLER23XALzr5nIwR+AWY2k5Rq85
         cAqg==
X-Gm-Message-State: AGi0PuacOmiluLkc7wy1lxXHklVhQS1VfmZty3Hnz9qH3PFaLYOGuJoM
        elSPFuW4zbgjaq/3ZP3nacM76MgxmZ4=
X-Google-Smtp-Source: APiQypIy3rs5TM4ATJBgw/48uO1cUzOxl3v2oK7Pn288QI0RwOrQjQvy6nKF7/Ufv9ZqkJcEYWF7Zw==
X-Received: by 2002:a19:7411:: with SMTP id v17mr8841985lfe.27.1586021532254;
        Sat, 04 Apr 2020 10:32:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u4sm7004323ljj.44.2020.04.04.10.32.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 10:32:10 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q19so10197828ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 10:32:09 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr7366641ljc.209.1586021529661;
 Sat, 04 Apr 2020 10:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com> <20200404160100.GB26298@redhat.com>
 <20200404170604.GN23230@ZenIV.linux.org.uk>
In-Reply-To: <20200404170604.GN23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Apr 2020 10:31:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfh4Q_UiOo9uYdXVsggbLhCr4pRsB4VAWMhgZ2X9d_sw@mail.gmail.com>
Message-ID: <CAHk-=whfh4Q_UiOo9uYdXVsggbLhCr4pRsB4VAWMhgZ2X9d_sw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic headers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 10:06 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I propose to do is the patch below (against the current mainline);
> objections?

Lovely. Simple and clean.

               Linus
