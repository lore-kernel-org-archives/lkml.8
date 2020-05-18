Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A830C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CB020657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCul2NXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgERK1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:27:39 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85075C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:27:39 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w65so2569071vsw.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfQBXo2vLHdFIaGQ6LQWu/Oo3H1KHRcSXWcWEEMW+9o=;
        b=HCul2NXQfwBhaC9FJEWSxkBkQ4oFSzTQkOYSby+W+yX78lzZ40tzmU5pqXZCoJF7zw
         wEAPsmQV8woaVQnkTwLVwW8uB0xSNBzyg0BQzDDo3EN5EXezWlKZpKVZdsrxb3Uqzkav
         f5zlBQGaDrj0c6i7cfiywi9Bh1FiXtSBODv4r3AiA1cG5haCgdaZH2j8ItHSopEkE7vr
         2d/pR7HfNp5KBSw2L+7dieWWumH23kwsXOtmMZzfLt+KUH7MRWy4ORGtMKunqF91lvIF
         sOr4W4VownvcQeP9P0NjgMwajustfXbk2A6XEKS9YWGpa1PM/GSR1JlzfiblLEdDzthn
         UyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfQBXo2vLHdFIaGQ6LQWu/Oo3H1KHRcSXWcWEEMW+9o=;
        b=sLQTMlhf8Ok1/iipfoTPvgnuxCR4lNPM0YsoxRproW7A4FEke3quZ3/Yleob31k+Xe
         xpZCoOoJgRj2cEbm6MbfyHIkYAbeN4a1NLQE9RC4EaKkBuCll6oAUl0L75k4wDjl//7F
         pV+UAZn9UcUyVHM3bVTUkNz6db37whQbX+kyT/Ec3DdTTx87XLSv+ZUlf6um1E86TeQt
         GMdG186yZQyvd2s7dW9GZEmzZLnfWWCBmksV4htooFvNk97/oSMBqMLqPf7vK5vLZqng
         puqFwGuVeA0uwX5gVeF0XoD0IWIbO8gmQm/sKHyLUaGkmzdcE+0vS+1QSTQtbM5Rvhdq
         slhw==
X-Gm-Message-State: AOAM532bs90DQwnHnHInjprz/+3/HzviYGp1fKT/Vm3ksAi5Y4JsKMDW
        SaBHc0wOClfJ1KhecMXcp/NM38yYhPDVRKR33CF53Q==
X-Google-Smtp-Source: ABdhPJxzyp39y6rQqakeOpKgzTEtryuXHOynb1Oc7O5AlQ36ymTjn0D59BwpEbhJk6xZcJJbjXIRNQF2sSCh9CVhM64=
X-Received: by 2002:a67:df02:: with SMTP id s2mr2609029vsk.210.1589797658617;
 Mon, 18 May 2020 03:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200513003430.651232-1-vlad.babchuk@gmail.com>
 <20200513003625.651340-1-vlad.babchuk@gmail.com> <CAHUa44E968nR1toCGn0_k6ABw_By7Z8EqB2rGSgiTmseo8oL-Q@mail.gmail.com>
 <CAFA6WYNOAwSaaaCCf0qoQ=gGBEsCkbdrWUzabkn3XnM7hndsow@mail.gmail.com>
 <CAOcqxo3vbv40QtK_R2m2ROyk8zXk9fJRszA6zG+f5_rse9qBDw@mail.gmail.com>
 <CAFA6WYOzzBx4CjyQQCyHgkPbOdqPMOAw54G9MK6DwhfrCHxLzQ@mail.gmail.com>
 <CAOcqxo2-G+k_E0Yg__aH_pTokpv8j4V+F0whjJKU49MeZaZ3fQ@mail.gmail.com> <CAFA6WYNwJ9SahZw0bh9WAr=2ofX2fpzW+bG1b7zCcov9h9qnag@mail.gmail.com>
In-Reply-To: <CAFA6WYNwJ9SahZw0bh9WAr=2ofX2fpzW+bG1b7zCcov9h9qnag@mail.gmail.com>
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
Date:   Mon, 18 May 2020 13:27:27 +0300
Message-ID: <CAOcqxo39kDDJ0FRYVkSLvdijkpF-nkm398Nrdm7pjWGzEgMKKQ@mail.gmail.com>
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

On Fri, 15 May 2020 at 07:55, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Volodymyr,
>
> On Fri, 15 May 2020 at 06:32, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, 14 May 2020 at 08:38, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Volodymyr,
> > >
> > > On Thu, 14 May 2020 at 06:48, Volodymyr Babchuk <vlad.babchuk@gmail.com> wrote:
> > > >
> > > > Hi Sumit,
> > > >
> > > > On Wed, 13 May 2020 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > Hi Volodymyr,
> > > > >
> > > > > On Wed, 13 May 2020 at 13:30, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > > >
> > > > > > Hi Volodymyr,
> > > > > >
> > > > > > On Wed, May 13, 2020 at 2:36 AM Volodymyr Babchuk
> > > > > > <vlad.babchuk@gmail.com> wrote:
> > > > > > >
> > > > > > > optee_enumerate_devices() can fail for multiple of reasons. For
> > > > > > > example, I encountered issue when Xen OP-TEE mediator NACKed
> > > > > > > PTA_CMD_GET_DEVICES call.
> > > > >
> > > > > Could you share a detailed description of the issue which you are
> > > > > facing? optee_enumerate_devices() is a simple invocation of pseudo TA
> > > > > and cases where OP-TEE doesn't provide corresponding pseudo TA are
> > > > > handled very well.
> > > >
> > > > Yes, I did some research and looks like issue is broader, than I
> > > > expected.  It is my fault, that I wasn't paying attention to the tee
> > > > client support in the kernel.  Basically, it is incompatible with the
> > > > virtualization feature. You see, the main issue with virtual machines
> > > > is the second stage MMU. Intermediate physical address, that appear to
> > > > be contiguous for the kernel may be not contiguous in the real
> > > > physical memory due to 2nd stage MMU mappings. This is the reason I
> > > > introduced OPTEE_MSG_ATTR_NONCONTIG in the kernel driver.
> > > >
> > > > But, looks like kernel-side optee client does not use this feature. It
> > > > tries to provide SHM buffer as a simple contiguous span of memory. Xen
> > > > blocks calls with OPTEE_MSG_ATTR_TYPE_TMEM_*   but without
> > > > OPTEE_MSG_ATTR_NONCONTIG , because it can't translate IPAs to PAs for
> > > > such buffers. This is why call to  PTA_CMD_GET_DEVICES fails.
> > > >
> > > > Valid fix would be to use OPTEE_MSG_ATTR_NONCONTIG whenever possible.
> > > >
> > >
> > > Thanks for the detailed analysis. It looks like you are missing the
> > > following fix patch in your tree which basically fixed broken
> > > tee_shm_alloc() in case dynamic shared memory is enabled (IIRC
> > > virtualization only supports dynamic shared memory).
> > >
> > > commit a249dd200d03791cab23e47571f3e13d9c72af6c
> >
> > Actually, I have this patch in my tree. So, it does not fixes the
> > issue. Which is weird, actually. I'm planning to look deeper into
> > this.
>
> AFAICT, the only difference here is that it's the kernel memory
> registered rather than user-space memory. But I am not very conversant
> with the Xen environment. So I hope you will be able to find the root
> cause as to why Xen is blocking this invocation.

Yes. I have found issue in Xen mediator code. It didn't allowed TMEM
with NULL buf_ptr and without ATTR_NONCONTIG flag. This is clearly
a bug and I already sent the patch to Xen ML.

-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk@gmail.com
