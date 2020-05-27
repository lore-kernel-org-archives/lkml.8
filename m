Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67410C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489E120835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICaX7NlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbgE0R6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388544AbgE0R6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:58:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE87C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:58:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so1866114pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2dXb/W+FFUUQdJGDBXGOrcBx0qp8UzbDlrm8pA5EtY=;
        b=ICaX7NlLLWUb8V6MIhHgmU+GSEus1nQ+B+yewGf+yzKsawUFBmphgWTlaoQOLpQR9q
         /jpDP6KtiNX4NO/6KA9kMKBev6liRbJ1BGVRzSnCHdMX2rfu7/i55zNOtMzAn8bxArUX
         jViDgG2CxALY1Fk7jf/Ink91WecuSjAZTOCDq/zuNS/Ajq/hHLCW/OPFw37M5dCymmLt
         1uIIEeqmBpTDpYS0G9Mu1eu6NzrDAAFQYC3gG97e07ChVOaHb6vqNL5spkY7biIj3Wn9
         3lTgVfuyc0YNgMlqs8LVPxcWo9Py6mLoZk495QfZBqI8oA5pJKVoK2SD5/WJJcdl+63p
         /aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2dXb/W+FFUUQdJGDBXGOrcBx0qp8UzbDlrm8pA5EtY=;
        b=l5KiKl3gWp4ndw3Xh7WObJddcBqRHobeadMPLbpT7HvNPqtbrR0939UTRJtaUzpj2z
         DovVv9gVbLjO3mv06VRT2xt3b78DJ/VPAc7CGYs2pn34PQ4qly6YYQIZe3ZDJrU6BI/o
         3yBAF+I2/6h+R++k/InBV1A4fA50vtF4HroZf2lNNDrYjFKVTYUcsyunp/ckqkBuU5At
         hRfEuD1dPRtN8wfW+xjmLujSTfiUX/7DuxGxHJQeZFU02VZMz/T6WzsrRRMSIdK7p3mg
         v7CK4ySMqiuRQDeNkp8eNbYpDhu4445fgMNsqW9uzFDDKBjhDjm5tmVQDuUfzs3lyUxK
         4OHg==
X-Gm-Message-State: AOAM531G6U/kShxlsE13JNYTW2X76M34NXuDYrBPWY2u9Z4rYRneTPxj
        +eHV4MNZxeUWQJG7JBNB+mtvENmZZ1yaoHVmseuAOg==
X-Google-Smtp-Source: ABdhPJylF3XJCAEDnd35ICRnynXaDjY473+4M+Syt0LKUEBzmZslJCsycy4dHuwtLGEcgLfbNNR3IHlLI1zsLnhDg4I=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr6511155pjb.101.1590602332138;
 Wed, 27 May 2020 10:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <159052247565.23781.7800427985507723263.b4-ty@kernel.org> <20200527135322.GU5031@arm.com>
In-Reply-To: <20200527135322.GU5031@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 May 2020 10:58:41 -0700
Message-ID: <CAKwvOdnSby=NaRG_xazeOOMXjzPu9FAuAPZW85FU0M8-+pA53Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 6:53 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, May 26, 2020 at 09:45:05PM +0100, Will Deacon wrote:
> > On Tue, 26 May 2020 10:31:14 -0700, Nick Desaulniers wrote:
> > > Custom toolchains that modify the default target to -mthumb cannot
>
> It's probably too late to water this down, but it's unfortunate to have
> this comment in the upstream commit history.
>
> It's not constructive to call the native compiler configuration of
> major distros for many years a "custom" toolchain.  Unmodified GCC has

I don't think you know which toolchain or distro I'm referring to. ;)

> had a clean configure option for this for a very long time; it's not
> someone's dirty hack.  (The wisdom of armhf's choice of -mthumb might
> be debated, but it is well established.)
>
> Ignoring the triplet and passing random options to a compiler in the
> hopes that it will do the right thing for an irregular usecase has never
> been reliable.  Usecases don't get much more irregular than building
> vdso32.
>
> arch/arm has the proper options in its Makefiles.
>
> This patch is a kernel bugfix, plain and simple.

Borrowing from the Zen of Python: Explicit is better than Implicit.
Better not to rely on implicit defaults that may be changed at configure time.

> Does this need to go to stable?

Oh, probably.  Need to wait until it hits mainline now.  I don't think
the compat vdso series was backported to 5.4, but IIUC stable
maintains a branch for the latest release, which would have that
series.

-- 
Thanks,
~Nick Desaulniers
