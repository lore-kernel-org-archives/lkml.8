Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03A6206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZNmqy6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgGHPdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgGHPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:33:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1186C061A0B;
        Wed,  8 Jul 2020 08:33:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so47340826iow.8;
        Wed, 08 Jul 2020 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyLb8SlKlhyAzCJgpUsncV6Hsfp2hFD6rZCRWfST+rQ=;
        b=OZNmqy6dMexDFVudZkHsNZW7fvX1gWcxLKoITuw/yDAZpr4dcBEr872L7PfpuPv3U5
         DUoalvVEOKA3yu4m7CFT9Um7UW9ikom7grPoop9+TDpLwXla258d+PoWTOf4iTYsWQea
         BHr7i76yr4Y5M8TLrMZJ+0XzO26dvrBmHrV9aOq1BXkXs75kL/TFwVsmYO/LM7Fv2SCJ
         O9eRHij+R/egclYARy4XHW6ZrunNICDVqSHeq1CRP68DcurXEkIE7mUpO0FlUlgxd1Ha
         g924rp11Ec/hjFQyk4nLj/qpEE3XapSmULAJMABENntKbx7IvX7P8ctnzfao3Q0PSj4w
         80RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyLb8SlKlhyAzCJgpUsncV6Hsfp2hFD6rZCRWfST+rQ=;
        b=tMVtDtS1YK94huE/MP8rE6SdAPQyHrZzXO5cTRfREdEUHOdgxygXoj5AbHkqGiprF0
         LQoNnfY0Y62H5QEqeztDcvfuAQMFpwP2H1KrvcfPHzhJ8EnG0jwkRvPCkHOg/6H4mrGb
         N+rVmV+rd6RGIN68HGGepfbTEQoYnGjezRwOiI/T5yVEAyoPgMgwmaMqt2aP6gmsJAEs
         vvJP+czjwjn7WwqvVsvUM6n+SLkP21gE2Sbn9BhmI2QgB1Vuq+HDXvfHyxxTuruwf/AY
         3kf789dCfmdvPfiizznZ19rdVxIRIZg7cqJxCnhuWvi15HLbyeEaEUdWI5xZ98+KpyA/
         AZvQ==
X-Gm-Message-State: AOAM531tw5aS7FZO01TicoMBbmKg+cRVvn1B+47fbNUu11kGy3dlTTVl
        IOLVESImHdXvFTjdShg9KmwztJ4iGZp5cIXsVUk=
X-Google-Smtp-Source: ABdhPJxmN6/ftSrdoJHD0FKGFingv6a4BF2CW23oA1LiWvGaeFrBISVVc9u+FQhR1y3WW4ip6PUKKwEnDzHBTPh5fNM=
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr37850434iow.45.1594222419991;
 Wed, 08 Jul 2020 08:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707145800.925304888@linuxfoundation.org>
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 8 Jul 2020 21:03:29 +0530
Message-ID: <CANk7y0iK9ziBq4wmpzeM6sh2hd8Nw6kN3b=OE7s243L7ZfpFUw@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/112] 5.7.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 9:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.8 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
>
Compiled and booted on my computer running x86_64,
No dmesg Regressions found.

thanks,
--Puranjay
