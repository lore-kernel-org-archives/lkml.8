Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05842C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85B3208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="u2Fn21QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgEALd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728620AbgEALdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:33:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4FC08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 04:33:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so2322065ljb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLXTIf6sR5xPtNtzDzFOIjNOdFUZv31CNDN3CIrYk74=;
        b=u2Fn21QMaMPaZhF3+p+phpGjItMvJ1fijPvTZnhWnBQ3Kl2NkKZ5DUcXIzboWaIEpq
         PHc7d76JBxNUX5u/aYisCd6toonq3zSOF/ex2HXvg3IoiL8y/yh4H2s+lAIWpquRciYA
         xCHQvMC7Qd+ijRUZkez2UtctZ9S6/th8SKbPTj/ZGKoJbOCC+u6O/UQvFBCgR5nAbISH
         TVdWz40fnaVIaXSFGCvZqNiefervOGniYKEr0SmaLZ72q9G0oRni14BDVvt8mwv9tWwI
         M4MqgyKsvuj8xpLN4bDmoV9q+0fCYbIqRqjK21n2KFbY9LknNXTRUI3SjvIgTaXGvDWR
         GR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLXTIf6sR5xPtNtzDzFOIjNOdFUZv31CNDN3CIrYk74=;
        b=YlHL9jkHR1aeAEtq4oS10eWDWALd+vd7U7RiN8rzWheHqxclFdKdWJGCYkQS3DycFS
         /ttBFZuMfAQDMywAk34PXzC7Zp92WG14P/219dQM4BZgcLzDlTTlbua/4HLCN7V3XHMO
         Y5h0JZ1AMmBU8SEB25RTuI8XBbMXFg/pBPw3K7blunk4ynmtkfuSOKb2QgQyuqeowPHo
         yYw0rkVAQbwS6Q/gzc+avBJg2SkP8WwsW6FT7ndZ0czcllC5FspUTBSYrDBqL5jVViQJ
         adyW+cszNV261ciXlVfy65cF7OO0vySP3dL7LhU7mStmHRP7NmYiAbQ5iCH9dUPqzKIu
         ZSzw==
X-Gm-Message-State: AGi0Pubyq/AME4qRUeFuwmhz4yviI7LMAWyQRlPS2srSFGtr03ktt01j
        DrYiRFzokAxRYdAgRdaArA+Bb6btyApOMcgWB0ek8g==
X-Google-Smtp-Source: APiQypLl1X0WceEbqV3CCseqAkA/BN/GLFhmaw9zT23HVad8Rb4QtYfdfJzDvxOQ7nGW4agmDAH/UpYKT6hStRyKGLQ=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr2242405ljk.42.1588332802396;
 Fri, 01 May 2020 04:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-2-maco@android.com>
 <20200429141229.GE700644@T590>
In-Reply-To: <20200429141229.GE700644@T590>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 1 May 2020 13:33:11 +0200
Message-ID: <CAB0TPYHSbjDGRHdvBRf-=WWtLP3T30Hx_hMOOera376DmATQgg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] loop: Factor out loop size validation
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Wed, Apr 29, 2020 at 4:12 PM Ming Lei <ming.lei@redhat.com> wrote:
> Now sector_t has been switched to u64 unconditionally, do we still need such
> validation?

I think you're right; I hadn't seen that change, but truncating
because of sector_t shouldn't be an issue anymore. I wondered if we
could actually have a smaller loff_t, but looks like that is 'long
long', which should always be 8 bytes as well. I might send this as a
separate patch, I don't want to drag this series on for too long.

Thanks,
Martijn

>
>
> Thanks,
> Ming
>
>
