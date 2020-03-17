Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF54C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584406343;
	bh=DHl9VnsSWzSk0mA/egYGoin4ghDXJ23u4oMCG39SmNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GfrftoZ3YEUJ77FLQ2UUU49CvfMTxWvJmrvWypTZYIEhZ/qgcnT7an1uIhNfC1KIt
	 w8lsXyyQ+GbaAOuIDQz4VE/gXh+oEPUWFhwG5eQXIZiLBid3ZU6fqMU6eLV68FQ49x
	 vEpdGuOzcOm3jroiDCHWGVnfcuYbSUwebrSJKosY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbgCQAwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:52:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49313 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbgCQAwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:52:21 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 02H0qATW015723
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:52:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02H0qATW015723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584406331;
        bh=bTisUi+CZu/g6bO8aAotHn/SP8Hi7R+MiDzAL3ZUAfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ji2It9v1H6SycySh6Tfb8fZBnkrKpkX6+Aqs5NFA/+Y5ti2Azoy6+wuAhqJdEUfeJ
         e439Ti3fs0IUKDa2rcJHn8FrKT93uNvDXtf7W1SRwPa5tCKLwsZAgN3FX+6YFXkP1z
         rWJXKKJA2VUE65KMiz48ZUaU/N5fRgIxZFgodYraFfknGKre8+qnzRQ74VRpOA3/4V
         Ui9+XXWyENLpz4CzMw8fxuC9/qZP0lJNe9ESVpInJCvjM8YDLQtNgRm2sRA/VQdv6a
         ytyLh+B2mIpmAPpTKTm+Q9sNOzVIDGGqigEpJRDw7kuqFP8tV8ZBtHxJqLRZlMhIp5
         VRyTCPiIaxrvg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id m25so3904043vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:52:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ39JH2J2E4B70gHSzSgO97btuRfn3AK6pUp1FCzsmsqzIQI8NBK
        lzTfYEFZBQa6vUmZ8bXnwGktZKcfj1IYK4rZvBw=
X-Google-Smtp-Source: ADFU+vuYWhTKUDP6HaM3wuCYIV2TyqZ3Q6nfU58hUxaICMBE++bLTwLXAhjLlI1bkSpqjl4rONmhLJUtIcpDgx2iSMk=
X-Received: by 2002:a67:8745:: with SMTP id j66mr1824203vsd.181.1584406329863;
 Mon, 16 Mar 2020 17:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200316112519.4375-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200316112519.4375-1-Eugeniy.Paltsev@synopsys.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Mar 2020 09:51:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATL1wApAN4uta_YQsdHmOAvRg1z7P1fun9Y8t0QjwBYxQ@mail.gmail.com>
Message-ID: <CAK7LNATL1wApAN4uta_YQsdHmOAvRg1z7P1fun9Y8t0QjwBYxQ@mail.gmail.com>
Subject: Re: [PATCH v2] initramfs: restore default compression behavior
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 8:25 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
>
> Even though INITRAMFS_SOURCE kconfig option isn't set in most of
> defconfigs it is used (set) extensively by various build systems.
> Commit f26661e12765 ("initramfs: make initramfs compression choice
> non-optional") has changed default compression mode. Previously we
> compress initramfs using available compression algorithm. Now
> we don't use any compression at all by default.
> It significantly increases the image size in case of build system
> chooses embedded initramfs. Initially I faced with this issue while
> using buildroot.
>
> As of today it's not possible to set preferred compression mode
> in target defconfig as this option depends on INITRAMFS_SOURCE
> being set. Modification of all build systems either doesn't look
> like good option.
>
> Let's instead rewrite initramfs compression mode choices list
> the way that "INITRAMFS_COMPRESSION_NONE" will be the last option
> in the list. In that case it will be chosen only if all other
> options (which implements any compression) are not available.
>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>


Applied to linux-kbuild.
Thanks.



> ---
>  usr/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/usr/Kconfig b/usr/Kconfig
> index bdf5bbd40727..96afb03b65f9 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -124,17 +124,6 @@ choice
>
>           If in doubt, select 'None'
>
> -config INITRAMFS_COMPRESSION_NONE
> -       bool "None"
> -       help
> -         Do not compress the built-in initramfs at all. This may sound wasteful
> -         in space, but, you should be aware that the built-in initramfs will be
> -         compressed at a later stage anyways along with the rest of the kernel,
> -         on those architectures that support this. However, not compressing the
> -         initramfs may lead to slightly higher memory consumption during a
> -         short time at boot, while both the cpio image and the unpacked
> -         filesystem image will be present in memory simultaneously
> -
>  config INITRAMFS_COMPRESSION_GZIP
>         bool "Gzip"
>         depends on RD_GZIP
> @@ -207,4 +196,15 @@ config INITRAMFS_COMPRESSION_LZ4
>           If you choose this, keep in mind that most distros don't provide lz4
>           by default which could cause a build failure.
>
> +config INITRAMFS_COMPRESSION_NONE
> +       bool "None"
> +       help
> +         Do not compress the built-in initramfs at all. This may sound wasteful
> +         in space, but, you should be aware that the built-in initramfs will be
> +         compressed at a later stage anyways along with the rest of the kernel,
> +         on those architectures that support this. However, not compressing the
> +         initramfs may lead to slightly higher memory consumption during a
> +         short time at boot, while both the cpio image and the unpacked
> +         filesystem image will be present in memory simultaneously
> +
>  endchoice
> --
> 2.21.1
>


-- 
Best Regards
Masahiro Yamada
