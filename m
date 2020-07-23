Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D55C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B792E206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGWUJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:09:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:42346 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGWUJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:09:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5CF682CD;
        Thu, 23 Jul 2020 20:09:40 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:09:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH RESEND] docs/core-api: memory-allocation: describe
 reclaim behaviour
Message-ID: <20200723140939.34cf8116@lwn.net>
In-Reply-To: <20200719153641.231131-1-rppt@kernel.org>
References: <20200719153641.231131-1-rppt@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 18:36:41 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Changelog of commit dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") has very nice description
> of GFP flags that affect reclaim behaviour of the page allocator.
> 
> It would be pity to keep this description buried in the log so let's expose
> it in the Documentation/ as well.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  Documentation/core-api/memory-allocation.rst | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Applied, thanks.

I'm not quite sure how this fell through the cracks before, sorry about
that.

jon
