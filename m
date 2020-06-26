Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA2D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgFZOjq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:39:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:39:46 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MHoZS-1ja2Sc3t1q-00Ex1k for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:39:45 +0200
Received: by mail-qt1-f180.google.com with SMTP id u12so7582807qth.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:39:44 -0700 (PDT)
X-Gm-Message-State: AOAM53190+Q2T/uvyQutMMNCq9iEf/WkY+gHY4O/Cp850Ec+ef4svr0U
        Uxi8kb4NpgBADXBF5UC1cpztTQ02/h19sxiJ2rI=
X-Google-Smtp-Source: ABdhPJxDO7M2i6RhrDHCfKCNv2dtPS9KcvP8Hcf8ZAFMYGALIa0pf6mu6Y+z8oE3gBIoefa5atPhLAjtgx1WlY//2zw=
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr3062402qtv.18.1593182383879;
 Fri, 26 Jun 2020 07:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-8-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-8-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:39:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38P1PGHkvTDqSQC6sBoDrfipbZzxUaJeV4q4At92g_bw@mail.gmail.com>
Message-ID: <CAK8P3a38P1PGHkvTDqSQC6sBoDrfipbZzxUaJeV4q4At92g_bw@mail.gmail.com>
Subject: Re: [PATCH 07/10] misc: mic: vop: vop_main: Remove set but unused
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Sl59jVMntcv6rENXUiPFJhr8KBF14wfYMnXSOVToQBCssqMs2Vh
 Zbia7kduQnqeYwmMyNqQPfNf8KUe+8XhAowDr/GNmOmblffTQJVx8cf14MuPqa9wwFTayfi
 vsLc37jI3tYBmK7f1b982Fl3cIZpzAYfCEIeRtJpH26oT1bIgpCWtDFHnE+dxzSWELg2LOr
 M5/tFUbBTzzddT/cFZsNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TkRr0fZgNoA=:drKgHdLvRvM6OBccjDnT7M
 0ETlPMyQC6g2ukckpC8sMGjDJOUYHK82nWgbC1+q9uRZpkUCFLjrDR0TnDKV8teBHIj3tOXst
 tgKYTm/Dr6x7AzuI/LcrirKiz9Cr11D5+/iQA6mnPOj1UgUSWsNbKWWFz2DtYN2/jz50WZTu+
 3n3muWehSAbRMXZLdnNYlBle/qNtLzNJpszsZXibyzKJsZWtbfCw9zTzoDetl8iLc6QYn80E0
 6v6tNUml66XVUBbhWGxntctIr8Lxs/ZS3NtjnBu4imOA2HGeezWaSv+uktwwD7yRl/c07vdqQ
 qDgOv0fDUwaiPgFn4TXN2hOfFlFRTD6umdlLsVt0rpJgtvL2a+iSPP1sM9A+uSbgxI2r0dmiw
 w/mlMMc9MhgiV9/YEXUooN5aJNScdjOM55kUsWBbLHQQWjcewh0fm1O4rW+ySYmSZunczrGeU
 mErK94NEC1iPZn5kZgyw9bc0b4tIbbwgY7+Vn0oratCTfaaV2uZJAS97Xor5Om5K6+F6lFOf3
 3p+pIXNG/iRf1BdOVS79VzYAzbT2sgFETebP/+uicwfG/1WKaH7Pg3UngA2mm9WtJeA2TusMi
 k++rIE4rCrFHqP43rIDAiXKFbOfW6dtS2Eke7BgDtCE0/PjXdAPBpsNz5UmhPq+wzm5LaLRkI
 c/wfjaPD3ZI9rzZz2MheHnueWxDEMF+O3Gcw9FvDOt6hJwGy9d3noYiGj7xc0wPeWQS+wsRkS
 mZOA2s/gvgDvpUtyDzqRyImc6uU+1blc8bw4kDYsHmnGlCASXeDxEaqUNdON0vwjCJGfgQcWO
 aNSiPxNg2g5hnQmHhd1hURbSbvYPfGkVw4hgWQZxq8XZ5ce4e1flEmIDURe/hJaCeWi66AhZM
 2dYG9fyBnaU/uh4CnYRWKYzPnNoPn29+SxVRDy5PQRLddJq7n2R19bDkyfUQqsjZRMwJKKICI
 QTD5SqWnYvTaVxd4PE/zYa7fc9R60PRirOKteA74sbVP2zZSmeZVA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Hasn't been checked since its conception 2 years ago.
>
> Squashes W=1 warning:
>
>  drivers/misc/mic/vop/vop_main.c: In function ‘_vop_scan_devices’:
>  drivers/misc/mic/vop/vop_main.c:617:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  617 | int ret;
>  | ^~~
>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is a correct change, but I'd take it one step further and make the
_vop_remove_device() function return 'void' if you don't mind
respinning the patch.

Either way

Acked-by: Arnd Bergmann <arnd@arndb.de>
