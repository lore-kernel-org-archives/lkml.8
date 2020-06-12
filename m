Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C31C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB352078C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2i7UIT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFLDUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 23:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFLDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 23:20:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A4C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 20:20:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z1so6191963qtn.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+yD7ZB4hsM8qhEU9lec/skmL6DmzijWeewUvhB26PdM=;
        b=i2i7UIT91hsDSYLJGFv0cTL8x9X38MwzzxrU4uemvyQ5jG83MPAEPEVxpm9vgWXjG8
         CPOVtq66EJiTZxtxIu3vxSlbSfXNPYmocnn0wfAg2w6rY+RZCdflcqxMxErRODxlgawK
         dZ3418AAawe8Mr9bPvjqneKwzyUCnvE86pZ6y6DJjk9hZADgEtP0+SILFtK+1DDBizhA
         irAjYgChF96XjCOPwS5bkfU2NqmoSRreg/9MaoFZa3Cl99QpiL+sU6vOIpA6UvnpSHus
         8cQ9HsVCS+cB/XeqzO7IaOnqeQPyJ65ouUD67t+wLXMOjkPmv9ny5+bLeZ5XsiVNPH5b
         RkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+yD7ZB4hsM8qhEU9lec/skmL6DmzijWeewUvhB26PdM=;
        b=jFzYoSJvYlQeXh42yjZH7eni6rqhN9xsnHZw/BNkcEXyx3A7mc4iZXj2lOZI6zUL3h
         BaZDt7zvzXSDZu2UsVF2exW6l4CDZF1eF5zr/IVMtWD+b2KEErF0VTLugdOfIioXgn9C
         3/K8WM1g3cfZ4acDEprc3oZZxcznY9beJnVrAPEgb+ldbQxB0+pyCuPYFTaQl2ok1yfN
         wMV92140Cl8XhN4FAdEujPLDjXnMLDT5x4uLv8CVGS28m5DIA+ULSbLTRspCyHGBspBc
         P/3+SSX5ovGdj4FY73sBYj61ATZ29K/fJecVX77TeFL9/E6TPzdr13Fcn6vDBSbsLjuZ
         GoMQ==
X-Gm-Message-State: AOAM530akZH6oJRY2+XLHtv1k97PluElOfB4DsKH/KitPHqVNc04B+Ht
        9rMEKnBiIYTk2SXSnP+KryROX59Ce+UgCS00MSc=
X-Google-Smtp-Source: ABdhPJwlq05oUUzSr2iXDlthywXBELjgP1Nr6qJereipQfYBcjDhATYTFeZzP+9MDq38iAQgorplrQKX3BZsMIOxeMw=
X-Received: by 2002:ac8:4cce:: with SMTP id l14mr1148401qtv.35.1591932009842;
 Thu, 11 Jun 2020 20:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org> <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org> <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org> <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org> <20200601204424.GA212944@cmpxchg.org>
 <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz> <20200604150539.GA322130@cmpxchg.org>
In-Reply-To: <20200604150539.GA322130@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 12 Jun 2020 12:19:58 +0900
Message-ID: <CAAmzW4NVoViiGzDx_7fFi-ShhbkB8PXHHSK=Eaa3D7vfZGGFNw@mail.gmail.com>
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 5=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:06, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Jun 04, 2020 at 03:35:27PM +0200, Vlastimil Babka wrote:
> > On 6/1/20 10:44 PM, Johannes Weiner wrote:
> > > From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00 200=
1
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > Date: Mon, 1 Jun 2020 14:04:09 -0400
> > > Subject: [PATCH] mm: workingset: let cache workingset challenge anon =
fix
> >
> > Looks like the whole series is now in mainline (that was quick!) withou=
t this
> > followup? As such it won't be squashed so perhaps the subject should be=
 more
> > "standalone" now, description referencing commit 34e58cac6d8f ("mm: wor=
kingset:
> > let cache workingset challenge anon"), possibly with Fixes: tag etc...
>
> Yep, I'll send a stand-alone version of this. It was a bit fat to get
> squashed last minute anyway, and I don't mind having a bit of extra
> time to quantify the actual impact of this delta.

Hello, Johannes.

Now, a week has passed. I hope that this patch is merged as soon as possibl=
e,
since my WIP patchset depends on this patch. How about trying to merge
this patch now? If you don't mind, I could send it on your behalf.

Thanks.
