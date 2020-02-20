Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60EC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8669B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3hUqa9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgBTWUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:20:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42662 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:20:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so66696qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXSghIj+6eUXA0fUdp+CC/pbQYKBMOwALINbuE/AHck=;
        b=l3hUqa9EQy4l2Ws9u84yaXrybs0iWVUcCUcs3edZfdqwhfZJJAebtKZoscIxWW+Y4N
         pYzYUbE01u/9zADmBfh90wYCjD53jnjLCBhc0GiJKPiwJOc6HMYIxbWLg/p5vJiX4RYD
         JHyL+pKC2pBshEDCTAE6lHtq7MWuPEk61zPH6LAXPqYgOB+j7FlHr/RywJGJEPvHH9EN
         GQZdmnd1V7VBBAvc99AXKf814Aupzs/XeYnioSYR3hYcKcNfi36QoMb5PVadtSx/XJM1
         nWdljTxeSOACl2ZBPrG56S7vwUufdCgLvcKVzOAJf6jtlbMykSYqnB18hSqex59a3WSA
         elGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXSghIj+6eUXA0fUdp+CC/pbQYKBMOwALINbuE/AHck=;
        b=HEmVeMspQUAvQmhA7+S0B84TUp2ofeNkkHKW98mSsA2EpTnvZmsbVgAGl0DPsSWI97
         pJakwXx27Z/CpOZP7bi3aXwIvNYBhcdTeMlZ2VYEa7UypBceasVOuS2tlnLo9+lyad/Q
         79EmznozFiRjRYXS9m5TUDXl4NLRDqdHXZ+fSFSzip7oYqT5qEciPgK+xAibuTLcxzDo
         PUSoF+s0IpqtJWToCkOPWQ9WU/AOgPsA56HpaO1ZA6VllUnkPr6B7XTulB4miR6XqDWd
         oToH5oZmTzI1yPAymFR1FwTfIGacLJmoxQYACrqCF0c/oFYOwLx539m5R+rpWS8p1Hz1
         QbgQ==
X-Gm-Message-State: APjAAAW3hWJ9sExuyyy3bhsYt4yuB86+O9kvSxAW/cTbfrrbN6WXiyU/
        8+54WZdan12uVk9JiB8bVukkxiH2MwXO6HMYC74=
X-Google-Smtp-Source: APXvYqw0hsXO+eax5ndqQtMiBwjFYBFbkvAWtPLzA1LnMV6RDYWUqbS1Lvj86xyvNybA12frxJS+wZeijS/PLKjE62U=
X-Received: by 2002:a05:620a:785:: with SMTP id 5mr893047qka.149.1582237237248;
 Thu, 20 Feb 2020 14:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20200216161836.1976-1-Jason@zx2c4.com> <20200216182319.GA54139@kroah.com>
In-Reply-To: <20200216182319.GA54139@kroah.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Thu, 20 Feb 2020 14:20:26 -0800
Message-ID: <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
Subject: Re: [PATCH] random: always use batched entropy for get_random_u{32,64}
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 10:24 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> >  drivers/char/random.c | 12 ------------
> >  1 file changed, 12 deletions(-)
>
> Looks good to me, thank for doing this:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Perhaps also needs to update the comment above these functions.

Specifically the bit that says "The quality of the random
number is either as good as RDRAND" ... since you are
no longer pulling from RDRAND it isn't true anymore.

-Tony
