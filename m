Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B73C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D673206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585936108;
	bh=18GHNOBVkEj7vvORr2+RoP8PDn87EfmttlpKTzZy46Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j0uHeDmOPK+QlPj75C3oQ+WU1fGGStqWDbuLQRujlGaMpX8EeM6tQ+1xZWdyrVwp4
	 KJPDlZTT4pGhdsJKEXjIIiqnQyBECCpQosHkWhtAROTdBTWTos66lS96H6wEZ3Q7Ch
	 9MJ0DH7CH0UAozUXYv/18pd3oaz17yTGy6ynv3AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbgDCRs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:48:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41623 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgDCRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:48:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so7820635lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3THBIeg1DeeQfa1qWYP5fMgyz8PG9WZarWEKIAjybzc=;
        b=N9neCI5Qjc956nHzpT6Wv66wmcCPHy18i498AuxWNSpHcXpezXTuTKm2OG1vKqL42o
         JtGfih0oxhGl0Bq1LQLwJPruvqzhW2QlyHd3ffmbTf6kYcGwiNvs1B3JlPdeCUi9ce4q
         vhAhfkqRxPVn0NCUVrvl0tZmhQSEnzqjCiCsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3THBIeg1DeeQfa1qWYP5fMgyz8PG9WZarWEKIAjybzc=;
        b=A4tfRgWOjkRp1Pao90aKbL4SUuTAIZVbHevNyPyBuXNOVbDg5h0OYmzHGeyYw334Qx
         sBP/sEd3L5M6N8O7VpOkyMYsTsRkfmWOeUu32zA9hXEdVvNS6ulMVn06stOLzktkDeD4
         5JjHdDiCiGusQCqwEZ3y1FmW7W3WXAGQE50x2MLJewBziM0jfIlbospZx9JpkYw4sIdx
         Mi1GQrVyKK4Mvmp77rwVkgIF2MB06QzPl7C/l8eiO/W8SQuPlkphgKZzzWisvgaYsjmm
         1NasoVsY0HTXcWNUOUu2U85RA3pA+FbPlxVcmUrffmZ9rHXk6c7KwomWqr4d3OrTK73J
         c+yw==
X-Gm-Message-State: AGi0PuYCJEj1FuOUoaq9I+u5vqVN2gewu+68G3U6+3isF2Bm1vagr5rq
        zlEOtQahgrlOqzgQu/ASHzNyTuBQ5Ak=
X-Google-Smtp-Source: APiQypKfaQ4yyVVyThFc+hDpjLTMquaMbVduxq+aOdI+OCkSAtLaPFHGlnvbVpXNrVn/WQjKYtgwcA==
X-Received: by 2002:a2e:9886:: with SMTP id b6mr5602376ljj.237.1585936104199;
        Fri, 03 Apr 2020 10:48:24 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x28sm5371239ljd.24.2020.04.03.10.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:48:23 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h6so6516935lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:48:23 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr6173851lfo.125.1585936102736;
 Fri, 03 Apr 2020 10:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200402010812.GA751391@yoga> <20200403013134.11407-1-natechancellor@gmail.com>
In-Reply-To: <20200403013134.11407-1-natechancellor@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 10:48:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG84d5bGHU5HLOMgR59BqUcuawPTxGgVDm3JWiWJHi6A@mail.gmail.com>
Message-ID: <CAHk-=whG84d5bGHU5HLOMgR59BqUcuawPTxGgVDm3JWiWJHi6A@mail.gmail.com>
Subject: Re: [PATCH] remoteproc/omap: Fix set_load call in omap_rproc_request_timer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 6:32 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This is due to commit 02e6d546e3bd ("clocksource/drivers/timer-ti-dm:
> Enable autoreload in set_pwm") in the clockevents tree interacting with
> commit e28edc571925 ("remoteproc/omap: Request a timer(s) for remoteproc
> usage") from the rpmsg tree.
>
> This should have been fixed during the merge of the remoteproc tree
> since it happened after the clockevents tree merge; however, it does not
> look like my email was noticed by either maintainer and I did not pay
> attention when the pull was sent since I was on CC.

Thanks, I've taken this patch directly into my tree since it was my
merge that screwed up.

                   Linus
