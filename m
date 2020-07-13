Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B41C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AB1206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGMPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:31:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:35506 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMPbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:31:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ACFB32E2;
        Mon, 13 Jul 2020 15:31:03 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:31:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: documentation: Replace HTTP links with HTTPS
 ones
Message-ID: <20200713093102.0fe0557e@lwn.net>
In-Reply-To: <20200713144103.35049-1-grandmaster@al2klimov.de>
References: <20200713144103.35049-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 16:41:03 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> diff --git a/Documentation/core-api/kobject.rst b/Documentation/core-api/kobject.rst
> index e93dc8cf52dd..2739f8b72575 100644
> --- a/Documentation/core-api/kobject.rst
> +++ b/Documentation/core-api/kobject.rst
> @@ -6,7 +6,7 @@ Everything you never wanted to know about kobjects, ksets, and ktypes
>  :Last updated: December 19, 2007
>  
>  Based on an original article by Jon Corbet for lwn.net written October 1,
> -2003 and located at http://lwn.net/Articles/51437/
> +2003 and located at https://lwn.net/Articles/51437/

Applied, thanks.

jon
