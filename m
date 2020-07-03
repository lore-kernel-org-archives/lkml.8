Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ADC20890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="TR7n4591";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsGfWB7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGCHbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:31:05 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45823 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgGCHbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:31:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 77DA6A86;
        Fri,  3 Jul 2020 03:31:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Jul 2020 03:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=fm1; bh=
        JySkV+jaMaBi53EvsBaH0nrrvi4RjY5RL+Gc+Q1kKYU=; b=TR7n4591CtsMVBC3
        0u4ZuGMFp/+YByjzIk84qhQn9zUzTZMc6kPZkUwg9psQlPXV6ttr1412SK1TFIQl
        IvhWDCbGUrQu8bMmS2X/RxGn/m/rcMk+F3SX0R6hC3tyP63l2dw2yJR30qTlrXXJ
        /EfVi4Y7k2xEM/Prndb8YdDxdRU91QLHBt7bd77HIfcA9gkHc3YyyuXVMpqDOmIl
        aEESaJxv7X8zZKxCw85fZf8DE4dNrULTQIhhuIWADPd10Lm4ccPtBZ/svnvr0BVO
        97lkYnpkc7Hu3lfWfnkp/AeR+I93hD7ewCqL78T1VewbXcteJhw0LplGPaxNiJwt
        97wIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JySkV+jaMaBi53EvsBaH0nrrvi4RjY5RL+Gc+Q1kK
        YU=; b=fsGfWB7g1K3lv7XMDpRAu9T7HwdIRDW0S9VF/gszCcXrqgz3FhztCReJG
        Xyhp2RaL3HiVI7SrhZ7q+Rq8st4NNxFLLmgiRfxKwZWgAMybFNHrOvGv9MBLtfDX
        fVX67lyHZ4FKMOQiWWKbTywiDs0bS+nIwh3qlKoTG+REjtWkHrPa2v2YyYmkx7SB
        TNuCSqnx8cbAAx5OJOHob5m8ie4f3fIB0t46X9tFK15FHH27ZAJoGS97cAdOvlP4
        GgB0rL5YYjM/3MnVoDUxfiP4/5Yt9OmbW/xLFKDoikXEJsFQmOSlZXK1FGO1hXYB
        FKRnbwHJwVXueyRL8ii2am/U/CpGg==
X-ME-Sender: <xms:tt7-XpVvQnOQuiF-zyTBzry_Vz1AvILz3B91I3Smmh9SkQCMrSGJlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpeffrghnnhih
    ucfnihhnuceouggrnhhnhieskhgurhgrghdtnhdruggvvheqnecuggftrfgrthhtvghrnh
    epheeujeffgfdvieduvdeltedvteelueegheegleeggeegveefieevfeeitdfhledvnecu
    kfhppeejfedrvddvhedrgedrudefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegurghnnhihsehkughrrghgtdhnrdguvghv
X-ME-Proxy: <xmx:tt7-Xpl82x6iX208VrAhJOb-xGUwwh_pDfhKyNDRHTqTJoV3A-eE_g>
    <xmx:tt7-Xlbb0df6jY24HhDf7-ZS3BOxLZukyOulI_QTShcHgr-A8GBVyg>
    <xmx:tt7-XsUTlXtkhXlQBqmPC8yIXp6ltCY8xN0QhPNOX0Lo2G1pg4mvCw>
    <xmx:t97-Xhi1G-39w_olYBWcDwfQ1fpp1CUYpGZiazZrKCo6du2uBS618Q>
Received: from pinwheel.localnet (c-73-225-4-138.hsd1.wa.comcast.net [73.225.4.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id E239E3060066;
        Fri,  3 Jul 2020 03:31:01 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] editorconfig: Add automatic editor configuration file
Date:   Fri, 03 Jul 2020 00:31:00 -0700
Message-ID: <16043769.gqpzGLO8mG@pinwheel>
In-Reply-To: <CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3XM9T8r3r3-ysQ@mail.gmail.com>
References: <20200703001212.207565-1-danny@kdrag0n.dev> <CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3XM9T8r3r3-ysQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 2, 2020 at 10:38 PM, Miguel Ojeda wrote:
> Hi Danny,
> 
> On Fri, Jul 3, 2020 at 2:16 AM Danny Lin <danny@kdrag0n.dev> wrote:
> > +[*]
> > +charset = utf-8
> > +end_of_line = lf
> 
> While UTF-8 and LF are probably OK for all files, I am not 100% sure 
about:
> > +insert_final_newline = true
> > +indent_style = tab
> > +indent_size = 8
> 
> for other languages and non-code files we may have around. Perhaps it
> is best to avoid `[*]` unless we are sure?

Most of the other exceptions can be accomodated for with more specific 
rules below the base [*] section. I just went through most of the 
kernel's files and added rules for the vast majority of the exceptinos 
to the 8-column tab indent style, though there are still some that 
haven't been covered.

It looks like some types of files lack consistent indentation, e.g. 
arch/mips/*/Platform and some shell scripts in scripts/ tools/testing/
selftests/ftrace/test.d/kprobe/*.tc. There are also some files that were 
highly inconsistent even within themselves (e.g. drivers/gpu/drm/amd/
amdkfd/cwsr_trap_handler_gfx*.asm), so setting indentation settings to 
something sane by default doesn't make them any worse. After all, no 
automated code style tooling is perfect and there will be edge cases 
where it breaks down.

That being said, I think most of the exceptions should be taken care of 
now; please feel free to suggest a better way to deal with these.

> 
> Cheers,
> Miguel


