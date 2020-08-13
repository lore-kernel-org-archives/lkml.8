Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMUsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:48:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93FDC061757;
        Thu, 13 Aug 2020 13:48:11 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 92CD35A0;
        Thu, 13 Aug 2020 20:48:09 +0000 (UTC)
Date:   Thu, 13 Aug 2020 14:48:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation/locking/locktypes: fix the typo
Message-ID: <20200813144808.4bcd0dfd@lwn.net>
In-Reply-To: <20200813060220.18199-1-sjhuang@iluvatar.ai>
References: <20200813060220.18199-1-sjhuang@iluvatar.ai>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 14:02:20 +0800
Huang Shijie <sjhuang@iluvatar.ai> wrote:

> We have three categories locks, not two.
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  Documentation/locking/locktypes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 1b577a8bf982..4cefed8048ca 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -10,7 +10,7 @@ Introduction
>  ============
>  
>  The kernel provides a variety of locking primitives which can be divided
> -into two categories:
> +into three categories:

One can never get away from those off-by-one errors...applied, thanks.

jon
