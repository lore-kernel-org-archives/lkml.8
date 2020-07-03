Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8A8208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593806999;
	bh=jnvKLWWZV/+AhJWo2rQU2rEaohy8bQfmt5/S+bqYzBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vzMGjto9gRGIFwf2RFTnDQpWy/ZZ7BtUudArYZoCkaWmGEpDYYVsM3/4oayS5D3Ji
	 7uM/Bt4/HjbBE+43arxcBOv8sZOUCC8Mg8OPaQIWGATFrr/4/HVULwrGqw2AdBp6nc
	 x3ryPUAhALhn/0VJJCQrVw74brQqdoe4zZ8Ao8bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGCUJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGCUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:09:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9DC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 13:09:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so22437155ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32NJCoPJ1LAKcnLbho5tjOXJbJthQBzYpGTkqpYZEQE=;
        b=eNU4xHzNwEfW77EIM2wKYJg3eybE7Nh7EyOIpR4XOg9JVMHJGOM9J2GMb29dLLCC19
         eCwMpT6ZQ/7wOkeMhKW8qMHCpge4Y6/MuMloZujBASUUaO8qoDnPo1CoPF4mEuogr81t
         It5p0dNPsnZGDGAqvdYQ6PXZ4VW3E0m2F/Uw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32NJCoPJ1LAKcnLbho5tjOXJbJthQBzYpGTkqpYZEQE=;
        b=NZbZVVKasVg6Azf+Gl9Kd9rUgs9l3OX+5r93rtjI/Ro1RICw+s8y1R/KNhVOFg/IDe
         4uQgTdLlXoqBZLYoyubQz5yH3gyPXpZ0GGnoVJl7EA8tg7OlinKiD5y7q8Pcwxe+Naot
         JEnXlHOgjrIuIzXlwAu1XaZ9NgfSFNzfHFnuP+WfYg+zEgDXkD+zBGUfnQMydwWXYqs2
         lN2EIld3XDppRt2E2lRwerzEQ7E0PMKzb7indAC32d9/Xd3GGn0grUZRsEuip+nw7hoX
         qTFEgutuS7wfH8pLh9WUueo9WdSrmLn7OEgR4GwIaaqwDTjNhR3WY4/hXXMQje9Z3Zmn
         zXMQ==
X-Gm-Message-State: AOAM530MO8EtHyV2MtC4EkvLL9yfTQCh053Fo35BFBUXwSUPUfinkvkb
        GBV2OSpCNynMwmB++uM1xeANJWNQQBg=
X-Google-Smtp-Source: ABdhPJzpC2EsmTBYDo4G+gLcq3Ru+0/rPSK6DcKJFBSgIvwRxmLof5zGP2lZxM4rIcFcDM+ktcR+4g==
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr22018630ljj.114.1593806952959;
        Fri, 03 Jul 2020 13:09:12 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g2sm5229532ljj.90.2020.07.03.13.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 13:09:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 9so38268980ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 13:09:11 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr15335747lji.371.1593806951543;
 Fri, 03 Jul 2020 13:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200703155749.GA6255@pc636> <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
 <20200703192807.GB5207@pc636>
In-Reply-To: <20200703192807.GB5207@pc636>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 13:08:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
Message-ID: <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 12:28 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> I have MSI TRX40 with latest BIOS.

I think it's just that the BIOS is set for the max possible, in case
you'd have a 3990X.

I compile my kernel with CONFIG_NR_CPUS's set to 64. That works around
the issue.

Lots of distros seem to set CONFIG_MAXSMP to true, which I guess is
the most generic thing to do, but the problem with that is not just
the silly problem with the BIOS, but it also means that the kernel
does dynamic allocation for cpumasks even if you _don't_ have that
problem, because at compile-time you don't know how big the cpumask
will be.

With CONFIG_NR_CPUS's set to 64, the kernel will just use a "unsigned
long" on the stack (and in various data structures) and be done with
it, and not do unnecessary dynamic allocations.

                Linus
