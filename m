Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB89C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C452071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Mtf7XaFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAZTg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:36:56 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41425 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:36:56 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so5789726ils.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f6DqRhpM07gER0CIQybx4Q5yaH78YC17HKI/RuA1oZs=;
        b=Mtf7XaFswJSsqFzr+cwj5aK3KYVnfxsl4evwP6KLklaGe6unTp4B/A46mtnX6toHF3
         Puyt8muN1wIQPnxPgShS+TUXAGwZkofrh6YzLhlQqEkB5O3Q85SbZ4zrLoLWwLPOt/y3
         eRI6ahF9SZVq5PuQlsnXu5+BJBbxcQU2PjRxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f6DqRhpM07gER0CIQybx4Q5yaH78YC17HKI/RuA1oZs=;
        b=Sm3Cn5hF7laDZ5DY6R9KuXFvipaPtBigAlqsRTWx0PuUv2P1ONe7kmWNyI7YVpyqNE
         onXdDoT7FN2WY8agnkr6Gu8e+VxNvWDexsw5doUrAFf0M5+qJfJKMh12bqGkujjeoQVo
         GTDU/Pqvwp0nTEMA2KvXhWeBYM7g3nxVyTk7ev0euw61eJH0kKHHMKeS2UKoPbC5aitH
         xKlzW3zMe0g3vIGEb7b5j89umitnI1HWXCd/ZMUmUHc5/DMUwizwtt8W+9A0OQN95MGx
         nGQ6l5MhGbO/10FaWKoEZoUAi/OTKW7KL7R28fhfAZS44mT+OaYlDszPfyRb5Bm9Weiu
         3iDg==
X-Gm-Message-State: APjAAAVRVQIpuxu6XZj/JZ3DcyqdN1lS2qSdvxc6Yol36BAooKMPVwfI
        KcgDK+7JTF7YoJcAJO+1gn7Pttr4rC2z3SqTJvS+fw==
X-Google-Smtp-Source: APXvYqwMN5iGd9dAVOFMM57zHjMeuex3EyiB8ZwtJFN0MbLcZjIz/47yEcc/Az7MiSIXH6ZOnOG3FduwpXSoZ52Xnjg=
X-Received: by 2002:a92:508:: with SMTP id q8mr6047962ile.187.1580067415773;
 Sun, 26 Jan 2020 11:36:55 -0800 (PST)
MIME-Version: 1.0
References: <1571990538-6133-1-git-send-email-teawaterz@linux.alibaba.com>
 <CALZtONCQ1YqpAXfZS6jemHuKpBXhLz440EcxSoWZbxrH0kyLHg@mail.gmail.com> <42753fc6-e352-adcb-52c2-6b68472318f5@linux.alibaba.com>
In-Reply-To: <42753fc6-e352-adcb-52c2-6b68472318f5@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Sun, 26 Jan 2020 14:36:19 -0500
Message-ID: <CALZtONCc7EDzm7EcvQjFp-SXsFVsi==pzs1E4VB79HtA73K8bQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: Add shrink_enabled that can disable swap shrink to
 increase store performance
To:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Vitaly Wool <vitalywool@gmail.com>
Cc:     Seth Jennings <sjenning@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 8:58 PM Hui Zhu <teawaterz@linux.alibaba.com> wrote=
:
>
>
>
> On 2019/11/9 12:04 =E4=B8=8A=E5=8D=88, Dan Streetman wrote:
> > On Fri, Oct 25, 2019 at 4:02 AM Hui Zhu <teawaterz@linux.alibaba.com> w=
rote:
> >>
> >> zswap will try to shrink pool when zswap is full.
> >> This commit add shrink_enabled that can disable swap shrink to increas=
e
> >> store performance.  User can disable swap shrink if care about the sto=
re
> >> performance.
> >
> > I don't understand - if zswap is full it can't store any more pages
> > without shrinking the current pool.  This commit will just force all
> > pages to swap when zswap is full.  This has nothing to do with 'store
> > performance'.
> >
> > I think it would be much better to remove any user option for this and
> > implement some hysteresis; store pages normally until the zpool is
> > full, then reject all pages going to that pool until there is some %
> > free, at which point allow pages to be stored into the pool again.
> > That will prevent (or at least reduce) the constant performance hit
> > when a zpool fills up, and just fallback to normal swapping to disk
> > until the zpool has some amount of free space again.
> >
>
> This idea is really cool!
> Do you mind I make a patch for it?

Sorry for the delay, again.

I think Vitaly has a patch adding this.

>
> Thanks,
> Hui
>
> >>
> >> For example in a VM with 1 CPU 1G memory 4G swap:
> >> echo lz4 > /sys/module/zswap/parameters/compressor
> >> echo z3fold > /sys/module/zswap/parameters/zpool
> >> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> >> echo 1 > /sys/module/zswap/parameters/enabled
> >> usemem -a -n 1 $((4000 * 1024 * 1024))
> >> 4718592000 bytes / 114937822 usecs =3D 40091 KB/s
> >> 101700 usecs to free memory
> >> echo 0 > /sys/module/zswap/parameters/shrink_enabled
> >> usemem -a -n 1 $((4000 * 1024 * 1024))
> >> 4718592000 bytes / 8837320 usecs =3D 521425 KB/s
> >> 129577 usecs to free memory
> >>
> >> The store speed increased when zswap shrink disabled.
> >>
> >> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> >> ---
> >>   mm/zswap.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 46a3223..731e3d1e 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -114,6 +114,10 @@ static bool zswap_same_filled_pages_enabled =3D t=
rue;
> >>   module_param_named(same_filled_pages_enabled, zswap_same_filled_page=
s_enabled,
> >>                     bool, 0644);
> >>
> >> +/* Enable/disable zswap shrink (enabled by default) */
> >> +static bool zswap_shrink_enabled =3D true;
> >> +module_param_named(shrink_enabled, zswap_shrink_enabled, bool, 0644);
> >> +
> >>   /*********************************
> >>   * data structures
> >>   **********************************/
> >> @@ -947,6 +951,9 @@ static int zswap_shrink(void)
> >>          struct zswap_pool *pool;
> >>          int ret;
> >>
> >> +       if (!zswap_shrink_enabled)
> >> +               return -EPERM;
> >> +
> >>          pool =3D zswap_pool_last_get();
> >>          if (!pool)
> >>                  return -ENOENT;
> >> --
> >> 2.7.4
> >>
