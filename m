Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13072C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E586420768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQaf+LI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404133AbgDOHFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:05:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404097AbgDOHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586934326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pOD+scWb3NIi4xqCsK2NBQZJlzZapfqAnkfXTVEreo=;
        b=jQaf+LI9Lj3QYvXXkuXEKe8SX5DiDm0h/CESLVxfFicqmliOspEPlUcvVojitqXuePwUFq
        gdzj4BnNJrF4H1LwYLQf6AdFWMLqXRYrAbDHFpIlaE2EGgBMORYgujP7d5uQJmq0AxFc82
        +KboPIfLmT8I2/GF9GTGpoV8lDIBWsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-WgRaKKW7MDqyh-4rU9TU5Q-1; Wed, 15 Apr 2020 03:05:22 -0400
X-MC-Unique: WgRaKKW7MDqyh-4rU9TU5Q-1
Received: by mail-wr1-f69.google.com with SMTP id t8so10024673wrq.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pOD+scWb3NIi4xqCsK2NBQZJlzZapfqAnkfXTVEreo=;
        b=ekNX23LgU5AeMDg5Mj1MnYURhxATq2ouIqVvrM1XesWCLKaR+zGo5jepa39xZMC+Y2
         QVKmFlBruG5mS5Kc4afRuIj/XoOO1DjJWmpa2Y0Whbakn762xa1bWlmKxRFxCkz6XpFm
         njLjt9jpw0An2OfT6TJ/tFn10OFrgumgsj8A7kLvaQ0XN6e80p7rUXHudmR2z2ClYcnh
         c/0kq3X/J/WRHESzfJ2ESpUja9CUtS6nkIh1E/onIB3bMVufwJWN+I5siYlNiJ0AN53K
         SFkWGySyqTw22XOdiV5QMyyFXXuGb5pjj1iPqsms/slF+Ktk1i0asSV4O2SK80uiRcA+
         c7sg==
X-Gm-Message-State: AGi0PuYMMJMffzM/yIA29lHPOtR6DYNN6xoIRX1FkTE9GvtfsyxwF1mB
        ovMVEhX/JON8te3gpP9knvJvMPP0GNM9lI4cgCNm4qg5gGYbb/C47790f6eGyf7sBApmi0jy4e4
        FQf8UkikWe8+bSICSvH8MqR9s
X-Received: by 2002:a1c:6787:: with SMTP id b129mr3832340wmc.165.1586934321253;
        Wed, 15 Apr 2020 00:05:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4uuUB/FgvO3N123wuUXAHq5ao0JK3O7ZhkFoWuHYJfyyiKjFD0z3pewOyOHKlUHuX+ZkxCg==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr3832318wmc.165.1586934321026;
        Wed, 15 Apr 2020 00:05:21 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id a15sm20713639wme.17.2020.04.15.00.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 00:05:20 -0700 (PDT)
Subject: Re: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for all
 architectures
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
 <e8a52162-dd38-6092-7217-cc5c088abadc@redhat.com>
 <20200414205603.GC118458@rlwimi.vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <bd4dc430-ace4-68f6-7645-d03c75937ab8@redhat.com>
Date:   Wed, 15 Apr 2020 08:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414205603.GC118458@rlwimi.vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 4/14/20 9:56 PM, Matt Helsley wrote:
> On Tue, Apr 14, 2020 at 08:39:23AM +0100, Julien Thierry wrote:
>> So, if it is decided that recordmcount should be an objtool subcommand, the
>> code itself should probably stay under tools/objtool and then have different
>> compilation configurations for objtool depending on the architecture (e.g.
>> HAVE_OBJTOOL_CHECK, HAVE_OBJTOOL_ORC) or something of the sort.
> 
> Yeah. HAVE_C_RECORDMCOUNT is used in the Makefiles to select building
> an running objtool mcount versus recordmcount.pl (which is another piece
> that needs some attention -- my preference is to slowly move arch
> support from there into recordmcount.c. So far it looks like s390 and mips
> are the ones needing a little special attention there..)
> 
> My recollection is Josh wanted to avoid a bunch of architecture/config
> checks in the code if I recall. It leaks into the code that implements the
> subcommand tables, for example, and that's why I chose to use weak symbols --
> we can unconditionally add the table entries and we don't need to play
> linker script + macro games to build the array.
> 
> As for managing minor architectural variations in a single subcommand, either
> those can use more weak symbols via arch/foo/subcmd.[ch] files or via explicit
> checks in the code (see the arch, endian, and class switches in recordmcount.c
> for the latter). If folks are OK with using weak symbols I'm curious what
> preferences are on choosing when to use which method -- the RFC reflects
> mine of course but I want to know what makes it more maintainable for
> other folks.
> 

Thanks for providing the background reasoning.

I think that using weak symbols instead of macros to conditionally 
compile is fine. However, I still think that temporarily moving code 
that could be shared across architectures once the necessary back-end is 
implemented is not the right way. For instance, in the case of check(), 
it should be arch specific parts it relies on that should be weak 
symbols (e.g. arch_decode_instruction()).

And in order to have a correct list of supported subcommands, maybe that 
could be done in arch specific back end (e.g. arch_get_subcommand_set() 
), which would fill the array of subcommands for the target 
architecture. And you could have a default "weak" implementation that 
fills the array with subcommands that do not rely on any arch specific 
support.

This way we don't introduce #ifdef into the code and we don't move the 
generic code.

Might not be the prettiest option, but would it be a good enough 
compromise? Or are there other suggestions?

Thanks,

-- 
Julien Thierry

