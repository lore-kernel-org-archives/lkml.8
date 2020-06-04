Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8EE206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgFDOgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:36:38 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:33265 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFDOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:36:38 -0400
Received: by mail-vs1-f43.google.com with SMTP id o2so3657798vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4Hx3BwEHJH2So5kTa/MIItyAdGgUGAgTi4KywxGBGc=;
        b=lmS/v9KZzUzGSydNoX7cVuS4c2A/cOSTcHG4SWfP6m05kBH6MPoz6hXWw+gJnNmnM4
         7PnUfG2scOoMK8bCBtm6PBAn6FaX1FxgKCHKE5CdhbfNM0Q7t3Tb+7jng9lX7A6q7/ZR
         t6Ya8giCvwzObRXd/a3WmMtXGfbN/unIh1WbLzpTFDzVHsy8urTj2OhOZBMZh9RUPwgj
         Fp6B2MjrxvapHeOpgDrWmdewkKkMk+IdyV6/jxJ1xcaOz77SVM9zdkZJ1/rlWJPPR1Rq
         fO93NOVLEljSlYKVC1rJ/Dcmz63u5lJjJPDjNibBI03IHBzy2FjI2XxldR1ORet78HME
         eSCw==
X-Gm-Message-State: AOAM530f/T5ZsYlOY00qdHQkQxB9KBV3whKEOLtrjwHx2yfJaFriyIQB
        x0tf46LchGvSQ8qr9wBBaEDd8WYA2Y/SrwedgOV1XBDs
X-Google-Smtp-Source: ABdhPJwhCxXt1KLLCABr033pxl0Bt2L46aMad4CJ0ByJy9dVIIbK4v2b84tVyvNLADHeUE9fta3uCAKWrbD9/4nn5GM=
X-Received: by 2002:a67:3083:: with SMTP id w125mr3719385vsw.207.1591281397221;
 Thu, 04 Jun 2020 07:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
In-Reply-To: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 4 Jun 2020 10:36:26 -0400
Message-ID: <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with kernel 5.6, loading nouveau without firmware (for GPUs
where it is required, such as yours) got broken.

You are loading nouveau without firmware, so it fails.

The firmware needs to be available to the kernel at the time of nouveau loading.

Cheers,

  -ilia

On Thu, Jun 4, 2020 at 10:24 AM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> Hi
>
> With Kernel 5.7 I am still getting this, while booting:
>
> ~> uname -a
> Linux zenogentoo 5.7.0 #80 SMP Thu Jun 4 16:10:03 CEST 2020 x86_64
> Intel(R) Core(TM) i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux
> ~> dmesg |grep nouveau
> [    0.762872] nouveau 0000:05:00.0: NVIDIA GP107 (137000a1)
> [    0.875311] nouveau 0000:05:00.0: bios: version 86.07.42.00.4a
> [    0.875681] nouveau 0000:05:00.0: acr: failed to load firmware
> [    0.875780] nouveau 0000:05:00.0: acr: failed to load firmware
> [    0.875881] nouveau 0000:05:00.0: acr ctor failed, -2
> [    0.875980] nouveau: probe of 0000:05:00.0 failed with error -2
>
> Old thread is here: https://lkml.org/lkml/2020/4/3/775
>
> My Linxu-Firmware is: linux-firmware-20200421
>
> This used to work fine with Kernel 5.5.
>
> Please CC me for replies.
>
> best
> Zeno
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
