Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E0CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC6F217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBERP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:15:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:52466 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgBERP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:15:57 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 90CDD6E5;
        Wed,  5 Feb 2020 17:15:56 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:15:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, SeongJae Park <sjpark@amazon.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 2/5] docs/ko_KR/howto: Insert missing dots
Message-ID: <20200205101555.23ffde75@lwn.net>
In-Reply-To: <20200131205237.29535-3-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
        <20200131205237.29535-3-sj38.park@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 21:52:34 +0100
SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

I'd really rather not see patches with an empty changelog, please, even
when they are relatively trivial.  But also...

> ---
>  Documentation/translations/ko_KR/howto.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
> index ae3ad897d2ae..6419d8477689 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -1,6 +1,6 @@
>  NOTE:
> -This is a version of Documentation/process/howto.rst translated into korean
> -This document is maintained by Minchan Kim <minchan@kernel.org>
> +This is a version of Documentation/process/howto.rst translated into korean.
> +This document is maintained by Minchan Kim <minchan@kernel.org>.

Is this even true?  Minchan hasn't touched this document in years, and you
didn't see fit to copy him on the change.  I'm thinking that adding
periods doesn't seem like the right fix here.

Thanks,

jon
