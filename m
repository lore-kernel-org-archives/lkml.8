Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB95C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D45822B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf0kPEaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHEIpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgHEIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:45:07 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:45:06 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id o25so13626494uar.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5bGfUkI0TnoG29U72+wYqyFdj5RODR1Ju6c+jix9G0=;
        b=kf0kPEaVVqjO+tibXO/BrYddVQyTvWLUZ/24XavuNmMYdFT6EOU3UN6FYcxjZH3qwW
         1NbL1hXeQvxv2HC+PZC40EULkvoRbTkdfu79/p4gZo3AqKSYl/VdcCXLKnTF0O8CDUik
         M8vI9JmDpxfYcDW8JwkO/EsjsgLg1exmXaBS4VAWQdLepewlrOqU0uqSvBzuO4oav4ZR
         /KZl/mgrSgkP1i0KZ8pZieCtdscu2Mbt/6Olxe8dZTpGEJmQiS5iiTUKlUXMwpH0BkQj
         0KouMItchhDfWeLk4CZlydh7yomaBu6t4nqtICtNGC+uhuVoorrA29jAEIlONK9OAL2T
         fIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5bGfUkI0TnoG29U72+wYqyFdj5RODR1Ju6c+jix9G0=;
        b=s4T4B6kaaxor2yhrNKo3TkXaJX2UjXk7JcZCcYVlxBbutHTcAoLW6y2jRlk7OMEvpV
         KJ7GeVXwxT/VNJaQtkANuE0wyNhhp1CDVjeJiJEUGA/b9o8J+YTHIJIfa8r+JzNYbAL1
         tgFHJLU+t0ANed3k6Eta3Vp8fwFjiufyAKXTziI4fiKQ79yosInXuIV8pSwViLi/bonb
         BkEPDIhVobra9AtnccRl97TTZT3xieHWl7ojllIXyUFvvAzBdCvTtYcX1O5VxDB1yFPu
         X6MH2xKlnivDwYxqOXd08v0hlpddJsiVxEkhhHCODWaIz+C7twO5wHHGH9Y47azUOck6
         UR2A==
X-Gm-Message-State: AOAM530NDVYGMaXhZH8Ulz+erZ0cd0wSXRLC7/W64xd6NZ0WaVQr0gqp
        83coT3eL3u7BpIfNDETbbYMDynZXvK4=
X-Google-Smtp-Source: ABdhPJzLbAPQH5Q/dm4z3Je4Y9rkae8eqQq2/znXOYTIR+qx8uEePU5uvbzVrJDViqCC2mEx5Cu08w==
X-Received: by 2002:ab0:312:: with SMTP id 18mr1273876uat.12.1596617105558;
        Wed, 05 Aug 2020 01:45:05 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id r35sm215288uad.9.2020.08.05.01.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 01:45:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 4so8928722uav.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:45:04 -0700 (PDT)
X-Received: by 2002:ab0:242:: with SMTP id 60mr1283334uas.37.1596617104040;
 Wed, 05 Aug 2020 01:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200804123012.378750-1-colin.king@canonical.com>
 <b99004ea-cd9d-bec3-5f9f-82dcb00a6284@gmail.com> <CA+FuTSd9K+s1rXUFpb_RWEC-uAgwU1Vz44zaUPaZK0cfsX4kwA@mail.gmail.com>
 <fc66cf3c-b4be-f098-3a2b-aef36b90835d@canonical.com>
In-Reply-To: <fc66cf3c-b4be-f098-3a2b-aef36b90835d@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 5 Aug 2020 10:44:27 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfVOPiiBi2AcyiyNHoOpbKg4dPWCNvjg=-UuP+GA2c5FA@mail.gmail.com>
Message-ID: <CA+FuTSfVOPiiBi2AcyiyNHoOpbKg4dPWCNvjg=-UuP+GA2c5FA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: skip msg_zerocopy test if we have less
 than 4 CPUs
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:22 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 05/08/2020 09:06, Willem de Bruijn wrote:
> > On Wed, Aug 5, 2020 at 2:54 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>
> >>
> >>
> >> On 8/4/20 5:30 AM, Colin King wrote:
> >>> From: Colin Ian King <colin.king@canonical.com>
> >>>
> >>> The current test will exit with a failure if it cannot set affinity on
> >>> specific CPUs which is problematic when running this on single CPU
> >>> systems. Add a check for the number of CPUs and skip the test if
> >>> the CPU requirement is not met.
> >>>
> >>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>> ---
> >>>  tools/testing/selftests/net/msg_zerocopy.sh | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
> >>> index 825ffec85cea..97bc527e1297 100755
> >>> --- a/tools/testing/selftests/net/msg_zerocopy.sh
> >>> +++ b/tools/testing/selftests/net/msg_zerocopy.sh
> >>> @@ -21,6 +21,11 @@ readonly DADDR6='fd::2'
> >>>
> >>>  readonly path_sysctl_mem="net.core.optmem_max"
> >>>
> >>> +if [[ $(nproc) -lt 4 ]]; then
> >>> +     echo "SKIP: test requires at least 4 CPUs"
> >>> +     exit 4
> >>> +fi
> >>> +
> >>>  # No arguments: automated test
> >>>  if [[ "$#" -eq "0" ]]; then
> >>>       $0 4 tcp -t 1
> >>>
> >>
> >> Test explicitly uses CPU 2 and 3, right ?
> >>
> >> nproc could be 500, yet cpu 2 or 3 could be offline
> >>
> >> # cat /sys/devices/system/cpu/cpu3/online
> >> 0
> >> # echo $(nproc)
> >> 71
> >
> > The cpu affinity is only set to bring some stability across runs.
> >
> > The test does not actually verify that a run with zerocopy is some
> > factor faster than without, as that factor is hard to choose across
> > all platforms. As a result the automated run mainly gives code coverage.
> >
> > It's preferable to always run. And on sched_setaffinity failure log a
> > message about possible jitter and continue. I can send that patch, if
> > the approach sounds good.
> >
> That's sounds preferable to my bad fix for sure :-)

Certainly not a bad fix! Thanks for addressing the issue. Alternative
approach at

http://patchwork.ozlabs.org/project/netdev/patch/20200805084045.1549492-1-willemdebruijn.kernel@gmail.com/
