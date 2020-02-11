Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE92C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF0206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BFychGtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBKIhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:37:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33491 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBKIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:37:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so11172524wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Na2M+tRUw3DCFcB3ipBiFwcqwV93zaQwJq0JYti7BI0=;
        b=BFychGtdnTwxp2Sf7F4Rt8RgZ+OfTEpB7vJbBKJf451dCNA20TixK8NKfT3xl0SXrc
         H2G5M+6IOPLvgRX/HF5rHWytHUKqhpIFHW/ZaxK097KnSLpQStH/GJQvOEgrmWpaKk2b
         fQC+tl7jPlikLcNQRjCqh3V66K2hCMi6YgcHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Na2M+tRUw3DCFcB3ipBiFwcqwV93zaQwJq0JYti7BI0=;
        b=qr4giigZMMoD+/DFIQPzD5KZ4cLcSutOvJrGRhg3EIPc7a43rJd/HQvGHAiihpOSf+
         8LPg2lzk12u9oO7gSZMDwshqm7doskC89IezVg15rkk404uo3VYGiJR3aNJVFifWT1Vf
         AN45HgvSBQ3jbDuFWmgMjngIvTTy4Lt9w5XX1UwJgPi0gpSbH+QIsSBE8HSoRJIOKFl9
         08cNMJzUZlcSYaXze6ItvL+E5teXsX0Ob9MEQaVJiSA3znKG1xGjPXMZMa8k3+ooKDy1
         3JIgj4FS8iq7y+EY7tg075BldbHfYJe7FqdvfzkSJPGrbReTFN3o4NZHDRVJkE40CLQP
         WcmA==
X-Gm-Message-State: APjAAAXpVTC8885DhKXTZ5TxqIjw6mppjxy7uhgQrDlXJtYUU516d/sU
        JDLwo8HNdCTQJW1J23VCp4heVg==
X-Google-Smtp-Source: APXvYqzvfJ8Za8TOVTfKZnBJ5oGi6BI/nCHpXb2BYNzjcWyMJFelUivBF/3aW3AvdilEpFm07Ix0SA==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr7171037wrs.395.1581410256522;
        Tue, 11 Feb 2020 00:37:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b10sm4432682wrt.90.2020.02.11.00.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 00:37:35 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:37:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Dual licence some files in GPL-2.0 and MIT
Message-ID: <20200211083733.GV43062@phenom.ffwll.local>
Mail-Followup-To: Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, tzimmermann@suse.de, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200210153544.24750-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200210153544.24750-1-manu@FreeBSD.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:35:42PM +0100, Emmanuel Vadot wrote:
> Hello all,
> 
> We had a discussion a while back with Noralf where he said that he wouldn't
> mind dual licence his work under GPL-2 and MIT.
> Those files are a problem with BSDs as we cannot include them.
> For drm_client.c the main contributors are Noralf Trønnes and Thomas
> Zimmermann, the other commits are just catch ups from changes elsewhere
> (return values, struct member names, function renames etc ...).
> For drm_format_helper the main contributors are Noralf Trønnes and
> Gerd Hoffmann. Same comment as for drm_client.c for the other commits.

Can you pls list all contributors for each file in the commit message, so
we can make sure we're collecting all the required acks?

Afaiui for official relicensing, we need everyone.
-Daniel

> 
> Emmanuel Vadot (2):
>   drm/client: Dual licence the file in GPL-2 and MIT
>   drm/format_helper: Dual licence the file in GPL 2 and MIT
> 
>  drivers/gpu/drm/drm_client.c        | 2 +-
>  drivers/gpu/drm/drm_format_helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
