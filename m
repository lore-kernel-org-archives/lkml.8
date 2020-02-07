Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC6C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117DF2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKSa49CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBGAEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:04:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36273 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBGAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:04:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so235351plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZFFBxKxZAZaC7rKowP3dBpqjl3coMOLVdOhrj8QTtU=;
        b=dKSa49CEXUtfhaZRDGsWkw+O6hjCch6SZ9FjRK0eY4/j1tRdrVPrwz6EYDVcQfnF3w
         NUIWH9CEe3EeOP1+HMxOeHGtdV9cduvQm0+D8p+g0cvufaHEP+Xjj4K64VfC4r5Sne5Y
         PiJ/8tS8P/OSvU+SOtZ/5EDx8P1/kyQ2Sih+UALy776fneFXX+1zd1+KhZqKY7eswxyA
         AwCfod4jqeJ0oj8ju1hjz6YvTWkZ/N1+3da+rS2EYvrPoKapEbY2/YmTPjdjuGR/8azj
         OvcW7xRvwWqhNOXhN0mHgP8AVqNuIHD9YYa//7GhbWo6ohLbN3qT4vymsMb8etY371ps
         /efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZFFBxKxZAZaC7rKowP3dBpqjl3coMOLVdOhrj8QTtU=;
        b=td/qlNkOfRDnTm7M09lVmNioXEE9XCaPRACPsRejdGFSvX4xqpxyZujDjfvTtoNyks
         tA2sZpw0He886FORGt+w+CW1DYzduTIUf/WJOrNztldt5oqDgyKHY7NqXpzFooVnRrzt
         gPuTtldQuFs97mruiTSohbKKp28E+CV/7+x4sahwE2b/V8RfzN2jeCoDTaLGMIBzmvYA
         MdGOgwVQ+7blaQlD5L2KkAGxen6c2YFbG15a4vPwbLTWXAToAYH5PlkdPPmpup+Td1go
         y48Ymr0lQuZVxdccgpJdW4p5t+uRnV1LkyKjYHgFI6JVMciyoQGRFSSUBX7wGT4K6chw
         owxg==
X-Gm-Message-State: APjAAAXzvyQPlfNqwPIVKVuwZ0HZgygAk2lRKAZsIqKteUcTsKh2wrOK
        JemZIZLmQ59ZjcdF5hV54lH98I4era2hxxKWFTqZpQ==
X-Google-Smtp-Source: APXvYqyA9NYMs7vZ3ED+CoZUpSbhn4IlsxFLfzt20lRi0wAfDekv3xkC/NhND7OCu35LYPy7af9afZnqFsVR+uFgjHI=
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr438587pjs.73.1581033883832;
 Thu, 06 Feb 2020 16:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20200206200345.175344-1-caij2003@gmail.com> <20200206232840.227705-1-ndesaulniers@google.com>
 <CAOHxzjGiO54BwUDR4zz6MwvFT3-XXDx830cQcQAcVUPA1N_emA@mail.gmail.com>
In-Reply-To: <CAOHxzjGiO54BwUDR4zz6MwvFT3-XXDx830cQcQAcVUPA1N_emA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Feb 2020 00:04:31 +0000
Message-ID: <CAKwvOdkaQJrXt3y_QDyZpQpeJqB0nYsV_p21h63SS1k2Q3Da=w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: fix an uninitialized use
To:     Jian Cai <caij2003@gmail.com>
Cc:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 12:55 AM Jian Cai <caij2003@gmail.com> wrote:
>
> Hi Nick,
>
> 'ret' is only defined in if branches and for loops (e.g. for_each_component_dais). If none of these branches or loops get executed, then eventually we end up having

https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-core.c#L1276
and
https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-core.c#L1287
both assign to `ret` before any `goto` is taken.  Are you perhaps
looking at an older branch of the LTS tree, but not the master branch
of the mainline tree? (Or it's possible that it's 1am here in Zurich,
and I should go to bed).


>
> int ret;
>
> err_probe:
>         if (ret < 0)
>                 soc_cleanup_component(component);
>
> With -ftrivial-auto-var-init=pattern, this code becomes
>
> int ret;
>
> err_probe:
>        ret = 0xAAAAAAAA;
>         if (ret < 0)
>                 soc_cleanup_component(component);
>
> So soc_cleanup_component gets called unintentionally this case, which causes the built kernel to miss some files.
>
>
>
> On Thu, Feb 6, 2020 at 3:28 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> > Fixed the uninitialized use of a signed integer variable ret in
>> > soc_probe_component when all its definitions are not executed. This
>> > caused  -ftrivial-auto-var-init=pattern to initialize the variable to
>> > repeated 0xAA (i.e. a negative value) and triggered the following code
>> > unintentionally.
>>
>> > Signed-off-by: Jian Cai <caij2003@gmail.com>
>>
>> Hi Jian,
>> I don't quite follow; it looks like `ret` is assigned to multiple times in
>> `soc_probe_component`. Are one of the return values of one of the functions
>> that are called then assigned to `ret` undefined? What control flow path leaves
>> `ret` unitialized?



-- 
Thanks,
~Nick Desaulniers
