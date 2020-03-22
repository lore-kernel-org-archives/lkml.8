Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A619C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D3220736
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cI3Ojtue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCVPQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:16:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33791 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgCVPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:16:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id j1so3464012pfe.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6dpw9rDwVFF+jBSqqps/Fz65ini0gev9EsYNdaUAAOw=;
        b=cI3Ojtue1abNbnhEXHj2iryE86swUOebT5p/+8RCaO5uNSnhQ9Y7TVRjkqQM9VLRFP
         dJv9sDMVYKxFQa0rCrirVl8449WdxPXtbt8AiVGom/vRGCQjpA1SrRhdc4HdrJ8NCERe
         BzLIan9hI5+ldnBF53MPXrWaJDzIME7aEKxgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6dpw9rDwVFF+jBSqqps/Fz65ini0gev9EsYNdaUAAOw=;
        b=aaOCm1GLbkj2YH5UiV+nq3AyTMVR/X3ei3SOtDabQ9LLeiDFdrCnQizEd0Lm7No1zs
         Co6mHA16iG/YcgrMrDZzQ0bST0r8Em+8rNnxde8L5fOsfnmMyUJMtb0CbUbiYb4QiDJw
         387Jx25U+ViYlJa6MN5Ib/Q29NAIKpC8u5TDL8X4fKc8c6sufF2l9h8mq6GY7Gwtybzo
         qdb6XwidWyr8IQKWWM4VMo4PUkRpaYhxn93unxi/2a3K5vt8g3CeDFcrVwpBXluYJyuq
         XG1EcsNDPolIGSByWljdrY/XmZ/e/nz0ghU9o1qnAccswyynHXwKk9WeBfFiq8JhWlwO
         BdNA==
X-Gm-Message-State: ANhLgQ0XctbGqJus4i516Ecnj+iRc/giBTduFojznVKCgjVJaNm43YX/
        N57m/c7yEhqqT/y4en9VDVTWtQ==
X-Google-Smtp-Source: ADFU+vuWKzy086D5ElUKvJfnJKYW2BQ4xV1n4gXNC8LIJaIR7+nZmnQmmYjnlO8aEfT/1OxfgJL/Cg==
X-Received: by 2002:a63:ff0d:: with SMTP id k13mr8595652pgi.376.1584890163299;
        Sun, 22 Mar 2020 08:16:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm10770850pfz.91.2020.03.22.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:16:02 -0700 (PDT)
Date:   Sun, 22 Mar 2020 08:16:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 05/11] pstore/blk: blkoops: support ftrace recorder
Message-ID: <202003220814.713B5DF7AA@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-6-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181117.6EA5486@keescook>
 <42205dc0-f001-bbf0-00b6-85aca0cdb1f8@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42205dc0-f001-bbf0-00b6-85aca0cdb1f8@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 07:42:07PM +0800, WeiXiong Liao wrote:
> On 2020/3/19 AM 2:19, Kees Cook wrote:
> > On Fri, Feb 07, 2020 at 08:25:49PM +0800, WeiXiong Liao wrote:
> >> +static int blkz_recover_zones(struct blkz_context *cxt,
> >> +		struct blkz_zone **zones, unsigned int cnt)
> >> +{
> >> +	int ret;
> >> +	unsigned int i;
> >> +	struct blkz_zone *zone;
> >> +
> >> +	if (!zones)
> >> +		return 0;
> >> +
> >> +	for (i = 0; i < cnt; i++) {
> >> +		zone = zones[i];
> >> +		if (unlikely(!zone))
> >> +			continue;
> >> +		ret = blkz_recover_zone(cxt, zone);
> >> +		if (ret)
> >> +			goto recover_fail;
> >> +	}
> >> +
> >> +	return 0;
> >> +recover_fail:
> >> +	pr_debug("recover %s[%u] failed\n", zone->name, i);
> >> +	return ret;
> >> +}
> > 
> > Why is this introduced here? Shouldn't this be earlier in the series?
> 
> blkz_recover_zones() is used to recover a array of zones. Only ftrace
> recorder need it, so it's introduced here.

Okay, that's fine. I thought maybe the dmesg front-end could use it too?
Anyway, I can look at it again in v3. :)

-- 
Kees Cook
