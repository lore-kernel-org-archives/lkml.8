Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAD72089D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5o1+Kcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgERMer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgERMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:34:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC28C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:34:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so7870824lfh.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSPwRcqIEUzwnsX+6a1/rCx7QnyIswo4ef56fDP+XJQ=;
        b=K5o1+KcxWilzNS0/SHukgu2PTQNU5j8LR+M3EH4/fEeODROqMFQoC76wWoJBmhBpXG
         RCBTfGFDxGdjpmagjAIg+equaPzVEMYnkG/2633Hx6g2L5TUtj23TsKnKhiXDBNo75Tl
         4y+1kjuBhiFaLihUT6IFqaPVvWs/atx4NBW6DlS7TtduLkn8HFxbYyVOPHxSUgTnunJi
         k2N5tNWUA5wG7YMcMXiuAeEotdrDot3DhcXCUtNPk3MYOS1OMcO12tGm2Vx7l3ySESB7
         /nKzRc9AUCrVtwxKkhfNgr3CffJDXT/jfqMuPdup0aTR5kMK7z6oUTP8dUrqQTv2N1/t
         yiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSPwRcqIEUzwnsX+6a1/rCx7QnyIswo4ef56fDP+XJQ=;
        b=WBS3X+pkdxZDBu0/nkZimGfmUyoQXF3RdJjnMxibNFbkRZ3Q+snUXplz7ZVuV2KpuX
         7pAu7r39nXYBH6kcTEbekeuOMiYeUNntU6WJuaEcB+RL1AW/GHRtURJqERMTjwZLzDp6
         wPZf/oKsfjacziTaPzDgNg7NOhzkjU5eRQeSVZn/aHRvrnmG2Ew0TZagqIgmQszXZmZT
         UmTg3pafRJJboWQH6N1f8P1XDf31Lhm4WA62K3Jp5jxxE+TEoh9GSLOJmYrh8zvqOQ5e
         rxO/dRhT05RgnISS7haOD8uRfSi2fFvOiV8NaXvVRvtINiqAOwgy5atsGY/Zl1ZPPd9i
         RYwg==
X-Gm-Message-State: AOAM532FAO9xXq9/B/q7CFCoRL6kQh1pEletUxphFrhSdeSi5FSQB7VB
        eY5ZywJAh5RRCaa2yA2SZXPFPkPEL/rR48No4OrxOQ==
X-Google-Smtp-Source: ABdhPJwS4vAqRfB2Mc/Wu5XLYS5nfyJNk9m09z9ZVmCkKEs3gMi9T/GM+ekq2djUdnN47dc0XQJ6rhxmrEKr0IT4mZk=
X-Received: by 2002:ac2:560f:: with SMTP id v15mr6415706lfd.160.1589805284317;
 Mon, 18 May 2020 05:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
 <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
 <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com>
 <CAOcqxo2-G+k_E0Yg__aH_pTokpv8j4V+F0whjJKU49MeZaZ3fQ@mail.gmail.com>
 <CAFA6WYNwJ9SahZw0bh9WAr=2ofX2fpzW+bG1b7zCcov9h9qnag@mail.gmail.com> <CAOcqxo39kDDJ0FRYVkSLvdijkpF-nkm398Nrdm7pjWGzEgMKKQ@mail.gmail.com>
In-Reply-To: <CAOcqxo39kDDJ0FRYVkSLvdijkpF-nkm398Nrdm7pjWGzEgMKKQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 18 May 2020 18:04:32 +0530
Message-ID: <CAFA6WYPuEjx1WD5JBhiMJsCpTPrpLKJXg=K5Q841qF1qCHQOgA@mail.gmail.com>
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

On Mon, 18 May 2020 at 15:57, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
>
> Hi Sumit,
>
> On Fri, 15 May 2020 at 07:55, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Volodymyr,
> >
> > On Fri, 15 May 2020 at 06:32, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, 14 May 2020 at 08:38, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Volodymyr,
> > > >
> > > > On Thu, 14 May 2020 at 06:48, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> > > > >
> > > > > Hi Sumit,
> > > > >
> > > > > On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > >
> > > > > > Hi Volodymyr,
> > > > > >
> > > > > > On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Volodymyr,
> > > > > > >
> > > > > > > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > > > > > > <vlad.babchuk@gmail.com> wrote:
> > > > > > > >
> > > > > > > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > > > > > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > > > > > > PTA_CMD_GET_DEVICES call.
> > > > > >
> > > > > > Could you share a detailed description of the issue which you are
> > > > > > facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> > > > > > and cases where OP-TEE doesn't provide corresponding pseudo TA are
> > > > > > handled very well.
> > > > >
> > > > > Yes, I did some research and looks like issue is broader, than I
> > > > > expected.  It is my fault, that I wasn't paying attention to the tee
> > > > > client support in the kernel.  Basically, it is incompatible with the
> > > > > virtualization feature. You see, the main issue with virtual machines
> > > > > is the second stage MMU. Intermediate physical address, that appear to
> > > > > be contiguous for the kernel may be not contiguous in the real
> > > > > physical memory due to 2nd stage MMU mappings. This is the reason I
> > > > > introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.
> > > > >
> > > > > But, looks like kernel-side optee client does not use this feature. It
> > > > > tries to provide SHM buffer as a simple contiguous span of memory. Xen
> > > > > blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
> > > > > OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
> > > > > such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.
> > > > >
> > > > > Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.
> > > > >
> > > >
> > > > Thanks for the detailed analysis. It looks like you are missing the
> > > > following fix patch in your tree which basically fixed broken
> > > > tee_shm_alloc() in case dynamic shared memory is enabled (IIRC
> > > > virtualization only supports dynamic shared memory).
> > > >
> > > > commit a249dd200d03791cab23e47571f3e13d9c72af6c
> > >
> > > Actually, I have this patch in my tree. So, it does not fixes the
> > > issue. Which is weird, actually. I'm planning to look deeper into
> > > this.
> >
> > AFAICT, the only difference here is that it's the kernel memory
> > registered rather than user-space memory. But I am not very conversant
> > with the Xen environment. So I hope you will be able to find the root
> > cause as to why Xen is blocking this invocation.
>
> Yes. I have found issue in Xen mediator code. It didn't allowed TMEM
> with NULL buf_ptr and without ATTR_NONCONTIG flag. This is clearly
> a bug and I already sent the patch to Xen ML.
>

Glad to hear that you were able to find the bug and fix it.

BTW, I guess the reason you didn't notice this bug in user-space
(xtest 1025) is due to missing kernel patch [1] (not yet in upstream)
from your kernel tree.

[1] https://github.com/linaro-swg/linux/commit/1149e7d06a009e5dacf6aaa29bd087da64bfbed2

-Sumit

> --
> WBR Volodymyr Babchuk aka lorc [+380976646013]
> mailto: vlad.babchuk@gmail.com
