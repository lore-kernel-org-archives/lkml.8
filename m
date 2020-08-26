Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA26214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uuviY+HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHZOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgHZOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:47:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77411C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:47:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so3231437eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpXoOzxjmaSPieMUrMwjgj+f7eMHv3D0MiHLZevapy8=;
        b=uuviY+HHY4G/qSfupdmikJBac7QR65ENkowJ6J/jYfnCePd8Xn9EiwqHhGK6jIRITH
         a5Ep6mk1NvA/fuR+G8ichkTPQwvkzP/b3MyrRRTinYparaXT/281yKXIj/TpRYdqsI6I
         5g6azBhlombBDx76l6r3mMxwJbwbzZ332F9aN5vanV+W1jG8CuvLqfa45p36iPiLfgcX
         aFEkVindyv2dVZDV1qIptDPZ9WkKPuSIrA6dN4bs21tIv/aKU9gbU+RKZxkgnY6iIs4S
         ++3D7x6o/4rTIV7zlf0n6Xr4eWd8x+fZliorBKrrERgW/wA9Mr4GSs4fq3+oqfodZeNI
         dGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpXoOzxjmaSPieMUrMwjgj+f7eMHv3D0MiHLZevapy8=;
        b=a6cpsY2h/RJXh0yuraPVWYPYBv7lvVzUqwBOwWe+HHWi5DEqCtv9AK9QlMkcERGT05
         4bSXOWFk/3UKC22gwvrRQMBBM74Kfs/aw7sNPx9n+VXQBE9yIZPKOprEUM8e0u0R4YzW
         2NecLZtISF9Q/TrPKB0mSBTpn98yMXMuyfc1PCraZz3/pRi4kQBvPaIFLgHpA6l8/CQk
         kuK4hfFo1gTfqYVTbs1ZEOIR/0UzLgzGRgdCRMGK7krXPj6Svw71k2/JSVcr/XLS5/zy
         w6Oxdamkey3BaXyY15ZQsDSTTiC/6RSHyJ0nScrEW/L9c9cFq8tTewRnApO2qpx3Kv0L
         C2aQ==
X-Gm-Message-State: AOAM530X0B5N0lIvk/wEa86j0UdRtaoZ3RsQ/CwVotqml9Q7yFsvjLXe
        +NLnRyJmX+H8ZnfrWTnA2CmdE+7OISQQg9XMfipP
X-Google-Smtp-Source: ABdhPJwhDdM4MFlfS7uVJxwKo58ItpXS0jchBQaNhFwzkwJQ2+x5TiuLQ5UN8rBk15kg9aXEbq2ho8wi0ftQGSuFQAI=
X-Received: by 2002:a17:906:f955:: with SMTP id ld21mr766045ejb.398.1598453272483;
 Wed, 26 Aug 2020 07:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200826113148.GA393664@mwanda> <CAEjxPJ45hfBr6S1jT3iSOcSiccfWWFcqJC-q9R5qbRndT_DNCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ45hfBr6S1jT3iSOcSiccfWWFcqJC-q9R5qbRndT_DNCA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 10:47:41 -0400
Message-ID: <CAHC9VhScNuz0X610=ZjrH2-xT1Gz6y=AMA1=Eg=ubNxpM02VYw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix error handling bugs in security_load_policy()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:49 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 26, 2020 at 7:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > There are a few bugs in the error handling for security_load_policy().
> >
> > 1) If the newpolicy->sidtab allocation fails then it leads to a NULL
> >    dereference.  Also the error code was not set to -ENOMEM on that
> >    path.
> > 2) If policydb_read() failed then we call policydb_destroy() twice
> >    which meands we call kvfree(p->sym_val_to_name[i]) twice.
> > 3) If policydb_load_isids() failed then we call sidtab_destroy() twice
> >    and that results in a double free in the sidtab_destroy_tree()
> >    function because entry.ptr_inner and entry.ptr_leaf are not set to
> >    NULL.
> >
> > One thing that makes this code nice to deal with is that none of the
> > functions return partially allocated data.  In other words, the
> > policydb_read() either allocates everything successfully or it frees
> > all the data it allocates.  It never returns a mix of allocated and
> > not allocated data.
> >
> > I re-wrote this to only free the successfully allocated data which
> > avoids the double frees.  I also re-ordered selinux_policy_free() so
> > it's in the reverse order of the allocation function.
> >
> > Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> I guess this wasn't against current selinux next branch?
>
> patching file security/selinux/ss/services.c
> Hunk #1 succeeded at 2145 (offset 18 lines).
> Hunk #2 succeeded at 2263 (offset 39 lines).
> Hunk #3 succeeded at 2303 with fuzz 1 (offset 47 lines).
> Hunk #4 succeeded at 2323 (offset 42 lines).
>
> But otherwise it looked good to me.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

My guess is that Dan was using selinux/next, just not the latest.

Anyway, the patch is now merged into selinux/next but I had to do some
manual fixes so please double check that it looks okay to you.  Thanks
everyone.

-- 
paul moore
www.paul-moore.com
