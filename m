Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECFC2BA80
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DF820B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDIJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:15:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDIJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:15:59 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mnq0K-1ixZfo1qzi-00pIOx for <linux-kernel@vger.kernel.org>; Thu, 09 Apr
 2020 11:15:58 +0200
Received: by mail-qt1-f176.google.com with SMTP id m33so2221988qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:15:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuY9q7a2o9AUQOpsPIHz1+jrXktyDH/TbnTw99sAvY3/xAjkcqXi
        BP8gOSvSNDWrylNNJTIu9ZzoeIBHsmTD4JxJoRg=
X-Google-Smtp-Source: APiQypL7rQnHFaV/J6F3l245EdvqvQj9PERdkX/il6/aFT9qPOaOo3CSPC1MiajWcrHTUGea8JinG7bbRXX2zZD+/vM=
X-Received: by 2002:ac8:7292:: with SMTP id v18mr11168094qto.304.1586423757348;
 Thu, 09 Apr 2020 02:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Apr 2020 11:15:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
Message-ID: <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add new reg_update_bits() support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fUhXbTmZBtgfIdnCHrnbaNFrzDFemHcsnDPQJYaNGwA5wX13a/l
 023S48tDTzi7qkGJ1uZdTe6djI+qnP9nM06NkXas8RdbSzUKlcVbs9hmIYA3ymRWOX2JZtG
 NVIjySDoPn97zDUqrPmkd2hYN8DfxSJdOgY/MoyYiTfSO9yFZ5zxe9Sxljm9tplOOYO4I9Y
 JPflSpvqCc4cETm/Ct38g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1u9vBiRz+RU=:FTWZ+MGzd54cIQJ/UsMI6c
 eR9j5KksWsUCBgS9KItox/2BJ+EaQFXpQSxL7z2Om9k/Y7+HOfDk/SxIYIHsRICvBBKNpVGHE
 1I5NkucpIJMMR0boCdi7NJL98pw05FZQe4yKhUbRTss6f7l0mK2xDwp+4d74r5p5Fv6Tx9NyC
 3/fHaAcEcwSwUT7qfip9zdltnaOTXuBnc7i+5TTWU1AuY8tt9npwqt6uAUSrqcI8f8Eez8Txu
 GaBAAR34H+EuQ0Y0Z53u8AuTpt9nDTxDzceg14pHQOhKLIcak6UXXxCWcLOQrDiQNZV4y/J3L
 XgiK+8oTrNaZ+gQ5a2HLbvR1pjFL+Gs19XAFkq4ggcKjztqpM1ZNh8INOcsgQr56arSi8QeWI
 a2sa1T0EpipOPXP8txlgPg2XoZGoIikmbbY4D0ogfmU3wYPKpwJHcVfnZwhNYwVt3jrMEV7Bi
 reGKVeHb1A/nV70GBYwkgSjpQZz7dGzuItojgDwM99AvjfDZwW6EqEYt12UlslFC3gjBD3W3u
 nE6nUCKsW+DzOSgHsIBrCLKIBKEAU08D+9bFswJroqBrZ+BwEpWue16i2cEMosNxGawxiS1Q0
 8/14LRvnfQGj3Hi+w5s2WXTvXGm+ZJCerGzADac5mflXqwML0KhS8stnALlayOWX9aDVMSWhW
 JWQq8nIhdBau1oGKxJ8QYWGpC+CAaqTud2Z3vs3i1d/fqDg5FllLVOlFGr64Bxm9jCddL8QDK
 GRYWF0kb2fQmQyY+XpwrzkIIP7Y64m6YUKnXhMezXYeHV0ip6LcS76sBEWH9msl/oQdkc+nzD
 WCQWom1n2DOYVnmovAQ7cq5ADFabZk5XBItxVEbTcvf6f3GhD4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:58 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The Spreadtrum platform uses a special set/clear method to update
> registers' bits, thus this patch set introduces a new reg_update_bits()
> callback, as well as adding a helper in syscon driver to support
> this feature.
>
> Any comments are welcome. Thanks.

This looks like a good idea to me, both the concept and the implementation.

The one thing I'd note is that we have a similar mechanism for devices made
by Sigmatel and later Freescale after they acquired them.
include/linux/stmp_device.h only holds a couple of definitions, so it's much
less abstract than your approach, but the idea is similar.

It would be nice in theory to move the sigmatel devices over to
reg_update_bits() in theory, but this seems unlikely to actually happen,
given that these are mostly obsolete drivers at this point.

      Arnd
