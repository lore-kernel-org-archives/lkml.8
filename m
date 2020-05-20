Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801B8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF00206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RVbzbeZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgETSDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:03:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:03:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so4103711wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/pzNIw5NMKlF1N9TSGtP2POLjyaFra4+alsVvEVR4Qo=;
        b=RVbzbeZJwQKn0fQJxBC+d3QQf+4Jc9ERELRrF6QN95Jy6i+oa32iKhFYYJLi4vMvIs
         v33khe4x4YGuIGCNzTToI+mqqNtkrtcxGbva5kt1BUX5731/nDwW0mhyJNyPVVSOIDLx
         3Lk9f5cOp7RmhmE3nLJT9TFSaP34iblyoCoAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/pzNIw5NMKlF1N9TSGtP2POLjyaFra4+alsVvEVR4Qo=;
        b=uL4qYZ4JfeEbAveSL1hFTOkRFygrpmwtmUBJf26Fmjsj7xyP7fPw8lpX2DQ7BakKlU
         zKjpicIxwNzcVaMN/K0NNU3z4TSkTIW3Gp40JaZJIq6ggNXKNgwODfE8+eCWDZIHO+Hf
         OncnoGwXPtwmyp8Y/+1sJa0D0GPhH6gYXrViHLNh8Lws3KbH1hudW8kXfWOhxzalZCvJ
         oPP0aQa5tAzkt6TIZDm5QdrBCb9uk36Fc1i22hS5NebqEDDqaD0t1OL1KCSB9Q0ElNO0
         SKWzYUwJast4PYDYeuCXzRBEqPnskQ97HHsuPXLBFPAPHaOURRBIRKhJu1iUpL/TLKPH
         CO1Q==
X-Gm-Message-State: AOAM532ocSGQd2u+t+e8CdAv/XJ+lyrrlv6E7j+vCXJmLk/LXdLLHawO
        Di1ZCvihUMHistt11zXOb40DB6bS2g0=
X-Google-Smtp-Source: ABdhPJxnsEvkukkCUZ+pGF+Xtq0q8Edmwd/+xQRwa/22eS6mkMjcbznb681Tz/hdxqAdzYaJBNcsRg==
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr4974085wrw.305.1589997817336;
        Wed, 20 May 2020 11:03:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d9sm3869848wmd.10.2020.05.20.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:03:36 -0700 (PDT)
Date:   Wed, 20 May 2020 20:03:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/3] drm/writeback: don't set fence->ops to default
Message-ID: <20200520180334.GB206103@phenom.ffwll.local>
Mail-Followup-To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
 <14063C7AD467DE4B82DEDB5C278E8663010E20F82D@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663010E20F82D@FMSMSX108.amr.corp.intel.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 06:12:32PM +0000, Ruhl, Michael J wrote:
> >-----Original Message-----
> >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> >Daniel Vetter
> >Sent: Monday, May 11, 2020 5:12 AM
> >To: LKML <linux-kernel@vger.kernel.org>
> >Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel.vetter@ffwll.ch>;
> >Intel Graphics Development <intel-gfx@lists.freedesktop.org>; DRI
> >Development <dri-devel@lists.freedesktop.org>; Thomas Zimmermann
> ><tzimmermann@suse.de>; Vetter, Daniel <daniel.vetter@intel.com>
> >Subject: [PATCH 1/3] drm/writeback: don't set fence->ops to default
> >
> >It's the default.
> 
> I can get behind that. 😊
> 
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

Applied to drm-misc-next, thanks for reviewing.
-Daniel

> 
> >Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >Cc: Maxime Ripard <mripard@kernel.org>
> >Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >Cc: David Airlie <airlied@linux.ie>
> >Cc: Daniel Vetter <daniel@ffwll.ch>
> >---
> > drivers/gpu/drm/drm_writeback.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/drm_writeback.c
> >b/drivers/gpu/drm/drm_writeback.c
> >index 43d9e3bb3a94..dccf4504f1bb 100644
> >--- a/drivers/gpu/drm/drm_writeback.c
> >+++ b/drivers/gpu/drm/drm_writeback.c
> >@@ -108,7 +108,6 @@ static const struct dma_fence_ops
> >drm_writeback_fence_ops = {
> > 	.get_driver_name = drm_writeback_fence_get_driver_name,
> > 	.get_timeline_name = drm_writeback_fence_get_timeline_name,
> > 	.enable_signaling = drm_writeback_fence_enable_signaling,
> >-	.wait = dma_fence_default_wait,
> > };
> >
> > static int create_writeback_properties(struct drm_device *dev)
> >--
> >2.26.2
> >
> >_______________________________________________
> >dri-devel mailing list
> >dri-devel@lists.freedesktop.org
> >https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
