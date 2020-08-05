Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950D522CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pIV877Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHETZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgHERZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:25:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61291C0086AA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:46:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so29500655edv.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3edvsdiBJ+dMkVwgYQe5b56g/OTwtECyNQldn00sS/k=;
        b=pIV877Jp9EOP/kj6De7JQRLtf8VLarGd/I50CrlfCnVlTSEvY4ZesiGKNPAJkMSA9S
         1xuBLUfpu8+qhUlXVyP6XOQ6q0sRV7EwvIwaXpVhCVUJTjQCjAneENJ37v5t/IG4dAAS
         5v+E0LKx1h0Z1Z/D73XVOhVsAP6a9wsqDzKnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3edvsdiBJ+dMkVwgYQe5b56g/OTwtECyNQldn00sS/k=;
        b=NYVG+lRRHzvFw3xA1cuL3SDmpz4Vudm1GyGGSlKcykYBFCRQ7YW9/T11UxNzA/WacG
         jCXS+Nt7a2nt8hzPjHy+JP8ZoHtwE4u1/pN5ak9kfFWAh5YDld0bCwGIYAnsKLKcGezs
         wChUA3y8aefLl0fK1sPAHeE4NPyFBjhe1n94HNrTHlEpiUHmb0Aumew95sgiQtwVsozx
         ks3aWTtZFc4snekYGhJTFkkOqPz95ds0nHRQ8kawBel+lvaFVr8VyV0qqxfmeFp39Cii
         h8U2BsjJ8Mlm+vc7JzjgE/oinKlN22oKssEcNTuQ6wUvsGWkFOc7HnBOHSiw0r1JwN6Y
         8amA==
X-Gm-Message-State: AOAM530UNV3wfeDPqrqo5tYD2qIydALAORerp6zdRXXB+zmxQiNrwg+p
        CSEf/Qs32nIGZ+s0eqATwtt8S8y7chThuoNgR3RFQQ==
X-Google-Smtp-Source: ABdhPJy96Yk1HJK8pmfb/tsUqlvWao5KdebzpybEXlIErIo0+XHeGRmkn8IkxZto7tV3EPeU3amgjnjkLpPlXf7haIA=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr3180723edx.161.1596638802798;
 Wed, 05 Aug 2020 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
 <20200804104108.GC32719@miu.piliscsaba.redhat.com> <2306029.1596636828@warthog.procyon.org.uk>
In-Reply-To: <2306029.1596636828@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 16:46:31 +0200
Message-ID: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com>
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:14 PM David Howells <dhowells@redhat.com> wrote:

> However, looking up that identifier requires some sort of structure for doing
> this and it's kind of worst case for the IDR tree as the keys are gradually
> going to spread out, causing it to eat more memory.  It may be a tradeoff
> worth making, and the memory consumption might not be that bad - or we could
> use some other data structure such as an rbtree.

idr_alloc_cyclic() seems to be a good template for doing the lower
32bit allocation, and we can add code to increment the high 32bit on
wraparound.

Lots of code uses idr_alloc_cyclic() so I guess it shouldn't be too
bad in terms of memory use or performance.

Thanks,
Miklos
