Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F8FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E94C2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kAHhnY0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406022AbgFYTOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405815AbgFYTOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:14:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFAC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:14:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b15so5081338edy.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pD7cDE1pRowKa97y2ug2GlsIr3bcaoCdNkFbx1fxc3o=;
        b=kAHhnY0eUb56R4ip4fJPASLy3SH+hwX/PxeFsHJSjGIR00mREk7bx1tJXh56KfJOsY
         GMl/RMnHXXGehaZ5CBehhPdU+Wn55OnprvZUYlJ4I17H7n7qUfG8yVybz+3U33taaNWw
         EIBzhGyRuN7wBSJtrXKMiVsKc10CN8EKq4TlQmI/v5SNteIgDIuHKNOWaPeCgCy+bLwC
         Pc6/6B9Zc/NeeCWrJg35xtp2CNXX4eyrkDvBxqSS7sZjyz+fvQPggy3lGVWq1EJfR88r
         zz+vF7qI4HvyKTKAwGk2kKfonyPoVRaPU0W2jjF/IO8jLUWaG4owmJXIaAx51zLayYCF
         IUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD7cDE1pRowKa97y2ug2GlsIr3bcaoCdNkFbx1fxc3o=;
        b=bt+f2Gt28hFQc5YY2r+x5MYblWA/YmzMpfa4F/0sv4kYKYBnaYcYHtgyiGO9yjLHNg
         m1WrjA/Xpe2TIjncZuyWcAIoXSE5EvQXlyYVDJK6xjPzCooQXhlLHVbko7Uc6ak/BSrt
         98/B2nu+UKGySfafBgvy/GMZPa81miTfefEVq1bvQ05cN+VRUQZdSMIGievHLXoNS134
         gsCbnGgHoGd8cm2af30UrZDg4VlsXRim3/+t0+WGfpSDLbh6VIAc9NqXJq+DrACz50pB
         ZOp0AiPCxpZhn1aN9AU3CJmwm6schaBbrwM5uud21PW0k31BLMhtONy9IiXCNtnVoFzs
         POAA==
X-Gm-Message-State: AOAM533a7phVrlsz16GyykZ2H9OuMdKEi9M+ekTisQSWl38t3yuj+TKr
        EzEPswRHifmmIZuVb/4ECSlocHXAq9D+e8/K394f
X-Google-Smtp-Source: ABdhPJwBF+4tgJZEQxIu8g09LpmP3KY3mtsOD8kLQZvMUBINU09oYuesxtYvtDT3DUBp28CQyH/S4RxLZI9OlHqM0Ig=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr27675622edw.196.1593112485180;
 Thu, 25 Jun 2020 12:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
 <20200618211012.2823-2-nramas@linux.microsoft.com> <1592942295.5389.9.camel@linux.ibm.com>
 <39d66bdc-55be-984a-42a0-34d0a011e0fb@linux.microsoft.com>
In-Reply-To: <39d66bdc-55be-984a-42a0-34d0a011e0fb@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Jun 2020 15:14:34 -0400
Message-ID: <CAHC9VhRQru30WtA-CMeqq=0GBtZ-Ut20ecHwpYfbEu5qCFqgDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] IMA: Add audit log for failure conditions
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, sgrubb@redhat.com,
        rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 1:25 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 6/23/20 12:58 PM, Mimi Zohar wrote:
>
> Hi Steve\Paul,
>
> >> Sample audit messages:
> >>
> >> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0
> >> auid=4294967295 ses=4294967295 subj=kernel op=measuring_key
> >> cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0
> >> errno=-12
> >
> > My only concern is that auditing -ENOMEM will put additional memory
> > pressure on the system.  I'm not sure if this is a concern and, if so,
> > how it should be handled.
>
> Do you have any concerns with respect to adding audit messages in low
> memory conditions?

Assuming the system is not completely toast, the allocation failure
could be a very transient issue; I wouldn't worry too much about it.

-- 
paul moore
www.paul-moore.com
