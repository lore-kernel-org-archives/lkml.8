Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19EFC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21582076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kdV7+rdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgDUMQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:16:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE16C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:16:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so3432103wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HlX9CDNaQn0ah+4R2AJ8wU9V1YmJ5LGY+YY4RdpAxCc=;
        b=kdV7+rdOTNmiPODp9VtKU4EpsM+j0zHeqYPxjmux0otaOS7b/KLp9tNgpGGH2KjNhE
         o1nuHapdqGwdeIK7l7EzC76Krca+ooeFj/9WU2im5j1/SdHjGluDrkALqRqWu/c7To61
         SbCPhDmUc+mKUw2JuqgyJ+cTndnRdCZ8LNAaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HlX9CDNaQn0ah+4R2AJ8wU9V1YmJ5LGY+YY4RdpAxCc=;
        b=p9W2ehfp537QiiJSZBTUTBEnFeo3KH3hOAMEetGQRnFHW+36/17Ua04N6cNzRNeWKo
         FTLXjclFOoRtccbJtVrn5U8jzLXTmiXMW91Mt+ttJKDE64dhR4xxWK4RHhyLLBCRsJMg
         Utf1RTtAeotURmV8zHwJK2wspr6TsjSw0hOWA7KxPZsFAL+oBdhNj85/6SmDClYix+hw
         D4jzuv4R4CiyM/zNxxBNjZW1efFAN56842TM+Bwz6HQ5PXk8UYcHnL/WisckAtvZ/vsf
         buKaw3x49EvG7Tdtz7c6isI0HBGHhR3/OXT2JHNtIFgYHWd79ag2wv80inW3akIXBJ6A
         gcLA==
X-Gm-Message-State: AGi0PuZk0KysOBGyZmBhcJlPn4Makzdtwg6C4md/UZho9aZJBvdcQFMe
        TxDj5eRUg7SFQI+zxLYfQ3AKog==
X-Google-Smtp-Source: APiQypLp+msXrwjQeDf59CmGpFmh2wKSOzgAEen1QE4ESErJgzU2kye0C9MqIxLWezadPjOfFk67bw==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr4976643wme.82.1587471403637;
        Tue, 21 Apr 2020 05:16:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 91sm3728608wra.37.2020.04.21.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:16:43 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:16:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 1/8] drm/fourcc: Add modifier definitions for
 describing Amlogic Video Framebuffer Compression
Message-ID: <20200421121641.GU3456981@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
 <20200416152500.29429-2-narmstrong@baylibre.com>
 <20200417150729.GP3456981@phenom.ffwll.local>
 <65879a34-2e31-2908-3cc4-183f62c70ca0@baylibre.com>
 <CAKMK7uHXtcMFv6LpCEjTg5V-TXbkt2eLyitZoCfSc-nMnwJbuA@mail.gmail.com>
 <25f5ed14-2caf-6b2b-2cd4-3dbf0dd9a03c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f5ed14-2caf-6b2b-2cd4-3dbf0dd9a03c@baylibre.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:21:24PM +0200, Neil Armstrong wrote:
> On 17/04/2020 20:14, Daniel Vetter wrote:
> > On Fri, Apr 17, 2020 at 6:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 17/04/2020 17:07, Daniel Vetter wrote:
> 
> [...]
> 
> > 
> > Yup there's a number of parametried modifiers. As long as the stuff
> > you get from a DRM_FORMAT_MOD_ ... macro is a full modifier with
> > everything it should be all fine.
> 
> Would something like that be ok ?
> 
> #define __fourcc_mod_amlogic_layout_mask 0xf
> #define __fourcc_mod_amlogic_options_shift 8
> #define __fourcc_mod_amlogic_options_mask 0xf
> 
> #define DRM_FORMAT_MOD_AMLOGIC_FBC(__layout, __options) \
> 	fourcc_mod_code(AMLOGIC, \
> 			((__layout) & __fourcc_mod_amlogic_layout_mask) | \
> 			((options) & __fourcc_mod_amlogic_options_mask \
> 			 << __fourcc_mod_amlogic_options_shift))
> 
> /* Amlogic FBC Layouts */
> 
> /* bla */
> #define AMLOGIC_FBC_LAYOUT_BASIC		(1ULL)
> 
> /* bla */
> #define AMLOGIC_FBC_LAYOUT_SCATTER		(2ULL)
> 
> /* Amlogic FBC Layout Options Bit Mask */
> 
> /* bla */
> #define AMLOGIC_FBC_OPTION_MEM_SAVING		(1ULL << 0)

lgtm.
-Daniel

> 
> Neil
> 
> > -Daniel
> > 
> >> Neil
> >>
> >>> -Daniel
> >>>
> >>>> +
> >>>>  #if defined(__cplusplus)
> >>>>  }
> >>>>  #endif
> >>>> --
> >>>> 2.22.0
> >>>>
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
