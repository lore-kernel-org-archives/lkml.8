Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D72620704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGQG74 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:59:56 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGQG7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:59:55 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MI5YH-1k29V93IjX-00F9Yk; Fri, 17 Jul 2020 08:59:53 +0200
Received: by mail-qk1-f181.google.com with SMTP id b185so7926317qkg.1;
        Thu, 16 Jul 2020 23:59:52 -0700 (PDT)
X-Gm-Message-State: AOAM5339BGpumRHMtE4Vu6GFpVpzvS32TwfJxX55xkQ9/iQnf3323a9F
        lT2+WWPG45AVDktawbdnFZdIGGGqJQD1GLShiaQ=
X-Google-Smtp-Source: ABdhPJwaKBW/RsvnQGEs0QjkcfL9xu0Lwumc0lzuw3nWoyJb9gE4p2b9Go8DMLyImZgf74HP7Hli3/CWm9JHm7vTLMs=
X-Received: by 2002:a37:b484:: with SMTP id d126mr7553671qkf.394.1594969191432;
 Thu, 16 Jul 2020 23:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200305111047.147355-1-enric.balletbo@collabora.com> <CAFqH_52LhfV9AsnPRZi_ZPsgYX8WrUrKEsV-E7VHOw3ZZtHd-w@mail.gmail.com>
In-Reply-To: <CAFqH_52LhfV9AsnPRZi_ZPsgYX8WrUrKEsV-E7VHOw3ZZtHd-w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 08:59:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ScHe+ErEZr-x4Sj=3Yz7cppKDcemXemvwXMbPh-RVMQ@mail.gmail.com>
Message-ID: <CAK8P3a0ScHe+ErEZr-x4Sj=3Yz7cppKDcemXemvwXMbPh-RVMQ@mail.gmail.com>
Subject: Re: [RESEND RESEND PATCH] arm/arm64: defconfig: Update configs to use
 the new CROS_EC options
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Kukjin Kim <kgene@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Bastien Nocera <hadess@hadess.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <maxime@cerno.tech>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ttxuPKoIw8Qj/U12D5To79v1kGuwCuWEFYDu+t5UtdTsAlF6npY
 ZAnDbKBOCWbhs7g+WRA1iQIjqsY9ItKEi39dd2WXenx54EpVktL8rmAKD/lnk+0V0951cgE
 E1C325HxehShg2Qzk2HaT6gPToMZdoLAphQtaV3f92NlIB/DvnqR5djK713Z5C5TpwpBMuC
 hM6iP1dGXnXbnF8j3qolw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HqEMcult3HQ=:WTzDaHwmunTdpvBqDgJpOu
 SwJXaa1aOTxeIGnLdmtqbasvhE4rOi69g187hQ5/5E1Mus4JZadwipGxTxhipgMF4q49PVd33
 xXyFUkN9uRHCcDEI95/FRWoxT6Q65RgrQxxcvg+AG29h4RUzdyu1Z5WpX5bSGug8t8Deooe1Z
 NwAJhae2uKY3rc37NVFm9g9kkxzbQcpe5CeiR12XEBdJLoUbaSRXjd103X2LOQ3528PW+FLSV
 dFESDAQyo/irFl11BqfPKY4Q24dpXxsL1nr5IF1QJCrB8jwTGrYKVKxJ3dQDLt5/lw24dRX8k
 6aiWIyEddzEyH8xCjFTCRQ2TQyfHSiWhedlRsu5u7iwXgcTSAA/gfpkSSzOmdpzfEms2eOy5F
 WOvRKucS4lwuQZ+PL/+S3CO9jY/9DASO+raBA5xxfvSyN9GkYP5dbNLj2cnkMOP4s69DXwGPB
 llZ/mWCyiry7G1u/23rUoGGBkewA7S/4FoY5GxDLljXnXsV3S8SRLLB+TE+CZmxWUKA/9Xdei
 fohNShfYlkZ53R+i8I+yjqyU87J6RH7BmD6DX3xN2KPlBfc1b1+tO8GAEqoKXZiS5BXNw6qqh
 OFr3BlsFtznUQb5hGV7AuPTHFtWbGw8ngfkFH+NzzMPH58T4CRBOwa7NKQK4btbfz3/0hYMeD
 8efSdgHDrO91I0WzNS547l/eIK0bO9feXXOSqfi9f30Cj5+zzgJwyBh3/UIXfoFjxidfq3et3
 EWF3aA7rRtF7GDuO9QJOvKskyCBcTOXmZ6pO3+VnEj4/5hIHGXs9VYlVB8aIvRtSjTOCK4Vu9
 OK0uWfcNA4ddJzW93co9HsKftp4Te+oi2nrMeCMXrP23bYT6wqpBvaq+nm3fDFg7lzNAybz+K
 SpAkgArz2Uk9Li4XQ3xOc82yDcSYcdys4Y9sJtCtxe6nBow4DHTu32Tr0rHL9NYsbFjfqH+VA
 F9RGPb2CqLf0of29sMi/uuNvlyBkZ7qu9kaNc6nKNmScqMbOIzVD+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:31 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> dia dj., 5 de març 2020 a les 12:11:
> >
> > We refactored the CrOS EC drivers moving part of the code from the MFD
> > subsystem to the platform chrome subsystem. During this change we needed
> > to rename some config options, so, update the defconfigs accordingly.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
>
> A gentle ping. I'd like to land this if is possible because that way I
> can remove some legacy code in platform/chrome subsystem.
>
> Thanks,
>   Enric
>
> > Dear all,
> >
> > This is a resend of a resend patch [3]. In some previous discussions
> > maintainers would prefer to have this merged through the arm-soc tree
> > but wasn't merged yet and I forget to ping again, hence, sending a new
> > resend.

I've merged it into the arm/defconfig branch of the soc tree now.
If you have future platform specific changes to the defconfig files,
please just add soc@kernel.org to the recipients to get the patch
into patchwork.

     Arnd
