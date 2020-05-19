Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF386C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A746D206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgESKWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:22:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:22:15 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MnagF-1jBFQH3KpJ-00jWAm; Tue, 19 May 2020 12:22:13 +0200
Received: by mail-qk1-f171.google.com with SMTP id g185so14184724qke.7;
        Tue, 19 May 2020 03:22:12 -0700 (PDT)
X-Gm-Message-State: AOAM5327/pSmv/z9zW/zrzhAN5vQx9PdA8zzScvA3g2GmehtpEBr2pT3
        yWGP4nrcc9jGn1YulbiOBILWsAIt29catOZr+dI=
X-Google-Smtp-Source: ABdhPJxOu+nLjvg7CMqkLaOXbJg4GTm6uL1Kx08HssunT+gb6Fi/yoTUZBq2l9jxT8nUph2PPk6WMqUkT4Yu1iuBXRQ=
X-Received: by 2002:a37:434b:: with SMTP id q72mr21154808qka.352.1589883731571;
 Tue, 19 May 2020 03:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com> <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
In-Reply-To: <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 May 2020 12:21:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Message-ID: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        john.p.donnelly@oracle.com, pkushwaha@marvell.com,
        Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IaFyvGkTNM1AAdVcuuF/bd7zHtH4dIF2+9hp8YOKRGna4ze1B3A
 aoVRJO4OZxWRnKXKKpMMIdcQOLMBHrJ9h7EfkyCrL2zS8jwXaP8mLY6MunV9PHE3woNFhOF
 m/4gyKcKhNNr3FuBZ/mAHCi1Zih+x6ifr9KGLuW27I+8jJmePrvBxyw2eQL/SpB8scn+U45
 Bl2VwWEOe2m8woFm8fTIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7C60NW8JFw=:HGNEjZNBDC3mlc32v5afSu
 i4mTtOfmF688rqsrWTp8qmZxPxjSmiaFyCv50k6OrWajTSxvNub+XWYXTuEbaKJpwu8xJ9qj6
 AI/s57L/LSrwEr6yrJ66DTP6EjCNQOjW9WZgnBffuiA78I8VtwMbTA6NB7TkaWbVdiUPF1jCP
 ucfpzVJpj4QRq1REufwsVz7+JDrW14vL54sBaRSwPTFli8A1zZ/9O+CMUG7/dwSSrqnyH9McW
 SyhfQVDEA29/VaWwZAqvmmVdVldMKF0nqRuSWIzdsOaqwxtCrnqGg0bjojDDwjZdHBeqb0e80
 DtyIfmcXOFa8a1VPZkBCRSEOWvS9GBeHcSjapkajkUS3lNQCpG1v3uWCXn0RHlg852ZNOsIZx
 L5I/dVKcjk0b6q960ZHmJB2U6mph5hYnH7vTFlnP4bkvdnlSHLlSYfmJTBKUuQTA4pSWfhtzA
 f+wiWV2Ks+s0NvgyzJ+mR8VQ9u4dgSgblb0ZB9xhRGrTTuYQvIMmBZKt0k7VY/NE8CQYjhc3m
 Su6guC49Cl1CFiuB7WOldX4xMpR9/c+WPUSoHF2ioQZhQ+pXDXgPexIE2VNFSyNiNt5cLm7M6
 soB3MW1ln1BP6v8I44aRkOgfG0eJvRHCT/JJhNV5ax/OwyFXzrZ4y5TVKYl1m/SEIv61Kh2iz
 N6NcqURRkZVJqbtHMQBGHd3VsAg7K8QNfA0BWINJL1BMUDwkuseeF/5R4UK8kMrs5oWFgYgpX
 XshS0TFOCnXetybGEnMZHsX8SO0geNcg8myeaDfv84JC0QoM76HSZ4mcjy2jgBrW+k7ZYF2ZM
 rt7iMm64YBkFWuztix2DfZwT8T/kvD8AL8d+SQTxxIwcAl2XS0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Hi all,
>
> Friendly ping...

I was asked about this patch series, and see that you last posted it in
December. I think you should rebase it to linux-5.7-rc6 and post the
entire series again to make progress, as it's unlikely that any maintainer
would pick up the patches from last year.

For the contents, everything seems reasonable to me, but I noticed that
you are adding a property to the /chosen node without adding the
corresponding documentation to
Documentation/devicetree/bindings/chosen.txt

Please add that, and Cc the devicetree maintainers on the updated
patch.

         Arnd

> On 2019/12/23 23:23, Chen Zhou wrote:
> > This patch series enable reserving crashkernel above 4G in arm64.
> >
> > There are following issues in arm64 kdump:
> > 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> > when there is no enough low memory.
> > 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> > in this case, if swiotlb or DMA buffers are required, crash dump kernel
> > will boot failure because there is no low memory available for allocation.
> >
> > The previous changes and discussions can be retrieved from:
> >
> > Changes since [v6]
> > - Fix build errors reported by kbuild test robot.
...
