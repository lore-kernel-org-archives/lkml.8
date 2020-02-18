Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B72C3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0C1206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d8rO57ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRWHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:07:24 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:39748 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:07:23 -0500
Received: by mail-qk1-f182.google.com with SMTP id a141so11284504qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQRm1HKqg4sASSbmlX3eEfnpvyJBvoOvTDtyKNLsJkE=;
        b=d8rO57ZZm8lN08wS4tLy2bFm+IjvouIwk9nD2MtDefIhDnAvgZKD06Lg+ScC9+1hTu
         Y9ZofnZg4TZHRXc+UlhawT32J7WHc1KlTUIIeJsB8/GVhqi23XnAKZBIDU4T9RBVhquC
         A8+l/wkkph4Rg8o73Z6EHG9VLGEMbuJTfhVCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQRm1HKqg4sASSbmlX3eEfnpvyJBvoOvTDtyKNLsJkE=;
        b=rL2Lg7Zy6jLf6CDMesYLlJqL3h77zoWLsSkceb8yWO7RMUlL1WFjZRg37kEhRx2V6f
         lfKA1ok2+cQxQVgq0gXbr+IGSOyXXufAHE7qu1XKkCCfuHgLubPz1FylKmWrY2S3GX9n
         NKGCSsgZfZvou2h29LBE6pREfiPphdSQinQVLC3kNknMF5pt/MgCzPO9ikcKo3oqom7h
         ThKELxOxfU+ctuTo6zW/zPf85jBMduL5k6EnilsjOVQ+g8BqvnuI8WvU8t05GWRJu1Q/
         uMq+rB8MrcmpiWI39cawYE37oLDMlbAe1O+dP4XAvMvuUUpMKbIDJAkYwfi7aVCFfCUo
         glQg==
X-Gm-Message-State: APjAAAXLPfIjLUdgglmo5E833aYDgqkSSMMWHkqzzHX6S4Ek4g7U8XHK
        LZhaBtSFs4xkjUvFIZnOegeDl2NEz7g7JXbEbgAV5axQ
X-Google-Smtp-Source: APXvYqx/RloPJi6yib7qwQgKX9OKaGanXcj5DEfO+iW1+CzNRhjO4luAjNZw4R5G3xGJlYxiCra2h09Tch8/cnbf1XA=
X-Received: by 2002:a37:717:: with SMTP id 23mr17581705qkh.34.1582063642335;
 Tue, 18 Feb 2020 14:07:22 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
 <20200211101627.GJ3466@techsingularity.net> <CABWYdi36O_Gd6=CVZkxY6RR8r4EKzEngScngT5VZc9-x4TB=3w@mail.gmail.com>
 <20200212235525.GU3466@techsingularity.net>
In-Reply-To: <20200212235525.GU3466@techsingularity.net>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 18 Feb 2020 14:07:11 -0800
Message-ID: <CABWYdi2sZGEEY-T=qyFOrtEGqo6+_Do+bfUJDSAcGhdJv1h0Ow@mail.gmail.com>
Subject: Re: Reclaim regression after 1c30844d2dfe
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I won't have time to try the patch for the next three weeks or so, sorry.

On Wed, Feb 12, 2020 at 3:55 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Feb 12, 2020 at 02:45:39PM -0800, Ivan Babrou wrote:
> > Here's a typical graph: https://imgur.com/a/n03x5yH
> >
> > * Green (numa0) and blue (numa1) for 4.19
> > * Yellow (numa0) and orange (numa1) for 5.4
> >
> > These downward slopes on numa0 on 5.4 are somewhat typical to the
> > worst case scenario.
> >
> > If I try to clean up data a bit from a bunch of machines, this is how
> > numa0 compares to numa1 with 1h average values of free memory above
> > 5GiB:
> >
> > * https://imgur.com/a/6T4rRzi
> >
> > I think it's safe to say that numa0 is much much worse, but I cannot
> > be 100% sure that numa1 is free from adverse effects, they may be just
> > hiding in the noise caused by rolling reboots.
> >
>
> Ok, while I expected node 0 to be worse in general, a runaway boost due
> to constant fragmentation would be a problem in general. In either case,
> the patch should reduce the damage. Is there any chance that the patch
> can be tested or would it be disruptive for you?
>
> --
> Mel Gorman
> SUSE Labs
