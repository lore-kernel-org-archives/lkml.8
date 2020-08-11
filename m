Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ECBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7652076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4l35cES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgHKRNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgHKRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:13:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279AC06174A;
        Tue, 11 Aug 2020 10:13:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z20so7113313plo.6;
        Tue, 11 Aug 2020 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ccr1YG+uUavAc3BLSL6SyQAEXgA3SXQDKm+kKYhlM4w=;
        b=B4l35cESUVYYiGVibTB5Elvb0Gb9x+ZC/jCg8YfKLSGYU6rStZqtdsKrksLZW5+IQ+
         7Boe6neBR0hw3PY+uHysGSMEEbbpgR4wLLmB9y+MLOwk/DGRP8K8e9Kzv3fkCMXL109E
         PSYFGr8Kn8xZ9NA2iWFBhLOexL5UZL4t8jxhy7DrS/c5fmgvHDkl2vxwYzfdNEj1pnzB
         1J5B6BrerOLONvlRt+83DBxVhMjiJBk1O51swkWdRODkFJS74XnGh4sHtkznOhvrLGag
         HqSUZMSMCro1F5ZOEsH4C3zYYCS9pQ68NEa4b2nDKitTTdTglq5nx4Ds52O1WtH/Uz8D
         GnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ccr1YG+uUavAc3BLSL6SyQAEXgA3SXQDKm+kKYhlM4w=;
        b=RAimADjStAL3vIOqOjavrMBUDUY7Pxii6Ri3YI6pIqdSqmRyznX7/f65mjAUAm8+UR
         JttpGFOQsmV8/cvBIE3W8/Jx7arcukBq2KdvUqBk1ME1Rpxye9FWd0f9n3+RPbMHKqC+
         vZF/bPFzafx10PvufVYSCSkBVrJOy6vjPziDYDgRDzfXNyvVh4H0CD2VmNr7ds+l7KSV
         FUCiXrm4hiJHlzhFqZcNnJNWxoXpJgI/mu5XN0z/93kwh+plYf8tx76vCOlLU+4/wiDw
         lsuw3+Tm/v16xr8wYl18k6O/dyqbIwp1SjEOLu0Z1YdDOm/lqY3Z7L/NXsve/AbWrVFi
         +uag==
X-Gm-Message-State: AOAM532M0k3r2wuqYjXYCD+mur3RDrTQ73ObmlmqOOJYjx3SGmp1I7Hm
        4SNxtcKpFb0s/WELDGtGYKeYJP77lzVTzw==
X-Google-Smtp-Source: ABdhPJy800tC/x7FlqOOxjMO4tBXPXzIbpWJ/iVl4flqCxZo9vvRRlR0CoKLAPFwfKhKRVvpFii0tg==
X-Received: by 2002:a17:902:b111:: with SMTP id q17mr1704052plr.202.1597165997683;
        Tue, 11 Aug 2020 10:13:17 -0700 (PDT)
Received: from arch ([27.255.176.246])
        by smtp.gmail.com with ESMTPSA id y20sm26228569pfn.183.2020.08.11.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 10:13:16 -0700 (PDT)
Date:   Tue, 11 Aug 2020 22:43:08 +0530
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver-API: Documentation: Replace deprecated :c:func:
 Usage
Message-ID: <20200811171308.GA69827@arch>
References: <20200810182107.18577-1-puranjay12@gmail.com>
 <20200811103640.19d3121a@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811103640.19d3121a@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:36:40AM -0600, Jonathan Corbet wrote:
> On Mon, 10 Aug 2020 23:51:07 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
> 
> > Replace :c:func: with func() as the previous usage is deprecated.
> > 
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  Documentation/driver-api/device-io.rst | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> I applied this patch from you in early July, and it's in mainline now...?
this is a new patch with same name I think?, this is not that patch.
> 

> jon

thanks,
puranjay
