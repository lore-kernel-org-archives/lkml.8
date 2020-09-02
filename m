Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75490C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5117920767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIBUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:40:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:40:43 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5gAG-1kBwjT27Cc-007H15 for <linux-kernel@vger.kernel.org>; Wed, 02 Sep
 2020 22:40:41 +0200
Received: by mail-qk1-f169.google.com with SMTP id p25so1082461qkp.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:40:40 -0700 (PDT)
X-Gm-Message-State: AOAM533ti2wpuJkJg6+9FH7kQM99tCbVxx6uoWVPr9fmO7Q7BQgzXrIz
        i5M/pLn8rjyX/+Z6Q48JHScZSiUSQkA6KMGFqkE=
X-Google-Smtp-Source: ABdhPJzodmejhJAtMKThbQWlJFz80SFiO54mmYtjDdiM3ONaN1YOToVfF3hqMeVTv6Cz4OnXxE/L/LZUnPhskl7a0Ug=
X-Received: by 2002:ae9:f106:: with SMTP id k6mr8135941qkg.3.1599079239381;
 Wed, 02 Sep 2020 13:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <b7719680-e451-5687-1fb7-c8c059a880d4@acm.org> <2C755628-1426-4BA4-B2A3-AD059BB0F605@exactcode.com>
 <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org> <20200827.230128.2175364115734830909.rene@exactcode.com>
In-Reply-To: <20200827.230128.2175364115734830909.rene@exactcode.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Sep 2020 22:40:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0XByLZGCMirzQfwBS_1HLzA9s8h3-JPQM171XGTycohg@mail.gmail.com>
Message-ID: <CAK8P3a0XByLZGCMirzQfwBS_1HLzA9s8h3-JPQM171XGTycohg@mail.gmail.com>
Subject: Re: [PATCH] use cpu_to_le{16,32} instead of __constant_cpu_to_
To:     Rene Rebe <rene@exactcode.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WFS9Gwp/vvhBs+3BN0hPtw42MfmCggOSKiHUd6r956gkSP1SCAs
 7Axg5qTjSRPaoeWQH2AmhW45YdrVydYj+lP0lcLWU7hgfUAyiTn5a+rb0Aa/aB1pyxdHX60
 xsWRCfNytoVaQn7iTVWxtDT80fwftT69z5KALt+nOs9rNBvcgOd3yb0m2q/I0fypqdpuHyW
 vF+5FAwWA2qOC3a8804dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1vtooSoJDT4=:KR/MCF9WUIACsKL7/bGtKK
 CqKtRyI7axyGNC98zcaCxlItjxHdTwEojRdfR+qW1SdTucFoPLtfncc3WO+S+wG5g43KmSi9N
 NY79IfwBPYYOaf+2YXqyAvOIYxok+9HPCmer0vwoKW4cQ49N2Cwdox+4gBOc84IP3Xva7z5Uz
 id25T2SIx9/waFob+sKJuLZDa9o2xmm0dxBubuduGLIPyn32Uh75VtDdGO8EJL+G0Go+MWyP+
 T2aa0F62rmRKAPEceGhpMxnrkgWpf5Z0cYLvzAOQVsPBSsyIq/a/SGUmeHFZqgBu+Gf3KrehV
 g0yWtcr62wbOD32FyIw6X2BgnxwVOENx77QXt63Xa+cVCHyFWtWqoZg7WdeIkqH5kEbiOyTx5
 m1o5VO8/xkTS3/gOLZV99DI+qulw7+JLuHkpn/OYDGH0bFdZYbJFIJA4cqBDoIkVMEwDJW+KI
 x5WvJsw73vEwIgLljnhif0KChK5+bhHXKmYM8RslGMgSXbjUB+vmyB38vXpnF+Ifg6Arhpn06
 D5LODp1WoTSzGUf85ik+my5Dubc5KKxR1O2t7x61ttzNdZmkcRHRQ1EKSXrXurCxqTl5A1dwI
 AVYUskf9gY/wE358dlu92tzPRdsezLPa9JT1d97QDqvP/lTLyv6h8dWLdOBF78iQ2DQ10aRZ2
 bJvtS6amkzaCz0v+wgcrElznJrOVdAAgi/ywBDq/pF5CQ4MqqqGLKMTMePzUqJQjs0kpdicxT
 yFsYJGEoV9jgo+aPKXNOZHJ1GZSXb3dCgFxFZ7aKFoTAYAY1FmAfGAqym73pjzTa3vtPL4Yuu
 2tkXSOOvA9Y3jKywWB2UY1uoVg+DoniwAWvOuWecmTfVGkT0WaV59sT9BfNJ2J0O+mWMph9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:06 PM Rene Rebe <rene@exactcode.com> wrote:
>
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> index fbb80a043b4f..3de6bf94ccc0 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c

The qla2xxx and qla4xxx changes all look good.

> diff --git a/fs/cifs/smb2status.h b/fs/cifs/smb2status.h
> index 7505056e9580..3d5ef02f1416 100644
> --- a/fs/cifs/smb2status.h
> +++ b/fs/cifs/smb2status.h
> @@ -29,7 +29,7 @@
>   *  C is set if "customer defined" error, N bit is reserved and MBZ
>   */
>
> -#define STATUS_SEVERITY_SUCCESS __constant_cpu_to_le32(0x0000)
> +#define STATUS_SEVERITY_SUCCESS cpu_to_le32(0x0000)
>  #define STATUS_SEVERITY_INFORMATIONAL cpu_to_le32(0x0001)
>  #define STATUS_SEVERITY_WARNING cpu_to_le32(0x0002)
>  #define STATUS_SEVERITY_ERROR cpu_to_le32(0x0003)

This was apparently left over in f5307104e757 ("cifs: don't use
__constant_cpu_to_le32()").

> diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
> index 8ff4d1a1e774..230a5a7fdafa 100644
> --- a/fs/jffs2/nodelist.h
> +++ b/fs/jffs2/nodelist.h
> @@ -59,8 +59,8 @@
>  #define cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})
>  #define cpu_to_jemode(x) ((jmode_t){cpu_to_le32(os_to_jffs2_mode(x))})
>
> -#define constant_cpu_to_je16(x) ((jint16_t){__constant_cpu_to_le16(x)})
> -#define constant_cpu_to_je32(x) ((jint32_t){__constant_cpu_to_le32(x)})
> +#define constant_cpu_to_je16(x) ((jint16_t){cpu_to_le16(x)})
> +#define constant_cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})

This one would break the build, as these have to be constant expressions,
whereas cpu_to_le32() is a compiler builtin or an inline function on some
architectures.

       Arnd
