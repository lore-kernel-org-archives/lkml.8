Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57098C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD662073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFVUQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgFVUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:16:05 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40978C061573;
        Mon, 22 Jun 2020 13:16:05 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2060F3F0CE;
        Mon, 22 Jun 2020 20:15:57 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
 <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
 <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
 <20200622070623.086f1623@lwn.net>
 <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
 <adf85348dcbfbf64157e6519115b3a0c9f35df55.camel@perches.com>
 <CANiq72mSz+LWLwOCa=9YtzKaD+NjhjZdRdwFiZ-gLMbjYd=QzA@mail.gmail.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <b2eeb299-d43b-54db-07a8-b50f5b66e7b7@al2klimov.de>
Date:   Mon, 22 Jun 2020 22:15:57 +0200
MIME-Version: 1.0
In-Reply-To: <CANiq72mSz+LWLwOCa=9YtzKaD+NjhjZdRdwFiZ-gLMbjYd=QzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 22.06.20 um 22:06 schrieb Miguel Ojeda:
> On Mon, Jun 22, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
>>
>> scripts/get_maintainer.pl --self-test=links has a reachability test
>> using wget.
>>
>> Perhaps a script like that could be used for http:// vs https://
> 
> +1
> 
> Not sure about `--no-check-certificate` if the goal is to move to
> "proper HTTPS". Perhaps we can try first without it and if that fails,
> print a warning and try with `--no-check-certificate` etc.
To be honest my script even blocked HTTPS->HTTP redirections, so I opt 
for maximum security.

> 
> Cheers,
> Miguel
> 
Also I opt for freezing the discussion about eventual future runs of the 
script until everything from the first run[1] has been applied.


[1]
➜  linux git:(master) git stash show --shortstat
  1857 files changed, 2664 insertions(+), 2664 deletions(-)
➜  linux git:(master)
