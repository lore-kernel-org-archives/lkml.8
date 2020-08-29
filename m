Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC3AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1702076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dragonslave.de header.i=@dragonslave.de header.b="MPuZ+cdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgH2Tgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgH2Tgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:36:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58664C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 12:36:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so3458132eje.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dragonslave.de; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQd1CZkmF2JS2WqNtkwtAtitWW8A9BxZ2UsFX+gxszg=;
        b=MPuZ+cdGVfqj6IgoyazyY9fqDopvH4zr34AEj6WfzXSYz/9OyRNInVeVECpcW/YuB9
         GPt3pPzGFQep3mbrffdhCy8o4Sz/3ti6KWhHB2GM64NtIbJUQqZTMXp2xxJlOd9WTaPs
         f1HeHUyqTbYC25N2WndeyXhyDTev9tluy1i6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQd1CZkmF2JS2WqNtkwtAtitWW8A9BxZ2UsFX+gxszg=;
        b=TbDwX0djhtSniq5Vnjaps9bPE1QWGY5aorFW1/ZjsaLjZf6jCGOqfDwiaDmypXcx3F
         szIAbQHNDxBoN4wD557I7XjKu1sqc7wVN16sDUTGAc2UwZBPUy1plWPOkcI6nSBN4F95
         WMijNo6xzt4rXMBG5qXrYFYNJxy5Pm3oNR8h6Lwv+NGa/3+rjEnq63NHHIWMTJ2zUCDh
         Fp55RVTiZYhtacp2EIhqMSJQ0rDj/xyc7m/QPylXYmySk596gcVY38YmWvETXeGqllin
         JQUp2lGeVqNjqXaNhw6fqiIHHpeDkhz+1iEMdsJDeLOw/2jQJ5Csy2BPNMElrxrnm5Gu
         gHrA==
X-Gm-Message-State: AOAM532PW8kcNr0M/dPQkq79M74mgN7Qt5eLtve7i0YfTMJGDbYe53MG
        6DfAVtHHjg2TzDaFvkecRnVoFw==
X-Google-Smtp-Source: ABdhPJydWr/wP7l2Q232WsPCPiRHz790MynByWRjvWBZMlqFv39tDcBYq1NUj5C9pGkhgN8ovZQ9jA==
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr4700942ejp.178.1598729807885;
        Sat, 29 Aug 2020 12:36:47 -0700 (PDT)
Received: from [192.168.25.146] (ip92340232.dynamic.kabel-deutschland.de. [146.52.2.50])
        by smtp.googlemail.com with ESMTPSA id y24sm1837527eds.35.2020.08.29.12.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 12:36:47 -0700 (PDT)
Subject: Re: Kernel 5.9-rc Regression: Boot failure with nvme
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel C <nix.or.die@googlemail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gabriel C <crazy@frugalware.org>
References: <f7328aad-ce1d-dd3f-577b-20b3d2efbabc@dragonslave.de>
 <CAHk-=whuO3U90x_i6nq+xmVymwqcc=kkb5=gv4vyLScQn7ZwBw@mail.gmail.com>
 <20200829175735.GA16416@lst.de>
 <CAEJqkgjz2wHAOVfHTw0V1fU8nOR70WZtuY9vJKywrUkJetC=TQ@mail.gmail.com>
 <CAHk-=wgMJGVqiKnmL+mJ=mrHkc3JsABLrmuaxJ1T=xTrnDCqag@mail.gmail.com>
From:   Daniel Exner <dex@dragonslave.de>
Message-ID: <7b8f7ab3-af40-81e2-1e4b-59468404f121@dragonslave.de>
Date:   Sat, 29 Aug 2020 21:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgMJGVqiKnmL+mJ=mrHkc3JsABLrmuaxJ1T=xTrnDCqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.20 20:40, Linus Torvalds wrote:
> On Sat, Aug 29, 2020 at 11:36 AM Gabriel C <nix.or.die@googlemail.com> wrote:
>>
>>> This kinda looks like the sqsize regression we had in earlier 5.9-rc,
>>> but that should have been fixed in -rc2 with
>>
>> git tag --contains 7442ddcedc344b6fa073692f165dffdd1889e780
>> returns nothing, that commit only exits in master, so probably in -rc3.
> 
> Right you are - that commit is not in rc2.
> 
> Daniel - that commit will be in rc3 when I cut that tomorrow, but if
> you are willing to check current -git to verify that yes, it's fixed,
> that would be lovely.

Tried current git and indeed it boots just fine. Thanks everyone!

Greetings
Daniel
