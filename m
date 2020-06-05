Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFB0206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sqcvTJCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgFEUtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgFEUtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:49:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227BC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:49:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x93so8448830ede.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21Q9/cXvccHpfKM5LJV8/84Rguo7Ngf33rA3ZIRa5vs=;
        b=sqcvTJCeVrWypB/+l+MMABvt/tV4gk+UOcn117JmtbQTP51NyXkUXKf2Prk5sIyncf
         HZO+JH/P2bkvCU3MnR4gYluBkZiySlU1+V1L3b+Ith0tbtKvUJlUwMzJcxEbxdQ+zAHf
         cZ38i/Z/j3e9ouUixxMOfm6mthAcTEc0GF6O/yg3tFxUUNx3WmaRGX4ej0WbArcaxl88
         FhNFZ5psvs05EKcJhSFeCaR6Ip9ZmbrDIpvOxkSOpaeU3+r2vGVDGise4cL+DMMtmBEt
         WaMGiqMKGXOzP4UeujYsrAF1B916+Xgwjvh3X8cYR4hig/3EN3CZylV0vJyn8APrYscz
         I8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21Q9/cXvccHpfKM5LJV8/84Rguo7Ngf33rA3ZIRa5vs=;
        b=O8QnWNTqLM5rUv9LTBZGHMKdUGjA8Odyuesekwoszc3MVAugvWwYF+U3Q2qor8cHks
         ahalInlA96d7qPF0q4rRqO+j5x0FjT3x96nqcj/Se1hc0G+K3RJ1nNivVEnAqLWd9UqK
         mVrLPBbL0SBDwu9yTqjrf12CIRkqIoQM4oKgAWOvWRxK4uBIxGUsxoWbl5wG0otCC12W
         MV5OeNid/2ZXZX/EAmZsKwYUd8y0Y3Ms0Wgud0znreB49Zlx9Li0c3gRO3dDWYtg3SvL
         FNzs5FrFB25jaBhDPR6sj7a9VtGgTbnSPKQGB8ENY71jQeHPL2nOAW88qCI2W7WkNLN7
         FBGw==
X-Gm-Message-State: AOAM531HSBIbatkshblCQ796aONy7M3+iwGVhYcaDWFoOYlHBiDwNkS9
        t3PmNtRwslOVzCGG06M8Lpzq336rxzklfFgEuZvj
X-Google-Smtp-Source: ABdhPJx8T/cpE+4mff+a8QGPcmAGE5mv7vBpaH31a5ydwUTia6v9NmR0TJm+SgSptgqBn0B9v/5hdv8UgtqffyiA2r4=
X-Received: by 2002:a05:6402:1d29:: with SMTP id dh9mr10952923edb.269.1591390183122;
 Fri, 05 Jun 2020 13:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
 <1591382782.5816.36.camel@linux.ibm.com> <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
 <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
In-Reply-To: <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Jun 2020 16:49:32 -0400
Message-ID: <CAHC9VhS8gmrWxt75aHAE16PWAay7sUrffZiT0A8VLugwexK4Uw@mail.gmail.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        tusharsu@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 3:54 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 6/5/20 12:37 PM, Paul Moore wrote:
>
> > If it's audit related, it's generally best to CC the linux-audit list,
> > not just me (fixed).
> >
> > It's not clear to me what this pr_err() is trying to indicate other
> > than *something* failed.  Can someone provide some more background on
> > this message?
>
> process_buffer_measurement() is currently used to measure
> "kexec command line", "keys", and "blacklist-hash". If there was any
> error in the measurement, this pr_err() will indicate which of the above
> measurement failed and the related error code.
>
> Please let me know if you need more info on this one.

That helps, thank you.

> Since a pr_xyz() call was already present, I just wanted to change the
> log level to keep the code change to the minimum. But if audit log is
> the right approach for this case, I'll update.

Generally we reserve audit for things that are required for various
security certifications and/or "security relevant".  From what you
mentioned above, it seems like this would fall into the second
category if not the first.

Looking at your patch it doesn't look like you are trying to record
anything special so you may be able to use the existing
integrity_audit_msg(...) helper.  Of course then the question comes
down to the audit record type (the audit_msgno argument), the
operation (op), and the comm/cause (cause).

Do you feel that any of the existing audit record types are a good fit for this?

-- 
paul moore
www.paul-moore.com
