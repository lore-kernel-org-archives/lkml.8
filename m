Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA15EC55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959872076A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YJOLdK2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgDUMTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUMTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:19:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810BC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:19:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t63so3305306wmt.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdYGArEdf7fNq4YWVNuWwxljCEjnbjIB59dLDp+tDME=;
        b=YJOLdK2paZFgMhCZVABVVasiwBvfkEOoc1hrEQAvKPs5+Mg2P6LsSmj6BO40ycvFZE
         1lzUa5qItqZ2YXj6gK1ROdgDQiJBpKBYO8dbxP0ge1g5DaOfeZSR2z5FbAq/KILTaf8C
         lOSRElIey3ImoIIKhGU/AvqunSIyPQvwlw6vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RdYGArEdf7fNq4YWVNuWwxljCEjnbjIB59dLDp+tDME=;
        b=RrAzLOk/Mk3qJf9zLzX0bIlkFBmFvNZ679LLjDY9u+H7F+pPCyJUBIM7RP/3u0z8fp
         UNXytu5IMCyCDjXWOx1YtSVs/8xixkz/Rt2ofuQsADSmjaLN+rzocau03X/F72s+DeEv
         kxJ3mEjxOqHS1zSxi2OXKWB+w6+QxwweYDTQkiHCC+faKkEQ3pMYwB4TabIrJfF3xtVz
         Gfq0TQPoSRshTYx4iSde3p0m2VqbZlcteIKRLTLJseC3I5QISPsPXolj2fvYpQDEnlTA
         ZSHoF5UnwDo4+s1jkNri1e4pdUz2FjlbxcYIoiqe6epQzeApU7i6UFBVULWODH0dOgjj
         mOcA==
X-Gm-Message-State: AGi0Pubo+hznXlWdlrjH00NXy6yyqAuVz+mbH4uaCXhPZN59Kj3RYm1P
        3ezmTstLm2q59ro7eyIHo2jSXw==
X-Google-Smtp-Source: APiQypJo1ryhFC8BXxo7eBvrM5Xp8MvpJyg2ajxfVjJl5qbaspVkvh4FIH8f6zeBALstF54m2xICYA==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr4460861wma.157.1587471539888;
        Tue, 21 Apr 2020 05:18:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t67sm3584098wmg.40.2020.04.21.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:18:59 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:18:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [drm:simple_bridge_attach [simple_bridge]] *ERROR* Fix bridge
 driver to make connector optional!
Message-ID: <20200421121857.GV3456981@phenom.ffwll.local>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>
References: <CB5A5B81-F06C-4CBE-95DE-96C8723D2AC5@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB5A5B81-F06C-4CBE-95DE-96C8723D2AC5@goldelico.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:18:11PM +0200, H. Nikolaus Schaller wrote:
> Hi Maxime,
> I have started to test v5.7-rc1 and can't fully boot the GTA04
> device any more.
> 
> What I see in the log is:
> 
> [   28.567840] [drm:simple_bridge_attach [simple_bridge]] *ERROR* Fix bridge driver to make connector optional!

General PSA (and for Laurent et al, i.e. entire team of people working on all
the varios bridge conversions):

Please don't make something an error before all in-tree users are
converted. Even an informational warning is often too much, even only very
few drivers are left using an old pattern.
-Daniel

> [   28.567871] omapdrm omapdrm.0: unable to attach bridge /ocp@68000000/dss@48050000/encoder@48050c00
> [   28.786529] omapdrm omapdrm.0: omap_modeset_init failed: ret=-22
> [   28.841552] omapdrm: probe of omapdrm.0 failed with error -22
> 
> This device uses the ti,opa362 chip which did have a dedicated
> omapdss driver before (which is removed now) and which seems to
> be supported by the simple_bridge now.
> 
> The opa362 is sitting in the video out path from
> 
> 	omapdrm -> venc -> opa362 -> video-out-connector.
> 
> What does this error mean? How can it be fixed?
> 
> BR and thanks,
> Nikolaus
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
