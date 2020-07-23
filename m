Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89372C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECB52065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGWUc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:32:58 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15055C0619DC;
        Thu, 23 Jul 2020 13:32:58 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B7D3D2CD;
        Thu, 23 Jul 2020 20:32:57 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:32:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: timers: drop documentation about LB_BIAS
Message-ID: <20200723143256.192cdc71@lwn.net>
In-Reply-To: <1595088518-28116-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595088518-28116-1-git-send-email-Julia.Lawall@inria.fr>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 18:08:38 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> The LB_BIAS feature was removed in commit 1c1b8a7b03ef ("sched/fair:
> Replace source_load() & target_load() with weighted_cpuload()"), so drop
> the mention that it is disabled in the no_hz case.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  Documentation/timers/no_hz.rst |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
> index 065db21..c4c70e1 100644
> --- a/Documentation/timers/no_hz.rst
> +++ b/Documentation/timers/no_hz.rst
> @@ -171,8 +171,6 @@ not come for free:
>  	slightly differently than those for non-adaptive-tick CPUs.
>  	This might in turn perturb load-balancing of real-time tasks.
>  
> -6.	The LB_BIAS scheduler feature is disabled by adaptive ticks.
> -

Applied, thanks.

jon
