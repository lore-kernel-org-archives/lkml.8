Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4430C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D662070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGM2xrbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgA2OSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:18:04 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33547 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2OSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:18:03 -0500
Received: by mail-pg1-f174.google.com with SMTP id 6so8924515pgk.0;
        Wed, 29 Jan 2020 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieZZcAiwddRgO1I0z1VjIfd2VtBIxW540IZSnXnxT2s=;
        b=dGM2xrbtbMK7IXKjwz05uLZHREq4IRPRGMaBC8INdXdt9Tw7kwtLHQlJYlP6xqAoNX
         JLSilAmj3EKtOzaFzv3Az/YH00YXiKVeYgZ42ei9ECmOZc0m0Cpftp4BkVdi7qgb7OI7
         wmyeCo2dDJXfZJiY9tz34m1yuSnYLr7fK/GQqBRDOamoF0sctR2FyIx2QQwMDQKMhayT
         UTCd9T056YQAIxEZVLy9/Dev7774pOgpsVK08Vuc5q/CsvB+3UQPJwZn9s9fgJo1ngLB
         seUbANkaefwcgdrJczgTL628chAhCuG71t7N/L+OmOuc7hung7VC5cgZtA+r1cuEIDP3
         ZUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieZZcAiwddRgO1I0z1VjIfd2VtBIxW540IZSnXnxT2s=;
        b=ip3A1Awqvq2CFv9Y+pr+rtAxkjyUjmOFiy7k3eVdR7kKRiKQa0Mma4xNa6uCTZ7era
         9zmASo7UWj0FKaROkMtOgAjjaNfi8YGMgnLm6PLwVjNpohMrZWElAjhhW8uvcljosogL
         1GjqGJEQM1EhssL2+H+5l0Tcait3m6GTMTxTWjb17bJVZ4ElQIKYOZ6DXRLi0RNnrOJJ
         Xmj7nuNwyhB+4UdCsUoh6LnswPJra38O6uX+kaBuh+JXYT53BI3wVCLlTjLv0Epo3MRR
         gs5hBAULu0GqLsoiYEjPvynJkh1KAMx9z1xDK41y0p+Am0FcFw/C/yUF3T5EzYeQ/CR2
         Qxyg==
X-Gm-Message-State: APjAAAWu7xVYXRL8OikoiK3JqhmJ7w/q4bWD1Cq2lXPLgoUiggH8i1D1
        /9ohRjIns5nyOfXEIb6zSZk=
X-Google-Smtp-Source: APXvYqwCfc4jCxY5BtbthWGX6JJXox9KjSvlQXxmyhs527/tGzSYKdnmWlvaER7eAOW6/YyczwXQZQ==
X-Received: by 2002:a65:4685:: with SMTP id h5mr23680746pgr.203.1580307482770;
        Wed, 29 Jan 2020 06:18:02 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id b12sm2917846pfi.157.2020.01.29.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 06:18:01 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 29 Jan 2020 23:17:59 +0900
To:     anon anon <742991625abc@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        anon anon <742991625abc@gmail.com>, wangkefeng.wang@huawei.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-ID: <20200129141759.GB13721@jagdpanzerIV.localdomain>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129141517.GA13721@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/29 23:15), Sergey Senozhatsky wrote:
> Date: Wed, 29 Jan 2020 23:15:17 +0900
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Petr Mladek <pmladek@suse.com>, anon anon <742991625abc@gmail.com>,
>  wangkefeng.wang@huawei.com, sergey.senozhatsky@gmail.com,
>  syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
>  dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
> Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
> Message-ID: <20200129141517.GA13721@jagdpanzerIV.localdomain>
> 
> On (20/01/28 15:58), Bartlomiej Zolnierkiewicz wrote:
> [..]
> > 
> > Help is welcomed as I'm not going to look at it in the foreseeable future
> > (I'm busy enough with other things).
> > 
> > > (dri-devel@lists.freedesktop.org or linux-fbdev@vger.kernel.org) into CC?
> > 
> > Added to Cc:, thanks.
> 
> Hmm. There is something strange about it. I use vga console quite
> often, and scrolling happens all the time, yet I can't get the same
> out-of-bounds report (nor have I ever seen it in the past), even with
> the reproducer. Is it supposed to be executed as it is, or are there
> any preconditions? Any chance that something that runs prior to that
> reproducer somehow impacts the system? Just asking.

These questions were addressed to anon anon (742991625abc@gmail.com),
not to Bartlomiej.

	-ss
