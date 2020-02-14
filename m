Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C0C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7920661
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLkolRJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBNEMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:12:54 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40252 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgBNEMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:12:54 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so6962744ilr.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 20:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gq/vUPgxiC7ymhK3gOaZqEbiZ00K1BjhwYNXIEgf4n8=;
        b=LLkolRJJlPVXwr74tzRQvftDulWmwUvvE4BTY3lOoQdW/ePbq3G9oetTN1dp7mhWrN
         UGlmmQSuMzsutFlW3qXIZF73o3UKIQO+PeAojfbxxdrII65JSSBHcmS1kgmRRMu7Yy+2
         r+XjvxbaBX+RVKxkw+P4D/lvtMagcKSyhludzNCTkhFC5P9g0UkziPy11DBS2Hx5+tmo
         l6+iEhGjrH8h10LhtY1Q0q/K06sigmVtGXohPLIYi20u/JFcj77+FHvX6zsPDWdmLxal
         E0L2DyDeAv/aYLLpO6YfzduCItO35+J+1ij7ew1HLu5u1Yd9jDI7iu+Ys4jZakEmmW9n
         7+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gq/vUPgxiC7ymhK3gOaZqEbiZ00K1BjhwYNXIEgf4n8=;
        b=eBz1vF4pAtk4y9SdJsEfVtBsSbJ4iUt4m4OsHsMX6oE4h/KSd4xkf/8yXZq8j/ibR9
         yiQkRPbY28UxZ34neoTGcMsuaLLz7Ghg8GHdimg5TlYyQR7ZvcfoG78RzdZbv538hJlh
         hHZctxzaL/TLckO4HCkfYwv2zyyGkvHWJZIPmewCi+0QNGJgFv83roIJ971dzMTEyOPx
         aOgWoce7tNbQXhxnLoV2cxegksFiqQ7Rwq9DzPRaztN8S4lOeAedxPOq0At5NpczO+FC
         cLqrhFG7PLvRKRs5hvavo+93X2MwpzDLOiUKRfu/MJAFHsFYWzVBx/ITXXZOWfAR8Al6
         w3Pg==
X-Gm-Message-State: APjAAAW9hxDlrhob/S7VwkMv5yWjvAViBI4Oqm8C1DdQxRKkcBpm9v2H
        g5simCOTM0w+LrFQ105cOteu+S+boYwm+FOsXGY=
X-Google-Smtp-Source: APXvYqw06bOeQTlcsHegd1IX50YN+9LrbIsMztC5QZl8tAsd+2eIrz0U4Iu2wqqeHHqiqSaS+6pd1k72YgkZhgt7Vic=
X-Received: by 2002:a92:5855:: with SMTP id m82mr1153192ilb.302.1581653573254;
 Thu, 13 Feb 2020 20:12:53 -0800 (PST)
MIME-Version: 1.0
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 14 Feb 2020 13:12:42 +0900
Message-ID: <CAAmzW4OepnqB7QupDV2v9=AnEg=43ygn01=y8bGWrjgEV=JBTw@mail.gmail.com>
Subject: Re: [PATCH 0/9] workingset protection/detection on the anonymous LRU list
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 2=EC=9B=94 11=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:20, <=
js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Hello,
>
> This patchset implements workingset protection and detection on
> the anonymous LRU list.
>
snip...
>
> Note that, this result is gotten from v5.1. Although workingset detection
> works on v5.1, it doesn't work well on v5.5. It looks like that recent
> code change on workingset.c is the reason of this problem. I will
> track it soon.

Problem is fixed now.
It's due to my mistake on the rebase.
Replace "mm/workingset: extend the workingset detection for anon LRU"
with the patch on the following link.

https://lkml.kernel.org/r/CAAmzW4NGwvTiE_unACAcSZUH9V3tO0qR=3DZPxi=3Dq9s=3D=
zDi53DeQ@mail.gmail.com

Thanks.
