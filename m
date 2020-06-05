Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22153C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC76B2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJA8AXXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgFEKu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFEKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:50:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BEC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:50:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so5525849lfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6PBqcu4dVcPaFrw4BGh+fD0tEbF0DBVHcXKAqEgRwQ=;
        b=wJA8AXXEALmx6h3BWpbD9/vkieuXWksBsDZWq9Pl2uDeXenuSDoa0dznCTcn+aMeH1
         FDIoPzENIOa7kle1EeAj9gaWffiLBBFmuAngkJioqKpQekFVlm6P0k9pkF5h2JIR5qAg
         1sndcEZykPljB5wOYiMZa+ML8HJ98KRc/fLqhiZketrr8WCL5b5gk0CKHY8OgGK0JirH
         SrOXZPgxeIIZZEuIxfWlJIeUu9CUFvtJLJQaSXgkyiNvFiZil1NumLc9kpGLuzKLh/dq
         J6IaWNL2ex89PXCoVGoLet+kf9ulu9/9GpwsVhF0mQYfKxQVU9ZnK6wCSQlm89kVsN4s
         gSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6PBqcu4dVcPaFrw4BGh+fD0tEbF0DBVHcXKAqEgRwQ=;
        b=mRo4NKbY+v86T0hn+5i44gqvMv92reSxGDWKiW1rFzDH4zLTBA0n4dJm1rXfb53jQC
         GCxLm6liceWM/dt9AasQVIoqzlo56/dtHXKXgolfO27vp5JwqHMGRfa6936SIuLGd4e1
         EXtkeQHbuypRU3Sv3GhQ2TLJ6IKVVa3zZg1KM0UyPRHVrzKzzQOY1oPgtlvay5X4O+LQ
         gZz9d0MFqH7u7957XMQXeYJenMuWjkp02qoeYBd6l6yRi8+3DCY8nFd6QNgOtrwtwlZV
         qiAWwGXYE75n1tDtqUQ4W4Alzgzb1ZfJkZeeFAW+yxh+Va2fK+axtSVXM3ppRSoyrj/T
         PZjw==
X-Gm-Message-State: AOAM533Wm2hyGblPfagFX6jbUhVs5cA3L58TPVoFHyMeGnKFBSNR6vd2
        D+LZptJXV+RqHyfsNTLsZBizaGR7E3pPRwhEPfYduA==
X-Google-Smtp-Source: ABdhPJzOJiojtwmNr5SOMrlaeXW50qJdj5r2rISr3n1YjgPpD4saq3YvUGnbwmqz/JJwarjnkhdVjFMdX/8wIL2olCA=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr5064475lfg.55.1591354222649;
 Fri, 05 Jun 2020 03:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
 <203212099.14886500.1591345676708.JavaMail.zimbra@redhat.com>
In-Reply-To: <203212099.14886500.1591345676708.JavaMail.zimbra@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Jun 2020 16:20:10 +0530
Message-ID: <CA+G9fYv=2xqP0ue69jk-xMa7VRwg0dOm14TqkNUazsqvxbU0_A@mail.gmail.com>
Subject: Re: LTP: syscalls: regression on mainline - ioctl_loop01 mknod07 setns01
To:     Jan Stancek <jstancek@redhat.com>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Martijn Coenen <maco@android.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 at 13:58, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > Following three test cases reported as regression on Linux mainline kernel
> > on x86_64, arm64, arm and i386
> >
> >   ltp-syscalls-tests:
> >     * ioctl_loop01
> >     * mknod07
>
> Test updated:
>   https://github.com/linux-test-project/ltp/commit/13fcfa2d6bdd1fb71c4528b47170e8e8fb3a8a32

ack.

>
> >     * setns01
>
> commit 303cc571d107 ("nsproxy: attach to namespaces via pidfds")
> changed errno that is returned for regular file from EINVAL to EBADF.
> This appears to fit more current man page, so I think we need to fix
> test to accept both. (I'm looking into that)

Thanks for investigating these failures.

 - Naresh
