Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F481C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BB5206CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6SsoRS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgGFOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgGFOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:36:12 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:36:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o3so15685543ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i/xoykjZv2MN+inM1xeXmVL7pwP7EjFwORlbboikyJ4=;
        b=t6SsoRS3SqKZduQ56/9T7prHW41jyK8QOiO5CboDIO3urs7fgWLgoPllCfr9ASvkN3
         g01IEAh8kbp7d9IxbLoEXYRndfp6uDBwUn2nh3rdnKN93DybHky0l4AcYIzXcnYfFnEh
         HY8R/2XxLWqsojUsDT52KS6kT7Aeka5feYZ5t6VuaEVxfm3q8LJHsVqU9JONv+RZ8Xzp
         KF9pfO7BTZIrnV4A1N3QGhpctF7ki94yNFOFuhInduZhWWBFnSEbrYQ5ZPjJcaY3NKI7
         8dDA9nO5WVCg0d/S64XH87CCZ8Lz8nq68DkfHh6OP0If5hfTOtmEthjXBx4tDof/JDVc
         nE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i/xoykjZv2MN+inM1xeXmVL7pwP7EjFwORlbboikyJ4=;
        b=Z+GLukXaQzjFU3PA4bA9x+F99jcoCwtFscEfza518/hPbLq6qioYkUMBEh081WuSfa
         FgTpkENjWpk4wx/38Fstzn3TRr+zIussd9LC8EpmSj+HbE1Uyb/ABdQGlw+kxNBa/4Vx
         XhvQyrf9z6lmYZ+x4MeDMTV8uavlmg6oQR+5zUSTfF81CSaN6JqV7/HF4ZYqMeKzPi0r
         BGuB0R+r/Azukf8W6EH7JDCzDnblCQqw0m39znFpEjg2lnRF4lV6TkjqEOmVsJ2t31rV
         cQSP+RRJD8f9HgDKkohs3LSxG18sCvSPUgxa6ZZZpQgjxgqymkwUvS/jkam0G49YDJ5W
         oo2A==
X-Gm-Message-State: AOAM532xiGXSG6jya7bGnZEiH8YMZlIWb7g0F3BnrDINvme+pN/l0obO
        kRR0aCBemMc0CUFXEu4BwaAZfiJbeQDjErbTfM6omg==
X-Google-Smtp-Source: ABdhPJyMcBpXGp6jUIarBCpemr4jM/nj3SKBI2Q8C/haV5TtYTU7ngu91vYNiqHB7VekbqrfWaqAqQBBJXmH3WFgwGY=
X-Received: by 2002:a92:a197:: with SMTP id b23mr29571523ill.58.1594046171533;
 Mon, 06 Jul 2020 07:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200703074421epcas2p177b67a55997c00b3b6ad8126a7ce8a6d@epcas2p1.samsung.com>
 <000001d6510d$c3bfcd00$4b3f6700$@samsung.com>
In-Reply-To: <000001d6510d$c3bfcd00$4b3f6700$@samsung.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 6 Jul 2020 08:36:00 -0600
Message-ID: <CANLsYkyZz1cOr-jGqHYr9w5MFbS2+t9+dApn5aBgt-KNERQuMA@mail.gmail.com>
Subject: Re: Could you support the modules of the coresight drivers?
To:     =?UTF-8?B?6rmA7LC96riw?= <changki.kim@samsung.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 at 01:44, =EA=B9=80=EC=B0=BD=EA=B8=B0 <changki.kim@samsu=
ng.com> wrote:
>
> Hello.
>
> I am software engineer in charge of BSP (Samsung SOC vendor).
>
> Recently, Google introduced GKI from Android 11(R) version.
> So we can't modified kernel code except module drivers.
>
> Coresight drivers doesn't support module.
> I need the module support because our SoC should set value to vendor
> specific register to run ETMv4.
> And in GKI, ETM has disabled in recommend defconfig.
> So if we use ETM in Android 12(S), it should support module.
>
> Could you support the modules of the coresight drivers?

There have been multiple patchset submitted to do that, the latest one
last week [1].  I encourage you to review and test the work.

Thanks,
Mathieu

[1].https://www.spinics.net/lists/arm-kernel/msg818583.html

>
