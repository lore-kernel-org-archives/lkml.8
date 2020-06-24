Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6813C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsLANbH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406405AbgFXUXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406361AbgFXUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:23:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F0C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:23:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so3709798ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3N8Iq+jMa7Wr2bmXCR98pNboSajMlgVPuPMQP9CFTnI=;
        b=gsLANbH8oUM6Oqn4g+49U/gczDfj3IaDXZ4bdqAM970FR1Kzectrc0SAtNLpsQY0LF
         JrlPKLo+goWwEjS3lM+M4CiRFku+WAyJCHeZKt8JxtukWcMI1AlskIDY8bRU6xfll5JQ
         XEvJ7WrIDuTPmB/Q+e3RtTXXOV9jZMPybKMGzBGZdgkOAofL1rY6yrLx0AkYkFvl0LrR
         vM55HjIBf9SnCeu26+5a4DmCplfZH797uDptMTtp7UwjTGM0qKFaPsGMDtD83p29fAPd
         g/7B9Efx/ARDqWtNzohLVDa6iG/gtZ4PBo3rSCtCXq7uMEp+BNPAZ167Fdm/Z/uvTmum
         NzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N8Iq+jMa7Wr2bmXCR98pNboSajMlgVPuPMQP9CFTnI=;
        b=n0BEVNZy1nmIEmhepSYbjotKKV77P47jwycWVvh7R852Hz/Tk6pFt30kvxEB34CLTF
         IlwanySl0ekjib2Q9eOx9pf9/wQFaOdlo7zZIrSOxgzy0A0ocK1dKqsqd3/Td54V8tz8
         +RUJ947JQJ2eRsLBg8A28bP3I1q2btVPnwXO1TbbuToKEJm1Alxnw7hq2FhcBZfvQR6W
         mWctSVq4eyQMX9wDdUIZeeDkupTA5avgy2c0QT7WPuEZ0OVS+gkoPl5mrAaGzID+eY8y
         /QWcnHMbtNrJKXOfKGi+el1cUvzEZLz8hZS7PF4ThDNyhWT4x/6ek8WNToMZY+hwKoHX
         dV+A==
X-Gm-Message-State: AOAM532pDMTTQx2Z5k39bXovAUPKQzm8dkk+nM+M5Hm1FYhzBkIBTkOd
        qkhzVPCvdo9MZ/PdUuf896LxgBVoDOFbW9gpQ0o=
X-Google-Smtp-Source: ABdhPJyZ0A3i4KIhrEMZ2Pt4CNQKY0ZyDPCM7n8IH+lqiA4Y4W2gkj1dII1B79yKWD+r3QyLP7FE2RgA1MTiJtGowBs=
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr18819307ejb.79.1593030194663;
 Wed, 24 Jun 2020 13:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200624191417.16735-1-chris@chris-wilson.co.uk> <20200624192116.GO6578@ziepe.ca>
In-Reply-To: <20200624192116.GO6578@ziepe.ca>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 Jun 2020 13:23:02 -0700
Message-ID: <CAHbLzkoy2kz7yirch7t9ruzJjNTyCCZHJFZst7OEz_DdmQyaaA@mail.gmail.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> > A general rule of thumb is that shrinkers should be fast and effective.
> > They are called from direct reclaim at the most incovenient of times when
> > the caller is waiting for a page. If we attempt to reclaim a page being
> > pinned for active dma [pin_user_pages()], we will incur far greater
> > latency than a normal anonymous page mapped multiple times. Worse the
> > page may be in use indefinitely by the HW and unable to be reclaimed
> > in a timely manner.
>
> A pinned page can't be migrated, discarded or swapped by definition -
> it would cause data corruption.
>
> So, how do things even get here and/or work today at all? I think the
> explanation is missing something important.

The __remove_mapping() will try to freeze page count if the count is
expected otherwise just not discard the page. I'm not quite sure why
the check is done that late, my wild guess is to check the refcount at
the last minute so there might be a chance the pin gets released right
before it.

But I noticed a bug in __remove_ampping() for THP since THP's dma
pinned count is recorded in the tail page's hpage_pinned_refcount
instead of refcount. So, the refcount freeze might be successful for
pinned THP.  Chris's patch could solve this issue too, but I'm not
sure if it is worth backing earlier once dma pinned page is met. If it
is worth, the follow-up question is why not just skip such page in
scan phase?

>
> Jason
>
