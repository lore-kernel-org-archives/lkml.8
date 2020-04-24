Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C525C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D662064C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDrLWAOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDXNQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:16:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB259C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:16:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so3720326pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oa/oNHUWZOTRPTTfBqwCxMu6cnopDNrg7qX1yx+D0Es=;
        b=fDrLWAOe45JA/LlPn6FGyX7H7o/h14fgDXB7FCyKQsisVv0+/iUotKI6wPbKEektvn
         D/49HKMvtl9DVcaX4nX4fdoVtPTEu2ublJHjyzAqW2Ruyeph6+S9B5jV33MLS0rC5BtH
         neGu6sihmDZD8pQcNqhRXd2fZZJtxMZcFp0OfwKTivAfvYIMT+/AXCsLYBUR0RpwmDdS
         9xww8khHXsEbkeZ9rsiEwB3OG89vUAOkkDtWiYgbPvZ2K8l3VObxpT+ShS0semRQvTKa
         hKUU5Ot6zpH9uSKbbLYrhdzcWNrxc/hBMcbLzrSbTO/rpPCyGzId1Kxep91t4RcDPR6X
         eoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oa/oNHUWZOTRPTTfBqwCxMu6cnopDNrg7qX1yx+D0Es=;
        b=Ur2AugHJ6kVmsaV1zfxcdiafihtsgfOwvxs8jptqoiBFxiRWHP2HK9yQAezMpMwQ3T
         WnTyCKegCNLbeBlbeUXdyW83Zs57vQDC4F11j0x6zZZLrYFF+wx3DJt3nQOmb3v8WJYW
         Cs6enTyqUtHUA1m5N5ny4OH/rUpHHYF+DwTN3AbVLwk7b58p++HL2IoFUYRYGuG5GqlK
         SdpOWuiFWx3yCg9J/VHYXTuesnc/KVXtfjK9kMtYPODN7Vk1XpNHf+LDtNm2BKwyxcB5
         G2ff72k6dVP5Z90rHBt7j0KeB7E+n7j+pSZ/c3mrO3QrB7y4ByLzRXQxpUbXozSswE1X
         wRsw==
X-Gm-Message-State: AGi0PuZ4lITUn89N7D43NqXj5ftV89nGywXEuV7nSOH8WylMufY1fhw6
        jNinVzZnGHcz5LCbeRt2wsgQlAPOdfZ3fMxosrBmbA==
X-Google-Smtp-Source: APiQypJOrLgs+kDHqzamHAX8n4seNWcLkNNFQ+4WcajoZ8auNmbQkqAS/xpZ05CHq4HN9oZLQfmbVvdG3WHUmuh3v9E=
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr8948599pla.336.1587734206165;
 Fri, 24 Apr 2020 06:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
 <20200424084307.GQ2682@kadam>
In-Reply-To: <20200424084307.GQ2682@kadam>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 24 Apr 2020 15:16:35 +0200
Message-ID: <CAAeHK+zS3WcmPEr9+hYGTMrZUwXyn5489Ke4f1zpdvTa-U-s9Q@mail.gmail.com>
Subject: Re: [PATCH USB 1/2] usb: raw-gadget: fix return value of ep read ioctls
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:43 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Apr 24, 2020 at 03:09:58AM +0200, Andrey Konovalov wrote:
> > They must return the number of bytes transferred during the data stage.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> This was my mistake.  Please add a Fixes tag.
>
> Fixes: 068fbff4f860 ("usb: raw-gadget: Fix copy_to/from_user() checks")
>
> I should have seen that bug...  I thought I was being careful and I
> even singled out that part of the commit and mentioned it in the
> commit message but I messed up.  Sorry.

No worries, the bug was actually present before your change, but in a
slightly different form. So FWIW we can also add:

Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

However raw-gadget is not present in any released kernel yet, so need
of backporting AFAIU.
