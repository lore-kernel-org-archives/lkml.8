Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CDB206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586454707;
	bh=OgZqU6/p7sp/8rW/N0WCBoaZXQS0YqK9sSMvzH9rJ+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fLxQalg4ZN6vYZVrIL/4XbJpyiRK6MK8PAvyGDICMmqKx5CMH5iAYnu6OZmbKx1jZ
	 ry1iHuIv3+Y+PV+qehlLCWSTYl6Khcn9uQMQb/2KLxqI+Q8egwcLpHTPeDWTLVIsR0
	 Q+wqcfG91iuv2pj8ReEcs8UvQTEZ6xy6POHqZZRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIRvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:51:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39817 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:51:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id m2so305321lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zm8DFopuwC2QUaIC0B+S/jPJIiq7sgNNsjYHbSi6B8g=;
        b=brLMEHKsLxQS/mXRonp0tnS65ifhtX+aGx3P1Zd+nyVvr7TqzJ/j7mDabxm2r9FyZ8
         Iq8pKJNR34gw2pOatRbQZUfC2Xpt5XGXsOAz3RYH+hVfNRIlj9HinhWv0whAVLNa54Cy
         tCgERca2zB20B2lI/kSjpHGDO9Fs8BlGzH2ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zm8DFopuwC2QUaIC0B+S/jPJIiq7sgNNsjYHbSi6B8g=;
        b=MvWqB7aa7N8ekQU6w5iNMsYyjh565q0MgUYAewFA82v43xfdrgSX8wDvWIEtZmPAFz
         kx4YYZbHsAKlS1PrxmWvPW8ZaOw2Mu4G0lbiUgFErJO79I0ln1s7a1Rg2vzGSi8j311y
         eDlY+Il75Ntgw1Owy80Mrr6Kgml8BIxs0LpJpjYU2t+ilNgDkMzatFAgLbT87Rdajwn/
         ksddAlUI5XRhlkcL/05Om9nSHt7UaFkc8dOPqh5Ius48+mjMwzCoeIQhb7GXqYt35EOD
         g44udEnGtabsrokD/4cdOeqvDuyCk7MmX3XxI0M3WwTK7DvQURhIBL//+6KKMa3Tjm/D
         ZNZg==
X-Gm-Message-State: AGi0Pub7SKbg+1WDexcfJY2MGx+V/lyfUQAQPU7Wc6tIsE1JkoA9xLAP
        ySJfzLxsS8yuNWfwkooTQCjmxdNxdik=
X-Google-Smtp-Source: APiQypLhiAFwLrxJ4JBTbxvzPeGnHielQgl3tHaLXlYBsdQHenQD1oUr+/3uOZSPxDw6rwkNtn/k7A==
X-Received: by 2002:a19:d3:: with SMTP id 202mr291975lfa.24.1586454703195;
        Thu, 09 Apr 2020 10:51:43 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s30sm8585944lfc.93.2020.04.09.10.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:51:42 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id m2so305267lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:51:42 -0700 (PDT)
X-Received: by 2002:ac2:5ec5:: with SMTP id d5mr291121lfq.142.1586454701653;
 Thu, 09 Apr 2020 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-e58ec1f9-86f2-451e-ac9f-9add83693752@palmerdabbelt-glaptop1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 10:51:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgay_mPN5R5k7hjnLmHPy9wU7xm681CVw5rYKa7-HHoDw@mail.gmail.com>
Message-ID: <CAHk-=wgay_mPN5R5k7hjnLmHPy9wU7xm681CVw5rYKa7-HHoDw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.7 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 9:50 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> This builds and boots for me.  There is one merge conflict, it's just a Kconfig
> merge issue.  I can publish a resolved branch if you'd like.

It's not the _resolution_ that's the problem.

The problem is that your tree is garbage.

Your commit c48c4a4c7ead ("riscv: Add Kendryte K210 SoC support") is
wrong. It doesn't do what it says it does. It _also_ adds that
(broken) Kconfig entry for the virtual SoC (aka qemu) that isn't
mentioned at all in the commit message.

It looks like you mixed up commits when you did some development.
Possibly because of bad resolutions when rebasing or whatever.

I don't know what happened, but your tree is a mess.

There's also a duplicate commit 9f40b6e77d2f that is a copy of commit
2191b4f298fa ("RISC-V: Move all address space definition macros to one
place") that you sent earlier.

I fixed things up and pulled this, but you're doing something wrong.

               Linus
