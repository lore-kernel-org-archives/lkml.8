Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB08C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F502075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cKzC6jqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgG1WAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgG1WAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:00:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:00:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so861988wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WYM7YWRrofiqW5kLWGSsE/Hx0/dOJhDIeA7P90h8h+8=;
        b=cKzC6jqIX1H2YhERV4aGOIAIex8WqwlQnUav0NdYcg7oMNLp0eb8eFOCvI1SHd4Gwl
         qPxRiRNhqeqDGTy9jVYcspX+roi/V/prv+zeEb/9I6OE1NQOf1bUoI0wGS+OAhJm87FI
         xatOWa41w23hcSzNBoTWCtjMz9h99qBuD0heU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WYM7YWRrofiqW5kLWGSsE/Hx0/dOJhDIeA7P90h8h+8=;
        b=DwgmuyHkQ+iVc8OthqqLLR9G6FeaPMk5k9XWxqPgxNBh5lXqbGCdTMrHpWT8fCAIxD
         93gntLTX7WfwSG2yBoZUEbfnXmQEGIM0TmwJJAS7J4av75r5dofXaxVjpn1W8UskBw1r
         YrwmRp6sATapTUFc7gvA/939uotrpJn5JYEIM/LKNEnjpOfImZekTWpkiAP5tQFsYlF8
         QnpGv5w7+hpSMNIu4kha6o8uk/NwWzdI2j9/z45zqxKtrQNDUnJ/Qlwj93s2lxDo0cww
         SgtVx3qKENh/mgdgrdx8hsDcMGQ3j0pmyrK93iRfK3+xf6IcQjrxDm5fjw1ijXsDehAh
         gggg==
X-Gm-Message-State: AOAM532AhZaHZG5w7mp0s7zXMxu/NVjKWeef/JZx5usRpGGiMnrGh9zA
        HUf4rmkak/HfJP+LquP+3PXzcPCKMPM=
X-Google-Smtp-Source: ABdhPJwvUftl1NlF82xTDYYgeZB/MS990hdVTA7J01V3SHsjpdjTsW0HjHP3YX7TGyWF7NAJnKfsYA==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr5425903wme.23.1595973611479;
        Tue, 28 Jul 2020 15:00:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 62sm396057wrq.31.2020.07.28.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:00:10 -0700 (PDT)
Date:   Wed, 29 Jul 2020 00:00:08 +0200
From:   daniel@ffwll.ch
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Small cleanups to ingenic-drm driver
Message-ID: <20200728220008.GI6419@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200728151641.26124-1-paul@crapouillou.net>
 <20200728201736.GA1277651@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728201736.GA1277651@ravnborg.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:17:36PM +0200, Sam Ravnborg wrote:
> Hi Paul.
> 
> On Tue, Jul 28, 2020 at 05:16:39PM +0200, Paul Cercueil wrote:
> > Here are a few cleanups to the ingenic-drm driver.
> > - some error paths were missing and have been added;
> > - the mode validation has been moved to the .mode_valid helper callback.
> > 
> > Cheers,
> > -Paul
> > 
> > Paul Cercueil (2):
> >   drm/ingenic: Handle errors of drm_atomic_get_plane_state
> >   drm/ingenic: Validate mode in a .mode_valid callback
> 
> Both looks fine, you can add my:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I assume you will apply the patches.
> Maybe wait for Daniel to take a look, he had some feedback on where
> to add checks. I assume this is covered by the second patch.

Yeah changelog for new versions would be great, but aside from that
bickering patch 2 lgtm now.

Cheers, Daniel

> 
> 	Sam
> 
> > 
> >  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 41 +++++++++++++++--------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 2.27.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
