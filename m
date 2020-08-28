Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B84EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209C7208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+bIkP5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgH1KNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgH1KM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:12:59 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73792C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:12:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v138so295062vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6HXUI5DD/tO1jp0etl8fGdPWC411ikUQuHLqZtsU6UI=;
        b=x+bIkP5tr77goYnNf4DekZG+QJ+jHXkO4/FPvOFxRgNHlmJ6xsunxMsebdA9GFg45M
         xGT2/9kHOxpcilvFqcfu2YBahPukoY/4DgWyBz9p8zb8/WM8tAHTcQgYV2egkgd9VdjT
         IhGPP9qIHcZ1CRHRsmLFvX2GvzKgCA9qKhw8gYjghhfXv86MQgNvKjhTYn4d9vqmYAKm
         bLlYRh2MUqr/yhDxxB9FcNfBlORfSyb8K39aN9xZa9RFjlDvdHlLt6LRh4fIBd9v7O3y
         YazOj7mT2LQYJarIFY/tgwB+mZeuMA0UBCNUVuMkWbEi7o40kIEWdbpZP4OlueGUNGIj
         ITOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6HXUI5DD/tO1jp0etl8fGdPWC411ikUQuHLqZtsU6UI=;
        b=ntnLcQqb8hwx0DtyrWiygQxpo+G4d7dQwWX+75fTQJQ7SWChFNJCWi03OO4M2MNZBy
         MYnQIe1Pqn+yN1AYMXB11QVW8bSc3wlvWEy4ifwplxEYXy28Rc/LlxyTnk5HQWUve4Bq
         SDBl4aj+irST+c53LM+FOGuRy5ZQ1dNjx3RpJHImA4UGbiyl9n2XWzdjmb3gRj4wPDG7
         sF2l1pXGzBzzHJ/UsqAvB86S2e4vcTxC+lAtMo12AXgRTlCtAGcTsAw5l++quA9VtrqX
         B8GuG3u5R6kBiAspPNQHggmDvUhQTs2+SW3QPewtOFHBMi9WIl8yomVFeTBKA4a6dsmR
         gyFw==
X-Gm-Message-State: AOAM5322g1qt7l3vcxR8nHiIm2HJ4AkEM69kO6+wu17bbw8ZJebIoyIS
        H1EQk+AAVAKJbRHpDc8uZOHe8VAPaul214gvi1FkBw==
X-Google-Smtp-Source: ABdhPJyZVuGh5RBJk2bXJRF96bDHaTJMZw6jD2kqXZVAAm+GWUOTgbMYGRtiT+o7iBlggckDw3el3rN2C4q/JTGfpFI=
X-Received: by 2002:a67:7905:: with SMTP id u5mr294659vsc.179.1598609578442;
 Fri, 28 Aug 2020 03:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7> <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
In-Reply-To: <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Aug 2020 15:42:47 +0530
Message-ID: <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
Subject: Re: WARNING: at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x4cc/0x5d4
 - on arm x15
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-08-20, 21:18, Stephen Rothwell wrote:
> > Hi Viresh,
> >
> > On Thu, 27 Aug 2020 15:16:51 +0530 Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 27-08-20, 15:04, Naresh Kamboju wrote:
> > > > While boot testing arm x15 devices the Kernel warning noticed with linux next
> > > > tag 20200825.
> > > >
> > > > BAD:  next-20200825
> > > > GOOD:  next-20200824
> > > >
> > > > We are working on git bisect and boot testing on x15 and get back to you.

Viresh,
I have applied the v2 patch series on top of linux next-20200824.
and tested again the reported kernel warning is fixed [1]

[1] https://lkft.validation.linaro.org/scheduler/job/1717615#L1881
