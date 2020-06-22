Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCBC2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592844406;
	bh=/PYhs1Q7QRpBSXOEqScJ0wI/pDX9KJ35MA/WrvV+/AQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hu9jnopgOoOO3gPSKRiWV4BagYbzUt9eEk0oR+0f+zf1On8J01IbXRhgVwNvZHKlc
	 prVzsze0cSvqYH7h6KD5/8SRhui8miGlBy9wWcXXkpGZxYs3Rc3W9ioLAeISm7xPl4
	 aE7HDgzbje1ew756j+V96IAE48WJqkUn7QXoyBAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgFVQqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgFVQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:46:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC470C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:46:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so9228143lfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=08Za9AWmtoavSkgvACEPrFQuRhralIzi0CfMGyDfgyI=;
        b=dt/wtNTzBFMv4ZiTu6dyx7XBY1xh5VxnA777YMfuF/P1SptUQyZfCFhXYO3KylYIfd
         +qwljg/eH2QOe50kUGSISxOZJh0OcT+vuY+LzZqcZICK+b8Hpk8VuYSqIS9wo8LLoum4
         /1KiRqw4iyxY1p93HhuHrd5kUXfPxHTDpHY3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08Za9AWmtoavSkgvACEPrFQuRhralIzi0CfMGyDfgyI=;
        b=FFZtevQAP7aDpdfHeqjp1L5CVaIOD3nOxo1NOpV/fQtJEfrpf1F23D1lrO+onyCx1x
         ORpz3IO9tOeOgrHnlV0DaIDY1ivRqhGkbeIlgbzY43n2XmDIiRm2pTvSO9uGoChVUieq
         aB59iQfTZFdTPNwbvCME4ai6S+F0XA6y9GDwdxJOEgd8nGMfA4UtbSZcvR7t5Msd1Knh
         Pus1tvp1SC0rMb/U2fKF6nhdlvWI0gUUmleIQyNEYKjYl8eksvIc6wQFKkQP2AhXilbz
         +Dzd2t5IyYxw2l8JqnAr5l4vbY/3ECUKKf4+76eJc1SeJpLuMLoswr1wuG6G3wCSdTuN
         Zlqw==
X-Gm-Message-State: AOAM531Mu19gMYm2J3Ekegut/h5VwMmswTLL7BPwpf9s9pfAU0SmU8dx
        WcokDePxvxwaLDquEnkErHndKRw+NIw=
X-Google-Smtp-Source: ABdhPJyBpS7s/8lycD/vSR7gf88QamsyydwHCzo3wWdwvVWcyLeu0ce0HSHUI2iqT5Jy+PnZvtmJDQ==
X-Received: by 2002:a19:b07:: with SMTP id 7mr10180637lfl.38.1592844401879;
        Mon, 22 Jun 2020 09:46:41 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e9sm2796851ljn.61.2020.06.22.09.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:46:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s1so20146457ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:46:41 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr8776716ljj.102.1592844400696;
 Mon, 22 Jun 2020 09:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200622114015.60DD1206BE@mail.kernel.org> <20200622120905.GE4560@sirena.org.uk>
In-Reply-To: <20200622120905.GE4560@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jun 2020 09:46:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1YafzVFcCAe52cG+gHuaJBGORGb3mZ+-9QqZ2LOmzag@mail.gmail.com>
Message-ID: <CAHk-=wg1YafzVFcCAe52cG+gHuaJBGORGb3mZ+-9QqZ2LOmzag@mail.gmail.com>
Subject: Re: [GIT PULL] regmap fixes for v5.8-rc2
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 5:09 AM Mark Brown <broonie@kernel.org> wrote:
>
> This (and my other pull requests today) are unsigned because I've
> automated the final checks and sending of the mails and that's not
> really compatible with signing the mails.

I don't personally check email signatures anyway. I do check the git
signed tags. So that's fine.

That said, automating the mailing is *not* incompatible with having a
real name in the "From" line. Can you please make your scripting at
least say "Mark Brown <broonie@kernel.org>" rather than just
"broonie@kernel.org".

Not having a real name just looks like bad email etiquette.

                 Linus
