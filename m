Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BED820738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="wOuZYuoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHYWLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHYWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:11:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F020C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:11:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d26so180667ejr.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMfzJvb3bssyfQ37ul9l9iixA3MkT5QgL2oMa2TRSL0=;
        b=wOuZYuoGCNRPZWHbOUu2+fJA0720LZyvSQZAsvdzHmozYqvx9gqy+y56yhGetak1hY
         0ZpH0AN34afF7sCXBNX1za3bo6VEv3zzifTgXX6NktsIb0KMECsyDGKURfkIGuHDYP7l
         2vNjvK5GRzzMhw930qnNFvFLO4U+OoPZL5m094zS+p1VYWRjrDEHbGSxNNj51Zz6WO1s
         ZiyoZK6bgROAVt3z1Eypl5YBuBJKIuUzkS8dmSmAYl3uXYnqEPUbHwQEx6RaRV+0lQWl
         BFyqbd0cR+wbFcr/X9k1q9CCWjlO/In+tr2E/EZFQcMhKqrQoeKYsWdzeLcVrkf5mvdH
         KzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMfzJvb3bssyfQ37ul9l9iixA3MkT5QgL2oMa2TRSL0=;
        b=ZNMSufVLDW0y6ylBa+TlR9p6lQnF/asGKm3gS9qaXQ3J7dJaJMFII1Vq5WpDZ6Uxh4
         61uRIEbX/2lFmQjRslTS55yDLxYiDFklutDU2pljHMLsmsax2KZ65ty6l3X6W+MZnmsI
         nxvF2eGh1zHDy3PlkLO8Eg+f6973cc8nASNmeEiLbPVY8ywYXcj6yyyWpo7EGOXvo7eZ
         YclsZg38D2lQQSeRSARkUtP6O712XY+AJAX96t+LQwNKMrW/Ph0dHBcuGWaU6epO5UVt
         7oo1/j4+MXRA+hxt7vw2AyBSkrzEAwk5gWRWFr92yCREr+ulM2fkJLHGhmwaERjpCBN7
         zThQ==
X-Gm-Message-State: AOAM533Hhh9+l9uHwUTBoWixNY1ihQjDQtAr6tI8tpimmJdkyLAZZWgi
        UouUQ9IJ47S1/U+R1qLqJa5SfL76txAGAhG1tq//Rw==
X-Google-Smtp-Source: ABdhPJx4LA5bEbVNRkF5QKu0Ea3A4Jn3y6fRrWhFi3M9+6OzYNhiTovXthqJYi2GFnhSh/cNpK6ycu1jKn8rhuKDP48=
X-Received: by 2002:a17:906:813:: with SMTP id e19mr9245378ejd.141.1598393458608;
 Tue, 25 Aug 2020 15:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200825145556.637323-1-gnurou@gmail.com>
In-Reply-To: <20200825145556.637323-1-gnurou@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 25 Aug 2020 19:10:47 -0300
Message-ID: <CAAEAJfBbxExQP7cAQnsAE1_Zh-onBKPt8is3S9qBEpx6MAywRg@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: v4l2-mem2mem: fix poll() bug
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

Thanks for the patch.

On Tue, Aug 25, 2020, 11:56 AM Alexandre Courbot <gnurou@gmail.com> wrote:
>
> This addresses a very corner case that probably nobody ever encounters,
> but I have hit it when playing with vicoded so here is a tentative fix.
>

I'll try to make a more complete review soon, but meanwhile
I was thinking if it was possible to include a little kselftest program
for this issue, something CIs can pick-up and test corner cases like this,
making sure we don't regress on the issue.

(Or alternatively, v4l2-compliance?)

Thanks!
Ezequiel

> Patch 1/2 addresses the issue that when the last buffer of a m2m device
> has been dequeued, any attempt to poll with EPOLLOUT will result in only
> EPOLLIN being returned, even if OUTPUT buffers are still pending. The
> issue stems from the fact that the last buffer check if done first, and
> returns immediately if true.
>
> Patch 2/2 builds on the first one to (hopefully) clean up the code a bit
> and make the function flow easier to follow. Functionally speaking it is
> supposed to be a no-op and it can safely be dropped if the former code
> is preferred - the actual fix is in 1/2.
>
> Alexandre Courbot (2):
>   media: v4l2-mem2mem: consider OUTPUT queue first when polling
>   media: v4l2-mem2mem: simplify poll logic a bit
>
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 42 +++++++++++---------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
> --
> 2.28.0
>
