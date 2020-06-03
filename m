Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384E320738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFCREE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:04:04 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38448 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:04:04 -0400
Date:   Wed, 3 Jun 2020 13:03:57 -0400
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, arnd@arndb.de,
        yamada.masahiro@socionext.com
Subject: Re: headers_install builds break on a lot of targets?
Message-ID: <20200603170357.GG1079@brightrain.aerifal.cx>
References: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:49:54AM -0500, Rob Landley wrote:
> The headers_install_all target got removed last year (commit f3c8d4c7a728 and
> would someone like to update Documentation/kbuild/headers_install.txt which
> still describes it?)
> 
> The musl-libc maintainer is using a forked hand-hacked kernel header package in
> his toolchain build project (https://github.com/richfelker/musl-cross-make), and
> he said the reason for it is:

These are provided by sabotage-linux, and are not entirely hand-hacked
but have a documented and at least partly scripted process by which
they're built:

https://github.com/sabotage-linux/kernel-headers

There's no obligation to use them, but using them makes things easier.

Note that, at the time the default was switched, there were no
upstream kernel headers compatible with a time64 userspace yet, so
whichever source you wanted to use required patching anyway.

As of 5.6 I believe everything is upstream and we could add stock 5.6
(or later) headers as a supported choice.

>   http://lists.landley.net/pipermail/toybox-landley.net/2020-March/011536.html
> 
>   Because downloading 100 MB of kernel source and extracting it to a far
>   larger tree just to get the headers isn't really fun.
> 
> And I thought "that's why headers_install_all existed", and noticed the target
> being removed, so I tried my hand at a small shell script vesion:
> 
>   for i in $(echo arch/*/ | sed 's@arch/\([^/]*\)/@\1@g')
>   do
>     echo $i
>     X="$PWD/fruitbasket/$i"
>     mkdir -p "$X"
>     make ARCH=$i distclean defconfig headers_install \
>       INSTALL_HDR_PATH="$PWD/fruitbasket/$i" > /dev/null
>   done
> 
> On the bright side, the resulting fruitbasket.tar.xz is 1.5 megabytes. The
> downside is I have no idea how broken the resulting header files are after this
> error-fest:
> 
> alpha
> arc
> gcc: error: unrecognized command line option ‘-mmedium-calls’
> gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
> ‘-fno-stats’?
> gcc: error: unrecognized command line option ‘-mmedium-calls’
> gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
> ‘-fno-stats’?
> [...]

Uhg. Surely there should be some fix for whatever mistaken dep is
behind this? Headers shouldn't actually depend on any config/compiler
output, should they?? Or is that machinery somehow involved in
generating the syscall lists and similar?

Rich


