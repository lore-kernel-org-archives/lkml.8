Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEBF2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="diGjbebT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgFKL0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgFKL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:26:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:26:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n24so6112587ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NA3wi+sqNlJq17nOS/TElKV909MYYt0naP4yTX76rbI=;
        b=diGjbebT+7YQBde6Y9mVDqeBytRKr6jSYHBHUv0V5DqlAw1S4U0YVd4tc8PIkFpm61
         cYpbZUrbwH+OEumKyZRu6py1EUMs6Ro7EMdBlCe5dwiHRKSO6jqL2p+tGuHvlJd8UZJL
         rbp0CrgdjnQyKCQSDNNWH7xc5xwYtgVOeVjiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NA3wi+sqNlJq17nOS/TElKV909MYYt0naP4yTX76rbI=;
        b=qN2BKYm48wFBFk0F/eAZBSWBtChoLMgFY0H47T5VtvJl+ryWCzdrvVRhlDdJWoKzjr
         LQBrEZdjC0ghbwFqrOn3aMMPXx+q/5gf8YIesLsyjbtIdy4KK0CCmMpj3/ovkASHE7A5
         827/rtibkHryZcIdmmr2ttvFjq/6pDuNDqbSVUBdV4N2pEJ1TnyeMQP5q3Wj94rKbcbv
         A3eyo4AoHpeVG4diwr7BXZHd/wwaI2Z7Wt5WBG/iwrm1PWrI+39dVG7ivdmIYkZGciwD
         jtIdlOidhCBPizjPwP++xAYGg4xfzfm5VLV0UCUIHKh3pMXMsv+nIL2pkM9TGJFIyiw4
         OQfA==
X-Gm-Message-State: AOAM530IdXiCFyMVkvIeExNgvqg8iGaS9rA6Zu2dNsdJm1CnEDx2Q/UQ
        ovfRJx7pMsBh+UtmN5IqEE3AcA==
X-Google-Smtp-Source: ABdhPJwAJGjjRC4+BgtAIKcDKG7ehv2dvKrFkl3jTqw26nmz0OeeRtECOvIQwke+FGfWU48BDCZU8w==
X-Received: by 2002:a17:906:1196:: with SMTP id n22mr7699922eja.33.1591874768241;
        Thu, 11 Jun 2020 04:26:08 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-127-38.cgn.fibianet.dk. [5.186.127.38])
        by smtp.gmail.com with ESMTPSA id i23sm1687119eja.37.2020.06.11.04.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 04:26:07 -0700 (PDT)
Subject: Re: WIP generic module->debug_flags and dynamic_debug
To:     jim.cromie@gmail.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-7-stanimir.varbanov@linaro.org>
 <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <548d30a8-0a5a-4ada-5564-b61f88863afc@rasmusvillemoes.dk>
Date:   Thu, 11 Jun 2020 13:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfuBxzxwoyXbDrgQzb=BZJ8ZQ5hHo32Zr1uo6Od=7+q13+GXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2020 20.32, jim.cromie@gmail.com wrote:
> so Ive got a WIP / broken / partial approach to giving all modules a
> u32 flagset,
> and enabling pr_debug based upon it.  I leave out the "pr_debug_typed(
> bitpos )" for now.  For Stanimir, bits 1,2,3 could be high, middle,
> low.
> 
> ATM its broken on my lack of container_of() skills.
> 
> Im trying to use it to get a struct module* using its name value thats
> been copied
> into a ddebug_table member.
> 
> Im relying on
> cdf6d006968  dynamic_debug: don't duplicate modname in ddebug_add_module
> to have the same value in both structs
> 
> but Im clearly missing a few things
> besides the likely future trouble with .rodata builtin modules
> (after compile prob solved)
> 
> It seems container_of wants me to use struct ddebug_table instead,
> but I dont want a *ddebug_table.
> Ive blindly guessed at adding & and * to 1st param, w/o understanding.
> 
> can anyone diagnose my problem ?

Sorry, I have not the faintest idea of what you're trying to achieve.
Can you spell that out?

Rasmus
