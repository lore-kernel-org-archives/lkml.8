Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBAC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09820857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BKJl2UEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgDQPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728600AbgDQPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:24:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:24:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d27so3539138wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CgcNS7wVJx/cYNun6VjX20ZMzfaQsrimyYkXrWNoBus=;
        b=BKJl2UErpEu+NCY9uO9Lommds4DyzAm/iPucAVPnMLsQR63OHetIN0V662rSMjFT+O
         ukCQfenaTNg7x3n+oIzre3kDQrPHxB50BEIKsdqAZ9oFmtbbaDLhpr43UKqZuvlI8J+T
         aMljbWOC8YGA9LydrAhqBKclch1+eX66x/kgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CgcNS7wVJx/cYNun6VjX20ZMzfaQsrimyYkXrWNoBus=;
        b=mABS9DR8Do3FfedjCLUfR6UB4UPXRrFENOFzfM5iyOl4TzkkiCCRCO7CWZtsRMeYjT
         B0SD9aS0oVFTn+kgfSILKBSbL/yA6RQASpx1aqf4ybmnSyrGeBs22wJaz+sg9pZLTrB5
         YZi5jkrn0WJIJwcV75XWZl7PwhztXIFYKgEE6wgOOmfQEMjCK2ckbVTHk/XTeyv16/VZ
         CQovUrnXSkDavZ88WkMIx3pFSm3X+TbhoPcUyo4zz0WobbBX7sGZqUNtFtuQloQ5ucWJ
         LlXOrREZ/EhKM6VjbeRWQUZeILgogsA3EgMWtYXSM/RzEUPsO9syYxWVHW9V0QavbnUP
         cgdQ==
X-Gm-Message-State: AGi0PuZQRjdQwudOcE96azvnYmipK/Itdm259p6BXnkpybPs1CHEwdHc
        5S/w3985gePHg34+sWRk2iIiaReqEHE=
X-Google-Smtp-Source: APiQypJ8TBKIbcM3sKU/AyEJfbOuZ02z9cZR91tRn6zeSl5vO8A9C4sU0ld0N/OBcLS5RBjM3z1S1w==
X-Received: by 2002:a05:6000:162c:: with SMTP id v12mr4747537wrb.313.1587137056871;
        Fri, 17 Apr 2020 08:24:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t63sm2703843wmt.37.2020.04.17.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:24:15 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:24:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/gma500: remove unused variable 'hdmi_ids'
Message-ID: <20200417152414.GR3456981@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200417101032.8140-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200417101032.8140-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 06:10:32PM +0800, YueHaibing wrote:
> drivers/gpu/drm/gma500/oaktrail_hdmi.c:676:35: warning: ‘hdmi_ids’ defined but not used [-Wunused-const-variable=]
>  static const struct pci_device_id hdmi_ids[] = {
>                                    ^~~~~~~~
> 
> It is never used, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Queued for 5.8, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> index b25086f252ae..a097a59a9eae 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
> @@ -663,11 +663,6 @@ void oaktrail_hdmi_init(struct drm_device *dev,
>  	kfree(gma_encoder);
>  }
>  
> -static const struct pci_device_id hdmi_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x080d) },
> -	{ 0 }
> -};
> -
>  void oaktrail_hdmi_setup(struct drm_device *dev)
>  {
>  	struct drm_psb_private *dev_priv = dev->dev_private;
> -- 
> 2.17.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
