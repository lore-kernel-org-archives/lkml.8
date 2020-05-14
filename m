Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5120EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFA22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ol61+9Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgENFjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726122AbgENFi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:38:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB13AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:38:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so1487536lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYvOOmKt6CqklOdp6kTHUSl02OGvdRFZjOL384iDoRM=;
        b=ol61+9LbEU7e8ijqyRqzUAIXynlhyJzhn/SkOgfM4ArdMEfcX7r4ihczbl64mYkMKF
         vvh85KomqcXA9IeSCihweH7ET/JVCQwEY2fPyCuvakqDemSWoX3wBLhD0EMnZ8xRGr+7
         RXX/B0DalcH82UeNskfR9FshI39wMZMtVqGfkrvKQGhyJM04gaQpePcqNSiW7lSlTmQ+
         xrg5vjYXadAv7TA5RBVn449jPcgXVdwXAMkIwPnSfd6SFcb6jmDZP1I4C9BmWIqsa2Wb
         zqhgD07r2ni5fkODZE/yaWepJs7I2r0YleKbY+vbTaPYzHmzD8Po2oc2rApl0woJZSi+
         HCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYvOOmKt6CqklOdp6kTHUSl02OGvdRFZjOL384iDoRM=;
        b=RTTC8YHSt7yHs01rgIRad3hnqFesqNMVS4gelO4ek/HjhwVyyjQ0bt/dAw6bZ5jMK9
         MODJ105Vrw5UcqeZ7ONFgVFAtmCwV7AF9UIf+YvSWyajGrjdVH8mwaRi5ktxrAEnvxOs
         0Q+FuuaHSMIaqd33uRmV1z7lzbvLjlAo+vqgV+cZYWw8pUIFkQ11i55wqhEVp8Hc1K6r
         r+dBIRxtUbCXWAQgtiOkNyD50sKwdAbePOG5lPkJkwvBBE7MzthD5wWTWKUvWSkMLnVq
         T4ouTOkuZUoky/EGCVS8flZChcX/rUk2KBMNONHt/fJL38Zfc8iP7rmqvWk6o3klvyrV
         2ieg==
X-Gm-Message-State: AOAM532YvNlgejTSlEI+5R8+NKZWRC+/JLJ+5/8eEFsQUmvSYGjvAt0j
        O6+pHz3P7r5e3vT6tX0jYxGhJaNgE0N39V7xmf1kOA==
X-Google-Smtp-Source: ABdhPJzQ0Ihn6yDiCu4RIEGUEPXSdGPbZtzgqm4dhKI9p8ZWqfzBmh/Z92mHho/82s4WB423bi6ux6wY0KnLrACsnaY=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr2000757lfi.21.1589434735336;
 Wed, 13 May 2020 22:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com> <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
In-Reply-To: <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 14 May 2020 11:08:43 +0530
Message-ID: <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com>
Subject: Re: [PATCH] optee: don't fail on unsuccessful device enumeration
To:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

On Thu, 14 May 2020 at 06:48, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
>
> Hi Sumit,
>
> On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Volodymyr,
> >
> > On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Volodymyr,
> > >
> > > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > > <vlad.babchuk@gmail.com> wrote:
> > > >
> > > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > > PTA_CMD_GET_DEVICES call.
> >
> > Could you share a detailed description of the issue which you are
> > facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> > and cases where OP-TEE doesn't provide corresponding pseudo TA are
> > handled very well.
>
> Yes, I did some research and looks like issue is broader, than I
> expected.  It is my fault, that I wasn't paying attention to the tee
> client support in the kernel.  Basically, it is incompatible with the
> virtualization feature. You see, the main issue with virtual machines
> is the second stage MMU. Intermediate physical address, that appear to
> be contiguous for the kernel may be not contiguous in the real
> physical memory due to 2nd stage MMU mappings. This is the reason I
> introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.
>
> But, looks like kernel-side optee client does not use this feature. It
> tries to provide SHM buffer as a simple contiguous span of memory. Xen
> blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
> OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
> such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.
>
> Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.
>

Thanks for the detailed analysis. It looks like you are missing the
following fix patch in your tree which basically fixed broken
tee_shm_alloc() in case dynamic shared memory is enabled (IIRC
virtualization only supports dynamic shared memory).

commit a249dd200d03791cab23e47571f3e13d9c72af6c
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Fri Nov 8 16:57:14 2019 +0530

    tee: optee: Fix dynamic shm pool allocations

    In case of dynamic shared memory pool, kernel memory allocated using
    dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
    during optee_open_session() or optee_invoke_func().

    So fix dmabuf_mgr pool allocations via an additional call to
    optee_shm_register().

    Also, allow kernel pages to be registered as shared memory with OP-TEE.

    Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
    Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
    Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

After this fix, your issue should be resolved as it uses
OPTEE_MSG_ATTR_NONCONTIG attribute for kernel memory allocated via
tee_shm_alloc().

> >
> > > > This should not result in driver
> > > > initialization error because this is an optional feature.
> >
> > I wouldn't call it an optional feature as there might be real kernel
> > drivers dependent on this enumeration. Also, it is a simple example to
> > self test OP-TEE functionality too. So I am not sure how much
> > functional OP-TEE would be if this basic TA invocation fails.
>
> Well, it fixed case when Xen is involved. I think, this is valid
> combination, when platform have the newest OP-TEE, but slightly older
> kernel. So, imagine that OP-TEE provides PTA_CMD_GET_DEVICES, but
> kernel can't use because it uses plain TMEM arguments,which are not
> supported in virtualized environment.
>
> If there are kernel drivers, that depend on this PTA, they would not
> work in any case. But at least userspace clients still be able to use
> OP-TEE. This is why I call this feature "optional".

As you can see above, tee_shm_alloc() being broken in your case was
detected via this simple pseudo TA invocation. So IMO, it would be
better to keep the existing behaviour as it provides a kind of basic
OP-TEE driver runtime self test too. Also, I think it would be a
better user experience to have every OP-TEE interface working rather
than a partially broken interface.

-Sumit

>
> --
> WBR Volodymyr Babchuk aka lorc [+380976646013]
> mailto: vlad.babchuk@gmail.com
