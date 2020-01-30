Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D2DC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA18214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580393825;
	bh=cRwyh4rU6H2VwguYZlplyaxNt/V2BdklXWw7seSSr/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MyUI8CtKm7rogX3h9CLDoNxU9HLArlZ8z8cTzxSyd7ICGs7VNHv1M4tWE++fkOVEk
	 d5mb8eSGmU/5XrMTin04inna+IkAztwdw/LUIivsRUKZgsQe6pJEUp96IA4CpPFZor
	 ADWUXcnScs8Y6Rkj7W9HpbRc152DHggd2IRqQ9KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgA3ORF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:17:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgA3ORF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:17:05 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF092051A;
        Thu, 30 Jan 2020 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580393824;
        bh=cRwyh4rU6H2VwguYZlplyaxNt/V2BdklXWw7seSSr/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JH6mwhRya6r+51Xgd/KeZ4jxRYtkK4XTKyGD3hUo5xoXd2tCbgWtMW7PCFH1j2XAR
         Vf+82LW46ZCt0RvdA81xvAGqaFYfmTdIBoqunZQZ0WZLQLPG3yv4HCkwgTMK7JSb0I
         Pe7uogcYUdlQB205LmMewnGu4nuOZ9fNyx1xtqEs=
Received: by mail-qk1-f174.google.com with SMTP id w25so3059910qki.3;
        Thu, 30 Jan 2020 06:17:04 -0800 (PST)
X-Gm-Message-State: APjAAAVAT5e591zIaBNnOZrbmgkWxtSANbCOqjb8w/GD+zaA464IvDht
        LoHsv4R79nhG0syUxhnCvz6kfuaCK8WL8OB93A==
X-Google-Smtp-Source: APXvYqzq6JJsjP4VU4+kvimngXTc9qjwMKZg98Rvkc5V6yfk7bJRYYN164PGeYPFF1r0/p5jPWiKUANlEcupbELeL9Q=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr5463374qkn.254.1580393823238;
 Thu, 30 Jan 2020 06:17:03 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260@eucas1p2.samsung.com>
 <20200130123934.3900-1-l.stelmach@samsung.com> <20200130124233.4006-1-l.stelmach@samsung.com>
In-Reply-To: <20200130124233.4006-1-l.stelmach@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 30 Jan 2020 08:16:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Q8ekM8ty33fKAmffTMZ5aZDCbMUPpdup7j=UuggB9Pw@mail.gmail.com>
Message-ID: <CAL_Jsq+Q8ekM8ty33fKAmffTMZ5aZDCbMUPpdup7j=UuggB9Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] scripts/dtc: update fdtget.c to upstream version v1.4.7-57-gf267e674d145
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 6:42 AM =C5=81ukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>
> Build and fdtget and add fdtget.c to the list of update source files.

Why does the kernel need fdtget and why not use the version from your distr=
o?

Please Cc the DT list next time.

> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  scripts/dtc/.gitignore           |   4 +
>  scripts/dtc/Makefile             |   5 ++
>  scripts/dtc/fdtget.c             | 125 ++++++++++++++++++-------------
>  scripts/dtc/update-dtc-source.sh |   4 +-

Separate changes by updates to this script, running the script (to get
fdtget.c), and updates to kernel files.

>  4 files changed, 82 insertions(+), 56 deletions(-)
>
> diff --git scripts/dtc/.gitignore scripts/dtc/.gitignore
> index 2e6e60d64ede..80f6b50fdf77 100644
> --- scripts/dtc/.gitignore
> +++ scripts/dtc/.gitignore
> @@ -1 +1,5 @@
>  dtc
> +dtc-lexer.lex.c
> +dtc-parser.tab.c
> +dtc-parser.tab.h

These are needed regardless. Probably a treewide rule for *.lex.c,
*.tab.c, *.tab.h would be better.

> +fdtget
> diff --git scripts/dtc/Makefile scripts/dtc/Makefile
> index b5a5b1c548c9..74322d8dac25 100644
> --- scripts/dtc/Makefile
> +++ scripts/dtc/Makefile
> @@ -2,12 +2,15 @@
>  # scripts/dtc makefile
>
>  hostprogs-$(CONFIG_DTC) :=3D dtc
> +hostprogs-$(CONFIG_DTC) +=3D fdtget
>  always         :=3D $(hostprogs-y)
>
>  dtc-objs       :=3D dtc.o flattree.o fstree.o data.o livetree.o treesour=
ce.o \
>                    srcpos.o checks.o util.o
>  dtc-objs       +=3D dtc-lexer.lex.o dtc-parser.tab.o
>
> +fdtget-objs     :=3D fdtget.o util.o
> +
>  # Source files need to get at the userspace version of libfdt_env.h to c=
ompile
>  HOST_EXTRACFLAGS :=3D -I $(srctree)/$(src)/libfdt
>
> @@ -26,5 +29,7 @@ endif
>  HOSTCFLAGS_dtc-lexer.lex.o :=3D -I $(srctree)/$(src)
>  HOSTCFLAGS_dtc-parser.tab.o :=3D -I $(srctree)/$(src)
>
> +HOSTLDLIBS_fdtget :=3D -L$(obj)/libfdt -lfdt -Wl,-rpath=3D'$$ORIGIN/libf=
dt'
> +

We never build libfdt as a library, so how does this work unless it
pulls in the distro copy?

Rob
