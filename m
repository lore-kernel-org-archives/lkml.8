Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09559C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24EE2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591392334;
	bh=yhOOwBIhtfycOWi+URIcez4u8ytVr2Va4jBzn1ja3Xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qWKocG1NU9QkUIVR9EUyyoZqbhJNu36HAUanCv+mHVthuS3gMnR4S3znKdbXWScSc
	 9mQ07yBgCpkNmLcifKUloM6avsnEgNpaX8cgl2u2/7B/uUeAPF+hXSXsH4rVVS8T+N
	 9b9sY03GIyQM0UZkmlUu+6QDDxbgqKje8tPnbfvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgFEVZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEVZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:25:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF1C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:25:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so13431720ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=su7aBmgFp3s3EJEbluac4gd2OffM4+Zbo0KIh4RzQsY=;
        b=BFxg4A1iQISYNle2o8Aci5KXRtbIdPHwQx4ahwVCRIsqw7qP2LtsnzMGqouiwT/1Ne
         Gh+CpFuVtvi7JTd652vUpzoNdKMVixC6MQbw/ApfQeW6EMncuiHAV/EkbQ6FpIMX1Cfl
         cJDAMDEF6JteXq2Kw8YyEVH4kk1sJf5fPD26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=su7aBmgFp3s3EJEbluac4gd2OffM4+Zbo0KIh4RzQsY=;
        b=St+DOLakxMX0ey0xayGAEppkc28jdGjUnsAaeeL3Kid3SgpDkAayRorlSlv/SzMBMg
         EbbRdshh/oNqjiGY78Pd45MhKoM8EihZTDaUVLc/o94Qa1yqAD55HcBvlm/JilAc37Mx
         UqPPKi/5ZvV6J6v3soQovLd/z5ZiP2suNJrGVHYC9nMGPd0Q3+Do09SYk7XXcKAwXI2N
         W/0UjFyV+wdYHiDVh1JQGH9qqydqgXFuZBMwW2YJcH/pKjNAuAHYPVWxZklffL6wE8A+
         qsG3TD1Rbxqrge0F0dizCj37GUkJf7CIMVlzEWxfkxSI9ub2vN7tfS0cOkR3/+cE4rqL
         GUBw==
X-Gm-Message-State: AOAM5330hB6msnIe/x3i6X4muWgJvCX5/XRJ3S9DF9ddyIyPRvHokc7Z
        TRfEVRoI72miC/S2kzn0yZ6qWYnjJ+U=
X-Google-Smtp-Source: ABdhPJzvjMjNX32cLWdVV5qZ5L1dhfbhhCwjvdy/EE1YrFd25nAab9vmgvtMDfFkRINcRNRg7xAhSg==
X-Received: by 2002:a2e:854c:: with SMTP id u12mr5586913ljj.422.1591392331499;
        Fri, 05 Jun 2020 14:25:31 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id f12sm1197611ljk.44.2020.06.05.14.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:25:30 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id c17so13429086lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:25:30 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr5996890ljn.285.1591392329927;
 Fri, 05 Jun 2020 14:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <1591332925.3685.16.camel@HansenPartnership.com>
 <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com> <1591391891.4728.96.camel@HansenPartnership.com>
In-Reply-To: <1591391891.4728.96.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 14:25:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
Message-ID: <CAHk-=wjy8sMqjft6ALTo28UECex84uiYEo=BJbLUJ_CHrPmOEQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:18 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Um, no, shuffles feet ... I actually tagged the wrong branch:

Ok, now I see the changes, but I see more than you reported.

These seem to be new compared to your pull request:

Al Viro (4):
      scsi: hpsa: Lift {BIG_,}IOCTL_Command_struct copy{in,out} into
hpsa_ioctl()
      scsi: hpsa: Don't bother with vmalloc for BIG_IOCTL_Command_struct
      scsi: hpsa: Get rid of compat_alloc_user_space()
      scsi: hpsa: hpsa_ioctl(): Tidy up a bit

Can Guo (1):
      scsi: ufs: Don't update urgent bkops level when toggling auto bkops

Stanley Chu (1):
      scsi: ufs: Remove redundant urgent_bkop_lvl initialization

They don't look alarming, but I don't like how I don't see what you
_claim_ I should see.

Hmm?

              Linus
