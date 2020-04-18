Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F519C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30574221E9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587234736;
	bh=9vyrnbFO2qMZ1z6t7KYdtgivFUWG5e2WrcyJdsUyqd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u1RsKzicx2yzrLGTKx05Lus8Vo0JoWyClgXqX3KgFfu+2ofG46ZAm1vpCcwN8d3OM
	 0V03VvetloDN6aRzyp9k+cpF5QpE9iYxMmrhnodNvAhYI+607VlfEsQCIuVHKEuEBZ
	 brVn67X1tHrZZPEd3tJpGaZ8KuP/1Ebs5mks0wWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDRScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgDRScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:32:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F6C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:32:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k21so5543692ljh.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roHWmvZVn6/F/wGdD9zKQyHgt7/0jSXot6B3J+TjEcY=;
        b=Ov5km4/W0JO/IIfYEyZciHkzHh2pF53WoxnC5p8aNLkfSv1bQrGKVHEY9CDHeQh3er
         0HrdAJD/5SAvLDL3+mS2NU67fvxAPyYejY9yZf+lpR9/I0C69GSpYjFN0VjsRdXdguFl
         x1ZeCfwN1w1w97BOGUUno/wjroNDI8xGjwVS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roHWmvZVn6/F/wGdD9zKQyHgt7/0jSXot6B3J+TjEcY=;
        b=sFpfbeInUP4UHEdKYUu+Xg1SAGRhjOxvDQTUtW1ciIKJguoqofzYQzpkIMnCLIU1wo
         doAlaOcj4gX8UVA/zMsWZaXG4s9D1Hrd+1upYN8OfXqcJBnbTBtJcHhB0aDQyIs2Y9nv
         FzPhiDvjnwwCfoLPiyhWcY129wbKnK7p0ywaBn7Udf/BboLQAdcDAa+aPzLj5d1xSVb5
         G1w4D32ANNo58fw4xxPpLQGr7XyMvJaB/nzZPQbrGMJimATJXK0DIeFLHAAFjr4lBC2Z
         4M0EA4s3IYvFj9OmpanTv7oPM8O7KRUaMj161ppuwzpPBhanShZSqhMwogEXCCTy+cIM
         L2qw==
X-Gm-Message-State: AGi0PubgUDYvVnlvBlJlrHvsXDOrwHI15UYOYzqoKqROSRIHXT0sRnky
        bd+ja4MqZCBuyCD1LsvY9M4dcZ5g7fk=
X-Google-Smtp-Source: APiQypIL6b8FPLVUhcsi4gPc7l3/RPIrzHBL9rE0ScxCsFS9iUTDhocTthpzcOwtgp/Y5OFXMGUHng==
X-Received: by 2002:a2e:9f03:: with SMTP id u3mr1091698ljk.123.1587234730270;
        Sat, 18 Apr 2020 11:32:10 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id w25sm18646194ljo.78.2020.04.18.11.32.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:32:09 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x23so4557464lfq.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:32:09 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr5449960lfk.192.1587234728893;
 Sat, 18 Apr 2020 11:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyt1N=QTmsyBKYzMqYJLbNzrgrnNoqQrzn3735ePSCODQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 11:31:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv=zGZO+6rrFLcv_OaM=pSRMXDVVSSZ06fiFaPq+XqFQ@mail.gmail.com>
Message-ID: <CAHk-=whv=zGZO+6rrFLcv_OaM=pSRMXDVVSSZ06fiFaPq+XqFQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.7-rc2
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:24 PM Dave Airlie <airlied@gmail.com> wrote:
>
> amdgpu:
> - Fix a regression in a previous s/r fix

Side note: if I hadn't been cc'd on the problem, I'd never have had a
clue what s/r stood for. I'd have assumed that it's some special
amdgpu term.

And the language in the actual commit message itself is not very helpful.

So please do write things like this out a bit more.

I expanded that "s/r" to "suspend/resume", although the change was the
suspend, and the bug was how it impacted shutdown, so I guess that's
not all that clear either.

               Linus
