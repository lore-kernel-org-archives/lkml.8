Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B40BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D792075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dYNCwrc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgE2MeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgE2MeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:34:08 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939F4C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:34:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l1so759322ede.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPeigCK2KYvMiq+sG6KOj8Q7ndlYO2BcnUQP68RJYdw=;
        b=dYNCwrc6IlS6OKS+HOUMs4HsVIYIFLl3Gqz0TZPCqS9Ciejf3uEtVff4+mgBC61GXT
         NJ/hJPkBr8k58Qzihx7KUMfArdD71UUqclR2W/iM9FLIOLjMEXLVyv6plFqv1dWzEWQ9
         /hOfJz1qPlzSRqe7UWMHr1HOday4CmE9WpEpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPeigCK2KYvMiq+sG6KOj8Q7ndlYO2BcnUQP68RJYdw=;
        b=NqDf/jIrBQfa6uIJZ3/+a1+Q4jTea+mry0hXCWpvdWhxe2/dbQ4e4ssntXjkNMndv4
         jhz1sAB9nn3HmVOECNvfgnMZmhj6x8/UK9h1oa/f0N5N+5rfwrbbKdMMZtkqa9C2iszP
         PqmQS5C/T30jjnrVuDNtHRJkE+fQEFpNWA7XPU9HV8p2FUE8ap3493nkCISyS+piysG9
         3BzJiO3p7xfSXuZYd49Pb5MA0RXKriIaJs4WDEcfbAPn+P/1MlXTpXREdR/Hu0z5LGBF
         F9qnPgl0QbSxZU2M8c174k3gfXLq82lfL+SHvJDRJ+X0MM5UYbcvC7tKtKZmamAmpLPv
         nN2w==
X-Gm-Message-State: AOAM533+g/ptCtILy4VNRqngHqBS45URfUGwBRD9pi1FrsGvSs7mXrQp
        M8RuPTKkFd4aYxEar19dBpz2GN9qnol/t4qskP/Kcg==
X-Google-Smtp-Source: ABdhPJyUnTM45zN0/5rNoZumMBq2dmAT3t3ZWSRcUjdBPA2OW7R/LUnUGuKWy/5vRX1XdxS74d3SlLrqc3MOIkpgBnE=
X-Received: by 2002:a05:6402:17f9:: with SMTP id t25mr8224125edy.134.1590755646368;
 Fri, 29 May 2020 05:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegstNYeseo_C4KOF9Y74qRxr78x2tK-9rTgmYM4CK30nRQ@mail.gmail.com>
 <875zcfoko9.fsf@nanos.tec.linutronix.de> <CAJfpegsjd+FJ0ZNHJ_qzJo0Dx22ZaWh-WZ48f94Z3AUXbJfYYQ@mail.gmail.com>
 <CAJfpegv0fNfHrkovSXCNq5Hk+yHP7usfMgr0qjPfwqiovKygDA@mail.gmail.com>
 <87r1v3lynm.fsf@nanos.tec.linutronix.de> <CAJfpegt6js2WK6SjSZHsz+fg7ZLU+AL6TzrsDYmRfp7vNrtXyw@mail.gmail.com>
In-Reply-To: <CAJfpegt6js2WK6SjSZHsz+fg7ZLU+AL6TzrsDYmRfp7vNrtXyw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 29 May 2020 14:33:55 +0200
Message-ID: <CAJfpegtH7C0cu2iPv8gLq5_+=U3-XWZ3XRsP64h6Gbx-qqyZTQ@mail.gmail.com>
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 2:31 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > Can you please describe the setup of this test?
> >
> >  - Host kernel version

5.5.16-100.fc30.x86_64

> >  - Guest kernel version

75caf310d16c ("Merge branch 'akpm' (patches from Andrew)")

> >  - Is the revert done on the host or guest or both?

Guest.

> >  - Test flow is:
> >
> >    Boot host, start guest, suspend host, resume host, guest is screwed
> >
> >    correct?
>
> Yep.
>
> Thanks,
> Miklos
