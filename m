Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28470C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDA92075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvDQ4ptk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgEFUh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgEFUh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:37:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5CBC061A0F;
        Wed,  6 May 2020 13:37:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so4234779wmc.5;
        Wed, 06 May 2020 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PQJFoJ87sWErTNm0JkGMeGO3o6fQqvJbc6kV3H7rQsg=;
        b=GvDQ4ptkRjDmQFS1+fjeJgo7M2daHg+GNJJxq7tln10vXF8NOEsrgcPTMjf3FVVTBa
         /mgjfyAb//wio6wYuEytkzHhoRTzmGmF7/Fu+xfPUa0274kRGVtgVwMeCb8my75ifc+c
         GjHwHejIq8rXesH4JwxQnkHQiqwDy3JFZCkjMKBuTuBkGYzlDHpaAI0ecyUIh07KhImh
         +PfJGzocAjrqBjXPiKdtjNvU0iCNpx8ZtftNtrK6zxGGsHcYlLUn6T0vd8MQ2KRFUy9r
         LxW/5TmEcGGo9KR6XBFAWuTwtSqcgCdUntaVZB4l2xKNSkoilvX8X76j1CTOwWZjCPae
         ypPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PQJFoJ87sWErTNm0JkGMeGO3o6fQqvJbc6kV3H7rQsg=;
        b=PWML3xomUFHS8qvm1NhIBOYFfrp2Ef7X0wHKlZDzFjY4F4zEc8ZflHiksEsGC4RiuL
         7MjFgvBbFRu4Yyt8VYFK6qO0VXX9p11L9W8By9pIhIVGYCDRtIAILO1VhPXxvrc0cyuT
         Q2RUVi4NyW2XZagYZ82hsKs+tb0A/WncItV0p/igS38sHrIl6al0UChmUSPJz4gixDdS
         To8FI7v/2Hi3+4aIkWYXk+kft31UigBwIHZ9FJJmO1nGovmVWrEfnmoKvjOK11MjQa2y
         Lq53Ar4thZAQOIILaQZwBG9M66AeGlkoC7ZNVsFCFDJnIyZ1ynv5fX/K9huBHsd5/jzP
         QIoQ==
X-Gm-Message-State: AGi0PuZXgsiup2CrYsB4QPFvXd8MLXB2dpbeGKsBVpQ6oTDCEsxEXs7g
        3uMA0j7fKTiyHNlTUA7RU7c=
X-Google-Smtp-Source: APiQypKDi8twc0nfflr4h3paiCm8PJSLvSswEZpdnpDoMAKyXk0YA21IhpJ8Kw94yErIKcWgnt16cA==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr6259795wmc.124.1588797473769;
        Wed, 06 May 2020 13:37:53 -0700 (PDT)
Received: from felia ([2001:16b8:2df1:2500:444f:2681:799e:cf0b])
        by smtp.gmail.com with ESMTPSA id y3sm4323742wrt.87.2020.05.06.13.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:37:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 6 May 2020 22:37:45 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MAINTAINERS: Wrong ordering in S390 PCI SUBSYSTEM
In-Reply-To: <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2005062232330.23358@felia>
References: <alpine.DEB.2.21.2005060741520.7719@felia> <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 May 2020, Andy Shevchenko wrote:

> On Wed, May 6, 2020 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Hi Pierre,
> >
> > with your commit de267a7c71ba ("s390/pci: Documentation for zPCI"),
> > visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS
> > complains:
> >
> > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > #14723: FILE: MAINTAINERS:14723:
> > +F:     drivers/pci/hotplug/s390_pci_hpc.c
> > +F:     Documentation/s390/pci.rst
> >
> >
> > This is due to wrong ordering of the entries in your submission. If you
> > would like me to send you a patch fixing that, please just let me know.
> >
> > It is a recent addition to checkpatch.pl to report ordering problems in
> > MAINTAINERS, so you might have not seen that at submission time.
> 
> Why not to send a patch?
> Same for the rest of similar mails from you.
> 

Well, the checkpatch warning is new, so I want to find out if and make 
sure that the involved developers are generally okay getting those patches 
or if there is a better way handling those patches to MAINTAINERS.

I do not expect that there are too many further cases of this warning 
appearing soon in linux-next now that checkpatch already warns about it.

Lukas
