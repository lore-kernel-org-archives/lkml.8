Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3934D207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFLMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:02:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:02:33 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MaHOX-1jOS5C2qmL-00WC6W for <linux-kernel@vger.kernel.org>; Fri, 12 Jun
 2020 14:02:31 +0200
Received: by mail-qv1-f47.google.com with SMTP id p15so4210873qvr.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:02:31 -0700 (PDT)
X-Gm-Message-State: AOAM531yWUIiDLH+/Q4cBa1ph4Y+/rmHKdIX4fjelErVFRWhTpc1epR+
        HRxu+J+K5ngIqs6vNr3yFDyHfaEFO7fAktxkZCk=
X-Google-Smtp-Source: ABdhPJwaC0q8qhyefJKAApvPQhwFQE9nP2a9nN27A+JIasUQypms2Mw76+TpVRTnJXgj3VyngfdGI9MrYEpUMtvmB5I=
X-Received: by 2002:a0c:ba0c:: with SMTP id w12mr12628573qvf.4.1591963350524;
 Fri, 12 Jun 2020 05:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com> <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jun 2020 14:02:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
Message-ID: <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YC/v+nicOl6cvJOVTGJY/HVyIWGBFraAlRDgozF0T0qDrGiQw3k
 5ggN15KSh3EdkJ9S53+BrUGcg9E+WSHs3F0ttUIisfps+e5vEhmbv8krGCc/kPfAha2U1W+
 44JinSYeOypkKjDWyoCbwGDNTnSTREIE2CRJYbEcjI9Qo953hennwGqZwPPJXxUx4EKnyNh
 oIYNplDQKG2I6tfDcmViA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MOGUWIfZU4s=:xR6L6qkvFA3jtnoOTHFgl7
 Bv++m24RMPCQCEf6Ul+htjmpgfvjrUsCQVZInIoYAP9ReJrpsav0CQQ/RqZY6H0izSSEYSLNG
 FEKsS1ieMg6knaMlpIqxAucqdL5ZNpxPuz7N8TEqAIjYbJLCrCPgP+ABQTzwp5LzIAA2cT4CT
 aoCtlrzDQ+FITt9wPeT1nlTzsNN0MxSS76dcq98jdu4dguJHdgdXP5FmII87QqU75xu67vX2Q
 uMFbamBOlvdfHLiIKsFpGFFmOub1uruAe4c30dxyoIgS/tj11ahnCgB6Zimz2dwO5FdNzZILL
 Afe/f//qGG+de+zd0CBHE4URhXBe9L7PFDskG+C2qEWx0K+aKqsPeg4akdz2uTLvW+sE1B/Bi
 HKEeLWJYrQySxV2+M+Tw1Zm3LHIX8us9lfYxrHl+sfSZpXrynLrJEsKFVWnUzM8giQ0anHzGC
 ipDCX+Z824NS3Z798Etn/lLtyALFJDbkKawNchDBATMD9HnYzguw+VbMIAXht1aa2gGNNsv2i
 2kifS1uOy865/SJ9tRPIJ1WTbeb76wcGZ4B8CVYz5HD5zjD7+2+xGjG33vrcYkpbg/f6RAjuC
 mFYp/XpojOdyrlud0fjZaRWrVtN5Fl1m1rle9L4fciyvu5zV1oteKFudeN+ADP3xcPN74rchh
 Bg8o7oqoq29Im8H/EUDKwLWEK1eLWkEK5XIi307K0+7MP8vSRBciUdGuGXstWJ8tcHv/7DElU
 Nli6O/oVk1Cf8LCStNfqysIg4CoTH+HPkb0Wxhklif5+jDw4y0dWcRTPoa48yEZlkKrTJCfUj
 m9c/pcJGao/oVt4/gje8ypihC1sjx5UNUa1euGLcf57eLcpoJg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> copy_{from,to}_user() uaccess helpers are implemented by user page
> pinning, followed by temporary kernel mapping & then memcpy(). This
> helps to achieve user page copy when current virtual address mapping
> of the CPU excludes user pages.
>
> Performance wise, results are not encouraging, 'dd' on tmpfs results,
>
> ARM Cortex-A8, BeagleBone White (256MiB RAM):
> w/o series - ~29.5 MB/s
> w/ series - ~20.5 MB/s
> w/ series & highmem disabled - ~21.2 MB/s
>
> On Cortex-A15(2GiB RAM) in QEMU:
> w/o series - ~4 MB/s
> w/ series - ~2.6 MB/s
>
> Roughly a one-third drop in performance. Disabling highmem improves
> performance only slightly.
>
> 'hackbench' also showed a similar pattern.
>
> uaccess routines using page pinning & temporary kernel mapping is not
> something new, it has been done long long ago by Ingo [1] as part of
> 4G/4G user/kernel mapping implementation on x86, though not merged in
> mainline.
>
> [1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain/

Nice changelog text! I agree the performance drop is not great.
There are probably some things that can be done to optimize it,
but I guess most of the overhead is from the page table operations
and cannot be avoided.

What was the exact 'dd' command you used, in particular the block size?
Note that by default, 'dd' will request 512 bytes at a time, so you usually
only access a single page. It would be interesting to see the overhead with
other typical or extreme block sizes, e.g. '1', '64', '4K', '64K' or '1M'.

If you want to drill down into where exactly the overhead is (i.e.
get_user_pages or kmap_atomic, or something different), using
'perf record dd ..', and 'perf report' may be helpful.

> +static int copy_chunk_from_user(unsigned long from, int len, void *arg)
> +{
> +       unsigned long *to_ptr = arg, to = *to_ptr;
> +
> +       memcpy((void *) to, (void *) from, len);
> +       *to_ptr += len;
> +       return 0;
> +}
> +
> +static int copy_chunk_to_user(unsigned long to, int len, void *arg)
> +{
> +       unsigned long *from_ptr = arg, from = *from_ptr;
> +
> +       memcpy((void *) to, (void *) from, len);
> +       *from_ptr += len;
> +       return 0;
> +}

Will gcc optimize away the indirect function call and inline everything?
If not, that would be a small part of the overhead.

> +unsigned long gup_kmap_copy_from_user(void *to, const void __user *from, unsigned long n)
> +{
> +       struct page **pages;
> +       int num_pages, ret, i;
> +
> +       if (uaccess_kernel()) {
> +               memcpy(to, (__force void *)from, n);
> +               return 0;
> +       }
> +
> +       num_pages = DIV_ROUND_UP((unsigned long)from + n, PAGE_SIZE) -
> +                                (unsigned long)from / PAGE_SIZE;

Make sure this doesn't turn into actual division operations but uses shifts.
It might even be clearer here to open-code the shift operation so readers
can see what this is meant to compile into.

> +       pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL | __GFP_ZERO);
> +       if (!pages)
> +               goto end;

Another micro-optimization may be to avoid the kmalloc for the common case,
e.g. anything with "num_pages <= 64", using an array on the stack.

> +       ret = get_user_pages_fast((unsigned long)from, num_pages, 0, pages);
> +       if (ret < 0)
> +               goto free_pages;
> +
> +       if (ret != num_pages) {
> +               num_pages = ret;
> +               goto put_pages;
> +       }

I think this is technically incorrect: if get_user_pages_fast() only
gets some of the
pages, you should continue with the short buffer and return the number
of remaining
bytes rather than not copying anything. I think you did that correctly
for a failed
kmap_atomic(), but this has to use the same logic.

     Arnd
