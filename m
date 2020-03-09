Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1F9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24720828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583751025;
	bh=vJICnBwbuwxw9HqQacavK8JPqmgqEybtY0UpihSWv1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n90svKJ1rydsivHiSGKWtAE8zNlmKzIFKQuvcH9M+wb1Yq25GycJ1KULNi1eEgEwR
	 KWochRD+G7jHmV0DkpylQ2T67yD1gGeyxqo6XsGlySo8v3Rew7bttLnR2B/pn72CrE
	 /G2s175QJkNbgEOdFjWHtJF9nHKrwWqHQRb83IL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgCIKuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:50:24 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52283 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIKuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:50:23 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 029Ao8fk028427
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 19:50:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 029Ao8fk028427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583751009;
        bh=mJp8WGofZ4hGSt54lVa/mRTJx1GOKc9d2mbBu9r5ZCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=08NL7csiNx4n94jSopstJRm8IKKFK3qPQ7NorW4KQadt6hnhstrw1Sfj5GXAA9frx
         B+MPcv+yak1attLoqv0gXJJmDrbhoxmBSV4StvxbuoPnyskWzqWA4PnvFOOFb45bda
         SDw0rgq+Gy3AdQqy0Az+QFX8pg/MG4hCtlDHoqD5lHzWmgjgG6MxVHKhqhbpHkAslT
         hKsJ0vfLf4Q+zxryjkqsiCj9/hdmmuzxk1KhXc8A+Wz7RynnwmaQ/MoCCcp9ZOoMDt
         +0NuE4MeQrjo6vp1INc+ivzdB033q6r0WRKOl8FW/HiGZzwBkKxG4L2NQZ4T7a0rTd
         M7od72N6s4t1Q==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id a33so3102920uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:50:08 -0700 (PDT)
X-Gm-Message-State: ANhLgQ35kEY2C9NO8Qwa2pIOYLGHjNJP9dYu2EAbEPN3ZDZ7jdNyK2qw
        7PdNqY3551d30ZrNDrYxDjPc3Npvx0L60OcuAEE=
X-Google-Smtp-Source: ADFU+vuZKQGb7N162mcqawbOgSEiUhyjmC9Hkgg1aqrbvkQIr5QQ6pCn2wNZEDSsYTjFA/d8i8wY4LTcCfYwY9V8Jqs=
X-Received: by 2002:ab0:6358:: with SMTP id f24mr7921270uap.121.1583751007693;
 Mon, 09 Mar 2020 03:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200306160206.5609-1-jeyu@kernel.org> <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box> <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box>
In-Reply-To: <20200309103935.GB18870@linux-8ccs.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Mar 2020 19:49:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
Message-ID: <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
> the 0-day bot emails are not CC'd to lkml. Here is the error I got
> from the bot:
>
> ---
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.6-rc4 next-20200306]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
> config: sh-randconfig-a001-20200306 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sh
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!


Indeed, this one is odd.
I have no idea...


-- 
Best Regards
Masahiro Yamada
