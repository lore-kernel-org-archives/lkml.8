Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3FD20678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Mf9BRQkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFBMQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:16:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A87C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:16:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z9so1624504ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4Qy4wUhDH5Xhze+eb6ArM9+MXeHPXd6rx4E89Zh3o0=;
        b=Mf9BRQkSo6RI1cW7TTfXRtxfIGGr+OWwuRTQSEFJkxZdq4Vi6AF1nkBBgQ8oP/YhrF
         H0/nXoSFjW4KPwsL1kA2fb2AgZ89LpPodg7HdbKKDWIIsD3IvuEr+a0mtdy7kHzHROb0
         zm8QfBjLJ0rXB+3IaCAfH0tBnl4EatcsS1dapBK9iHchRPo70+L8M/VYAxHtQ1T6C/QR
         o0eOhLwXjLjdvhO0/2UDM1ZyLP59t9nLiZW//MtL2l2wIkRmM7+NuJ7ukJLTpvO64lhA
         2tSBsRSl57M8UnyJXUK7OBhuD09MGnodJIGo/dclKNC1CXJpmYRXCrC4M2K5J5O1lCT/
         C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4Qy4wUhDH5Xhze+eb6ArM9+MXeHPXd6rx4E89Zh3o0=;
        b=lHZuG8sLgGGXZwuYq+w2g6quL8AilGkc4/Lhz3zm64ieGl229BOdBvTUvw/dWuMD6Y
         qs/QBVWf6u9OmQYGlEP9yF5tNBXLbwf9aL77mr4FP5NSir3Yb2AWf2Cg1Wxq0qwykkWl
         hECPq691U6oP0xgOg6x8x0Sd62XGT4hy0KO1ekDloheMwYQmKsr1rlQkEvC7jsaR9BRY
         5GoeMumi7trRtO2BkVMhxEX9GtWLJ/1BtUh7CP77OFVMUi1oPPMZvg85x4HMfj3JDqaR
         +vV/BpsF+QusJxYuevKY480Hfp2LxRqWqIAAOFcuigkLEyY04DAFuaQBAeB0Hl+ySkUi
         01JA==
X-Gm-Message-State: AOAM531k7amCfeZeTpikoIGt7t0+DyWA7dEThM1s49LJPDpGFlITAb5W
        dMIDbQhyAlcYG+lOOc+n2KfWZur6wSrzn1y9+e3dFg==
X-Google-Smtp-Source: ABdhPJz/MQmaRwMBlZrBRQBj7nKunvfyDrbTxaAL2zsuQ89V/bYCS1lJwB4Isa1BAtyheXxEJF+wb59TAr/aT2U3gB0=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr12906405ljj.43.1591100174869;
 Tue, 02 Jun 2020 05:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz> <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz> <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
 <20200529152036.GA22885@quack2.suse.cz> <CAB0TPYFuT7Gp=8qBCGBKa3O0=hkUMTZsmhn3VqZuoKYM4bZOSw@mail.gmail.com>
 <20200601090931.GA3960@quack2.suse.cz>
In-Reply-To: <20200601090931.GA3960@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 2 Jun 2020 14:16:03 +0200
Message-ID: <CAB0TPYGCB+EUPOz61Hc6XpozN04N4Jro2FbkcTTYOOmDr-bUuA@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:09 AM Jan Kara <jack@suse.cz> wrote:
> Thanks for testing! My test run has completed fine so I'll submit patches
> for review. But I'm curious what's causing the dips in throughput in your
> test...

It turned out to be unrelated to your patch. Sorry for the noise! We
have the patch in dogfood on some of our devices, and I will let you
know if we run into any issues. I'll also spend some more time
reviewing your patches and will respond to them later.

Thanks,
Martijn
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
