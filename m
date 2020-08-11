Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB97CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F994206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxxtjYrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHKVCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKVCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:02:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:02:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so15079284ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SqN9nLJxMkItru3oYTXhx6j96ZiU7pTVOyqv1zeuuIY=;
        b=hxxtjYrYnGjD1wO09RSb92fDA1DZ9IDUTJZ/qu5XfVPOB46ylXC+sbRzBA/viA4sbs
         DJQV0OmvrA6e59CfODLNw38BxEdUd4loYwnfSY+id8d6AazjTx9c1EcXXoeezTymmsuQ
         NnoswU1VlZ9JUiUdg7Z59swgFVOABYLT2fhaXKqu9B9tCdrye8UY4dBwVKz57nyMuFxJ
         89bvZDFYMbUil0jiMqcy29K41PiPHOad3q5z/UA/Bo58zNrD2jd0MDpCAFj/PUCwJhFs
         9Hd5ldijIRRPaKEDjmrLhkxaMkGg7TW//0n80PzrqvAimeVaOPPSMwXEJeWV0Mbz4vNK
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SqN9nLJxMkItru3oYTXhx6j96ZiU7pTVOyqv1zeuuIY=;
        b=VYY9u32A2lh6e1SttN3iJRnhMIijc7W5utn8vbg6My/2oH6v3ChJOQq9HVY1+82zl6
         9ieCXtBErTPLeLHsubtJSKarRNyP6uHorM0bt/TEykZ0X9Er+pJySu483P20krH73QHa
         PDjqdWX+IgDVLtQSqcCctBeDAAFHwHufWsZ4fG1/ZVImX3l2K3oRY0wI4OVLNiS2sFhQ
         AWc40sT9Z98rjgg0PW6IiCRw3jIfuzUEZEJhggJpA1ahnnFSrfJtvpwPVMGOoOYhSVxu
         fSAhGicFnBYXBYydwSl6+XrOSJJ/8Fhzl0C21bD2RqZcWmt0V28hItco8aHAkValUV3w
         26gQ==
X-Gm-Message-State: AOAM532e0PU+pop1xzGCOElsfeIKLmukzINL1HAiLdlWDBld+pGPiIoU
        HFt0fI9z4LF19RQfMlha5sY=
X-Google-Smtp-Source: ABdhPJySHDLA938vyHhaUe+TpFjhPXNrywrjp6YatW5UID9cPQWmrZFTrG8GI4kWluIzhHM+tH3zew==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr4025093lji.345.1597179769581;
        Tue, 11 Aug 2020 14:02:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 185sm10254613ljf.82.2020.08.11.14.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:02:48 -0700 (PDT)
Subject: Re: [PATCH 1/7] regulator: push allocation in
 regulator_init_coupling() outside of lock
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
 <0d61983a-ed11-e5c1-f2c8-954e5ae330f4@gmail.com>
 <b27219ff-6cd8-399b-5710-cb5c2d99b21f@gmail.com>
 <20200811172015.GA21273@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <813bb196-769b-cffa-d5a0-7a6e6d9aa824@gmail.com>
Date:   Wed, 12 Aug 2020 00:02:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811172015.GA21273@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.08.2020 20:20, Michał Mirosław пишет:
> On Tue, Aug 11, 2020 at 07:27:43PM +0300, Dmitry Osipenko wrote:
>> 11.08.2020 18:59, Dmitry Osipenko пишет:
>>> 11.08.2020 04:07, Michał Mirosław пишет:
>>>> Allocating memory with regulator_list_mutex held makes lockdep unhappy
>>>> when memory pressure makes the system do fs_reclaim on eg. eMMC using
>>>> a regulator. Push the lock inside regulator_init_coupling() after the
>>>> allocation.
>>> ...
>>>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> On the other hand, couldn't it be better to just remove taking the
>> list_mutex from the regulator_lock_dependent()?
>>
>> I think the list_mutex is only needed to protect from supply/couple
>> regulator being removed during of the locking process, but maybe this is
>> not something we should worry about?
> 
> This is what I would like to see in the end, but it requires more
> thought, at least around interaction with regulator_resolve_coupling()
> and the regulator removal.

I meant that it's very unlikely to have regulator gone while it's
in-use. Hence it could be okay to ignore this rare case, and thus,
simplify the fix significantly by removing the offending lock.

Still this won't solve the root of the problem because potentially
reclaim could happen while storage regulator (or its supply) is locked,
although it should be a very unlikely condition in practice.
