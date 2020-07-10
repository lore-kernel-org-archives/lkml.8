Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C561206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyiBWcN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJJiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:38:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C544C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:38:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so5201037wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Jbi183m0TzluzNkv0DodmYg38STdcfALNs2QkQx/ZQ=;
        b=GyiBWcN9aKw6m/tQhm05EfDoST8lxs1IRtLYYNKk4WbfS+/gNbaYUa/PhLjUg74Mjh
         eg9PACbyuL1jsECSLCqYAyUUY97g8vAZdQiU77TW9cJG2iEOQVOqVwmUNoOKe0ZevXXj
         sL0Fmw2kquiAlJLTbmeBkMogaa4Ypt4AlKJ7kcYEPsq37VELQ7r1IzEmyZliG1IXMzhX
         aj0PcXZyxX1DMOUg1ZOo8TwiqiEBaeQbFsv4H4w0TrpwdslzetEzeJHZOOWIf1dymIJE
         0aFOFBKs6BVO8vgIIRHH3982I9MU5a/L5Agxb/0Z8/YqO5dOqGvQXWzy7rwyhkiwcOLS
         l4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Jbi183m0TzluzNkv0DodmYg38STdcfALNs2QkQx/ZQ=;
        b=aUTP/g9oCHQhC/l3KiyCHkHAsplhf7u++MaznxbMlm1wg2+5kf8hPSAmHRvFclsxJJ
         8rkXaBIHbZJQfeDhiMJ7bbDNipvHMaVIdIEiV7WINcpRxgGYPI4DaLbSNW5rHZmcVmz1
         1P+0niWbYt5D04gCk9MPHeHXD6uA9Aazwgl5yWQ1Jr3c39sBDm0FQIEparK64crb4Zcy
         VZvB9MjdlPZG7yAHS8S36NMM/3NqZ9pQP3LOeqEgjCaOrYkyZ/73tx9BG+ywPznrRY2O
         Epx+aGoXY7o+TY2r0hboRwbWpa9hIgU8Q+38w0YZCqVl8idJ/67ZHJj2PAz+ycIY5QTO
         EpTQ==
X-Gm-Message-State: AOAM533SPp0HNo92PeZUUJJaKdCSf16yeodIa/O6vsllSfEgcxzlaGdq
        3tTVhBM9OcJ3xQ2/XIG+hKo=
X-Google-Smtp-Source: ABdhPJznGlgg1F1mQUDcrnL9PEQ/a32anoUrwebL0aWIjufbe7noJbHz3PKFyxkvNF3DqwLiHzkYZw==
X-Received: by 2002:a5d:470c:: with SMTP id y12mr27411645wrq.340.1594373884392;
        Fri, 10 Jul 2020 02:38:04 -0700 (PDT)
Received: from ?IPv6:2a01:36d:103:26a8:de2:306:5f14:1695? (2a01-036d-0103-26a8-0de2-0306-5f14-1695.pool6.digikabel.hu. [2a01:36d:103:26a8:de2:306:5f14:1695])
        by smtp.gmail.com with ESMTPSA id z25sm7838739wmk.28.2020.07.10.02.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 02:38:03 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
 <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
 <20200709124327.369781a0@coco.lan>
 <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
From:   Tibor Raschko <tibrasch@gmail.com>
Message-ID: <3fe09e6e-5d4c-857e-0486-81c0a164f0c0@gmail.com>
Date:   Fri, 10 Jul 2020 11:38:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Nobody has a problem understanding "blacklist" and "whitelist". These
>>> are universally understood words even outside of computing. Claiming
>>> that we need clearer alternatives is smoke and mirrors.
>>
>> Actually, as a non-native English speaker, the first time I saw
>> "<color>list", I had to do some research in order to understand what it
>> means :-)

You have to research and lookup *any* new words in a language when you see them
the first time. You'd also have to look up "allow" when seeing it for the first
time too.

> Thanks for the perspective. This is why we need clear and uniform words.
> Our community is global. English isn't English everywhere either.
> 

So, the proposed alternatives "allowlist" and "denylist" are better because they
are not English but are in some kind of a global language? Your argumentation
doesn't seem to pan out.

The language in the Linux source is English, and in that language "blacklist"
has a meaning that is not limited to computing but is universal, irrespective of
the field of science, and is even used in everyday life. And this meaning isn't
associated with ethnic differences.

As I stated multiple times, I support removing all references to slavery and
masters. But trying to avoid "blacklist" is not just pointless but also useless.
The real problem is that "black" by itself already has a negative connotation.
so instead of blocking words unrelated to ethnicity, we should not call
Afro-Americans "blacks" anymore. The problem is that a group of people are
marked with "black" which is a word with black connotation. We should stop
calling them blacks, and that'd be a real solution (at least as far as the
language is concerned).

Raschko T.
