Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D387B2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdhm0lWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgENBSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725952AbgENBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:18:46 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:18:45 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id p5so367447vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVWSL7qvC4yqYlQuiHnpdtaQ5HgS3E6TtV1AkP5YA5s=;
        b=kdhm0lWyJrwkRF+EbJnyk0Spr3Svf85VUdXEpgxB2D36Q077wId9PkF7MXv3Wch9Xz
         KoY0I+9+AW/xrNC2fQjUy23bnqw5QmC5wRkCV1FYrxjYGhZ+ufjB7ODUU80sVCmvBqC4
         dyKEU4BpKAjUYlI0A3M4Qs4DSDrSKWuknqtoZI8NRuX/E50hacqQeRdoii4rgVhSnKVq
         IF8gAf4sQfts8ti4dRC5unyoHVprBZSJepg8mkWLAn3z8pQAiRMhLVvGwESkMe9eaa0K
         OLexJ5k6c8Ohza7FJn6X/abQ47D27sq/WG5Ssaz+ZMb5bS59VHHoEA08cAvlAkVO0Y1d
         KKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVWSL7qvC4yqYlQuiHnpdtaQ5HgS3E6TtV1AkP5YA5s=;
        b=FJFEawodVC+dD6z3PAWujzOZUhbQ12Pu8+ANJ7+LHVfHyRy9hRhk5F6xbTaNrMN/ul
         QeOQzj+s43eH+qE2Df8Q+Rt2lwGmQgmwsylFAPTlrO7QujoutI3KY9OohhJMX8kKeU2l
         5SzsaBxVpYnKG0LhcShvvckTqC1B+vhwMb5At0U742OImKRdIuKyyq6dC7kflX7CXEzC
         3y1IMeNXM32CPOBOp+WP/ccuoHiPJCoirl7Vc/k++nhrSnq8qf2+GbGTjnLzZay/DCaI
         ICaLX5MaUlkoTsC1xbx/TpSb6ZJA8iZk9IhT36VW2umThdxrVAnU5VXKfiNmxuJCmcoo
         Km2Q==
X-Gm-Message-State: AOAM533i441chNyVyzAIPyKgK1ne6N6mXHpcJhDvzswELrWqa9UOqRQo
        4r/2QRbX64Q/btxK8lY4WyQ+W3rrh7NS2kvPf4s=
X-Google-Smtp-Source: ABdhPJyTvW8/qCFYpupArSpa7iLScZKZQFjt3a1BIW173qXozLy/9oTCEDvNEmslQgYouqGvvMvU8YaQmRAQUUmbHds=
X-Received: by 2002:a1f:ac0e:: with SMTP id v14mr1813619vke.28.1589419124254;
 Wed, 13 May 2020 18:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
In-Reply-To: <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
Date:   Thu, 14 May 2020 04:18:33 +0300
Message-ID: <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
Subject: Re: [PATCH] optee: don't fail on unsuccessful device enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Volodymyr,
>
> On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Volodymyr,
> >
> > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > <vlad.babchuk@gmail.com> wrote:
> > >
> > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > PTA_CMD_GET_DEVICES call.
>
> Could you share a detailed description of the issue which you are
> facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> and cases where OP-TEE doesn't provide corresponding pseudo TA are
> handled very well.

Yes, I did some research and looks like issue is broader, than I
expected.  It is my fault, that I wasn't paying attention to the tee
client support in the kernel.  Basically, it is incompatible with the
virtualization feature. You see, the main issue with virtual machines
is the second stage MMU. Intermediate physical address, that appear to
be contiguous for the kernel may be not contiguous in the real
physical memory due to 2nd stage MMU mappings. This is the reason I
introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.

But, looks like kernel-side optee client does not use this feature. It
tries to provide SHM buffer as a simple contiguous span of memory. Xen
blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.

Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.

>
> > > This should not result in driver
> > > initialization error because this is an optional feature.
>
> I wouldn't call it an optional feature as there might be real kernel
> drivers dependent on this enumeration. Also, it is a simple example to
> self test OP-TEE functionality too. So I am not sure how much
> functional OP-TEE would be if this basic TA invocation fails.

Well, it fixed case when Xen is involved. I think, this is valid
combination, when platform have the newest OP-TEE, but slightly older
kernel. So, imagine that OP-TEE provides PTA_CMD_GET_DEVICES, but
kernel can't use because it uses plain TMEM arguments,which are not
supported in virtualized environment.

If there are kernel drivers, that depend on this PTA, they would not
work in any case. But at least userspace clients still be able to use
OP-TEE. This is why I call this feature "optional".

-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk@gmail.com
