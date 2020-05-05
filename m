Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98310C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770F520675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgEEPBh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:01:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgEEPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:01:36 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqbI0-1ijfm30e0G-00mZts for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 17:01:35 +0200
Received: by mail-qk1-f169.google.com with SMTP id t3so2590496qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:01:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ0WgklLu32gAaviTjfCYolnqRp8TAH5rD2R1ENOJX0GnpJYX/X
        8zNg7fIbclkO2u3Ht5rPoLtnHgj02oYBxxRF9Ro=
X-Google-Smtp-Source: APiQypKEmmDkWyjdjHqC8UEv4XIcDMi+fpqsIc8gLYnt2vwvk7Vu3FpHhRwPKldfTYlGKweDKG4ilgk/kiL3dUraQdk=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr3769549qke.3.1588690894009;
 Tue, 05 May 2020 08:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141546.824573-1-arnd@arndb.de> <30d49e6d-570b-f6fd-3a6f-628abcc8b127@suse.com>
In-Reply-To: <30d49e6d-570b-f6fd-3a6f-628abcc8b127@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:01:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mWH=Zcq180+cTRMpqOkGt05xDP1+kCTP6yc9grAg2VQ@mail.gmail.com>
Message-ID: <CAK8P3a0mWH=Zcq180+cTRMpqOkGt05xDP1+kCTP6yc9grAg2VQ@mail.gmail.com>
Subject: Re: [PATCH] xenbus: avoid stack overflow warning
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>, Wei Liu <wl@xen.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:d7lBElUzkBtNaxgQhP5+oaHyPwAoN4rffrWRbwqyDF1rRwft1g2
 KDdWB/phR4tgRakSWikVocfGk8ZzlbMGOlpYQQ5/IX5PPpP4Lz4NIZtHjcuY0ENpED1cQsN
 9Gmm6K5XR+O5dSozN0JZ0qfXXvhBNCskaHgq+jL+ljM1e5m5LqhClAzTjkJ0QyuDYp6X+VW
 KwLfE91tlRYsFJet3+Y2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tn8UadlDyzk=:aq9idjHfBaT0CX2ftAbrKj
 XsxzSmm1MOxpACfIdSAbr2VOCVazMz4jRCDkhdeA+hpanha8xqqEvlF5x7bbXBw7K9dAfWhoq
 sr/k7WNaTiPmzyTb0Hd8haiuyuVlnTSRZTYW61XWEgDSsg6bB4ohIdHhXmvIPesGfpht1In0i
 VEsvlD+ikoMYal+MqbXpPGCdB/fO3H5Lxt4mieLKA3piLH/z/qnTLBICWTjxRK9inbzDbL7fH
 qsNZAT15Rb/8kvZQUyLDEZ+mBEt43g74c4F0BPN1ci+bSS3qJgkALtsDh5LFBXiEtZqkpBC/q
 0gVISe95lZI+BYdEQ3DyprdkGjRzr1g1IH3Ox/mmVYYa7cHnD4pYJxPUoCb+ngiCbz6qJZqVh
 Bjy96grpEbCYCpQOzwwQw3yfHa3uoZEBMc0JfPw6D5LVbGuJu1Qqe6EaXheHu3Q2aH8niPMMC
 mfN1y/fce7n66diG2YSBLFte/ZbwfJ3h73TtRaWMA+TvGMDDuifrvOg76aEG6Uykn2CClIflU
 HgIlyf1qWdE4IBaE4vs8ZHK4mCD2JDqYv/QZaIBQl8Lp22NpsGvCIji5rl4A4y61ro+dFEi9z
 XOtH1i8iCLyxncEkfKPJ992Xmi0XIn891/XCplUzS2ps19Y1FXNvkGmk3pYvs/G9A+ivvcTMM
 caa94t180oLJz8pKUYmqEfRS1MRKJbagQrrIK0ZzrKxQh8YvkrOOilxaIE30okh5ypbclGnEt
 u+N6zzlRuHmhhCKa/Mi5Plq/E49v8Ko5U1hc82NMAul2adzvMi9rR37lQ9qfLdzAwVCyBMWAZ
 r5NZJgdImCgX7r1D4x0a3ZimsjEYcpakaDM0JApa/7S5wazgCY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:34 PM Jürgen Groß <jgross@suse.com> wrote:
> On 05.05.20 16:15, Arnd Bergmann wrote:
> > The __xenbus_map_ring() function has two large arrays, 'map' and
> > 'unmap' on its stack. When clang decides to inline it into its caller,
> > xenbus_map_ring_valloc_hvm(), the total stack usage exceeds the warning
> > limit for stack size on 32-bit architectures.
> >
> > drivers/xen/xenbus/xenbus_client.c:592:12: error: stack frame size of 1104 bytes in function 'xenbus_map_ring_valloc_hvm' [-Werror,-Wframe-larger-than=]
> >
> > As far as I can tell, other compilers don't inline it here, so we get
> > no warning, but the stack usage is actually the same. It is possible
> > for both arrays to use the same location on the stack, but the compiler
> > cannot prove that this is safe because they get passed to external
> > functions that may end up using them until they go out of scope.
> >
> > Move the two arrays into separate basic blocks to limit the scope
> > and force them to occupy less stack in total, regardless of the
> > inlining decision.
>
> Why don't you put both arrays into a union?

I considered that as well, and don't really mind either way. I think it does
get a bit ugly whatever we do. If you prefer the union, I can respin the
patch that way.

      Arnd
