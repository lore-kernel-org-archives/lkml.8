Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33684C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE25220656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591916437;
	bh=Pldo8IzGwjxJTJMiXT5gvNSQreqzLAc9EDhHrcvrpXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UTgR8RotvJahUPEmHux9CRjCRVX5gbgZDnu3vOx/R/4c1MxVm2RmxdK129+K0tUup
	 niwKU3yuCgNtuYGnDufduOr8OjGxjWoyBAGLLAEaRyNi8w4NqFw28kMHBGFx8YU2qp
	 CL4sqAc87xWK1axloGlk0kUQyDs3Z1880vQbjFcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFKXAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:00:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B38DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:00:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i27so8879654ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrS//NtZJ0IUQN8SVVIHfAtdyozOThH5v2HHej6NSIg=;
        b=g8CQ4pLEoZi8+yvtZHb3c83vWJJfji2IupxMjW0OvjuKqSQwWHIlKnDsA0BRgkTUHj
         qCyqDx1805SmdGF2iNQL36xIGbWOxqMYlJ7Jr+umloVVHtKr+ufg2Y9BrJbS5CkF7JNq
         86DEH0tz7Z/6PZItkUMZoN+fXqzvq1KnCGwPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrS//NtZJ0IUQN8SVVIHfAtdyozOThH5v2HHej6NSIg=;
        b=qgPUsR0GYFfdaxgZYFvTNr/TtkfwC20p0GToa7mLKBswc+D1XoOw5u9HB40wO9kZEn
         c/w1P9xaJtrPQsNFK6HsyemfNl5X1HlbQiMBMktr8BkDOoSG/Em1pl7yM+EYA6kiWfEO
         M3pTr54wAeWgE/kp3SKItlUK5RLgA5gAmJCK0LHE9tqtJeEAhJQj75DrzthACU1rPTfs
         uBTEZ4K1cvI/6Wxccr9mKJwKyyekVLO0OMJ0qD8Y2sapnnAZ5VTt1FIGiDwSjpZcvJlb
         RMQoz3GvfO26YII4Gsl2TFAFdfakxROMzddmOO6TSSbRY1ykLFc8hRd5R74wacBQfLFc
         eFUg==
X-Gm-Message-State: AOAM5302J4rF9VP+i8eBXxi5qZMDuUQSz//hrmI7fcdMVIXjaKAGRKae
        YD/T1Hwj1ehHgRAe4xufM8cjAJV5Unc=
X-Google-Smtp-Source: ABdhPJz6t8lGrxG21JtmNuztkWMM1kwqO1IDTh+GwQ7JCH2ajJNHPv4NFZwdtSTDqpnG9GU/BurRAA==
X-Received: by 2002:a2e:8456:: with SMTP id u22mr5137999ljh.73.1591916432138;
        Thu, 11 Jun 2020 16:00:32 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f19sm1208035lfk.24.2020.06.11.16.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 16:00:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a9so8932833ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:00:31 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5048656ljn.70.1591916430845;
 Thu, 11 Jun 2020 16:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <2f77e88e02ba81f0496dba778854fae8d0b5e862.camel@perches.com>
In-Reply-To: <2f77e88e02ba81f0496dba778854fae8d0b5e862.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 16:00:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjq68jF+fcSJYpRT3yS+=oOxaEFtYVmSjKb0RLbo7+JWw@mail.gmail.com>
Message-ID: <CAHk-=wjq68jF+fcSJYpRT3yS+=oOxaEFtYVmSjKb0RLbo7+JWw@mail.gmail.com>
Subject: Re: request: run scripts/parse-maintainers.pl just before every -rc1
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 3:47 PM Joe Perches <joe@perches.com> wrote:
>
> It seems the last major reordering of the MAINTAINERS file
> did not create many issues for downstream branches.

Honestly, it doesn't seem to create a lot of upsides either.

If this is going to be a "let's re-sort every merge window" issue,
then it's more work than just ignoring the sorting is.

Pointless extra work is still pointless extra work.

            Linus
