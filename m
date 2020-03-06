Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867B20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eTHhCcEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCFKjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50703 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCFKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so1837210wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rCwwPNd2pA0INB2HwJkp3rqo1usGcNxwzdg6ma8wOKI=;
        b=eTHhCcEclE09OQebKxTAtBcuem6YrVVfqc6wr7gzch/KOv9hjBwMrETehU/oSBUFjX
         l9RbDlri1cZqI8jE26fig1J/BgoL9F/ihHJocP8/UCnDCvgi1xfAqPrfmg0Ceb7WmzQm
         aWZ7/H0OldRYsjAGDfwM90Gf9q8iHvafGPsVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rCwwPNd2pA0INB2HwJkp3rqo1usGcNxwzdg6ma8wOKI=;
        b=QwPI0X8op9UGDwObV+RpSqg39iYyEU3FrCN6+Rw9TWt8xFK9eDGsba6S19gcSt8Pxr
         DxhQwWWviGijX7ZUS3xr7w6cX6bQsePlpgKgqjZBsPf6FYazvRnEvpZ6b6T5AV7tcU6y
         EsSzczXz+AhLr8TPGvJxT9feb4BgstYumiNpaWww6Q9pnb4moc5m71yBocdtIfDyXzea
         BdavsoAfFTnJdObF65avXVdaEWaxiBSh/LaaZQquz3pMgMkPznCuDVJv3PtxYd0cWQcn
         o1WJT6aiHrzxs4YENxxwUsw7s/AsqOmI4j/eyOQ6Jol97FHbhY9282iGdRLrI7OOovd5
         D1yg==
X-Gm-Message-State: ANhLgQ20xYInZbGH44pQogiReqyrYJYMzd+k9vlBu9RbU49EHPjvcXkI
        Tsve6pL7I5iqC7WgAQdR2yJxww==
X-Google-Smtp-Source: ADFU+vsoxbiLn65abeK+CoaJTkFH/7IMTTkUgAtZxrezRu/238vSq4AIzpYtowBToyIoT+aRz7bdHg==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr3356418wmk.90.1583491188842;
        Fri, 06 Mar 2020 02:39:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a184sm13066027wmf.29.2020.03.06.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:39:48 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:39:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Joe Perches <joe@perches.com>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] MAINTAINERS: adjust to reservation.h renaming
Message-ID: <20200306103946.GT2363188@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Joe Perches <joe@perches.com>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
References: <20200304120711.12117-1-lukas.bulwahn@gmail.com>
 <b0296e3a-31f8-635a-f26d-8b0bc490aae3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0296e3a-31f8-635a-f26d-8b0bc490aae3@amd.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:08:32PM +0100, Christian König wrote:
> Am 04.03.20 um 13:07 schrieb Lukas Bulwahn:
> > Commit 52791eeec1d9 ("dma-buf: rename reservation_object to dma_resv")
> > renamed include/linux/reservation.h to include/linux/dma-resv.h, but
> > missed the reference in the MAINTAINERS entry.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > 
> >    warning: no file matches F: include/linux/reservation.h
> > 
> > Adjust the DMA BUFFER SHARING FRAMEWORK entry in MAINTAINERS.
> > 
> > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

You'll push this too?
-Daniel

> 
> > ---
> > Christian, please pick this patch.
> > applies cleanly on current master and next-20200303
> > 
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6158a143a13e..3d6cb2789c9e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5022,7 +5022,7 @@ L:	dri-devel@lists.freedesktop.org
> >   L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> >   F:	drivers/dma-buf/
> >   F:	include/linux/dma-buf*
> > -F:	include/linux/reservation.h
> > +F:	include/linux/dma-resv.h
> >   F:	include/linux/*fence.h
> >   F:	Documentation/driver-api/dma-buf.rst
> >   K:	dma_(buf|fence|resv)
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
