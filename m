Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D05AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB6C2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPNByhGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEOBCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:02:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:02:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g2so239392vsb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YzFPlaP/aBDfAjyXONQQgVIcoZ+A/P5+bIgEnwDswk=;
        b=fPNByhGkkI8Jtt5PMLFWnwdA60cQuNSUBTd62M31vDTFthzj4K4EkCHc1mEqmpr03i
         6vH66iwwEBs1PiLhA6sysabloeu6SLlZw8ExEpU7M6eR6W6Tp7uA5Fp2W3SQ7P4JzX/l
         JZujraxbImwz/FTI//OebUH9NhMPRWoqTJ/Cm2x2geTdgvtzsxHapr6nVlWnqwSZNzln
         YWpcTgR20Lsf+ekqfReaoohfHb4ZSlH13iQc8Iw2prFMl72bQF2aSu9KL0PV+93gwJHd
         7RQJog48D/uXVo5QXE2iyaL/gWV/2yBbK0ay2ryflusBJiDlkk1Buwqb/PLBgwtOsIVo
         KpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YzFPlaP/aBDfAjyXONQQgVIcoZ+A/P5+bIgEnwDswk=;
        b=ea7SW/x5XfE6Rme+Nn2lJ+epDzCfBzk7v7Z730rF37WE//X4cpd5LMtXXTnHykHINP
         OVszqCy0HeBHTSfFvVKWJybw452+hWC2m+7tr+whzUdobchP2cccwaam9q8L5TpZ5mLW
         iW88nVq3jSAd4lLUb6SDvkCnFQbR8obKtuni9qcqRZYXSZYBjU/J8KRDzUya4ZxFWO7Z
         rQvam+Ndls4C4rJzQwrVW7j+UuhRw0vwGtpzvjZBw9Bubrp7pgiS2EyBW7H8rGGSm7w8
         7P0Vedk+gYAMf/xgyFC5TgL9r/RJ5YZKTHC4lThlyqdWMNc07kHerPGERlf2Hn4ofkRY
         ndlw==
X-Gm-Message-State: AOAM532RNqEGBItbOv6HyYCTDHGloPz82eG4YD6wNHByIg1E7sSdvS0G
        2hEncVV1r3fduIGZfhko4V103ITXcXcw5F7qF5s=
X-Google-Smtp-Source: ABdhPJwfH8X02TLgE2bSi5WWMFMZ/80SvIfBzCJ3S/vtJSNOkSeyX+2RWIJKgB8rDaBW6gZZgahqTdqWrY6ke/v8gvs=
X-Received: by 2002:a05:6102:502:: with SMTP id l2mr818187vsa.210.1589504523437;
 Thu, 14 May 2020 18:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
 <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com> <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com>
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
Date:   Fri, 15 May 2020 04:01:51 +0300
Message-ID: <CAOcqxo2-G+k_E0Yg__aH_pTokpv8j4V+F0whjJKU49MeZaZ3fQ@mail.gmail.com>
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

On Thu, 14 May 2020 at 08:38, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Volodymyr,
>
> On Thu, 14 May 2020 at 06:48, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> >
> > Hi Sumit,
> >
> > On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Volodymyr,
> > >
> > > On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi Volodymyr,
> > > >
> > > > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > > > <vlad.babchuk@gmail.com> wrote:
> > > > >
> > > > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > > > PTA_CMD_GET_DEVICES call.
> > >
> > > Could you share a detailed description of the issue which you are
> > > facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> > > and cases where OP-TEE doesn't provide corresponding pseudo TA are
> > > handled very well.
> >
> > Yes, I did some research and looks like issue is broader, than I
> > expected.  It is my fault, that I wasn't paying attention to the tee
> > client support in the kernel.  Basically, it is incompatible with the
> > virtualization feature. You see, the main issue with virtual machines
> > is the second stage MMU. Intermediate physical address, that appear to
> > be contiguous for the kernel may be not contiguous in the real
> > physical memory due to 2nd stage MMU mappings. This is the reason I
> > introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.
> >
> > But, looks like kernel-side optee client does not use this feature. It
> > tries to provide SHM buffer as a simple contiguous span of memory. Xen
> > blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
> > OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
> > such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.
> >
> > Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.
> >
>
> Thanks for the detailed analysis. It looks like you are missing the
> following fix patch in your tree which basically fixed broken
> tee_shm_alloc() in case dynamic shared memory is enabled (IIRC
> virtualization only supports dynamic shared memory).
>
> commit a249dd200d03791cab23e47571f3e13d9c72af6c

Actually, I have this patch in my tree. So, it does not fixes the
issue. Which is weird, actually. I'm planning to look deeper into
this.

>
> > >
> > > > > This should not result in driver
> > > > > initialization error because this is an optional feature.
> > >
> > > I wouldn't call it an optional feature as there might be real kernel
> > > drivers dependent on this enumeration. Also, it is a simple example to
> > > self test OP-TEE functionality too. So I am not sure how much
> > > functional OP-TEE would be if this basic TA invocation fails.
> >
> > Well, it fixed case when Xen is involved. I think, this is valid
> > combination, when platform have the newest OP-TEE, but slightly older
> > kernel. So, imagine that OP-TEE provides PTA_CMD_GET_DEVICES, but
> > kernel can't use because it uses plain TMEM arguments,which are not
> > supported in virtualized environment.
> >
> > If there are kernel drivers, that depend on this PTA, they would not
> > work in any case. But at least userspace clients still be able to use
> > OP-TEE. This is why I call this feature "optional".
>
> As you can see above, tee_shm_alloc() being broken in your case was
> detected via this simple pseudo TA invocation. So IMO, it would be
> better to keep the existing behaviour as it provides a kind of basic
> OP-TEE driver runtime self test too. Also, I think it would be a
> better user experience to have every OP-TEE interface working rather
> than a partially broken interface.

I can see your point. But I think, that it is good to not to break
backward- and forward- compatibility. Imagine, that user upgrades
OP-TEE without changing the kernel. Previously it worked well, but new
OP-TEE provides new PTA and kernel refuses to load the optee driver
because driver fails to initialize that PTA.

This is basically what happened with me. Platform that I am using does
not provide any OP-TEE devices so I assumed that I can safely ignore
this feature. But, when I flashed the latest OP-TEE build I got dead
optee driver. This is confusing from a user standpoint. You don't
expect that firmware upgrade to another minor version will break
existing setup. My proposed patch at least prints the warning, so user
would know where to look...

Anyways, if we'll find a proper fix before next code freeze, I'd
prefer to drop this particular patch. But let's keep it as a plan
B. What do you think?

-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk@gmail.com
