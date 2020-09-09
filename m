Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DCCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB84207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxfEaHf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgIJCKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbgIJCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:02:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F9C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:23:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x77so2552461lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yl188sYExyD90GkGlBv3BhIbGYC9T3G2g/05Tggzfnw=;
        b=VxfEaHf9+nL+R2k+5le9H9YNehcUR633iVDOtcpItDj5uw4ygLrSb9Cs/iP0lTLExE
         2vj6cnYiqIpwdVHsnSbU1ggz6teLUODzSsuBP24F2DsBkeAUxi+eYtkP9+Jsleu0PUWx
         F59zR+gvWpK70BVa98dDHlayuC7om5SYx7Gj69U1GHpWh/Gil6Xiwwi23U8zRnY2AV1p
         xdLEINiD6X75kO31RJ9Q6XNOswjoKStJdVuXOxJgq7CaFHNVSRXMj2bi0SbPOr9xxqYb
         BuX/UYnc9ML9tNResZ/r/6rkxhryRGOOVHq22wuFuZOzzpbNp3wO/5fLxTKERS2SNR8F
         w4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yl188sYExyD90GkGlBv3BhIbGYC9T3G2g/05Tggzfnw=;
        b=NnZca8FsgAoxyDOcQ3xF+Bsc+LCPmWb6rECDqWhGiT5tatGnplCsyDg0rqVD4B+UgE
         NrNW1bul2WymYcYCO+uTdnFkkXAV7VGsGB7Utwzb6wDofpN84nCZkd9a8xDJsQjK03nL
         HVH7BDG+y9k97Q2mfzAJd//0B5gnatjabLKghtOmBvjxEZcdHzn8bJ6wE7Xaw7lr7GP3
         mzX1gUyKEj8OeBg4dncT3p/WagYL7XJGkVYH+cXKacWxX8k5xNl0EZfrlNNomRu/PFoA
         IlOyyr/MB+6xneO072FlMFQ9C7qc5vEANwnvDxVUc15ewui3BV/1yGhn2rT2HUM4zMii
         YNtQ==
X-Gm-Message-State: AOAM5320hCOkvTD35btqFR/mneQNZuZAEwQ7NqshTN9JSOBtOTX5do2d
        es4/aSqlsVEqKPkH9aAbVuH0JVmW01P6Xncltfk=
X-Google-Smtp-Source: ABdhPJxJzBHtPDcsWnz08jMs86wkQnZumqyOghJZZb+fnRl/+we6VfuDQMOvv9auplBrmAuyPPgzQsC+QsLwSKe/4MA=
X-Received: by 2002:a19:5e19:: with SMTP id s25mr2812753lfb.196.1599693808198;
 Wed, 09 Sep 2020 16:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
 <220b1cb4-9c2e-c9db-5590-6dcd43b9aaed@huawei.com>
In-Reply-To: <220b1cb4-9c2e-c9db-5590-6dcd43b9aaed@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 10 Sep 2020 08:23:17 +0900
Message-ID: <CACOAw_zoA5PKY7sbzZtria+jjuFSQ3RormTYn83rz7NAOkxtxw@mail.gmail.com>
Subject: Re: [f2fs-dev] Question about STEP_DECOMPRESS_NOWQ
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. I misunderstood that is some residue of trying to implement
softirq context decompression. :)

2020=EB=85=84 9=EC=9B=94 9=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 4:15, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Daeho,
>
> On 2020/9/9 12:43, Daeho Jeong wrote:
> > Hi Chao,
> >
> > I have a question about the below flag for decompression.
> >
> > STEP_DECOMPRESS_NOWQ,           /* handle normal cluster data inplace *=
/
> >
> > According to the comment, you added this for using inplace
>
> I added this for the condition that: in compressed inode, partial cluster=
s are
> written as normal (non-compressed) one due to bad compress ratio, during =
reading
> data in normal cluster, we don't need to queue them in workqueue, instead=
, we
> can just handle them in IRQ context (end_io()).
>
> That says, if all pages in bio are non-compressed, we tag step w/ STEP_DE=
COMPRESS_NOWQ,
> once there is at least one page is compressed, we change step to
> STEP_DECOMPRESS.
>
> > decompression but inplace decompression mode is not being activated
>
> 'inplace decompression' means decompress in
> a. reader thread or
> b. IRQ context ?
>
> Thanks
>
> > now, since we are setting STEP_DECOMPRESS right after bio_add_page().
> >
> >                  if (bio_add_page(bio, page, blocksize, 0) < blocksize)
> >                          goto submit_and_realloc;
> >
> >                  /* tag STEP_DECOMPRESS to handle IO in wq */
> >                  ctx =3D bio->bi_private;
> >                  if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
> >                          ctx->enabled_steps |=3D 1 << STEP_DECOMPRESS;
> >
> > Did you mean to deactivate inplace decompression mode on purpose,
> > since it had an issue? I am a little bit confused about this.
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
