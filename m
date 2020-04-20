Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08546C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3EF20A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYtRrZdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDTKRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:17:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6CC061A0C;
        Mon, 20 Apr 2020 03:17:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a22so4214176pjk.5;
        Mon, 20 Apr 2020 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQwBgtUGJlKMOa45Jn8Rf9aNt1TP9LL5RxpacDSa9OM=;
        b=HYtRrZdTeb5v2kfEkCPR+6rQT5fP8Y3gaiUuDtIE3OAsBfF7sVTxaklMTAYnGn5SKW
         /xGeJGtrSZEaVdHl+gwf9cJGAZTspn5YbvOFqDszdKafBXZBoYgsjnHKXm1yyvcMRZ23
         XbtfAnI8AAy3UW8SXzTQT/R1KdigVxLnsZ7cnKlFt7oawbLvZPNdXjhfP1TGHbrI87gU
         kp1atExvEggE1ZhWy1HI/Z5KOTKe5R/rYmZB/BlHiQ8W/cklyVqrRWAZghT8EHNHZe6D
         tGzK/mXt5zcN4SSFhbs+smf44hpcCBj1v1F2pSjWxKrm0QxGXn5DTp4M+ChG7DN2qSQl
         IoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQwBgtUGJlKMOa45Jn8Rf9aNt1TP9LL5RxpacDSa9OM=;
        b=JXz66/Y7F0G0WydGppYPwlcG/9EIPneu0nyCKic3ed+MIsJhSJGD4cDFSrISnY020V
         jIReNiDg6KzD806seW54Rq27s4y9klb4NT+lzrxX9xoNnxTP1oH2qt1Do0YUqnT5T30U
         LtKGipmXKN697l/F7O6TMaA9OU2NljDF25FqHjgkBLxOBcsjnc8WV3eqUFb6E1eczMdW
         CZZI+ouLjPnqQDxaFYCNXoYrgv9+aeewAf5Ckuzo3eiQZgslM+76yvtznaddDfok5bAZ
         mHC3CS7WyU8ceGrTmdAlbT1BY9SYqUK2TqsF60NMBueLu2K7Q5m5Juz+I8X/9BGOVV+a
         lzCA==
X-Gm-Message-State: AGi0PubJlYjKCKYZ3db+P/+IbdEiEqmZmF+EzcFqH2+umDrkHYs/9F/+
        QWPVXwmx1U9vIRLB1ZFH9BwgzVdm4chfkeyleoOGHPlSG8E=
X-Google-Smtp-Source: APiQypJj+uMW4TOJ5C9KzBmk/r05SyMy64CzHhYWv5u+jl5v/HYHaaiMN5M1jlvGcee7bIhVmuCv75dKPdRzCm/3LNQ=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr20434411pjb.143.1587377824736;
 Mon, 20 Apr 2020 03:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2004201122490.9739@felia> <DB6PR0802MB25339A9DFF7F87CB06158476E9D40@DB6PR0802MB2533.eurprd08.prod.outlook.com>
In-Reply-To: <DB6PR0802MB25339A9DFF7F87CB06158476E9D40@DB6PR0802MB2533.eurprd08.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Apr 2020 13:16:57 +0300
Message-ID: <CAHp75VeCWDB4VOyV30fFQ5YwBuKL=W62b+A2Pr3=zH-JmxsoRg@mail.gmail.com>
Subject: Re: MAINTAINERS: Wrong ordering in CCTRNG ARM TRUSTZONE CRYPTOCELL
 TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
To:     Hadar Gat <Hadar.Gat@arm.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <Ofir.Drang@arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:51 PM Hadar Gat <Hadar.Gat@arm.com> wrote:


> I was wondering why this patch was not applied.. somehow I didn't get this warning when running checkpatch.pl.

It a quite recent feature, so, if you are not running linux-next on
daily basis, you probably won't see it.

-- 
With Best Regards,
Andy Shevchenko
