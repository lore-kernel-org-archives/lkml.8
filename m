Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF49C2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPtmcHHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgEFEIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgEFEI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:08:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7A8C061A0F;
        Tue,  5 May 2020 21:08:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f18so803502lja.13;
        Tue, 05 May 2020 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPWbtQ2Ipi4zH8vFVUvc1d3VaVsHhfFkCiz+akQxQ1s=;
        b=SPtmcHHr7tdZpS0WGhctRtDuSDha+MZN0YPNsafUc94yqdQQVOWg+FFAibD7bYwRcT
         ChxKdbH+LmcX0Rvq7EKy5C8TSpbxks24+h9EKUpw8TU9nWGWtKyWBa2Ynk7Lns9gY88T
         wD33/dUlXqDWH3jN4KPYMyMSODGSdh4Hk5LQmXrwINK3Ps6NTBIx5x+lNinwPBeSP4Yp
         jaP2XWlJ67knCfWI9qwm43DDdECSC5o58Pvp8BujjfuoKG9hB973GOM25XPkznf90NaD
         dgrLEpPBxWOh9Nokt7AjQoHpr8vpylaZrVJ3CE2Lt1W7StqcNYEQCUoP/4I7FDShybGs
         G2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPWbtQ2Ipi4zH8vFVUvc1d3VaVsHhfFkCiz+akQxQ1s=;
        b=mPPZUdjLciJB0yqN0/aHApVgA/L2SyZmjWVMtaOYwe71/GJkb4lqBtv4peXyXuVEGe
         WzJ+VjqVuRSkvCQh2At6PHt+6/SO93fKRhE5FfZg84NNdx2FGUHNpqFhxFAXlz1vbtKz
         2a+fKG2uVio6Arpl6jO4Ge7H6uTqfFIsnDB/gjmxBNQ3X/0z560qFvtc9DIOtPhhe8pG
         7wlh1Snp6c50UWvJ7lTY5s3cB1mOx+UH5L42SQU1/FcipvpLTHwmds45o/sKsyv6Hgl1
         l9bMEbTALpCDL/w0ryQRGdFoPt8bM7HlzBvoLgnPzBg1z+cbX9VLDDvL65ORFD+yvLKd
         9nMA==
X-Gm-Message-State: AGi0PuY7oVDlohQIPyloCw9gtew6Mtp1HER83T67MyTVINMdWW18elUb
        aJ6Xs/0hSbBfJWDPwAHhbbhOtKjhVAqQgvztDwhH7BL/
X-Google-Smtp-Source: APiQypKyYbeaZXkor2B9STYZVK6rBc3QfwXRGW5JhnrzYAQrroZdvsTvW5yGJLC5aQ7SXFwwdMZFdVwjfqymFbU7KQU=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr3689511ljg.266.1588738107661;
 Tue, 05 May 2020 21:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamvq+puThrxfo80TOy=xgbQEQNT6xvxy4w6hP2O1By66uw@mail.gmail.com>
 <20200501070538.GB887524@kroah.com>
In-Reply-To: <20200501070538.GB887524@kroah.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 6 May 2020 00:08:16 -0400
Message-ID: <CAEAjamsTt5E0NgauzFXYzN=GK2-y0tvgYx9B26kYAbBkDqfagg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in gadget_dev_desc_UDC_store
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:05:38AM +0200, Greg KH wrote:
> On Thu, Apr 30, 2020 at 11:03:54PM -0400, Kyungtae Kim wrote:
> > We report a bug (in linux-5.6.8) found by FuzzUSB (a modified version
> > of syzkaller).
> >
> > This happened when the size of "name" buffer is smaller than that of
> > "page" buffer
> > (after function kstrdup executed at line 263).
> > I guess it comes from the "page" buffer containing 0 value in the middle.
> > So accessing the "name" buffer with "len" variable, which is used to
> > indicate the size of "page" buffer,
> > triggered memory access violation.
> > To fix, it may need to check the size of name buffer, and try to use
> > right index variable.
>
> Can you submit a patch for this as you have a reproducer to test the
> issue?
>
> thanks,
>
> greg k-h

I just submitted a patch after testing with the repro.

Regards,
Kyungtae
