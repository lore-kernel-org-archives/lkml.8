Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D13DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B3D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kuDotpuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgFBNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgFBNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:16:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415EC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:16:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so2907072wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OpasVMisglYsuLwIdyOtQK0A81fANkOyysqk8CVIvx0=;
        b=kuDotpuhsY+MXpsr9Oy5OHDubwIUR/t6up0ak/ePcy2RYYIQAcRwYchPhLrdrqQ8ZC
         jDK8O0tZ+vCJrTENfDjEGHWnjEKoRkrWEcPXw3RXThiLDdTS0t0w+q1PM/ZIlowe3v6E
         wt0jXrNZ+k5dqoWCCoe7cAQEnilSIKZTVdFlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OpasVMisglYsuLwIdyOtQK0A81fANkOyysqk8CVIvx0=;
        b=e1pPT3rMbQG+spyS7EEV/M0Gvn1ongDhAJrW1ecgmESE2vJ8WuqDFjDCUbf8z6nrpv
         Sp9F6n8mQIensVjEgtTQOFi5aL+dgM3O40XPaEKEt0wmaCiZubevZy0rZc3Ehp5QW369
         3pAYo9RHh1tgqUu4Mbx2kg0m5zj9lIvO3qA1i0OzCu7IfnmqGchZajZxObhPe0qfBBSF
         mbFzyr6/fzVgLDxTzLKrFTZHT4yHMsejeuTgWwXPIRKEZp23zIHTwIfk52Jxd0ZUDAUt
         bcuLKhdL2ymJumUcqlPifxm5WuHvQ7K/iZKKaIhsmmUvOmvI0c6DLQlCoPj1JeqWOVtD
         1deA==
X-Gm-Message-State: AOAM531q3fiffI+cYS/w5mMaqLUqRGP4OKnGJK1PEjVSX+IUgPVuPbnS
        p4r9EeUdrBjEKHNPNTCQhW47K/KzSCs=
X-Google-Smtp-Source: ABdhPJyKXdTRZdaW33eS+W0IooJHz/fLbQxnKFQHG78T5To3m81jjbqdvxTgllHwNEE6P7CX/B+JFA==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr3955987wms.109.1591103758685;
        Tue, 02 Jun 2020 06:15:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t8sm2591537wmi.46.2020.06.02.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 06:15:58 -0700 (PDT)
Date:   Tue, 2 Jun 2020 15:15:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-fbdev@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: pxafb: Use correct return value for
 pxafb_probe()
Message-ID: <20200602131551.GD20149@phenom.ffwll.local>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, linux-fbdev@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <CGME20200525071149eucas1p271b0c64a9d44429978e2099257681b70@eucas1p2.samsung.com>
 <1590390705-22898-1-git-send-email-yangtiezhu@loongson.cn>
 <be2f65ba-e26c-fe3f-82d9-d9532db496eb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2f65ba-e26c-fe3f-82d9-d9532db496eb@samsung.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Mon, Jun 01, 2020 at 03:25:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 5/25/20 9:11 AM, Tiezhu Yang wrote:
> > When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> > to check the return value and return PTR_ERR() if failed.
> > 
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Thanks for going through all the backlog of patches in the fbdev area
every once in a while! That kind of housekeeping work is often
underappreciated, but rather important to keep the ship going.

Cheers, Daniel

PS: Of course also holds for everyone else doing this in other areas.
fbdev simply stuck out just now catching up on mails.


> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > ---
> >  drivers/video/fbdev/pxafb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> > index 00b96a7..423331c 100644
> > --- a/drivers/video/fbdev/pxafb.c
> > +++ b/drivers/video/fbdev/pxafb.c
> > @@ -2305,7 +2305,7 @@ static int pxafb_probe(struct platform_device *dev)
> >  	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
> >  	if (IS_ERR(fbi->mmio_base)) {
> >  		dev_err(&dev->dev, "failed to get I/O memory\n");
> > -		ret = -EBUSY;
> > +		ret = PTR_ERR(fbi->mmio_base);
> >  		goto failed;
> >  	}
> >  
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
