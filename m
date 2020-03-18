Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D02C20773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jJIEU+TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCRNtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:49:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34958 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgCRNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:49:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so3456113wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhjSzraoBOeWPVT3LQo7Ng/qwFROJg9Ku7xc0QPbKjI=;
        b=jJIEU+TNBKOQ4016fYVaddPzkMst3rQ/3p4Xx3wFIZf72OaeRdXqtmSGdKlWghdzNC
         VpteDO5ULaAuOLTMOG3h73tSIo+42mAS/8SC2fcV9B1nVUpFMsICMGHTsKjANBqMSymI
         vUdJNQpr3MUfg1nQcTUJV3WCigBgClEDXWlLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nhjSzraoBOeWPVT3LQo7Ng/qwFROJg9Ku7xc0QPbKjI=;
        b=aSoTkM+tgi9BIYinM271Fu1Uja4sCKqFhDtpspvAZd+Rca9gC7Ha+7IbtbwBMLYwtd
         H+lBMuDg5xMyaiSxl1TyWWsJvSxGY2PdSm1AwYawzw1FM7Xfz2ddnLbHFkyJjTOC0Sd7
         aMrsxTBXNM5/vezGTRQVIMwstxc+EBCFzjz+nIU5heg500l8Tb30wspocdwnS6VspZBY
         FtqOnPXyClOVCNR59+OHkCnFfeX4UEiRwxE3nb7m+WBdluV3nG+H2Ai81kFLt1wWhqhc
         DaURIhOWqqXMBjZveuY5gE1wF+N6X5p3oHKzI+5uLPSkmFM6ojysGhYB6j+4ZHYOSpsB
         ZWOg==
X-Gm-Message-State: ANhLgQ2SAcRVq4IQ/gApAAYQAiE9ajdFPpEK2IaqT6RRa5EZ93aZ/ekh
        QBURUiOzMeXgfRRd9bDXbAzuAA==
X-Google-Smtp-Source: ADFU+vs5ilQvxkbVvgYWAdqliMhxQa+MQFIS4q+2x/7fT0/rVzc8bp98oG9vOKtAIrgiSeNYnlDm7g==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr5281804wme.176.1584539351962;
        Wed, 18 Mar 2020 06:49:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t1sm9719981wrq.36.2020.03.18.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:49:10 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:49:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: drm_vm: Use fallthrough;
Message-ID: <20200318134909.GW2363188@phenom.ffwll.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1584040050.git.joe@perches.com>
 <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
 <20200317164806.GO2363188@phenom.ffwll.local>
 <623eb1bc61951ed3c68a9224b9aa99a25e763913.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623eb1bc61951ed3c68a9224b9aa99a25e763913.camel@perches.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:13:29PM -0700, Joe Perches wrote:
> On Tue, 2020-03-17 at 17:48 +0100, Daniel Vetter wrote:
> > On Thu, Mar 12, 2020 at 12:17:12PM -0700, Joe Perches wrote:
> > > Convert /* fallthrough */ style comments to fallthrough;
> > > 
> > > Convert the various uses of fallthrough comments to fallthrough;
> > > 
> > > Done via script
> > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> > > 
> > > And by hand:
> > > 
> > > This file has a fallthrough comment outside of an #ifdef block
> > > that causes gcc to emit a warning if converted in-place.
> > > 
> > > So move the new fallthrough; inside the containing #ifdef/#endif too.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > I'm assuming this all lands through a special pull? Or should I apply
> > this?
> 
> Hi Daniel.
> 
> I think you should apply this.
> 
> The idea here is to allow a scripted conversion at some
> point and this patch is necessary to avoid new compiler
> warnings after running the script.

Ok, put into the queue but missed the 5.7 feature freeze for drm so 5.8
probably.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
