Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089B8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 10:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47B52075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 10:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgHBKsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 06:48:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgHBKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 06:48:52 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N6c0W-1kp4iC24vm-0182c1 for <linux-kernel@vger.kernel.org>; Sun, 02 Aug
 2020 12:48:50 +0200
Received: by mail-qt1-f182.google.com with SMTP id c12so17259796qtn.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 03:48:50 -0700 (PDT)
X-Gm-Message-State: AOAM533w7XPaqDcC436DxVuAHHOddiW71FyQZ86VcXJ5sCOAIq3eXhEL
        AtYzCO+P0lkl0HDdNqXdpLjyL3PESlw3RuVlGBU=
X-Google-Smtp-Source: ABdhPJzf7r69SJnZE7dgiyqiOZlGugwB3VvFrPiXTsViaVSwnZRTWmLBWUbY5NzH2nKwSgzfKWTGslZhrEN9SWRzWzM=
X-Received: by 2002:aed:33e7:: with SMTP id v94mr11562770qtd.18.1596365329348;
 Sun, 02 Aug 2020 03:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200802005458-mutt-send-email-mst@kernel.org> <CAHp75Vfwhfrse47jRR9msFHA4ZqoVvE8RYHZNKxu-_ZiGyS9Sw@mail.gmail.com>
In-Reply-To: <CAHp75Vfwhfrse47jRR9msFHA4ZqoVvE8RYHZNKxu-_ZiGyS9Sw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Aug 2020 12:48:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-gQEH3NpYUx=aFg6U8LagfYKuXqMMH4MvVS4SmaghOg@mail.gmail.com>
Message-ID: <CAK8P3a0-gQEH3NpYUx=aFg6U8LagfYKuXqMMH4MvVS4SmaghOg@mail.gmail.com>
Subject: Re: sparse warnings in vop
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2UfiMW94oLywLg7t89Vgq2wmaOI14QANsAqSN0qPVerD6+ryryU
 54wqakUfSaC+iob96oTbeF9Kz/4ixBypGIsu2z1g9n1y0VDcZVErmXXsObdu/NzBdrQEhd/
 s8KK2CJlzQmOxzXjGnAq1zOumHDIxwpHYfFgfAGAwFTWNEz4UqrfVvSfD7cVfr5Id+EeyXY
 LuTA57EEbN1L5Hpcd9DHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vjy/ktTocks=:vu4w9xm30tncebyK4v1AFh
 tIIjiusEWJyRvBOV3gXX2h2ueJGO3IG7Fon1NisyD4MgUksbEewmTn23CAs4bWX++bV27UQ9F
 2eHmJRubul6q6zLVYmyWBYQxVRDYLOnTj08q17WMy1Xbj5FL1hokFFvNbQvjqqT4cPxMqOWdL
 DCufpzTJAF8f+VKcM1NnOfinM1Nu237IOBHTmb2Fz22LZweSwrvhR8WCTyeUAJea62AbFTCsK
 CMNxzhELxtLezrzUIMN+KVlj3IhXlUPTRSHb1H9oPe98nHcGGlR4ogN81gco71j6gyEVOpkQj
 S1rQ37N5HSS88gMCQ/cDCsbJ8+sQ8VePSIGR0QzqDgME4nDJjCZGDrtKDmObuuecNO+ETOP6j
 5Amu5vLZjbtYibpmiaC8uN9a1QiS4g7OyZVsD/2918hZTNzW3RSJrUtb8EKkNLEQCkBAnzWo8
 VK4RUTnBhFnLAQz3LXSJwPQPnPrwM8a9CRGKDg6BGCoqPeFQ9hCqz06mYZM1qx/1MFulCAnXI
 OBxpskO2y7tb10w6j8o34KjZctGqP4C3x+la2lAZ05E78Betl6LR91XgrejZktwmFlrBoPbXC
 Y3fnY4akio5PJj8zXWU0qKBbl2mCRwMm1GAxqR1oUup9m0YIeyeqFpBm/A6c08Xzf/oUS6kg9
 TGpfHmBMFpLdHydc9PuVEAekfeynnM/qEPCoIBrBCDPG/EJRUnzQSmZLfb4f9kwA1NBR0lbB3
 UM0bm0bc9wbXcGKRRruUGTvevQELkTPHGmmdzWTQ8W5MmAOkTVeeqXdQHBqOC00ryjHLCIDQz
 byfjq92UzS4AmV1J3HEe4X55EpnS1uN5F9YkazMR5MWUudRRVjBmKRpZS0P2DKdB6vJJYqM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 9:25 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sunday, August 2, 2020, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> Hi!
>> Building vop with make C=1 produces the following:
>>
>> CHECK   drivers/misc/mic/vop/vop_main.c
>> drivers/misc/mic/vop/vop_main.c:551:58: warning: incorrect type in argument 1 (different address spaces)
>> drivers/misc/mic/vop/vop_main.c:551:58:    expected void const volatile [noderef] __iomem *addr
>> drivers/misc/mic/vop/vop_main.c:551:58:    got restricted __le64 *
>> drivers/misc/mic/vop/vop_main.c:560:49: warning: incorrect type in argument 1 (different address spaces)
>> drivers/misc/mic/vop/vop_main.c:560:49:    expected struct mic_device_ctrl *dc
>> drivers/misc/mic/vop/vop_main.c:560:49:    got struct mic_device_ctrl [noderef] __iomem *dc
>> drivers/misc/mic/vop/vop_main.c:579:49: warning: incorrect type in argument 1 (different address spaces)
>> drivers/misc/mic/vop/vop_main.c:579:49:    expected struct mic_device_ctrl *dc
>> drivers/misc/mic/vop/vop_main.c:579:49:    got struct mic_device_ctrl [noderef] __iomem *dc
>>
>> Would be nice to fix to silence the noise, but I'm not 100% sure
>> what the right thing to do here is. Tag struct members with __iomem or
>> cast with __force on use?
>
>
>
> Sounds right to me.

I don't think either of the above, adding __force is almost always wrong,
and __iomem never applies to struct members, only to pointers.

The first problem I see is with:

static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl *dc)

The argument needs to be an __iomem pointer. In the structure, the
first member has type __le64, which gets mentioned in the warning.
We usually use __u64 instead (or don't use structures at all for __iomem
operations), but I don't think this would cause a warning if the argument
is fixed.

Then there is the question of why in the world you would have an MMIO
register contain a kernel pointer, but that is more a driver design question
than something that causes a warning.

      Arnd
