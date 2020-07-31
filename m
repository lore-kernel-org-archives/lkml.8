Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8920838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MYVt6NoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgGaJLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgGaJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:11:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA72C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:11:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so7966588wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WRZsaWH75/5Iq8OKoAx5+9VLutXrIla+ysrRSJUPm1c=;
        b=MYVt6NoXLAR/L4rGhf6N59GHtdGK562gzGbqOW+6Zk9s+6HX4VA6m9ky2k+QzarJXg
         GOWqBUN7qvt+vytb71ocRMPQekmwnMyaILt7cLPVlilyWjXets3ok0/N//6MV9eQ5ZGO
         aRM7ZBAWjzi8p/5xm8DgFPppdawqVV6WcGT7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WRZsaWH75/5Iq8OKoAx5+9VLutXrIla+ysrRSJUPm1c=;
        b=tElQONNHRMQrGK69RjMVFZaAlmopDuXv3LozyghKZ6DjErBzf4FYM5kGpIVOWdZh1U
         E/MDYfeMNTkBYxeXq+26TbnPUKN+h9AtvO058meQ4pCF+o1hVyj5bxday5pE6NfUdfdI
         JGKGJVefSVvtJxcbf444O4zqvNnMgKYvOdhCG4YLBf25A6GYteyeSXBcK1taspQer3R7
         lAUbjLNDOfoTsJalpoTxBEIp0NeT2ADAQamVIg4n5swbNE+Y35TtdetOgeZewSKA/Sgj
         rfdQEdmGGBN1zDwBZjEpoSSVMXw8rhAV6PeQbDwb6Ung3fWiTFfqvMBV9NMcl+iqAOKp
         rUUg==
X-Gm-Message-State: AOAM533iayifopP9GazV75xQ1tdZXX+nY/PTIsvnMwGTkYIyj7Gw69z+
        lsTTqcugQOD4QHNt4G3+SSjDM/O2OxE=
X-Google-Smtp-Source: ABdhPJy1z6Gykg826DXlEWkylfgl6Y+BGbsxUdXutQ8kXUucm/vcH+x0BFlrhspIKsABOQVPUdN82w==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr3236516wmi.180.1596186704846;
        Fri, 31 Jul 2020 02:11:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p6sm12191414wmg.0.2020.07.31.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 02:11:44 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:11:42 +0200
From:   daniel@ffwll.ch
Cc:     daniel@ffwll.ch, David Airlie <airlied@linux.ie>, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Small cleanups to ingenic-drm driver
Message-ID: <20200731091142.GS6419@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200728151641.26124-1-paul@crapouillou.net>
 <20200728201736.GA1277651@ravnborg.org>
 <20200728220008.GI6419@phenom.ffwll.local>
 <PYF7EQ.CC652MXUV2R41@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PYF7EQ.CC652MXUV2R41@crapouillou.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:28:01AM +0200, Paul Cercueil wrote:
> 
> 
> Le mer. 29 juil. 2020 à 0:00, daniel@ffwll.ch a écrit :
> > On Tue, Jul 28, 2020 at 10:17:36PM +0200, Sam Ravnborg wrote:
> > >  Hi Paul.
> > > 
> > >  On Tue, Jul 28, 2020 at 05:16:39PM +0200, Paul Cercueil wrote:
> > >  > Here are a few cleanups to the ingenic-drm driver.
> > >  > - some error paths were missing and have been added;
> > >  > - the mode validation has been moved to the .mode_valid helper
> > > callback.
> > >  >
> > >  > Cheers,
> > >  > -Paul
> > >  >
> > >  > Paul Cercueil (2):
> > >  >   drm/ingenic: Handle errors of drm_atomic_get_plane_state
> > >  >   drm/ingenic: Validate mode in a .mode_valid callback
> > > 
> > >  Both looks fine, you can add my:
> > >  Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > 
> > >  I assume you will apply the patches.
> > >  Maybe wait for Daniel to take a look, he had some feedback on where
> > >  to add checks. I assume this is covered by the second patch.
> > 
> > Yeah changelog for new versions would be great, but aside from that
> > bickering patch 2 lgtm now.
> 
> This patchset is V1, I'm fixing issues you saw in the ingenic-drm driver
> when reviewing a different patchset.

Oh right that was pre-existing issue in which callback to use, apologies
for the confusion.
-Daniel

> 
> Thanks for the review, I'll apply now.
> 
> -Paul
> > 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
