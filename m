Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BBC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02102075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HR10p5le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGIJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:09:01 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46157 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgCGIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:09:01 -0500
Received: by mail-pf1-f177.google.com with SMTP id o24so2275851pfp.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nU16B2xp2DIniBDEEsyS+pcU0JMbdNxb8GbdumZjS0k=;
        b=HR10p5leSjFRnwqUNx/Gv31a/IZ40Dd7xPHR6I6PRT8uz9ssb0Y2Bz3NBM+yPWuZ52
         d2cv715aawG7DMJxN4yddW3r5hT2qweQjWwYUPr5Ei4zElV0V6jPGXeKDuI1Iu9Ozj7L
         rrgz+WPxWeUO3jBlE8MwXTq1Q07C46kQ7Li+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nU16B2xp2DIniBDEEsyS+pcU0JMbdNxb8GbdumZjS0k=;
        b=o2bOaweehnl+2X7fg/nt4sLRvnew2Wr4NVAO53WgyciSHUqhsSpkTMYoZoyFpD9gGy
         qVUjYFER6qDpq3qFmmVu0eSuedXJNeO1lCIrS4FWNn/H/nM8mQW4QgXQn22UE/vpXf1f
         CJ0JwHVyMndFvqG6XBo+ZranQjEH4Ul8n0kQHqcuBo3+71V3BxTUtlPNyiSXFbaVCPiF
         8OSVkSQKny23s+2xtZvyD7oSd5pblPNRNwqnsC2m0L5/Ekv++JLj6vAGaGt2KgmBjY3l
         PPR+22HwneqR9Y9JFTQ/ByB41VJPw3tS7qLmjEk8Mc5pcImF/qvWmkVLq0sxK2nJFff+
         5S/g==
X-Gm-Message-State: ANhLgQ31TYLWu1b+xJxKD0MMAzTJjXA788AbFkfbwiKXtn1uvZEwPy5O
        hpjldKzXYlnP2G+ESrmWb9J8PQ==
X-Google-Smtp-Source: ADFU+vskDNL0SpSDH5EH2mSWBx/vmBvwPv11i4h/1pELnQ8rLtQ5q2SeYWpH0NindybguMHaTHjlrw==
X-Received: by 2002:a62:17d1:: with SMTP id 200mr7480449pfx.227.1583568538332;
        Sat, 07 Mar 2020 00:08:58 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id m12sm11775429pjf.25.2020.03.07.00.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 00:08:57 -0800 (PST)
Date:   Sat, 7 Mar 2020 17:08:55 +0900
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
Subject: Re: [PATCHv4 00/11] Implement V4L2_BUF_FLAG_NO_CACHE_* flags
Message-ID: <20200307080855.GE176460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <04241ce5-dc41-9ea8-a058-5c0d8f9ba5a4@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04241ce5-dc41-9ea8-a058-5c0d8f9ba5a4@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/06 15:18), Hans Verkuil wrote:
[..]
> As mentioned in my v4 review I found a serious bug when testing with
> v4l2-compliance. That meant that this series was not tested properly,
> which is a requirement for something that touches the core framework.

I run tests locally on my board, but the scenarios are rather limited.

> I've posted an RFC patch with my v4l-utils changes (assumes you've run
> 'make sync-with-kernel' first), but that's just very basic testing. You
> can use it as your starting point.

Thanks. I'll try to use it as a starting point and run more "diverse"
tests cases.

> It needs to be expanded to test the various combinations of flags and
> capabilities. I don't think there is a reliable way of actually testing
> the cache hint functionality, so that can be skipped, but the compliance
> test should at least test the basic behavior depending on whether or not
> the cache hints capability is set.

I'll take a look.

> I also would like to see a patch adding cache hint support to an existing
> driver (more than one if possible) and the compliance output when tested
> against that driver.

Need to talk to Tomasz and Pawel first.

> You should also test with the test-media script in contrib/test: run as
> 'sudo test-media mc' to test with all the virtual drivers. If it all passes,
> then that's a good indication that there are at least no regressions.

OK, let me try.

	-ss
