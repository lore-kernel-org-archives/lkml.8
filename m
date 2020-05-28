Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283D12088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="DeK/qHOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgE1JkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgE1JkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:40:20 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A26C08C5C4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:40:20 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id u190so5590286ooa.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rg/jQtOAufmv9zTXyUApJHA7GRXuqiMxXo9mtSDI+YU=;
        b=DeK/qHOkPphL1YEJ12bOXStaEyZQMTUB3Xmk/bUN5zYAVRIY7PYOusUAyR3pRGgbFF
         WzWbgZeGRg1FLbPgaX030YozQ1iKIZ/abEEzTzMEUBywnOoXp1iNV83f9vlzQWrLwX4E
         PTNQKNu7jr5PSyJ5ynLEaACi1Bd+1YhxNB6uW4OXXMM9w8DCJlByt0f1WND6jsTEaqBH
         sdm8siOyLQ/EJIM7N0t51oINAACfwkUxFOEm8cQVF91lNBsX284mPAdLKeSTVuzDA9Y6
         pdJyIQpY+IABGaf+N9Ck0kB6zR3c/pCR4nxomnvdyHA56+IMOvtndhc3abjKZ/Asxqrt
         yuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rg/jQtOAufmv9zTXyUApJHA7GRXuqiMxXo9mtSDI+YU=;
        b=c3Bwd+ohGeIRxaH50eD4w4qPl/BxUCkr+5LGVTQjP/aJs6UMoy3Y7j9tEFtpa4Yx3F
         JtMi7T491sDRaIfAfzeKxoz+d5d84ZBFckPIVtNoy9ncufvxHx6bwvfClRzSAFD0kO2T
         u1FY48GPAhPgLflzc5r81lfVyG6MAsXFedzQe8CeaHqdGpvSqn83vwsLdQrf5oVdTMW2
         gjnMHkNabQGi02bhur9at9GZOWyQ8Kk9KSFMELJYJQKui6K1hBby6TcPmFnTIeT8BSJT
         F7+UHPvkIwXK91ueeIO/Kf6gfAcpseG90Yze2oF51m1E/ypER09VU4Colge1RCTzaAH+
         98zg==
X-Gm-Message-State: AOAM533torwXMxSMWTaFE5Jho6AGc4HKEixHFOScLVNXwY4M+j6rZ/Aa
        K3jndjj5UQTG65YkrMGfv3o+U77PfWg=
X-Google-Smtp-Source: ABdhPJynq/Sf7HuCQoaXq3kTzLGkYX8RA2u9n6/Pkv/ESo8hdfhY/a6VvFAmwcHhf4r97Gr2R9yjqA==
X-Received: by 2002:a4a:1dc5:: with SMTP id 188mr1810473oog.76.1590658818843;
        Thu, 28 May 2020 02:40:18 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id a7sm1486763otf.38.2020.05.28.02.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 02:40:18 -0700 (PDT)
Subject: Re: [GIT PULL] sh: remove sh5 support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-sh@vger.kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <67759544-b041-74af-fe95-50fca4a9ea39@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <3a2164e3-08da-efea-2d58-5e230a85ccce@landley.net>
Date:   Thu, 28 May 2020 04:40:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <67759544-b041-74af-fe95-50fca4a9ea39@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 12:55 AM, John Paul Adrian Glaubitz wrote:
> On 5/28/20 7:46 AM, Christoph Hellwig wrote:
>> [adding Linus]
>>
>> On Thu, May 07, 2020 at 07:35:52AM -0700, Christoph Hellwig wrote:
>>> Any progress on this?  I plan to resend the sh dma-mapping I've been
>>> trying to get upstream for a year again, and they would conflict,
>>> so I could look into rebasing them first.
>>
>> So for years now it has been close to and in the end impossible to
>> provoke sh maintainer action.  At the same point hardware is pretty much
>> long gone for the real commercial variants, and never took off for the
>> open hardware nommu variant.
>>
>> Linus, would you ok with a 5.8 pull request to just kill off arch/sh/?
> 
> We're maintaining SH in Debian so I'm interested in keeping arch/sh, but
> I'm also let down that SH maintainers aren't that active at the moment.
> 
> I do know that Yoshinori Sato has a tree where he takes patches and sends
> PRs from time to time, but I have no idea what is going on.

There are still people who care about the architecture and try to get fixes in:

  https://www.spinics.net/lists/linux-sh/msg56844.html

Alas, I haven't had better luck getting Rich's attention, and I say that as
someone who has his phone number.

It met Sato-san for lunch once years ago, but he lives in Tokyo and english is
not his first language. I was under the impression he became co-maintainer to
show Rich the ropes of maintainership and to answer obscure architectural
questions, not because he was volunteering for significantly more work. Rich was
supposed to be load bearing.

I don't really have the domain expertise to do it myself... :(

Rob
