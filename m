Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CFF206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgIJIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:35:44 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgIJIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:35:28 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQNAv-1jtxoT3fNp-00MJBv for <linux-kernel@vger.kernel.org>; Thu, 10 Sep
 2020 10:35:25 +0200
Received: by mail-qk1-f182.google.com with SMTP id w16so5282053qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:35:24 -0700 (PDT)
X-Gm-Message-State: AOAM5319IjGsy03KVQRBzq5pp13nubRR3sNohpfWotIHAQxqQWOB3Q3n
        5RR6SwXG4sR/MluJI467+V5/M/cUh09vbT9XreM=
X-Google-Smtp-Source: ABdhPJw/yNZ9NaNx5KQrnGGIOIdxCSqfigrMiTuRCRZadb6BT/I+4BcdjHkG1/zWNq9enZdOOffqeeKrY0JZOJ/FA5M=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr6388590qkk.3.1599726923765;
 Thu, 10 Sep 2020 01:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com> <ac2ab6d1-69c9-34aa-6c25-588bacc78002@xilinx.com>
In-Reply-To: <ac2ab6d1-69c9-34aa-6c25-588bacc78002@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Sep 2020 10:35:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1aaS85m5nv0hmmxgEVss-hNGL7Qg8iosSFDjDdzzP87Q@mail.gmail.com>
Message-ID: <CAK8P3a1aaS85m5nv0hmmxgEVss-hNGL7Qg8iosSFDjDdzzP87Q@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from
 late_initcall_sync instead of probe
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, rajanv@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        tejasp@xilinx.com, Jolly Shah <jollys@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HQSXYbpozuiwc4y7A8dQIjQ87atIhHebv8bWPUI2/elY3E6fLgz
 /CSH62Tbgdi1Oyd35PxCNk2dxEe0xnTSvErBvHS5mNNn8VMrthrXvTaRDfXHNVCckWDxJc5
 mApdd8pq9oDgYYcjRSJzDh4TLTFSY6V+HSctudeiatU38V/JxhB+4a2zBRX03VMFmHcMu7Y
 D6/z1e1uZXNRc2XBQenWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+f+AmU+nPc=:duuEJUjCczVWwB6ccgW3SG
 n/SNe8WZ+1Z/6wT9xdNg/RMGoPjraA7exI8fvcI+5/Bho58pxVjTpSUilRNuGlB8pcB0UZu3A
 3FtdLgQxgoMlVm+i0ctR2VRBNp5qD1ZsTqMZwXDdthpyeDQEQA3E746zfVI000cqv4CSpyS+g
 To0+GljcakWFDbDaqp0+iQbMWjdJQW6hpcFJb+0bamDRbMEuaaYtjw2TXvNIyRjV9AAf2rKsN
 MDxgpM2YChPIzdSrOU113Q56fT64Oednl4uc3ha9qRQYsgoRg9Gid4aRnL2I5nesmvjbB8lww
 JHeW86pobe1tCd6KdTEZpqf8YOPnHvBvCO7LsltktATDjjBrVJEI8iv/ABvJVlCzP2kMrzSer
 g1voimqk8gRkA/0DUn04OVCbctI3K3HrYkeg33IwRzFoX8G3osZARwEFw3VJImBE1w2yOgP6S
 7cw9ukzIXgax4NVFEHm2rmH1U9F8AU0B12qgGGik5R2vo12BmTpwlGhfnLr2/J+IOAADLhL1b
 J7OSpM9IXTB8gjsOTVvUsLx0vlYnORWBIigsWDIlTE8y4YX2LV4gcUmSFuf5XzwrC8guI5fDa
 CHttPHg7gnCGGMxCAbuzS2twVJ96Oy9ymE7YLdcKfn6FQoZJ90KlQBkPawztMxRT6gOO38MRt
 8ogFkWoJeujopQQEjergZ27fJrTCRTzhRTJwH3KdKJRVt+sdZqiePWepjBXwQhCbDvrrgrm2I
 QezK6txDoxxVdwfZHznwySMWSa1tWjap2PmS5i25emo2fE3Ag8WgO7DVVMR0VPOXkIIZNoFmB
 XZVYZX0XptTVG2M0iaBuCrMwvqocqDDaak/QzFs4Nn29ks7llUDE5tC9OJshbhZCXzbeQ/g5l
 yPEcaJtlIZJYveW8oAkZMD7uHZtj0CoqmGFZp+L8RkMteSNiGQXbchbwkf9MNBC/uvnWN6CZ2
 voarbElWiH6dFaBC0Aft9mjxcYpAXHLWEVTCb+15fodd5dDcORrIC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:50 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > @@ -246,6 +245,23 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static int __init do_init_finalize(void)
> > +{
> > +     struct device_node *np;
> > +
> > +     np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> > +     if (!np) {
> > +             np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
> > +             if (!np)
> > +                     return 0;
> > +     }
> > +     of_node_put(np);
> > +
> > +     return zynqmp_pm_init_finalize();
> > +}
> > +
> > +late_initcall_sync(do_init_finalize);
> > +
> >  static const struct of_device_id pm_of_match[] = {
> >       { .compatible = "xlnx,zynqmp-power", },
> >       { /* end of table */ },
> >
>
> Arnd: are you fine with this way how to check that it runs on zynqmp or
> versal?

I might be missing something, but this sounds like the wrong way to do it.
There is already a platform driver probed in the presence of the
"xlnx,zynqmp-power" node in the same file. Wouldn't it be better to
either check for the same node instead of an arbitrarily different set
of SoC names, or to make the platform driver itself get registered
form the late initcall?

       Arnd
