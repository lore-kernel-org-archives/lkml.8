Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA8EC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5002820679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584406701;
	bh=wXkJt0TNZyybiR6gkgYwQsL0d0G2i2XFhW+feaizHjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VchTrl2JP6PRx5FJKCeRkJJMLdQJTzmMt9dSSJku5KQL+TpgdlOH1WgX9hkAyc9UM
	 61TGbl2684TF2WpkNgRdvsP865sJIPTnf/PDkYUWXXmeoAJ18vuXl/6rPLoczVNat9
	 8kUIigUUMAznJqqm4oJhLLBipVnm5tm4RV42CUUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgCQA6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:58:20 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63909 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733274AbgCQA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:58:19 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02H0wA3G018076
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:58:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02H0wA3G018076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584406691;
        bh=+VzaV5sFRtxKAoH7rppPTz7vYTx/ptvPFYNX1JZhr8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GiCnmEy7O3U4VXa+yfMjIQmZAPzU4/Ct1ZwiT6pnC+/5xY3EEiJ80n63iZBpCIYPp
         +L/hDvKxtVjfs3I6C6tuEEl0j9kWZuF7L6sqzO9A9YWhYw4aK3C6w6TWMzSY0noU/s
         Y00VJjswqHfczNpIyce/5eQ8ryhBk1+bl1B+WdFlm20ZlT65KEW8WEUfoPHlMEzP9W
         Hk0wfP714TUEi+SziukauXYljnwJBW5n/nt8EB2hVuQIxDUwqKkysXyNUm4/ylLN+q
         jWExfKOYHXwzZaI2MDns3toWx/a/EpdXxk9F7mPbgB4LafM3nJrbDckREk9kKMV7Cf
         2AKV0kFsSokNA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id 9so6852935uav.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:58:11 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0tG7Sol8QnWHXQVFThAKL6TeLZK3zkYeg5eQFbUN0+ma5m9a7H
        KBX6zLRhg5uXbn5ONDcZFC1/n3u4ovk3UvLfrvI=
X-Google-Smtp-Source: ADFU+vuBMyABnImUl6b7dOsBe/MmCPk6aP5Z95Lob+zvXfebQ+cT0BPcRz9rBKi3g9swgrYAnym5uBEh+XpBuHhH+wc=
X-Received: by 2002:ab0:28d8:: with SMTP id g24mr1921244uaq.121.1584406689827;
 Mon, 16 Mar 2020 17:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200311102217.25170-1-Eugeniy.Paltsev@synopsys.com>
 <CAK7LNARSNBOMK9+s9pmVsVtnzr2qqFxHNr+GhJd_BnbgNW4SSQ@mail.gmail.com> <BY5PR12MB4034829B9DC8EC77C5164439DEF90@BY5PR12MB4034.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4034829B9DC8EC77C5164439DEF90@BY5PR12MB4034.namprd12.prod.outlook.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Mar 2020 09:57:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj_p0PaTiuY2q3+AA-Hf87bG2YFoqfxCAfaXWqhRZA+w@mail.gmail.com>
Message-ID: <CAK7LNATj_p0PaTiuY2q3+AA-Hf87bG2YFoqfxCAfaXWqhRZA+w@mail.gmail.com>
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

On Mon, Mar 16, 2020 at 8:22 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
>
> Hi Masahiro,
>
> >From: Masahiro Yamada <masahiroy@kernel.org>
> >Sent: Wednesday, March 11, 2020 23:12
> >To: Eugeniy Paltsev
> >Cc: Linux Kernel Mailing List; arcml; Vineet Gupta; Alexey Brodkin
> >Subject: Re: [PATCH] initramfs: restore default compression behaviour
> >
> >Hi Eugeniy.
> >
> >On Wed, Mar 11, 2020 at 7:22 PM Eugeniy Paltsev
> ><Eugeniy.Paltsev@synopsys.com> wrote:
> >>
> >> Even though INITRAMFS_SOURCE kconfig option isn't set in most of
> >> defconfigs it is used (set) extensively by various build systems.
> >> Commit f26661e12765 ("initramfs: make initramfs compression choice
> >> non-optional") has changed default compression mode. Previously we
> >> compress initramfs using available compression algorithm. Now
> >> we don't use any compression at all by default.
> >> It significantly increases the image size in case of build system
> >> chooses embedded initramfs. Initially I faced with this issue while
> >> using buildroot.
> >>
> >> As of today it's not possible to set preferred compression mode
> >> in target defconfig as this option depends on INITRAMFS_SOURCE
> >> being set.
> >> Modification of build systems doesn't look like good option in this
> >> case as it requires to check against kernel version when setting
> >> compression mode. The reason for this is that kconfig options
> >> describing compression mode was renamed (in same patch series)
> >
> >Which commit?
> >
> >I do not remember the renaming of kconfig options
> >with this regard.
>
> Ok, I've checked it again - looks like I was confused a bit by
> "CONFIG_INITRAMFS_COMPRESSION" option
> as in v5.5 kernel I have in ".config":
> CONFIG_INITRAMFS_COMPRESSION=".gz"
>
> And for v5.6-rc1 I have in ".config":
> CONFIG_INITRAMFS_COMPRESSION_GZIP=y
>
> But they are different options actually...


Right.

There is no prompt for CONFIG_INITRAMFS_COMPRESSION.
So, users have no control of it.

Because this is just a matter of the file extension,
commit 65e00e04e5aea34 moved the logic to Makefile.




-- 
Best Regards
Masahiro Yamada
