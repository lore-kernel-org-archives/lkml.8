Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D89C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242AB2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS7dADSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLWNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHLWNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:13:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11057C061383;
        Wed, 12 Aug 2020 15:13:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so3471200wrf.0;
        Wed, 12 Aug 2020 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqBr0PUEEB8cuy5zVxMzbUajdX/OIAgekwWI0PNps94=;
        b=IS7dADSS4/kzfNN5NtOPUKoflz97qg8wOq0DIPx3EABg0XsxGFwzJT5tTD0QLKOfw2
         YaerRoAcVv8hFRBElyLPGsk/fqftmdee+zGcHvzoZovYxUNa8MtiCCG6wxdmEr5UmXrf
         r8YsKAHOZ8WF/VM970CZ1w3FiG0PkbiX9bRQ/DHq4HRQalIAqfm7+pEq4I0Nlya7aC5d
         oEZCyD1LSFgqfRuoSFt1anuVmRif+7HgajfaAO+jTtad/9ixj8/wv3TzVGUh6nm9FiJu
         z9HrQ+lTZLeJEGLZ7EqmJaeAEWK/mRLvraBkzw11UUKpYx99m0QTEhhNQ/fo76GGTjeB
         lH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqBr0PUEEB8cuy5zVxMzbUajdX/OIAgekwWI0PNps94=;
        b=fwWiAE2fTE7snQttbDhOTTDBmOV7aAu+Aq87z1cIzmluoV3bSOLuSYf3dbrSLc36Pd
         Iv+OmhAij25NWOOLh5pC3GKXA6jRsVavViV6sHtVgsXjZghf8pOGDY7w1lnAc052TUoz
         SJ6LKGoevex0bbcL3dSrh2Upn7Sduq6YkGG38AOVk5aAPaqEINrzWXP/WaoNl9Gmi1kB
         Gs35kL/TyUvB/8VDNq9nNzT0+G6Yi2lpEl8QZ8XNzDSOa2xSxOybqNwM+mxdX9bdcZzl
         3muZBn+kTiHl6Q/HHyIOhkwjMfDFm0WMIdYGxlF5MjfFEbHVkN5OYAny+VgTydAyGYYR
         t7fA==
X-Gm-Message-State: AOAM531BPZKcd7gbwQHT7bpK3UWUsxXSRSR8pqdtq8tpHVcTeHljKeAl
        uJysxhiS5f4e0SElYRynT1hp2nAGyCI=
X-Google-Smtp-Source: ABdhPJzxMvPco1yzHvAkRFJIuYcI1Dyvi7FzQFyyQ0vka1hjTWZiVbSPHBqCmElRMp5Nn93U3EXeBQ==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr1052626wrm.113.1597270415090;
        Wed, 12 Aug 2020 15:13:35 -0700 (PDT)
Received: from ?IPv6:2a01:cb00:b4d:ac00:dbd2:4764:90a3:4fd2? (2a01cb000b4dac00dbd2476490a34fd2.ipv6.abo.wanadoo.fr. [2a01:cb00:b4d:ac00:dbd2:4764:90a3:4fd2])
        by smtp.gmail.com with ESMTPSA id h13sm5788630wrx.17.2020.08.12.15.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 15:13:34 -0700 (PDT)
Subject: Re: [PATCH] docs: cdrom: Fix a typo and rst markup
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200808163123.17643-1-remi.andruccioli@gmail.com>
 <20200811104432.0fbe21db@lwn.net>
From:   Remi Andruccioli <remi.andruccioli@gmail.com>
Message-ID: <88e58f2a-c829-8572-a858-e73cdfe41027@gmail.com>
Date:   Thu, 13 Aug 2020 00:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811104432.0fbe21db@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Aug 2020 18:44:32 +0200, Jonathan Corbet <corbet@lwn.net> wrote:
> On Sat,  8 Aug 2020 18:31:23 +0200
> Remi Andruccioli <remi.andruccioli@gmail.com> wrote:
> 
>> "The capability fags" should be "The capability flags".
>>
>> In rst markup, a incorrect markup expression is causing bad rendering in
>> Sphinx output. Replace the erroneous single quote by a backquote.
>>
>> Signed-off-by: Remi Andruccioli <remi.andruccioli@gmail.com>
>> ---
>>  Documentation/cdrom/cdrom-standard.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I've applied this, thanks.
Thanks to you Jonathan.
> 
> The backtick replacement makes the warning go away, but a better fix would
> be to remove the backticks entirely; I'm not sure why they are used as
> quotes in that file.
Yes, I agree with you. Actually I did it that way to stay consistent with the
rest of the file although I noticed something was wrong with the rst markup.

After investigating today, this file comes from an old LaTeX file that later
was converted to rst with some tool. That tool replaced different LaTeX
commands from the original tex file by backticks (minus the one from my fix).
After recovering the original tex file and compiling it I could figure out
what was wrong and see the original intention of the authors in the LaTeX
compiled result: some words/expressions appear 'quoted' while filenames are
rendered in a mono font.
So even the current Sphinx output is wrong since the conversion of this
file, as everything gets currently rendered in italics.

Last version of the tex file can be recovered at:
b693d0b372afb39432e1c49ad7b3454855bc6bed

Conversion to rst was done in:
e327cfcb25422c91f4bb8e8a3488386ac95955f1

I'll see what I can do to replace all those backticks by the proper rst
markup according to the original tex file.
> 
> jon
> 
Yours,

Remi Andruccioli
