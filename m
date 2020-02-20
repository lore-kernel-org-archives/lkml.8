Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0CDC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A97207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JG0tnAIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgBTXol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:44:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39451 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:44:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so6543195wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JND3fDcmDGV+LOuOc+MELgsbHkbd9A/S1d4P55At3V4=;
        b=JG0tnAIOd7aktwBZsysuBUFcBpECsP35+OXKFI70Zm/Jbyk8b7AKhlzsavPwe//lDf
         GColtgj2fpk01oMSObpUZi5Zu9tVZBdq65GfSYrJcu8Wl2T8UcEqtNz7Isi9bvA6LKfH
         hzfEY+38Jm7cCcamdH/aqMq92seb4XJ0No/NJ/O+rbqig5Xz9zrPE6IG4n8Ds3YWo80n
         uroJ95Ho2RX2BBMmOjyPpEVOl9GlQ7M/ryQNuje/rnB+IZKBKPLgKw/O17iKSCmutY0G
         0y3xk3F4epw87mQ6trjyyvoMJwkJS8EQfrqfhmoDjwgBZWBz6fcpsfGpzYDT5thcuwvc
         N3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JND3fDcmDGV+LOuOc+MELgsbHkbd9A/S1d4P55At3V4=;
        b=p0NYH1lQjQLgvbQEtYML2a3Tl2MN9Gv8Oq3KeGJda5If0i8LJyL8RIVQZFe5TbUVWD
         TDm3dz1AP3sI7m3thKyXvqmZ6bQrlGGhWELu5TCRXccn/pYAyS7Dmc0lWCwzwD1e6ilw
         QAUun7Fyv1c1ukWJPApdP8lwohekvz3/DzCJOA0Ewdsz7UH9ZoQulOFpglXqf/SSgEv2
         //QywGZ/ipVGOT4ff+li1Am76fHIB5omkjUoF2/442SSM6rv/osGL0kFzJ2iALcFl5F4
         0xfyTIycx/GQHzGdtYiqNgT7cvZ2Y2eRxFqVaSuA6aL3nMnyRDo0s87aBOsNTrMoNgU6
         ZpEQ==
X-Gm-Message-State: APjAAAWQPQnvvB/G8bId5ODt5xNEZCJ33Z2asupUl9LvppYYDQv+JCkw
        +rJEwYB8pvrTOvwWZMM38/Z3WFLLgC72cjEchsZc9pUGzYQ=
X-Google-Smtp-Source: APXvYqyEBpsj9nEa56zgIwEIS3Bvz2+c3Gfexs94e6PgMzrjyA2GWPzsjrN3KBbl1wSTBIfBcyq39yVDT+D0OUlHUXY=
X-Received: by 2002:adf:e692:: with SMTP id r18mr45012733wrm.413.1582242279439;
 Thu, 20 Feb 2020 15:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20200217145711.4af495a3@canb.auug.org.au> <CAOFY-A1nfPjf3EcQB6KiEifbFR+aUtdSgK=CHGt_k3ziSG6T_Q@mail.gmail.com>
 <CAOFY-A3q_pmtHKAoOJdbB09wy=dxs9SdpXjCsU1wBxU5EDHVmw@mail.gmail.com>
 <20200221101845.21c0c8c5@canb.auug.org.au> <CAOFY-A2ndGCSEDstOmXs-u1XjNsaj8wkLezYsMbzeZeVTJGC5g@mail.gmail.com>
 <20200221104328.0f897efd@canb.auug.org.au>
In-Reply-To: <20200221104328.0f897efd@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Thu, 20 Feb 2020 15:44:28 -0800
Message-ID: <CAOFY-A2tK5=eFt2AQx+FOjyHXQ85XE-N8gdbb49wJphjAAgFUQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 3:43 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Arjun,
>
> On Thu, 20 Feb 2020 15:22:04 -0800 Arjun Roy <arjunroy@google.com> wrote:
> >
> > I have a possible solution in mind, but it would involve a slight
> > change in the SPARC macro (to be more inline with the semantics of the
> > other platforms).
> > If you're open to such a change, I can send it out.
>
> Its not up to me :-)
>
> If it is not too much work, I would say, do the patch, test it as you
> can, then send it out cc'ing the Sparc maintainer (DaveM cc'd) and see
> what happens.
>

Certainly, I will do so.

Thanks,
-Arjun

> --
> Cheers,
> Stephen Rothwell
