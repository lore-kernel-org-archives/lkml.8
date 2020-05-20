Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED17C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3831207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:32:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:32:41 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxDck-1iqvjr1ekS-00xexJ; Wed, 20 May 2020 10:32:39 +0200
Received: by mail-qt1-f182.google.com with SMTP id m64so1921053qtd.4;
        Wed, 20 May 2020 01:32:39 -0700 (PDT)
X-Gm-Message-State: AOAM532/YEZMPDLymtXiAK8C+tZZNXDAYAgwZ5a3cNyYyCd4ue9lu+YG
        x/5DHCbb9WLVFFDBNCKW1OmFzhFlkB2HlRZCS78=
X-Google-Smtp-Source: ABdhPJwxHJfu9ad8fPRH3eY75VjvZPKl03jAeY6SOosBXI/bytpm+uNaMTBw34fhMdF542eIC1sItzGVn5tJJELnGhs=
X-Received: by 2002:ac8:518f:: with SMTP id c15mr3966843qtn.142.1589963558179;
 Wed, 20 May 2020 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200519131327.1836482-1-arnd@arndb.de> <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
In-Reply-To: <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 10:32:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
Message-ID: <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com>
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r7q4B6sn5NDNHf0cUJuyd3+1Dx9OG521Z2awa++weaIQNrMRw7j
 7G2xNSqzvvsexvR+IosDSi01VEZul/SrksXUAxkUMezDyTdIimNLJeK76xYW1jW9wNzHP09
 QXOD1rHs6cd4jdwvsNan568zUgSQDYwsiDVqkzxdSPGcMaT1ZGWTmhMhdZG9i3SklGB3RqV
 +5ZWx4MrASaBwE4h31aQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ZRZAO9Lg1g=:C4gWAUP+tl/Tap5d+XHgYe
 xYjVThaqPba6ka+0NWAAA52g99sJ73ROP3NpPcZw9kqg20i6f7isM0GKnohB0xp+Yn4kD4z5d
 XUdkQXmIGRw3G3PPJ95LH1xM0aa8zrr0jdfEGL1gWan9wi3Hirkj9Ar8pCizvGhGohjDk4Sj/
 /cGPPxmjf1a29BQlM5Z5Waa7RlfPKnC4WaDHmUsozc+Yhat2fVO/J7ehdDJRM7fkQ4yH0u57z
 VgeGeiuCcfGP4ioBS2jomfqSP8Nch0Xj9SKo1h6Znf9tzCZSEufcLQaDiSAMU9BrTxXo8tY+Q
 EBvhS+1fEydaop3LN137Bvfq6i/N4lfoJjth2QnsWotcgVmhudwHyKpLJOFzELhKF96012TJg
 DTK2bcwl89ffGX3k9K4GZ40JHVwMH8ksmWU/+OUkGWDVPako8KeLIkbVIJb2H5OQGEAO8pvBi
 C+AtISAucdED+4MhIqXIoFmtOFJNg6B1LLOU580CXYa8lyhc7JoHPNMH6iQs5nAasWKAQtJxO
 TKYnZq8hM1JBU/EVkRoIO0fbWTkJaCpbmyWKY2U/faahvtI96706ol5givhOEJ4QpLiqJRXNU
 FylAK7aTLq755/oIr64IIpkNFwRSF1DQfKFF4kPGBjlqcail2NV6eX0QBcza9OqxCE6Dbj8hO
 BCDRLiZ3Ezawyyo3ANJkVa3bMlEkl1KZBPBLfcdJ+6PPlUXx4uHYjL/ooEMWgzB6FFg/nb4iC
 lrYunllPD45K/snDuFoS0VDIfQoxmfbCTyOJewDFmfGaROLEFq75EOIPwylJADRvs7joimiHp
 D/yv/ovrjd4yq3BGVczcaQfilT3UdfZtap13K1ii/8cm+1DW6g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 3:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Using the socket ioctls on arch/sh (and only there) causes build
> > time problems when __kernel_old_timeval/__kernel_old_timespec are
> > not already visible to the compiler.
> >
> > Add an explict include line for the header that defines these
> > structures.
>
> I can grab this.

Thanks!

> > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> > Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
>
> cc:stable?

Yes, I missed that.

     Arnd
