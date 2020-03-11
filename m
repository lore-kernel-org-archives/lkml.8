Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2EC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B2020739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583957606;
	bh=dtG3wnt6vyUProclgIP0kVL/6ugVoxd4NuvF6uOGLe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=etSBHD9nqOSOqzdrV5hzZMGfVaqU9vN+++8bpLvvEiqWu8tXcNnFn+dFbdjXK1JXv
	 DOgZiFJB572fbFHY33zp8iEnxQnveR8T9K6FU/G1FGyn3GQAooZtOQ0GS3d5ubNLYa
	 VosXZJcz0ayoSvJw3rx8lfBJf0wEWvHwdXwJO5LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgCKUNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:13:24 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:44421 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCKUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:13:24 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02BKD4v4025297
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 05:13:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02BKD4v4025297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583957585;
        bh=UgsI4L/7hhHUm8L3XjDdMOn1HtPURuk7s+u4j4PE49E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeszQ2FUXR7/uYcNONbBryhW4NCRyk80atebVbcpk3fC0Mm2nWiuuKyPTJer0ZPBW
         6yuswb+EeCl35RdRn2CxTHoMCOkzkGxBFf7q/lXo6LdrZfFp2UrI+6qgSzxZYC1TGG
         0WXj/KmlrN3YzTWLVo2NVK3F4TLWhbqjSitrvSbfvrE8oOKa9COOMpLcZkbqXICYKI
         hcaS3bIv8qRBAWBczjt/AxmVlPfTXhYd+bQ6NLssyW5OkweHrdZwaeTT009QGm5zVU
         91NVb0Jy8JLO/68jyTQ9DLQgj0730xGucS7ZfVY+MQPGTUQwFThU5CzAJdBGcu9cPo
         IqYZeF6QSiTUg==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id s139so902080vka.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:13:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0BewnAvATnLaKCnkWPKexCKi9uZianLGnLOopEKahpd4XN84XB
        hGjATUUxghaX2M4ZMsU4vY32MvAik7YrBTrOaBQ=
X-Google-Smtp-Source: ADFU+vt4K27MGCUWogRfX/2TSFVHCEsD8Ht8K80zJtpqN5IrUtsd9RyhaPlDJSqHFhMUShiI/tKrNEc6TB2DXVNwkdw=
X-Received: by 2002:a1f:2f4c:: with SMTP id v73mr3187092vkv.12.1583957584022;
 Wed, 11 Mar 2020 13:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200311102217.25170-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200311102217.25170-1-Eugeniy.Paltsev@synopsys.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Mar 2020 05:12:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSNBOMK9+s9pmVsVtnzr2qqFxHNr+GhJd_BnbgNW4SSQ@mail.gmail.com>
Message-ID: <CAK7LNARSNBOMK9+s9pmVsVtnzr2qqFxHNr+GhJd_BnbgNW4SSQ@mail.gmail.com>
Subject: Re: [PATCH] initramfs: restore default compression behaviour
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

Hi Eugeniy.

On Wed, Mar 11, 2020 at 7:22 PM Eugeniy Paltsev
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
> being set.
> Modification of build systems doesn't look like good option in this
> case as it requires to check against kernel version when setting
> compression mode. The reason for this is that kconfig options
> describing compression mode was renamed (in same patch series)

Which commit?

I do not remember the renaming of kconfig options
with this regard.



> so
> we are not able to simply enable one option for old and new kernels.
>
> Given that I propose to use GZIP as default here instead of NO
> compression. It should be used only when available but given that
> gzip is enabled by default it looks like good enough choice.



Another solution would be to move
INITRAMFS_COMPRESSION_NONE to the end of the choice menu.

The default of the choice menu is the first visible entry.

GZIP if RD_GZIP is defined, BZIP2 if RD_BZIP2 is defined ...



> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  usr/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/usr/Kconfig b/usr/Kconfig
> index bdf5bbd40727..690ef9020819 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -102,6 +102,7 @@ config RD_LZ4
>
>  choice
>         prompt "Built-in initramfs compression mode"
> +       default INITRAMFS_COMPRESSION_GZIP if RD_GZIP
>         depends on INITRAMFS_SOURCE != ""
>         help
>           This option allows you to decide by which algorithm the builtin
> --
> 2.21.1
>


-- 
Best Regards
Masahiro Yamada
