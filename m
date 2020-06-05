Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50279206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591391541;
	bh=LOC7J01Oq/U8Jhk1N8/yzSzXoeUWCptQ70CQKe61Mbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Al3IEkoHfZvig1+DYYBvJ3rJu+psZuENg/5rnwPDLc00QpZl8N7ZLNPcyONoqymMk
	 4djFgcXb0dEyXRMGTZ8U46qXny5rjUlmYXYE1MUZmau0qeWtRsJJQa0q8tEOM9u108
	 BVONbrzFn8U+tYETlUZmAj33hP6TSy/lsLuVl91Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFEVMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:12:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB869C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:12:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x22so6640643lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14R55ZKvpOnzJ4vLF+zswvbqpQYyCsLayXmmbG2iU5A=;
        b=XWNgx39kpLgYRPFYKrRtzRIaIxKu+xNlnkkj7oOii+v2J8BaNUl4vfcqFKkJgW+CYY
         0SIp5PvrfN+ZmIp+tKX5xxQw8ODR52HX+tzB7Nz5b1tJk0QzsJAXFmHmEW79M35fXW2m
         Z0aMrpog04rXRODX/DlKFGTGvKoQbWh6YQhDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14R55ZKvpOnzJ4vLF+zswvbqpQYyCsLayXmmbG2iU5A=;
        b=b31GJwsfkYJpSWt+ODNYPG9nmb+mu7YNyBTzW8aTg7kWc7qi0nQ8wPSVtg2gcvu0cQ
         s8L5A2zCbRN7dQ73ne42rrlaJPTERwsnn7TU4Jd+t/2tqPWEU9uzKfX6Ntg/kLYXvvgj
         wx/CxM8WfsKqwXDJKLQwy574k8kGcvmPbdnz8oic0kx5od0S5hzBPh3T33lgxUw0hZuP
         QRMqgDpf0xnWOe0zDul/B83RLleoAqwaLeeQzGTmfqaJrYwfCFOKDKGp9QDMOUhrZf0M
         I1KwiYMe6YSMjo1dHK0XZdjPFj7uz/f5IsDYIpqcPdNjZnoRp62r7D0Y6e6b5ih+Vq14
         hl3g==
X-Gm-Message-State: AOAM5305WYnMYQ9oHaqoj5AGk5O+MUvxklse2x3IK55mzS3LYH4wwxMA
        H9WJ/CG2wws5+TzjB1kIt1idBU0NPfU=
X-Google-Smtp-Source: ABdhPJwVqd22cUiu6FaiHbca9DecIVPDeASyn5MOb/njDQ5VJI7A+JLG4L8cLMkphgGAQ1tqn7rcwg==
X-Received: by 2002:a05:6512:15c:: with SMTP id m28mr6327789lfo.126.1591391537875;
        Fri, 05 Jun 2020 14:12:17 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s9sm1193817ljc.43.2020.06.05.14.12.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:12:16 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x22so6640587lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:12:16 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr6221141lfo.152.1591391535762;
 Fri, 05 Jun 2020 14:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <1591332925.3685.16.camel@HansenPartnership.com>
In-Reply-To: <1591332925.3685.16.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 14:11:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com>
Message-ID: <CAHk-=wjiQmscZHzOYKmMpFoy4h4xF1Mvf9O8i6qtTtS38t6Wsg@mail.gmail.com>
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

On Thu, Jun 4, 2020 at 9:55 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

   "Already up to date."

Did you forget to force a push? That scsi-misc tag is your tag from April 10.

            Linus
