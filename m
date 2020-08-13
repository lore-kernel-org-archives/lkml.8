Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4556AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C83520885
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ejivrTcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHMLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHMLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:33:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EDDC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:33:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so5759662ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKBHpRq2gdYecMDnHVd5fZCbJkMkjf8ao+KHmXIXSMg=;
        b=ejivrTcNuBz6f3oxo1Y3zzsM8DitmA3VJUE1qaeuEwlJPxUAvWFXytt/iywwB7qCGy
         5MD82jHYBj5HiDAf7kqp4ks7+5ToBEqHq8nGc08BLB5vvo5QQS/eV3bJ4iGfykjfdDRM
         rZvrV7fxjdhXqS6mmXipjtnrPgGvLYh5D2JQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKBHpRq2gdYecMDnHVd5fZCbJkMkjf8ao+KHmXIXSMg=;
        b=lp4n89CPRSEE7Cafn5V1Wv53VhO+CvEGith/sYCpp081Vif+bZZuwy32BKIuJBDyPW
         fFUhwqfhvW/BV8no/7ct2qHC/Lwui+x149VKRXRGS48h+tSRNrlUVqvT91dmK4v+5Kn7
         hzSFW2RmCXpTfzRmMtK+m8DxfKZOqR5MYWoXLYXfLcKise1hZtBk2WH+1l2RvX4YX0SK
         12kK9Z3W0e39EOVT8GGpLOZcA+DW2K+e1Tf/h4aMDnxgbVoJhxefnmg1AWrtdxipnmiX
         hlSOfAd5C7tLJkqnz3LijRNryFQSf8usQzRvg6kGIAkuQv0BwE2fDOOkFAMceve1byNl
         2jww==
X-Gm-Message-State: AOAM533Uj68UbQ3NlcSmvQZJxHH8Wcit91OZZX5JDiLV2+Bu39Sxtmf2
        guRR/rPQCJX8N4V021c64/V0Yw==
X-Google-Smtp-Source: ABdhPJyoUHvy/tjrCSKGg//t2kcgYLKwm9obdrTFz24GkBvRPgwiMB83dvHU/dDl+wqiLNW3FXvczg==
X-Received: by 2002:a05:651c:314:: with SMTP id a20mr1762778ljp.434.1597318387708;
        Thu, 13 Aug 2020 04:33:07 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a1sm1138751lfb.10.2020.08.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 04:33:06 -0700 (PDT)
Subject: Re: [PATCH] overflow: Add __must_check attribute to check_*() helpers
To:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <202008121450.405E4A3@keescook>
 <20200813112327.GF17456@casper.infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3e498585-f22f-25b8-9385-feadd55fdc7b@rasmusvillemoes.dk>
Date:   Thu, 13 Aug 2020 13:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813112327.GF17456@casper.infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2020 13.23, Matthew Wilcox wrote:
> On Wed, Aug 12, 2020 at 02:51:52PM -0700, Kees Cook wrote:
>> +/*
>> + * Allows to effectively us apply __must_check to a macro so we can have
>> + * both the type-agnostic benefits of the macros while also being able to
>> + * enforce that the return value is, in fact, checked.
>> + */
>> +static inline bool __must_check __must_check_bool(bool condition)
>> +{
>> +	return unlikely(condition);
>> +}
> 
> I'm fine with the concept, but this is a weirdly-generically-named
> function that has a very specific unlikely() in it.  So I'd call
> this __must_check_overflow() and then it's obvious that overflow is
> unlikely(), whereas it's not obvious that __must_check_bool() is going
> to be unlikely().

Incidentally, __must_check_overflow was what was actually Suggested-by
me - though I didn't think too hard about that name, I certainly agree
with your reasoning.

I still don't know if (un)likely annotations actually matter when used
this way, but at least the same pattern is used in kernel/sched/, so
probably.

Rasmus
