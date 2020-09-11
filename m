Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48498C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C889621D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fRQh/tOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgIKIP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgIKIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:15:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18724C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:15:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so10586848wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k8Bj3ASTIpypJ8ggKoM+aQRjaad0dEkxTPVx2fp8uGs=;
        b=fRQh/tOglgsku2462Zr61073wgcr+e/eaLU/50pvajTvuPIvdnYICnzSUm7FvMvi4p
         MmKv0YhMk8XAy/F9mhJHBDTrgGsTzpvfgEmvRYXCtUF9xzPga5JBhaDao8umntOK+AQh
         I7vagGkCjLylhdYtE/dkSzoXa/xVyy+ik0G6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=k8Bj3ASTIpypJ8ggKoM+aQRjaad0dEkxTPVx2fp8uGs=;
        b=hsKs49bjqEFSsHxOb4TFuZAQsOxunwYQmZX7U5ucQQpNIFzylHjghBoRj43tI91wO/
         YnIMXNIQCqZaUXe4J1g0cRtLhhPJVIp1MhQrPApFmzk1KetNPUFyYc3kdBAy2o/+OQ9G
         x7IQ/V4jywXAK3iLwsmZN4Ga7j3/BjHf6G/RMLZAwIIjMhlNuSLkIuY/OxO7nHkcr6So
         Sj8Ne8fO61/IX+4Y3y/2/ymKEWMwwQ6wdLXhqE6GTc45g3M8iLjIZb8QW1lKpgZ4Zlws
         +F/RvKLg1Az30XFkZvawkZThOdGkZzD02W2zebP9UuJ1G9vbRiNIoFXpA9rQJsp6/vXQ
         69Ag==
X-Gm-Message-State: AOAM532bjnu2gk0vVYbhhJltXgxuM3GlbFX4801SEXNxRwNqZexnXJor
        QC8J4P+2s6IfTL1f2VI7xKokbw==
X-Google-Smtp-Source: ABdhPJxU1ll9iAceBTayzDGewibbztq9+abcfDZ6D804bpFjvBJi1qAFfNus3ZOJ7xUMAgiq6aX1LA==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr866124wrp.246.1599812122122;
        Fri, 11 Sep 2020 01:15:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k8sm2777115wma.16.2020.09.11.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:15:21 -0700 (PDT)
Date:   Fri, 11 Sep 2020 10:15:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Michal Simek <michals@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] drm: xlnx: remove defined but not used
 'scaling_factors_666'
Message-ID: <20200911081519.GM438822@phenom.ffwll.local>
Mail-Followup-To: Hyun Kwon <hyun.kwon@xilinx.com>,
        Jason Yan <yanaijie@huawei.com>,
        "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Michal Simek <michals@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200910140630.1191782-1-yanaijie@huawei.com>
 <20200910181418.GA3187626@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910181418.GA3187626@xilinx.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:14:18AM -0700, Hyun Kwon wrote:
> Hi Jason,
> 
> On Thu, Sep 10, 2020 at 07:06:30AM -0700, Jason Yan wrote:
> > This addresses the following gcc warning with "make W=1":
> > 
> > drivers/gpu/drm/xlnx/zynqmp_disp.c:245:18: warning:
> > ‘scaling_factors_666’ defined but not used [-Wunused-const-variable=]
> >   245 | static const u32 scaling_factors_666[] = {
> >       |                  ^~~~~~~~~~~~~~~~~~~
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>

I think you're the maintainer, so please also push patches to
drm-misc-next. Otherwise they'll just get lost, or at least it's very
confusing when a maintainer reviews a patch but there's no indication what
will happen with the patch.
-Daniel

> 
> Thanks!
> 
> -hyun
> 
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > index a455cfc1bee5..98bd48f13fd1 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> > @@ -242,12 +242,6 @@ static const u32 scaling_factors_565[] = {
> >  	ZYNQMP_DISP_AV_BUF_5BIT_SF,
> >  };
> >  
> > -static const u32 scaling_factors_666[] = {
> > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > -	ZYNQMP_DISP_AV_BUF_6BIT_SF,
> > -};
> > -
> >  static const u32 scaling_factors_888[] = {
> >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> >  	ZYNQMP_DISP_AV_BUF_8BIT_SF,
> > -- 
> > 2.25.4
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
