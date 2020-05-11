Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C8C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7256A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b+tSFMrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgEKKMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729231AbgEKKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:12:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:12:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f134so5253652wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxDN71QWVlIvPR/Qe9BjED7lK/KCTSrcSC7GeFvMB4Y=;
        b=b+tSFMrvsOVBFnenMDfROizokqqsnSkXcglzgocb+51zy42IXbNcvm5CHNupiOZMBs
         ANqitFhidqbalpsVfp+bA/q0JND5ePnK4K7dgxr1Y+0WOZLuIknw/CLde/AY7WU+iUoV
         fDLkN/x1hi73cW3Lol0SnEsnc+wQwS//RVi7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AxDN71QWVlIvPR/Qe9BjED7lK/KCTSrcSC7GeFvMB4Y=;
        b=rn3kGuxwA0nzrgKB/Yf5PXJg03/5vXQAQGUuLLY8LzF25f9NHJ/2u6eDDy2KmYDwUm
         TskJ3f0TqXZnwIddzcgsUCpYj140slw6oss7cpBwnuZbsawEHC0AEvh3PawXlhlQpx3y
         e4HsLcxSe7Wfg2X5PW5TvESUhu85dgoncOvFX2RBiiuckharDpYg6zgWjDcxKjJfM8l9
         OOLxrY8OHBQPDhOJ7mbQ+HRU4HVhRqhX0e6NzfBJfbg4pwChPy36cfhLzvH0QYNNYYdI
         5/NMzaNBiZA8D/qfyfJQKD1eVJrhq3nLvMUhTMtStxQNOyuqVBcO8fvlWq+WfuznrWZM
         fRuw==
X-Gm-Message-State: AGi0PuaUe+kGeQ8F7Vki4OSqB1+hQPt6ENNjLun1CQB+17rF8LVZpEx9
        6ZD5UZqF1bwrzU4khjiirmw9mQ==
X-Google-Smtp-Source: APiQypJduS5g8MSJy/JNzf+Alo7zIfVFjEdcgIp2nM0k6p91EvBmHQ+tR8aq272pVf8oIkv+vmiJPw==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr2914697wmo.45.1589191925721;
        Mon, 11 May 2020 03:12:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a10sm18015507wrp.0.2020.05.11.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 03:12:05 -0700 (PDT)
Date:   Mon, 11 May 2020 12:12:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-fence: use default wait function for mock fences
Message-ID: <20200511101202.GB206103@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
 <20200511091142.208787-2-daniel.vetter@ffwll.ch>
 <158919006380.1729.6928823811672806738@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158919006380.1729.6928823811672806738@build.alporthouse.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:41:03AM +0100, Chris Wilson wrote:
> Quoting Daniel Vetter (2020-05-11 10:11:41)
> > No need to micro-optmize when we're waiting in a mocked object ...
> 
> It's setting up the expected return values for the test.

Drat, I suspect something like that but didn't spot it. Kinda wondering
whether we should maybe lift the -ETIME special case to the generic
version. But that's not really a safe thing to do there, drivers might
actually use it for funny stuff.

Anyway motivation is that I'm pondering some extensions of dma_fence_wait
and removing as many of the ->wait hooks as possible would have helped.
But there's some nastier stuff like the legacy nouvea and radeon ones.
-Daniel
