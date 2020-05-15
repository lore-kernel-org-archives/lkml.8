Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86369C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EDE206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 04:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySnRwIEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgEOEzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 00:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgEOEzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:55:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A38C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 21:55:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so784174ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roDur3StTlQ06ArIugmD/EEpbcPRguB/tMY4hSg8Yvg=;
        b=ySnRwIElCG3Wckl0JtphfTREdhjNCFclsxO3kJcQl0LxHlQn8pn/omd11/Bs199su4
         ngUi4vH/CYY5FVlJgJ05NtM7Y9XZCk4o3vT/DloHw2KItOOPM03LYXvFAveJRzq7CY1d
         1RJFuILFr82jWTz5PDZOcnyjgjuFHF9tiB1pFJn0YakVjkRkLLRNNkQAMGGlCMMi9Z7B
         3+Sc+ZHQBK4NFCHnq+wKSk2bHULumywAVeXSZPLaqAXk2wIkKcHdjeM8WA0noVBO16fI
         9r1GkR+jGkXi/6P3qvA0ktVzapFp0Dnas7ADFYAE1pqNvRcwPIaCiLujhS6FX4VaXtiX
         MEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roDur3StTlQ06ArIugmD/EEpbcPRguB/tMY4hSg8Yvg=;
        b=GlA9v5EZie4FLF1GCz4CIPaIPevoyOfNW9+Tg8DCoh+AZ7ExI9lH/7221aCKJQglwQ
         JYAcQTn0xtU9ZHQo8PI3/YKESUIyVLqwci/RyJ6u9YcrOiQAhf+IkrDWe1wt3GWZwhdZ
         Pzycbud9uIp9ycARKAuvikDfwZ2DjSHZam77nanNRQpgNLqiiDq5wMSsT3ZsIqIcaUY8
         s21eeT6w+Sq6OQERoPYuB+avMkUjNozWv2wrQG/Bmf53JrlRfj/UKO+9NKicJvsRnzq3
         bfyquhXLdmG3pTZta4AeIyBFD3eavllRsfGLPAve/o4zRQxqkXS4rBUr33Eh9grQnCow
         5n+w==
X-Gm-Message-State: AOAM532IkG6DzLBJiLCk5iFGQgnp2BRm087xJQNQSohVwAPdCe2Hj06e
        47TmIFQYRcagw2aZaYj5F0SEr0iVl9tbFd5eRJJbrzv9jAQ=
X-Google-Smtp-Source: ABdhPJwU0QThFqTCXqLteLfLJmdu65Ll8YwUlGeR1Re46cmVVhgSBle4/gcqoDr4TNe/cTDLPyrbMoTbLPOGKHKHrBE=
X-Received: by 2002:a2e:b706:: with SMTP id j6mr962419ljo.293.1589518503249;
 Thu, 14 May 2020 21:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
 <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
 <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com> <CAOcqxo2-G+k_E0Yg__aH_pTokpv8j4V+F0whjJKU49MeZaZ3fQ@mail.gmail.com>
In-Reply-To: <CAOcqxo2-G+k_E0Yg__aH_pTokpv8j4V+F0whjJKU49MeZaZ3fQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 15 May 2020 10:24:51 +0530
Message-ID: <CAFA6WYNwJ9SahZw0bh9WAr=2ofX2fpzW+bG1b7zCcov9h9qnag@mail.gmail.com>
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

On Fri, 15 May 2020 at 06:32, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
>
> Hi Sumit,
>
> On Thu, 14 May 2020 at 08:38, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Volodymyr,
> >
> > On Thu, 14 May 2020 at 06:48, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Volodymyr,
> > > >
> > > > On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Hi Volodymyr,
> > > > >
> > > > > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > > > > <vlad.babchuk@gmail.com> wrote:
> > > > > >
> > > > > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > > > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > > > > PTA_CMD_GET_DEVICES call.
> > > >
> > > > Could you share a detailed description of the issue which you are
> > > > facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> > > > and cases where OP-TEE doesn't provide corresponding pseudo TA are
> > > > handled very well.
> > >
> > > Yes, I did some research and looks like issue is broader, than I
> > > expected.  It is my fault, that I wasn't paying attention to the tee
> > > client support in the kernel.  Basically, it is incompatible with the
> > > virtualization feature. You see, the main issue with virtual machines
> > > is the second stage MMU. Intermediate physical address, that appear to
> > > be contiguous for the kernel may be not contiguous in the real
> > > physical memory due to 2nd stage MMU mappings. This is the reason I
> > > introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.
> > >
> > > But, looks like kernel-side optee client does not use this feature. It
> > > tries to provide SHM buffer as a simple contiguous span of memory. Xen
> > > blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
> > > OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
> > > such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.
> > >
> > > Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.
> > >
> >
> > Thanks for the detailed analysis. It looks like you are missing the
> > following fix patch in your tree which basically fixed broken
> > tee_shm_alloc() in case dynamic shared memory is enabled (IIRC
> > virtualization only supports dynamic shared memory).
> >
> > commit a249dd200d03791cab23e47571f3e13d9c72af6c
>
> Actually, I have this patch in my tree. So, it does not fixes the
> issue. Which is weird, actually. I'm planning to look deeper into
> this.

AFAICT, the only difference here is that it's the kernel memory
registered rather than user-space memory. But I am not very conversant
with the Xen environment. So I hope you will be able to find the root
cause as to why Xen is blocking this invocation.

>
> >
> > > >
> > > > > > This should not result in driver
> > > > > > initialization error because this is an optional feature.
> > > >
> > > > I wouldn't call it an optional feature as there might be real kernel
> > > > drivers dependent on this enumeration. Also, it is a simple example to
> > > > self test OP-TEE functionality too. So I am not sure how much
> > > > functional OP-TEE would be if this basic TA invocation fails.
> > >
> > > Well, it fixed case when Xen is involved. I think, this is valid
> > > combination, when platform have the newest OP-TEE, but slightly older
> > > kernel. So, imagine that OP-TEE provides PTA_CMD_GET_DEVICES, but
> > > kernel can't use because it uses plain TMEM arguments,which are not
> > > supported in virtualized environment.
> > >
> > > If there are kernel drivers, that depend on this PTA, they would not
> > > work in any case. But at least userspace clients still be able to use
> > > OP-TEE. This is why I call this feature "optional".
> >
> > As you can see above, tee_shm_alloc() being broken in your case was
> > detected via this simple pseudo TA invocation. So IMO, it would be
> > better to keep the existing behaviour as it provides a kind of basic
> > OP-TEE driver runtime self test too. Also, I think it would be a
> > better user experience to have every OP-TEE interface working rather
> > than a partially broken interface.
>
> I can see your point. But I think, that it is good to not to break
> backward- and forward- compatibility. Imagine, that user upgrades
> OP-TEE without changing the kernel. Previously it worked well, but new
> OP-TEE provides new PTA and kernel refuses to load the optee driver
> because driver fails to initialize that PTA.
>
> This is basically what happened with me. Platform that I am using does
> not provide any OP-TEE devices so I assumed that I can safely ignore
> this feature. But, when I flashed the latest OP-TEE build I got dead
> optee driver. This is confusing from a user standpoint. You don't
> expect that firmware upgrade to another minor version will break
> existing setup. My proposed patch at least prints the warning, so user
> would know where to look...

Warning prints aren't much useful in the sense that they can't be
detected via current OP-TEE CI.

>
> Anyways, if we'll find a proper fix before next code freeze, I'd
> prefer to drop this particular patch. But let's keep it as a plan
> B. What do you think?

Since it seems like currently the kernel internal interface is broken
with virtualization support. So how about "plan B" being skipping the
enumeration in case "OPTEE_SMC_SEC_CAP_VIRTUALIZATION" is set? As we
can't expect to get TEE kernel drivers working without getting this
interface fixed. Also, having an information message that the kernel
internal interface is not supported with virtualization would be
useful too.

-Sumit

>
> --
> WBR Volodymyr Babchuk aka lorc [+380976646013]
> mailto: vlad.babchuk@gmail.com
