Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43140C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAA821974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFRJ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:29:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgFRJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:29:36 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mkpj7-1j22dt0gCV-00mKSt; Thu, 18 Jun 2020 11:29:34 +0200
Received: by mail-qt1-f181.google.com with SMTP id y1so3848159qtv.12;
        Thu, 18 Jun 2020 02:29:33 -0700 (PDT)
X-Gm-Message-State: AOAM532px3Vm8oMcgKXDNs5qMUOQlMUtdsGcLyXBQQq31mCPkMbW+S8d
        ymjYDs/z/sAxvBWYpZuWeAnJb+BqkVBvP4kfhnA=
X-Google-Smtp-Source: ABdhPJzgdtQ0e15RU/B+VXyW0HKmnrk4ChsFiunlbGhEA/nSRl5iqi+DLHNRjiUEFWDMgOl/S3Q+Wjj/KNXfigA904g=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr3356547qtk.142.1592472572907;
 Thu, 18 Jun 2020 02:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200618080223.951737-1-lee.jones@linaro.org>
In-Reply-To: <20200618080223.951737-1-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jun 2020 11:29:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
Message-ID: <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
To:     Lee Jones <lee.jones@linaro.org>
Cc:     michael@walle.cc, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mJn8YsYvecBQHNzW2F014KvvXMMCXXUSdpntKRjYKP8FlCPGqOE
 gVc/v9hqPBEvM7gXD94bvAvORSYxC7R32rBSY8tYbSc1Kv45vHgm2yfQzUfwsd1HhtY68vg
 ZqBW4aH3eCMtOAiS146tG2nY3TBNnc41Np7kyD78KmyS1DzBJua4Bm+/zqQOXJnltf7JE5/
 SIiIIy6Y6ptBLBoqQ78Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJNVddY0ieA=:SGaGsC5HsbFxsXW3/fZvfk
 MgAK6no/aF1IbmEEuXZtshDPqmpwCbVPYgJr4sWqJ0W6us9taTpnDSZd3NCuAlV3J7xK2ZgyZ
 gZZUr1/M++LWwmMaQUEZfzR9eqYeSlfQ72T5LR5ejGTZM7rvwueA55EsGBASCICw0rTcSwjOi
 iAZtztev/PJOvbnYwweTiMqXC2cOBuUgSxDNwH5/wqbEvCxIv/BtV8icGfnR66cU4x/fmuIIy
 yIEozTnqqzn4owr5Jm6dihYjFF0sFNv2mVkDtan/D9eUd91ZoDYkcs2px3IViFO1SyeWf5t+w
 E+zjFineyeJTSfrdiFfzOnlcBM/RbO6tdTzjD2sc5v6/z7dQ0FYz07DEUjtPQcLciSb6KaYuT
 NK+f0SoYTJ6twF4YMZxYXtTsDnGSm91v4JwXKdEuiPM2emULTUESrsc6L1OQIr1sBj9N9Y9CZ
 Zwq5Jw/5mMPWhXQ8AHFoGBvruuBgEriPYq3wW7suL//sCoOB/mUkroDq8r6g2PmLVfGRc7WJ8
 Od/3rjN7DPdC2xBiVM2+FECUaU+7szCGUAymSLIr6/NASZo/tj4xqyZ4Oxpb2IBHpPDJ03+N+
 0K3O2yCyL1rLLBOcqGv9ZD/sorH25rHNLimogocZeAZAvqtJJDZy0DjrcIT2njBl/npUDoWdR
 ZdBgfHkxK9wxbicr4eJSGSuLStcQrxIj7hU57FgbrI0mRsWJYtF4zu+8+prG9NrvylGI0nXxw
 D6jOKOUQVO1jf0O7y3iIXOm/DKdhNwfnCqGTmoaIInUCGw6j9dR0pVmsfyapuyLnr3CMPyIb6
 nzFRQG/pruKhGInthnHS0cT3ewWRfsGMLtuuqmf3KuFX1EsmQA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> The existing SYSCON implementation only supports MMIO (memory mapped)
> accesses, facilitated by Regmap.  This extends support for registers
> held behind I2C busses.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

The implementation looks fine to me, but can you explain how this is going to
be used, and what the advantage is over open-coding the devm_regmap_init_i2c()
in each driver that would use this?

Is this about using proper locking through the regmap framework for
shared i2c clients, or to reduce memory consumption when lots of drivers
access the same regmap?

My impression of the existing syscon code is that the main value-add over
other ways of doing the same is the syscon_regmap_lookup_by_phandle()
interface that gives other drivers a much simpler way of getting the
regmap just based on the DT node. Are you planning to add something
like that here as well? An ideal driver interface might allow
syscon_regmap_lookup_by_phandle() to work for both mmio and i2c
based syscons, or additional ones as well, but implementing this would
be rather tricky when the i2c core is a loadable module.

     Arnd
