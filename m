Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B5CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BCD22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OM/JL5bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgG3DUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgG3DUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:20:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B8C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:20:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b186so3947492pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1CdvmZ2y3O11xRbSas05vz3yxZKjjWMivmHxLl+TXRw=;
        b=OM/JL5bnbfc8/rOT7SazeRLNGTmcPwnhSE2CSA1CqhgNigfDwfzLxj0BPkWlYqYW9b
         6HEndzeOJuiNQ3xhOFhtDT3B/+SJbDE1Rc6iM/UP1jwrQPCHhZxDHS+us8Ru12XI6i5c
         UIQLDvoCch0lcO+j+J5v2PcLL5b6UMAmqdn0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CdvmZ2y3O11xRbSas05vz3yxZKjjWMivmHxLl+TXRw=;
        b=DWv3adtKkogjwB7LImQGEiynixqTqeAcPRtAM+D4ejh95OrAtmJrNR6vVE0sCEHLVU
         Zv6EUF9hipv5jCPLCIP0rvstkBmwnMbMrGg16hQdwAP7Bp9TNMtrYk1Y2+y3blZtJ+Ny
         juBjFIOObjGCLcXgPpKrL4MgECPqII54KT0HkwSg3imRMwNwR6ma2JhhJosMn+Dci2dU
         hJN2RJOjvvUMmV1wvBsJFmOX/dKgHiijNAcrD6OfNtuLCGK3/u+WNmjbcI/HVohEOGzr
         YyOYGnHT1X5zzv2VNYUuztWq06MJ9BAyvFVDbpFUXjbDGrdLrDWQwaPFisNS6eF5sF/L
         itDg==
X-Gm-Message-State: AOAM531rQV2bAeLYRSDxfj3O1Whr6YqnVUme4yFIfQo+q6S95UgFZb2u
        udoW+CyV0CFR1ObTxx/MXrbtZQ==
X-Google-Smtp-Source: ABdhPJy0dnH/Y0r3adW9sU/4OMzLuJibNCs455u5u3r4V8O/DyZvrAFqVZFLvxR8iTMi//1kkpVS0g==
X-Received: by 2002:a63:140f:: with SMTP id u15mr30513554pgl.94.1596079213134;
        Wed, 29 Jul 2020 20:20:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t17sm4064454pgu.30.2020.07.29.20.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 20:20:12 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:20:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        torvalds@linux-foundation.org, lokeshvutla@ti.com,
        tony@atomide.com, daniel.lezcano@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        davem@davemloft.net, hkallweit1@gmail.com, vkoul@kernel.org,
        grygorii.strashko@ti.com, peter.ujfalusi@ti.com,
        santosh.shilimkar@oracle.com, t-kristo@ti.com,
        zaslonko@linux.ibm.com, catalin.marinas@arm.com,
        Dave.Martin@arm.com, broonie@kernel.org, yu-cheng.yu@intel.com,
        Thinh.Nguyen@synopsys.com, felipe.balbi@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] include: Replace HTTP links with HTTPS ones
Message-ID: <202007292020.12C777FAB4@keescook>
References: <20200726110117.16346-1-grandmaster@al2klimov.de>
 <202007291420.9AF368B18@keescook>
 <20200729144510.d77300ba8f7e891fb9fb595d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729144510.d77300ba8f7e891fb9fb595d@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:45:10PM -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2020 14:21:12 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > On Sun, Jul 26, 2020 at 01:01:17PM +0200, Alexander A. Klimov wrote:
> > > Rationale:
> > > Reduces attack surface on kernel devs opening the links for MITM
> > > as HTTPS traffic is much harder to manipulate.
> > > 
> > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Jon, do you want to take this?
> 
> I added this to -mm yesterday.

Ah excellent. :) Thanks!

-- 
Kees Cook
