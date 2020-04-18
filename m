Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650BC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E79C21BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDRTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:08:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgDRTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:08:14 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCJvA-1jYAYw3LrG-009RqB for <linux-kernel@vger.kernel.org>; Sat, 18 Apr
 2020 21:08:13 +0200
Received: by mail-qt1-f178.google.com with SMTP id x2so5129571qtr.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:08:12 -0700 (PDT)
X-Gm-Message-State: AGi0PuZvEE+2HLyNpwWd1mvv1vE6/zeSDNvbGPhR49J717usGoo5jlbj
        ypIXk4QkzuGryRR2dyAZe3YV7ywkwcZ/n38QAFo=
X-Google-Smtp-Source: APiQypIQyXCRKSNvdaLZyvEmQlPP55qqr3ssdQ7+2edvP8fsUKvIDTOrd3u0yqw+zJY4D62C/KJ2CxmsV4AmsRa3J14=
X-Received: by 2002:ac8:296f:: with SMTP id z44mr8929296qtz.18.1587236891632;
 Sat, 18 Apr 2020 12:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200418162157.50428-1-wenhu.wang@vivo.com> <20200418162157.50428-5-wenhu.wang@vivo.com>
In-Reply-To: <20200418162157.50428-5-wenhu.wang@vivo.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Apr 2020 21:07:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05Rr7q_OtqqtG5hCPO3cettAJQNpmD0ULec+3PS-QPHA@mail.gmail.com>
Message-ID: <CAK8P3a05Rr7q_OtqqtG5hCPO3cettAJQNpmD0ULec+3PS-QPHA@mail.gmail.com>
Subject: Re: [PATCH v6,4/4] drivers: misc: new driver sram_uapi for user level
 SRAM access
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        christophe leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kernel@vivo.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8ZxrgN2A1Lko1y08b0S35T9iptQBWw0tyEvHJw94iggeKE551jJ
 EWyILGChISCD6nomyqQISA3vB9x9UBatj1S37cL4yAGSjuGO/7DSmIP9Leo1HSjSHzeLeQI
 l0RGD5XCvD9zAs44AZsT0gOIFJsBb35KpnjRB9XKCNBKS7KL3exU3qz9i0lSNMO0plTbYIW
 ca73fIeUMSyAK/X9Pzchg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BfJ2MlxJAY=:YWf+z0SU0dotGHqTPuf97B
 R/hIO/5L9qXHLFqNjfvG6eCgWlARtldyDgwkg/wYSZj21T/RAyLK3AR1+ugyOHrpUHS09cxod
 oS6J73J2kpUjiHnOKjGAyqsErm+p9cfrkjg61WXbfWuYww6ZSn1DD5OT/3P6sdYHQsFnhRCiz
 axkA53nDB+7CMYvSyuPZkYM4KIvgtfI7f0pnB1R0ZhVw/77OigI7IBKIoW+UqqpIGJqfaXhU1
 J+WxX57LSJZd0+jL2aP4GY2L2/botm4iAX2yjbAV34Z4ij38NMYhQiKoc/1oWIGVJ7gL6rLPZ
 iTY7D1cyLbCh2oP1l2OS4VWZRaHn5SJf/i77/jgixshJdnDGc045NlTv8zhWkhTHLZVfhFo02
 cxCwl/T4qhzrJAnjos7vwMwHFiY5HMsR2NXf80x7x+JBUg1XZrCj9zm4m62TXgZ5mRWpb9PGN
 TgiU+sMn/ApAH+p2J5D9aBi253CSFLSZwtrTippLmL5ZDsPdJhuEhz/385gCw/3MuwyfrF+b5
 VGkKnlLta8RA6xkWSZ70KhQigUJveYLibea3knxG+dbh1XdNlIVaiqgDqQPXHtqyqkDnBlUOg
 FYHHSRZjkDnls+rR8XB1QcTo7xVTMv+JPJc9thwkhjHktp2QrAcSv9NgJBjy6eeI19tCFHp5N
 G2OuTHN771ccpm9skuYTPq+ZrYnn+1qI9+2bE9HOwv3ImayWEXuE84uM5COHyFJzxo342HSXG
 8y8I4DKawVcNU/I+9uqGCnWvKK8kkVZUkz8kYcPSnMdGD9KQCyxFjnD15bBmSJARH+Uc1gZvH
 +rchzaltaIzYai/eWDhQl4RVqCfXb/tWWzQ42skxmjtoJk9dfs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 6:22 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
>
> A generic User-Kernel interface that allows a misc device created
> by it to support file-operations of ioctl and mmap to access SRAM
> memory from user level. Different kinds of SRAM alloction and free
> APIs could be added to the available array and could be configured
> from user level.

Having a generic user level interface seem reasonable, but it would
be helpful to list one or more particular use cases.

> +if SRAM_UAPI
> +
> +config FSL_85XX_SRAM_UAPI
> +       bool "Freescale MPC85xx Cache-SRAM UAPI support"
> +       depends on FSL_SOC_BOOKE && PPC32
> +       select FSL_85XX_CACHE_SRAM
> +       help
> +         This adds the Freescale MPC85xx Cache-SRAM memory allocation and
> +         free interfaces to the available SRAM API array, which finally could
> +         be used from user level to access the Freescale MPC85xx Cache-SRAM
> +         memory.

Why do you need  a hardware specific Kconfig option here, shouldn't
this just use the generic kernel abstraction for the sram?

> +struct sram_api {
> +       u32 type;
> +       long (*sram_alloc)(u32 size, phys_addr_t *phys, u32 align);
> +       void (*sram_free)(void *ptr);
> +};
> +
> +struct sram_uapi {
> +       struct list_head        res_list;
> +       struct sram_api         *sa;
> +};
> +
> +enum SRAM_TYPE {
> +#ifdef FSL_85XX_CACHE_SRAM
> +       SRAM_TYPE_FSL_85XX_CACHE_SRAM,
> +#endif
> +       SRAM_TYPE_MAX,
> +};
> +
> +/* keep the SRAM_TYPE value the same with array index */
> +static struct sram_api srams[] = {
> +#ifdef FSL_85XX_CACHE_SRAM
> +       {
> +               .type           = SRAM_TYPE_FSL_85XX_CACHE_SRAM,
> +               .sram_alloc     = mpc85xx_cache_sram_alloc,
> +               .sram_free      = mpc85xx_cache_sram_free,
> +       },
> +#endif
> +};

If there is a indeed a requirement for hardware specific functions,
I'd say these should be registered from the hardware specific driver
rather than the generic driver having to know about every single
instance.

> +static long sram_uapi_ioctl(struct file *filp, unsigned int cmd,
> +                           unsigned long arg)
> +{
> +       struct sram_uapi *uapi = filp->private_data;
> +       struct sram_resource *res;
> +       struct res_info info;
> +       long ret = -EINVAL;
> +       int size;
> +       u32 type;
> +
> +       if (!uapi)
> +               return ret;
> +
> +       switch (cmd) {
> +       case SRAM_UAPI_IOCTL_SET_SRAM_TYPE:
> +               size = copy_from_user((void *)&type, (const void __user *)arg,
> +                                     sizeof(type));

This could be a simpler get_user().

> +static const struct file_operations sram_uapi_ops = {
> +       .owner = THIS_MODULE,
> +       .open = sram_uapi_open,
> +       .unlocked_ioctl = sram_uapi_ioctl,
> +       .mmap = sram_uapi_mmap,
> +       .release = sram_uapi_release,
> +};

If you have a .unlocked_ioctl callback, there should also be a
.compat_ioctl one. This can normally point to compat_ptr_ioctl().

> +
> +static struct miscdevice sram_uapi_miscdev = {
> +       MISC_DYNAMIC_MINOR,
> +       "sram-uapi",
> +       &sram_uapi_ops,
> +};

The name of the character device should not contain "uapi", that
is kind of implied here.


        Arnd
