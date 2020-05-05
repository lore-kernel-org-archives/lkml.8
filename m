Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70702C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7A1206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmrkkpj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgEEML4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEEMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:11:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4264C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:11:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so807751pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abv/7rhr/v/5ghsi0YL/I2pl8CswRSslzBuSGDsjfH8=;
        b=kmrkkpj4xzNc32kOT660UnZdVO/0XEF5w66zC5Rot7YZVN2KcAGY1hk8yWJOh0Pnp3
         wRCVTqARax9kslvfxY7YHmT9grw5/nt5Q3qXpUGg1fFZEB+ce3QiEO3A1EKp5slIJoPJ
         vyIq0Bnxj+MJezpQtGDmv+nF+FUFU/Vs3iTGMhzcdyieubsPPCEvf5AEaGQbCsonLD9K
         n0Puj9KqYj+mny72+bGRhGpd/x0oQocn83HaK6Nm0lkIoedqrs6O0U/x8fLKhfPPP44i
         U34HWnAr92OwhN4S/9wIQR6pzejqNEuSDCwjk1KPJ8dkVvk/ppzRAbyGOOGvf9advrGd
         g12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abv/7rhr/v/5ghsi0YL/I2pl8CswRSslzBuSGDsjfH8=;
        b=sDIUBqK20ZBMQE106DVPccEqgSrxq7i2fPpjCvFh8MFn9/Lsx8PhA7JbvN2XnKuPKb
         3Phsro71G7rLSzZj8cufN8iK/OLxqJ77cup8i5AMGTvSqZncm/gykZUmvhqbujBYs5qE
         veLMwJIMI11SpjZQmQtDA1f2kGl7YpWeK6Xmz6wn3QPVDGct7C0YrDFYMew1qnBscpzy
         0IrQAg2etJGnySEQoX4OOvFSbrG1jpHz4j8mwZOdzendF0WXKaIGg50VRmlKuM8zdYwE
         dqUneg9csY8cuDInfMHVOZooPNOcEYFmWbcaxqHQbRIxWt/281hKnWJ2m5mSww7+AWO/
         ddUg==
X-Gm-Message-State: AGi0PubrRj7E3RO94mkTSLGrNgrsneMmLsJGslBPvdOBEYBJccfGRWK1
        yTKL4VQjrHilEjXTUTaXiVGGkHRCX5hkOn2j/FwYgg==
X-Google-Smtp-Source: APiQypK6cLjJ6Cd0LA0LqazL4l/v2Dyby2+2IAMcClxna2t+ak4c4LjEk2+b4TRMe2nm9/zA6fdae8mSTiT4PyV0ylc=
X-Received: by 2002:a63:a61:: with SMTP id z33mr2654097pgk.440.1588680715004;
 Tue, 05 May 2020 05:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
 <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
 <87y2q6akhh.fsf@kernel.org>
In-Reply-To: <87y2q6akhh.fsf@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 5 May 2020 14:11:44 +0200
Message-ID: <CAAeHK+y=d_Hu1mwGifYuw6GRSBR=zncGCVOeN6GobP3L1zui=Q@mail.gmail.com>
Subject: Re: [PATCH USB 2/2] usb: raw-gadget: fix typo in uapi headers
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 9:50 AM Felipe Balbi <balbi@kernel.org> wrote:
>
> Andrey Konovalov <andreyknvl@google.com> writes:
>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> return -ENOCHANGELOG

I've sent v2 with changelog shortly after Greg's response. Would you
like me to resend all raw-gadget fixes formed as a series?

BTW, to whom should I send them, to you or to Greg? I've noticed that
some of my gadget patches from before got into the mainline twice.

Thanks!
