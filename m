Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDFEC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6850D2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD1K3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:29:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgD1K3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:29:25 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7zJl-1j8Slk0BW7-0151mp; Tue, 28 Apr 2020 12:29:23 +0200
Received: by mail-qt1-f175.google.com with SMTP id z90so16777275qtd.10;
        Tue, 28 Apr 2020 03:29:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuaEzZ9lXoaV0P/0gznngXFbu65OUwIPXFwI6v99nnn5CbHm2Ei1
        qQYTbyAODisEizg4oRawc3r633bqYnBaw9CzV9U=
X-Google-Smtp-Source: APiQypKhnq3/Wss+OoRFjOQsqmAF7V3ZB8I32IaOWidhbDzgpeLsUO8NqJdgDqyVWcWGVB1IlWYAM4APKq/hkKuddMg=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr27367360qtw.204.1588069758853;
 Tue, 28 Apr 2020 03:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
 <9c58aeb1561f28f302921d54aee75942545c4971.1585889042.git.eswara.kota@linux.intel.com>
 <20200417093551.GH2167633@dell> <d5b7eb87-7468-a1c4-bf19-d676c8e9c49d@linux.intel.com>
 <20200428100538.GM3559@dell>
In-Reply-To: <20200428100538.GM3559@dell>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Apr 2020 12:29:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1DP2JNUKP7X=+oPypVZqOHrkByOr3hEXw+3mu2fP49Sw@mail.gmail.com>
Message-ID: <CAK8P3a1DP2JNUKP7X=+oPypVZqOHrkByOr3hEXw+3mu2fP49Sw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 1/4] mfd: syscon: Add fwnode_to_regmap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eOSOkVGCe92qoxV6q9UDWybPC5J3V7C4wBiiws1XQI12tDwvbqJ
 XN+RvFFD2lqmanEQKLGAGOIBpW6BqCRCRHDPl+r4EC3xPR986/oixubRLF4Zrc0hh1Imb6c
 fiTrqKueIScI8QQk9pKlk0M3fOs8HZP99Pyim1jEz2wtveL33ut3gW4sKWHGRWx2BVcJ+w2
 mup5Ri3aDElNTipE9/o8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NU0xku3jdYI=:T23XrRhZ21r4lDEjmesagI
 1xlQ5FOeLpy94iyxmHFrFTK8OX1YTYwUqlZy5VQybkrdCtS/0ZVsjhKsyzOu9Z92SY5b8XS4C
 RHwDvu8edMgsB8BvwMLdT5krkhYKcTHN81E+jHRFB6mjWkq3LUCjsIiD6PnL6Ne5gmGPCWMbw
 IBA1HjW4ncK3WtVL81L+bIYWIO1KzsiVD7Uv1kxXbeZKDnw2qEiHtdBztguVnTbzNPeicZG4L
 74l48ALUnH9M1Qwl8xzHL3A+Azb8GLSilX8JPBbN7mcWAyLNmvaPUigOb6TuGaltMu+X/QYE+
 XCBHJtyZd20jkRfz76dnWW/ClsUFpRpPhE3ZvXlRHt4TOuCpLhKEO+vI9dycePgGSxEMw2Cue
 yzDDJxGqkmTCg/qUiQTbIG7+bZQ7NUeMNJ2fCgDjYqk8c6L55yF61juVDzg9h9KkkGGlk2fRj
 PGg5i8CLJykNHf6hJx8nRNaR2Y6ME8mbdkh1eBrLwF2xJePE7PCcfCyTxeBu8V7HvVWVR7Ytc
 rR84uCFSzgI1W/g3IiEzH0t56KuSEOBA95gTUU9/rrm6nqCmfjXrwAInboEtL9B6JxfjBPi3O
 AjeD1Jb53MKQhXp0DFvjSquLKQO9pOtX2GoSmalWfK83y6+aJJFyUpg/8W3T2Tx1CuafJP6GI
 z83ugZABVBEi6FEnBSCLgvA8nJqjN5Cy0OxjeljjhE8TB2Qrpiz31dhGe5iKboUkqk1+CS+Yu
 EzwDg0sKi21amKyL/8AZU31rBBEeFtSDWEEnf3JqWcurPfANqQUznl69JOavmqy9zXLEJ+FXv
 w2kKA5hA7SPkd0paM/qRagcU/YtiLKQjirn3bKC7SQKAMi9RUIp3a6tsdU0eSdCDcqi0j4xFE
 0j1BKnIJw4TSG2qJ9hhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 21 Apr 2020, Dilip Kota wrote:
> >
> > But, i feel return error for ACPI or oother, looks better because
> > 'device_node' has fwnode pointer. And provide description
> > in the header file, mentioning function is success for 'OF' and returns
> > error for the rest.
>
> I don't think this patch adds much to be honest.
>
> Better to just do:
>
>     device_node_get_regmap(to_of_node(fwnode), false);
>
> ... from the call site I think.

Agreed, or just use the of_node pointer consistently in the driver that uses
it and avoid the use of the fwnode interface entirely when dealing with a
modern driver that does not need to support board files any more.

      Arnd
