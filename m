Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D04FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A90206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aODv4vSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIANmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgIANcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:32:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B2C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:32:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so984105wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bx9oQ2NagEe6NO8GIGkDSi51bJAcX461SHWuEDdlU9s=;
        b=aODv4vSb/PtYX2etcdsUG9b4DkQ7ggsrTqv4odqPbmVeKSOtc8x4orvCVl5pTPdofn
         GzpU8kzSxnyrFLBsV4wDhaUkZVId84QvpqgasHh9RvVJ0U1Mk7G/7qsTfZCy2OJUeYaY
         v84qOYWsNzUtbkktxEDEnj+npfSVvCVZvemEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bx9oQ2NagEe6NO8GIGkDSi51bJAcX461SHWuEDdlU9s=;
        b=bJC20ayGTuuJt16Wwrn8BB2Wz8Nc3BexcYxarFtK8cE1ssV+s4UJozKmrtfEC0ZXE0
         5wOB0oEjX7D/zLk6l/DmpX9GtXx2kAzByVovsyWJIndsC4/Z6HeIdhfj5S9xWodf6Tcj
         UhFpIIziREGNqvlVcezWGTIurseqeBveYerSSXyoADr9nAkd78ZIWmbE1p6Z8rpHXoCU
         OiXnFN4JRnzwsEr8y/fnSog7/3ZRkxZk8a5aERDTP5HLWsYIdzMhx8/hOsqsxp1mmqc+
         8QMok4H7ufAseVpso8RaIdc0goaj3VV9xXvxDoFwFAzLHDeJ3upoNT08xcMX3f/hxJEl
         w9aA==
X-Gm-Message-State: AOAM532XzhTrhlQKOJIr7IvjgXTYniBqrpLxExcPQkHl478ILyAxtatO
        18RPE/+cw2iaGXjlReUTSM6k3onoz/60ZG6i
X-Google-Smtp-Source: ABdhPJxMIpyA4+ivRVmjL76n4SwUIJPpyNp2oXzgh60A0zsTrXOGV9cAYNKuDeIxPZ/25Yor8JDoOQ==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr1778101wmr.105.1598967122596;
        Tue, 01 Sep 2020 06:32:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s124sm2056569wme.29.2020.09.01.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 06:32:01 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:32:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dma-buf: fix kernel-doc warning in dma-fence.c
Message-ID: <20200901133200.GE2352366@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20200831041713.12571-1-rdunlap@infradead.org>
 <81dc0a34-90f6-401a-f846-924fdff4aaff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81dc0a34-90f6-401a-f846-924fdff4aaff@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:02:03PM +0200, Christian König wrote:
> Am 31.08.20 um 06:17 schrieb Randy Dunlap:
> > Add @cookie to dma_fence_end_signalling() to prevent kernel-doc
> > warning in drivers/dma-buf/dma-fence.c:
> > 
> > ../drivers/dma-buf/dma-fence.c:291: warning: Function parameter or member 'cookie' not described in 'dma_fence_end_signalling'
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> 
> Acked-by: Christian König <christian.koenig@amd.com>

Will you merge these two to drm-misc-fixes or should someone else?

Always a bit confusing when maintainers reply with acks/r-b but not what
they'll do with the patch :-)

Cheers, Daniel

> 
> > ---
> >   drivers/dma-buf/dma-fence.c |    1 +
> >   1 file changed, 1 insertion(+)
> > 
> > --- lnx-59-rc3.orig/drivers/dma-buf/dma-fence.c
> > +++ lnx-59-rc3/drivers/dma-buf/dma-fence.c
> > @@ -283,6 +283,7 @@ EXPORT_SYMBOL(dma_fence_begin_signalling
> >   /**
> >    * dma_fence_end_signalling - end a critical DMA fence signalling section
> > + * @cookie: opaque cookie from dma_fence_begin_signalling()
> >    *
> >    * Closes a critical section annotation opened by dma_fence_begin_signalling().
> >    */
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
