Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D8E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDLgGsPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD2Hkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2Hky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:40:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D4C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:40:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b24so183507lfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6vndLuaeXb6bB9uiepv0GIEKfn+kuOCySzTjAzHsMU=;
        b=FDLgGsPFHgxlMBjFNmkfnE/Jr4mIXNB0ns9FLOBMmwPRIyZAlEnLT6cTCgVk6vLaCW
         ttoowgf6aOut7y2PxCcyMO7iByXRbafn3qJt+BEsv13U45mOcDHqmNm3MT7KhHXp02s8
         qNIODLOep7LI6mc5PkRyIZQkcJPxNxdJbwAhk7uhCmWq48lMQcj25Pu5LwbYN2bIMoAn
         gniHdU1zqIfIAJJQEwtEf1I9od2tl1RQ+3At4RTciCU3gNLSIxB+sLpX3Z4BQC9m6hiP
         K9rXPnNmEK76QnKzxjl6YrH0FewLuscVAmm2rpuLKi0NVxWe4nau8n7rvoBvBx9GwCIt
         6YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6vndLuaeXb6bB9uiepv0GIEKfn+kuOCySzTjAzHsMU=;
        b=EVauGuqJrNXli22zY31tt69i6PJv4+PLNRK5h3oILURpdH0SfLr8aCfxFPH+J2kcoq
         gSZoqH2SPkqZh+sklt5DAcN8LAdWhdzfT40zsNEydaqSxb9dFprzrWHwgokwGcaPDUBp
         Q2SsrG/SJYyN8BIsSywZNi44Qno5zPa0oOs1tsBfkQOlq4bHD1e+BU/tbIIjvwur0aj3
         CSecDoiu3fdYo5kj3cKtTB1wB8FTX+l2IPt55r8GoxcfY0IwEGhSV/N1FYQT4ac+iQ+9
         SaorlhHGpsg5GVXQ/aLhW+IGQ6tXIP+kwzuR1mRSDZb+0VmjMKdT2rMUip+wd9vMZQIa
         VypQ==
X-Gm-Message-State: AGi0PuYKWq6Tf6yxS0XcqDfEmhfRRK8aKbB9NrxGzn2yAG1Vo07JeiHN
        PhQyxC+uHw/202P+UBc/QGZumILmZQLDOA7QRnY=
X-Google-Smtp-Source: APiQypLMoZakO/8ExLncaCmnnOtNMCr57sttCek7NXn2hztLvfuFdT+oQQxp8aJPkYV2kumt/lzBA/5xwKhJMFDHg7I=
X-Received: by 2002:ac2:5c07:: with SMTP id r7mr22066594lfp.160.1588146051463;
 Wed, 29 Apr 2020 00:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <1582175719-7401-1-git-send-email-yash.shah@sifive.com> <MN2PR13MB3552ADB09621545F67A914E28CFA0@MN2PR13MB3552.namprd13.prod.outlook.com>
In-Reply-To: <MN2PR13MB3552ADB09621545F67A914E28CFA0@MN2PR13MB3552.namprd13.prod.outlook.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 29 Apr 2020 10:40:15 +0300
Message-ID: <CAEn-LTqUWfiV_QV3hyCQ9YouaHCzNFPq=WABfioNEiMJVP8ZVg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways enabled
To:     Yash Shah <yash.shah@sifive.com>
Cc:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

I think this one got lost in time. I don't see it in v5.6 or v5.7.

david

On Fri, Mar 13, 2020 at 8:03 AM Yash Shah <yash.shah@sifive.com> wrote:
>
> Any comments or updates on this series?
>
> - Yash
>
> > -----Original Message-----
> > From: Yash Shah <yash.shah@sifive.com>
> > Sent: 20 February 2020 10:45
> > To: palmer@dabbelt.com; Paul Walmsley ( Sifive)
> > <paul.walmsley@sifive.com>
> > Cc: aou@eecs.berkeley.edu; anup@brainfault.org;
> > gregkh@linuxfoundation.org; alexios.zavras@intel.com; tglx@linutronix.de;
> > bp@suse.de; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Sachin Ghadi <sachin.ghadi@sifive.com>; Yash Shah
> > <yash.shah@sifive.com>
> > Subject: [PATCH v5 0/2] cacheinfo support to read no. of L2 cache ways
> > enabled
> >
> > The patchset includes 2 patches. Patch 1 implements cache_get_priv_group
> > which make use of a generic ops structure to return a private attribute group
> > for custom cacheinfo. Patch 2 implements a private attribute named
> > "number_of_ways_enabled" in the cacheinfo framework. Reading this
> > attribute returns the number of L2 cache ways enabled at runtime,
> >
> > This patchset is based on Linux v5.6-rc2 and tested on HiFive Unleashed
> > board.
> >
> > v5:
> > - Since WayEnable is 8bits, mask out and return only the last 8 bit in
> >   l2_largest_wayenabled()
> > - Rebased on Linux v5.6-rc2
> >
> > v4:
> > - Rename "sifive_l2_largest_wayenabled" to "l2_largest_wayenabled" and
> >   make it a static function
> >
> > v3:
> > - As per Anup Patel's suggestion[0], implement a new approach which uses
> >   generic ops structure. Hence addition of patch 1 to this series and
> >   corresponding changes to patch 2.
> > - Dropped "riscv: dts: Add DT support for SiFive L2 cache controller"
> >   patch since it is already merged
> > - Rebased on Linux v5.5-rc6
> >
> > Changes in v2:
> > - Rebase the series on v5.5-rc3
> > - Remove the reserved-memory node from DT
> >
> > [0]: https://lore.kernel.org/linux-
> > riscv/CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-
> > Z_FaOr8LPni+s_615Q@mail.gmail.com/
> >
> > Yash Shah (2):
> >   riscv: cacheinfo: Implement cache_get_priv_group with a generic ops
> >     structure
> >   riscv: Add support to determine no. of L2 cache way enabled
> >
> >  arch/riscv/include/asm/cacheinfo.h   | 15 ++++++++++++++
> >  arch/riscv/kernel/cacheinfo.c        | 17 ++++++++++++++++
> >  drivers/soc/sifive/sifive_l2_cache.c | 38
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 70 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/cacheinfo.h
> >
> > --
> > 2.7.4
>
>
