Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBCC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EBD205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgD0LZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:25:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgD0LZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:25:57 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MhClw-1ixZ211rW6-00eOcO for <linux-kernel@vger.kernel.org>; Mon, 27 Apr
 2020 13:25:55 +0200
Received: by mail-lj1-f170.google.com with SMTP id h4so3588446ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 04:25:55 -0700 (PDT)
X-Gm-Message-State: AGi0PubTqVfIyLz412k3RyHG48J7FlGdHZUGsOToVriOpGz76zh/ujg1
        3zRjzXBqpy/Dq16YW/DoKgIAnfzw1J76oIRD284=
X-Google-Smtp-Source: APiQypIq0ASCjxz2l793vCnkxz7mMfufmJDW99FACiQR0YIhaLSyFoSV6Nq7RSPRCfYSqnClXjs/aDcMosfF1VJVBdI=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr14254347lji.73.1587986754907;
 Mon, 27 Apr 2020 04:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Apr 2020 13:25:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a104Njrxb7vh+YJGpSBxW2ODMJ6M+PvN=WAuM_VRBM9bQ@mail.gmail.com>
Message-ID: <CAK8P3a104Njrxb7vh+YJGpSBxW2ODMJ6M+PvN=WAuM_VRBM9bQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] defconfig: fix changed configs and refresh
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dS+/9uCjf5PCpL+kH3BI3ZPknHEKPrnE9zg6mLgpo3Ni+ABoamc
 /upZug1OWmYhqe07Zo0lHzfHTt14MUsVBUW5disYZKyiszri+s+PZq6UpH9uNlUmDGRGBOu
 w+Wl2tJNKkyIJi9cjibsU57+s3u/3ocJYnS2Y7DbC+b7f9M+qs77lJ9XuMJWg6l0jHh1UE2
 gqFIDb1I6xcggL87wPFLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fH5kslps8rU=:MQ9WjW4ehCTmAQVYMMc4h3
 j4VqK0YTIi+UyiKE2LOqHecm57dHWtEmfdjpKcLDto75r3Vf7MPc4V4pTg66SL0NhtIhUxzEe
 zu2eVZgbSxONQi47bg460Kz/kmSxeLeTbUzXrQiR3kdC4JkppHG+XynJ9bX6QT31gtbtXyk4M
 DTXG+WeB/y2ctAz9drgXX1mze42G4YfKIeY/ycilZBulTsmyS3rSgw5q3sLnscq15w1/vdthS
 VUutwolye2Ia4AAJm9IHPBFwrR+9nnnnYOIU7oQ4L2L8LYqHp5Wa4SF7uxPwiPq0bTWu2J2nA
 iKq0RqZ5PEcAkt5xzT+WOalvFhBs8f28pi7ncvc6wM+bpbHuDPndARAP3z5BQEjoWE/Fu0lKF
 zjnt1ZxaGCREpqkRBEp+E2F+lWjFRvetBxCdiv8vuuwajRwUaNEOghtFHTmntwmnRj8LHOr4J
 UtWfeND8woQYSlyYn5QZfqziIu9E0qgxFD6M09VcatmigyQyk4EF8rUHf5Dz+qM6EnQtvSL6O
 AKCtlsHmmgRKK0KidINV6sZ3zvlXOznczGw0xXh0143jPKaM4XpKx95+fFYrUGXVCZytjQ9SZ
 Sp8FZcs2WF9HIFYygmxqEaC4kpvipaYJZ7ipxEfAsIQOlYE7mNDYuwPMC98PFideRNgN/IDE9
 OkDhG33fiA/Bza/RJtXCVXLdfqDe5vlWY3ryhWfOYpOqZn3XQwc4Tpp+jjptmvasDWnad+j3/
 TbQybd71r2kHUOkYVVinVmlfm4nTuM7mR1I/3FrHCvP8UDu73qtlnxCMroqEQnLVSdYGuH6tW
 oVj94H/Nkh/HlMDt0KrNr/fEie7RDW+aqd0ENfplVOPRcmNjdg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 4:31 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> Three configs have been renamed and/or changed behaviour.
> Clean that by using the new config name.
> With the name change to DRM_SIMPLE_BRIDGE the related
> DRM_DISPLAY_CONNECTOR got introduced, enable that additionally.
>
> Then refresh the defconfig with make defconfig savedefconfig.
>
> The refreshed defconfig does result in a not changed .config.
>
> Applies on linux-next/master tag: next-20200407
>
>
> Changes in v2:
> - additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent
> - add reviewed-by tags

Thank you for the series!

When you are reasonably confident that you have done these patches correctly,
feel free to send them to soc@kernel.org so they make it into the
lore.kernel.org
patchwork instance and we pick them up from there.

From the description, I guess the first four are supposed to be
applied as bugfixes
for v5.7, and the last one is meant as a cleanup and queued for v5.8? Please
indicated in the cover letter what you think should happen with them, then we
can either follow that suggestion or see if anyone disagrees.

For the last patch, I want a better description, as you do not say how you made
sure that nothing else changed that needs to be addressed with a separate
patch. From the diffstat "1 file changed, 7 insertions(+), 10 deletions(-)", it
sounds like seven options got moved around but did not change behavior,
but three others have either disappeared or also got renamed. I could look
more closely to see what happened exactly, but I'd prefer this to be obvious
from the changelog.

        Arnd
