Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA57C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2124125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlxIOFjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAWKWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:22:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43070 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:22:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so2382610oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMAWrdUILB1z+wY3Sx+Tkapa14K6I1hBZeKU/i+V6lY=;
        b=KlxIOFjbhVHEdJ0l057E/t1zRkumYDzpJLbxlaal+okJPpEaxcTDo+B23BCt5uSW7v
         ReOqq/vwhkQcBSoNTADY6g03Je4AFJ4yGy0R6fIUz4z/hLArsld4ezsT++tGo35Obmmx
         afcnwROuyw36sgOSn9Ft+7TNpaQwhaInFaxHnc4pU5kozFRECCER4myfzMMwt0ZkBaeN
         ZL/3zWOMeuDMKqoGTXyWseW+LGuF4DHUcL9XAs5x6nQh+KxbvNrv7r6enPL1MuftO/ba
         wTF1PQ9jPuFqKlc6juNklWotdMxDo/UHAKAkWRub7nc3zv65SNcq5+aMSRzJ+YkkPz3J
         mV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMAWrdUILB1z+wY3Sx+Tkapa14K6I1hBZeKU/i+V6lY=;
        b=m3vFwlS6yf/i1GThXL1ZJZtI+7LHKHp95Cm/7I+0sb0MmdvAH8g61O+9lM8flbYFMn
         A0FWctTAdQYQLh3lCSlFAv6MW0BRKhMf7U17M14bcLJ5716QVNMKjW/KEhoRDk82pveH
         XiwPJeDYM6Eu6Bold/cDG9sUs7VhbVG7y6fjRcgn4+jbiKUZnuos95r6ZGUbMc/ur6Sk
         aEXeIT8opA1fFHZc5nvNkGlhfB4e3DsNMNUiFj3IzC+4AYWQ8ZmyKUUfqKPRMFXrIYRs
         NkxtQJ1y0cYjNleNjGleKQ//xsLqSYmHjt4YxHCit9Ivi0TAMdukKjPk3ZclyvPvUrFf
         Y+xA==
X-Gm-Message-State: APjAAAUGAqC2lr7mtQY3xedAYO6xd3Iro7Gw5799JAEyzHevoNK+df9M
        0bKte1xIHXTuW3we1Srqp5TY3iQhepWrYeJ/glTpYQ==
X-Google-Smtp-Source: APXvYqzdKgGHj3RTDUsVVXjaaG5q4SJL9mlqzDMCMPc/dJM7heOne2hoxHrHt9+ZExdNtJacgwDbTYl00N2VMizi1NI=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr10200597oij.149.1579774919613;
 Thu, 23 Jan 2020 02:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 23 Jan 2020 11:21:48 +0100
Message-ID: <CAHUa44H0YL5Ke-QgzACYF8dS1C9PE97kjF9CZZQUiSE4RN0+mA@mail.gmail.com>
Subject: Re: [PATCH 0/5] tee: shared memory cleanup
To:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 9, 2020 at 1:37 PM Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> Here's a group of patches to the tee subsystem with cleanups and not so
> urgent fixes related to tee shared memory.
>
> - Unused parts of the shared memory object (struct tee_shm) are removed.
> - Shared memory ids usable from user space are not assigned to driver
>   private shared memory objects
> - The TEE_SHM_USER_MAPPED is used instead of TEE_SHM_REGISTER to accurately
>   tell if a shared memory object originates from another user space mapping.
>
> Only unused "features" should be removed with this patch set, there should
> be no change in behaviour or breakage with other code.

I'll pick up these as they are in a few days if there's no further comments.

Thanks,
Jens

>
> Thanks,
> Jens
>
> Jens Wiklander (5):
>   tee: remove linked list of struct tee_shm
>   tee: remove unused tee_shm_priv_alloc()
>   tee: don't assign shm id for private shms
>   tee: remove redundant teedev in struct tee_shm
>   tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED
>
>  drivers/tee/tee_core.c    |  1 -
>  drivers/tee/tee_private.h |  3 +-
>  drivers/tee/tee_shm.c     | 85 +++++++++++----------------------------
>  include/linux/tee_drv.h   | 19 +--------
>  4 files changed, 27 insertions(+), 81 deletions(-)
>
> --
> 2.17.1
>
