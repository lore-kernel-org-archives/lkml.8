Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6709E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFBDbRGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFVTUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgFVTUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:20:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC20C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:20:19 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so9492514lfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQGOol6oHmAM1Ng4z/uCNOq7Oann9kEoHMOFg8EwYLs=;
        b=IFBDbRGuOV6E9NDzvc7om4hzvpex+EGEmN8GTzzHydmrjGWlNV1uO2E/g0yWsPAWi9
         zjE8fuW1yOUP8g12Xuq00kdOTLqwSAJjTTg4ZhbhSNW78kg7QgBPir5Ap1BUj/a16o21
         J57EE3or5bby4Cv0SEw6LiqfvNQgXwWltI7MvZlT8kzMM3Tsk60+advzEk7PdkR7W8ew
         lAX4Uf72XIJc7hIEhbjko+c/4/DUWSRg2tWy/gAaZ6fE3lyf47k3iqQJVh4oETlneyHj
         rbyugQ5vCtpTGtNlXxITC7wQNanT6yfSqWFi8FTnk95apjQCxRAxuFuuW7sA49kDUMsN
         wbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQGOol6oHmAM1Ng4z/uCNOq7Oann9kEoHMOFg8EwYLs=;
        b=dCiynsxjXIVtoFTyG9XZDvI4zwC20JIHXytBa/fbrmV6nyauqts4ffBH7v/XxQnNST
         3o7rnhQYh7F1mgsDi2OCxP5zYflEkpsVA56UKCPh8OHJfoP8paypl+apA+H8egfYk5wm
         eAYE/AyAqUZJNuhWTAk1WmdaX5A8l6WhWsYDugAy7TKniBYxySs35g+QLilRoLsMIVJQ
         agmGZE/xY0AJNWEz41hO8OUT1uM1PpY3INkbJ9TjR012DimUfdxlPxcksp2N6CXZBFSz
         C7WhgJgPcVERxecyBuJ19FbmlY/+cXHIqivCmvaz1G1+f21ADfSYMjHePDwMyBe8YH5Z
         0qIw==
X-Gm-Message-State: AOAM533Eglmfo0byoDvdNbGyS19592z1Isjp//1IWKp0Kr3soSag/l8I
        t6o5Frq39hiWhP5SHWX3aUop2dSXyKbpcatNMpM=
X-Google-Smtp-Source: ABdhPJz4RZaNe5vITzo3tnXIR0fi+rJgtxh0xTAogXKk2pl7INIbw94pdlI6wWGIyDWeWTdqocO4Dka7MgKG6ttG2UI=
X-Received: by 2002:a19:b07:: with SMTP id 7mr10494968lfl.38.1592853617855;
 Mon, 22 Jun 2020 12:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com>
 <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com> <CAFqt6zbJD+k9xkV9Se0nL2qKfnea3mRrWJ4gzPmPJBquYk4M+w@mail.gmail.com>
 <fe2a1d23-7abd-86a9-4aec-2c14fb11cdea@nvidia.com> <CAFqt6zb8hK+mpqfrZ_QoGLO4nNfbHvZ7aJLRrcNRgDsywFHKqg@mail.gmail.com>
 <5a5133e6-b84d-a2cc-fcb4-db85c4e65d62@oracle.com>
In-Reply-To: <5a5133e6-b84d-a2cc-fcb4-db85c4e65d62@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Jun 2020 00:58:32 +0530
Message-ID: <CAFqt6zY0wGGL2gkL9Vi3udEp3xNUzUoGmuJpj_H1ff7EBYr-qw@mail.gmail.com>
Subject: Re: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:40 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 6/22/20 2:52 PM, Souptick Joarder wrote:
> >
> > I read the code again. I think, this check is needed to handle a scenario when
> > lock_pages() return -ENOSPC. Better to keep this check. Let me post v2 of this
> > RFC for a clear view.
>
>
> Actually, error handling seems to be somewhat broken here. If
> lock_pages() returns number of pinned pages then that's what we end up
> returning from privcmd_ioctl_dm_op(), all the way to user ioctl(). Which
> I don't think is right, we should return proper (negative) error.
>

What -ERRNO is more appropriate here ? -ENOSPC ?

>
> Do you mind fixing that we well? Then you should be able to avoid
> testing pages in a loop.

Ok, let me try to fix it.
>
>
> -boris
>
