Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06846C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB4F2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgFZOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:38:21 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:38:21 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MZSJa-1jIVZN3Agw-00WTwM for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:38:19 +0200
Received: by mail-qv1-f46.google.com with SMTP id h18so4577893qvl.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:38:19 -0700 (PDT)
X-Gm-Message-State: AOAM533P0GK/URejM9im7PyN55skwiJKYyfEVh6fBpfmA2htzlNWVL2B
        LIiEfkv4L9Rfz6bD/u1jxcuSwYo5bMloetJiSQs=
X-Google-Smtp-Source: ABdhPJzU2pJ/DVdl89LZUoVSIRq9gExv/2PUvldmzwiyp//wzCyXgDLKBfzFdoubCsuwWsC04Acg52OraZjG32EuONg=
X-Received: by 2002:a0c:f802:: with SMTP id r2mr2489000qvn.197.1593182298713;
 Fri, 26 Jun 2020 07:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-7-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-7-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:38:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06m8ShEDGisd14M2TNi9szzb4Ut9dcc28NkYvV=JrwVg@mail.gmail.com>
Message-ID: <CAK8P3a06m8ShEDGisd14M2TNi9szzb4Ut9dcc28NkYvV=JrwVg@mail.gmail.com>
Subject: Re: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg descriptions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:I40IUFJuOb32KJe25iXU6zoY0zXiWwkrUU/qq7lL43xu8O9Bpt3
 udYmW0XG7k7ByYfCRdoLFKijYI+tgzYQLXpeqG1xgWozi2lzhqvvZMgfZCH/b6D/8pzotmx
 P7czB48SjoLoWYvfDKeD1FFmtZyc6YYwZFngsQhLJg0mVADt2EQzGaA0IhXEhEWZY8HxdIg
 8UJn1AlrGvIE5yACTQnlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYlQf5qTNZY=:WoPKH8/96dNHlJHUWCTKcx
 ak78A8YEpoLZ4UDJxx2HgTrysCx2eD2Ob4U7AJQ0v6bwneZGJEdHSxBfmkn2JMAxIns6Cke80
 ynprl3bqsP+aJ1Ug1jXdm0XjONGTRSrmZXjrGaJ4NE86vTIwHD8xlLJnbnaEEhrAMCw5WqyQJ
 SxtMDXQGF1aqG6VmfxqnBeNU9LTyLnV1YEdgs2CCKnd6xdKUIeZfiudkhRI92ucECb0U8g8JH
 03ZG38bWhel+vPB+oPBD2xZSPVQOiQru79arOi3UvSxtRefK7dzjIAVosrUGMwlQcjdDyvWaA
 hAWIbrZ+jOXcxL6G6G46p2V6ykNI+VX8WLA7Y9WxkvKe3FrINL7fYyVXunTSPKPSqE294dlEH
 N/4j/dwRdI/TpZMfNR5ekAqdB6oE/1Sy31nVGiKKRNzzNWBbCI3F/knxvhHdIpl9PMjqGKdjd
 mm0fSOQa8QbxfSshovkr+DKufS0GGhZaCwQld0+IqoOEcPnVvRh0B7HLstRk/CEP1JYrvm8Sc
 1GJUHnYkKnHB5eQfxil5Op0pDeVdB/RV3clBGIXnylKF1zaWX0/BPN3muAVflorj0lLcjBayT
 igPSpCexvaJMPyiJWVSF5dhK4IhAjrE5wat/OP05UhMG6sHcS8AuvqFrfcOOUdIVje3dyDvJy
 XcToB7BlIVT2r8cdN59Tb1pYnMXEb56Ic9Z3V+URRG8JMIuSOTNUxNMkmTsTZcfImqDsacX0C
 +2lFKEnBcGvVyGwGmUloQ3qR5AmuX7lr4/DaVviWdasrrTkZa0hARB0k2I0tyOU1DQ0DNGubc
 FtyXr/qDlMKJRD3fDwmCkw0rY2ZlPJE9EFb/WeZ+yeE9tFuED4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Copy-paste issue.  Looks like the kerneldoc style descriptions for
> these functions were taken from existing functions with slightly
> different argument names.
>
> Fixes the following W=1 warnings:
>
>  drivers/misc/eeprom/eeprom_93cx6.c:239: warning: Function parameter or member 'byte' not described in 'eeprom_93cx6_readb'
>  drivers/misc/eeprom/eeprom_93cx6.c:239: warning: Excess function parameter 'word' description in 'eeprom_93cx6_readb'
>  drivers/misc/eeprom/eeprom_93cx6.c:280: warning: Function parameter or member 'bytes' not described in 'eeprom_93cx6_multireadb'
>  drivers/misc/eeprom/eeprom_93cx6.c:280: warning: Excess function parameter 'words' description in 'eeprom_93cx6_multireadb'
>
> Cc: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
