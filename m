Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF60C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7DF2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590690910;
	bh=5f/UQK4AbvT+ggwsQdG9jYroFY1q2Cl/Gx2hs1GIzyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=umukMm3wzjDZWVak63PAKsRIXKwMEqQpycmZHf6ym3oo0dWAVNhECiYdaj677/qBw
	 RiDqduQ3Nc+vNgjuyiy+a1SkS/wsNljKErtzf8cnkc22Rw2Fdd9eBrMnJKGwJ8P1cR
	 WCHkzTmxs7kp6mWBQqTIHPMqJRuW4SNbD6oyfWCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405885AbgE1SfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405871AbgE1Se7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:34:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8371C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:34:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so34624657lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZXwnhtb72bzMNc7WKjgVNvk5iu+pb/emOFP01RfFs4=;
        b=b9b6qcHWL3rOwKE2o1mVgZTGi/Jh3UakeJMZtMrGip2F1JRvbD0aBKiFLhF32UXav0
         ZpY2pTzxDigSqUkwl6GDFnRIt2rCahf3zct6AEV65X4TuuHjQAb6CYv6WxS61N4EMKSi
         ve3JAJIoruOf0C5zu7rxwZf/wvvstfcA9PZeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZXwnhtb72bzMNc7WKjgVNvk5iu+pb/emOFP01RfFs4=;
        b=NlH5Arx64e3YWkSXEoRvkqpkwr47HP1XI7xaKMaTR5rqmABbpEWZ1P94Rd4ZceeSjS
         vt8e2kV+BrE7joMewd2tWKBV+Ps3QCLA7SsBuei3l3a8hdZhaoLSMWHYgQSK/8RfeeSm
         hsNAD7jR8BvTauk6glY7AHcYDbdqhthH2+J8s38863C1Fy/OtazquZ7YkTswyK+sxVFT
         eSCpswRTfVDEg+yliRsCFG16/8QRHxwj/Abi8KYeonrjIveyJalFpR5d+TS/pYoInZVs
         hDLPY5uhmnSEpsv7OwxfA5q8huQ32y/1kmVAlWXbVr0X0v9I09Krbq7W/EBMx8d9Uien
         kOYw==
X-Gm-Message-State: AOAM5333eWh02KZzdXAGAmYn4liMtGbnv7MUqIuYSSSmHDhCNhakuiop
        HBVPK951bTZbDX7GCry/JXPN8agHVeA=
X-Google-Smtp-Source: ABdhPJxdr8nEeFRhBqu2HqEj2+2ofEx4Lq0AoXvdhH6yvJy6XDIUAfBoK19A8MSLKHnjVlsAOGpU5g==
X-Received: by 2002:a05:651c:323:: with SMTP id b3mr2059871ljp.454.1590690896403;
        Thu, 28 May 2020 11:34:56 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id a12sm1573001ljp.60.2020.05.28.11.34.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 11:34:55 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d7so5995824lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:34:55 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr2363365lfn.125.1590690894732;
 Thu, 28 May 2020 11:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527213447.GH23230@ZenIV.linux.org.uk> <20200528070255.GA790247@gmail.com>
In-Reply-To: <20200528070255.GA790247@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 11:34:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
Message-ID: <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
Subject: Re: [git pull] coredump infoleak fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:03 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> I'm wondering, shouldn't we also zero-initialize the dump data to
> begin with? See the patch below (untested).

I actually got this patch from Andrew today independently due to a
KMSAN report. Which I'm applying.

             Linus
