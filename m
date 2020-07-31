Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D59C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1846208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596173169;
	bh=+jnidopSpBsFrcK/eoTOmb/CpKI7jt8C9N1g0k5BuMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Z+5Hs+PNEEhLba7noGPmdxJyodQbFvWIgvTGVwi0WGr6cdbyZpAt00EgKgGCiIRp
	 7GtzgwX3jf4DKW165dg7kdC9WtaryGEmtYH+XTLe5csWxjV4Sep/242TF4zZ/DXjjE
	 Yz3SzcmYfqjHZAUftSDfwRM3kJ/D/17TI/cyub6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgGaF0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgGaF0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:26:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:26:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k13so16231881lfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BURlW5oEPe0ZoWHcTMmVXKlH1gDArDoxjCd8GsiLt/g=;
        b=McJ1p2BBjbRxrRHk2xVOuHYl3VZBcQKQTQP+bpdLJ08ISAsuF8HWf4zpEDDe9wGfsQ
         40DAuiCLu/h0nJPqQwqqaPrLy1IES7Gh+RWqyipWbMByyrQsMsBTwD7Kj6602hvJv47D
         TlfhA4Sn8MJOZMmNRKeoYy3sLWShjwzbN/GNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BURlW5oEPe0ZoWHcTMmVXKlH1gDArDoxjCd8GsiLt/g=;
        b=JNa1Oxa3Syzy/M0smPwRT5AiSbr2uE9dcFgGxJmFcPyphPu3v5hzBG7Eapwzn4CYYT
         vSPiJmEwvGpkhC2btT/X0NZxJ1XOwy7cNQCnrXZlz1McMCmrYLAZfX+w1yXrLe04yDFa
         yg4s1X3S6XyYkh+FdMlzTVY+22IdhHQzEbJcQIYuwfUFntrnPUJN1ikq1orASN4rcLF7
         fZH+BAeEPInMwBeokBxf9sZd+5uPI+59BLGru/vpHpFClRTMd2GCMzmVjQ8cgiGwJZzM
         KwD2AjDIYF+jzyZKDJ3FHSNXgFqU3OrzsxhigNB5na1gbSf9uh0aMpE//eXVKXufuKR8
         oprw==
X-Gm-Message-State: AOAM533zSCUmjwxNhkKQW2HV5Yk2xQ/Q7GsOGmyRkWSgCCoturg3Nf5L
        ohG/ROQoBpg6M9mT2EPFSxrzwbWehHs=
X-Google-Smtp-Source: ABdhPJzUtuoRsUdRkUXLmnh6NmMpavaidzdmr6380yPx355N3nxTT0JwbbJkKEKdItVlOHBO6Iri+g==
X-Received: by 2002:a19:4201:: with SMTP id p1mr1056212lfa.97.1596173159890;
        Thu, 30 Jul 2020 22:25:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t6sm1652368lfe.52.2020.07.30.22.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 22:25:58 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x9so31244067ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:25:57 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr1132237ljj.312.1596173157320;
 Thu, 30 Jul 2020 22:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au> <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
 <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
 <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com> <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
 <20200731021631.GA8247@1wt.eu>
In-Reply-To: <20200731021631.GA8247@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 22:25:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPPibftjeuvi+s=RSeZij3PEWDOxb05UH4yRJWeDMzFw@mail.gmail.com>
Message-ID: <CAHk-=wgPPibftjeuvi+s=RSeZij3PEWDOxb05UH4yRJWeDMzFw@mail.gmail.com>
Subject: Re: arm64: pointer_auth.h:40:3: error: implicit declaration of
 function 'get_random_bytes'; did you mean 'get_random_once'?
To:     Willy Tarreau <w@1wt.eu>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Emese Revfy <re.emese@gmail.com>,
        hsinyi@chromium.org, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 7:16 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Don't you want to take Mark's patch anyway in addition to all this ? In
> case anyone meets yet another build issue, they'd have more luck trying
> to revert any other patch. Right now if they revert one, it breaks the
> build in a different way and doesn't help much.

I think Will picked up Mark's patch into the arm64 tree, so I felt I
should let it come in eventually that way.

The immediate problems seem to have been resolved.

Knock wood.

             Linus
