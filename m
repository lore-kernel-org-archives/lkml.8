Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A558C206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZlny/Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHYAIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHYAIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:08:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:08:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z18so291231pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCtJ6y/corMJGMSjjBXZ0t8LvIkH00RakiQX5uTiZ9I=;
        b=PZlny/UgBuwewfmYbMdujOA4X6pD4zbOcsm47Nw/99lzEbbK+qYMe3tVUixjqKcU4W
         C1W+ziouidvfkGTp4YM5d2r5RmpsRv6gz3FWFrjT1b2eGq66gD4JRLEdx/wnt/HKyy7Z
         92B83Sop5z69Yb3RGIOxaMrRHSKY35kJMq7UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCtJ6y/corMJGMSjjBXZ0t8LvIkH00RakiQX5uTiZ9I=;
        b=LooLUaOiGr9mp0vZPhRcjm8GsYgPMnUNxH4vUCgPFlDQpEQcshwN8c7XtqIQ4AhAz5
         VwVYGSEtSSAV1Xgu/mcsVg3DIu78gHFGw8S0zYrbKYv/otu8VVbuxVBfratUtIg8q7VP
         d58HzkyfHOaOks/w+NH/cf0Wu1bzTrerlDY5ejnsnsgg/EBKIO7kcnIHw5xyBje5avz7
         YAsprK5k4F71zkOLJc/5ziYNICZIY4XD+5pCSt0w0Xmr1pe3/c5JgUSdksMMF10wXtEu
         4iITL42wtDldFuSr8pcafBpcRIrkv1RAmHG/nFQfwzUBAbL6ICaKTqO3Uxp/ZIN/3nsM
         FWfw==
X-Gm-Message-State: AOAM532QsNwNuB2wLNx6/HEKSwjXsLx+u3FdYl77UCOLfgajNR5eXJrY
        XiXE1PDjFTPrkhuwxdUh3uBIFA==
X-Google-Smtp-Source: ABdhPJx89StBjDDWNBIcSgKFIXxVIbai4JQfBHGbb60GQ51ySMK9yY3iM6+mfgS0ji2LOVU6ldqqwA==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr1408421pjb.30.1598314128878;
        Mon, 24 Aug 2020 17:08:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g5sm628179pjx.53.2020.08.24.17.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 17:08:47 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:08:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] interconnect: Show bandwidth for disabled paths as zero
 in debugfs
Message-ID: <20200825000846.GC486007@google.com>
References: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:50:12AM -0700, Matthias Kaehlcke wrote:
> For disabled paths the 'interconnect_summary' in debugfs currently shows
> the orginally requested bandwidths. This is confusing, since the bandwidth
> requests aren't active. Instead show the bandwidths for disabled
> paths/requests as zero.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

ping, any comments on this?
