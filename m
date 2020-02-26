Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E848EC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF8B24685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gekNFchE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBZLUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:20:10 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35393 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBZLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:20:10 -0500
Received: by mail-pl1-f181.google.com with SMTP id g6so1184958plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lpgAvuPyR+sIWKoxcdeHfSe+jlWLnLYfyv35onaZuX8=;
        b=gekNFchEUC62KpMCt7uhWCQm7h6h7a4P0NUThEDpEDbnovP+eRJQ0VInNsQ+oczXxD
         HaNJLwgjxUvfhAnJ1UKI99IXO4n2UWXfRg379ENygO+QRmWPIla38U7oGIftDffZFLEv
         5pBkH2tl43gBa0dxl54ytvAkppd0NHDJn1MKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lpgAvuPyR+sIWKoxcdeHfSe+jlWLnLYfyv35onaZuX8=;
        b=iJnqSf1ihAwQSZioB2pkgZ7BIEHM4S6yG1SnL79/LpmE/3M9h+GXyI+CVQBF+Nduxd
         NixtuL+f/jKYbkdqcyPZAUpG+UYTugxHnxs2Jdr+FL26z9oseM3W4OHHfuhnpNCbwodN
         p7ry10PHDdiVIG8L/qP0cIn1HUwDVuLU68mlNwqmpa88U9goXdNtXoAPqYb0TgbJ6p6M
         mm6oy14VS7OHx0XbiInVFoo8zvp8yvWUAfQijEuCYAw+nKOS9Fez0hGrkkFpZlNBjmDx
         bpJxBPoW9grQskXkFeNiLsHSQnDBCbiwpN0Wm0tTdQfXExyzxs2CvhAyfyYC/Ed5JPQL
         etgg==
X-Gm-Message-State: APjAAAVG07J4G98T7aWNo9wJLveXUsEDT8r/W8lUHTIpdp7xoeWV42bS
        qDl4osgMVgqmvR/X3xn8ftwWLQ==
X-Google-Smtp-Source: APXvYqwSvqM81VX/g8TyRkNhHORZJgA0xILYsUrpWyxA/xoLWEyI02n228EuZG9ny4YyoNacM71KdA==
X-Received: by 2002:a17:902:b417:: with SMTP id x23mr3735687plr.9.1582716007630;
        Wed, 26 Feb 2020 03:20:07 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e6sm2572658pfh.32.2020.02.26.03.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:20:06 -0800 (PST)
Date:   Wed, 26 Feb 2020 20:20:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHv2 00/12] Implement V4L2_BUF_FLAG_NO_CACHE_* flags
Message-ID: <20200226112004.GH122464@google.com>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <35d43107-3c1c-3bf8-20e5-6569605643c3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d43107-3c1c-3bf8-20e5-6569605643c3@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/19 09:53), Hans Verkuil wrote:
[..]
> This is starting to look pretty good. I think you can drop the RFC
> for the next time you post this.

OK!

> One thing I would like to see as well is test code in v4l2-compliance,
> specifically for testing the various flags and capabilities. I.e.,
> if V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS, then it should test that it can
> set the cache flags and the NON_CONSISTENT flag. If it is not set,
> then those flags should be cleared when attempting to set them.
>
> Also code in v4l2-ctl and common/v4l2-info.cpp to support the new
> flags, both reporting them, but also setting them.

I do have two trivial patches - "sync videobuf kernel header"
and "add new capability to common/v4l2-info.cpp".

But v4l2-ctl and v4l2-compliance will require much more time,
I think. So I, hopefully, will do it sometime later.

	-ss
