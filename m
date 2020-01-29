Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6BC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533E220CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA2FRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:35 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDp3hCcz9sSG; Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bfbe37f0ce994e7a9945653d7624fadc5c500a9f
In-Reply-To: <1577900990-8588-6-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Scott Wood <oss@buserror.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/10] powerpc/83xx: use resource_size
Message-Id: <486sDp3hCcz9sSG@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-01 at 17:49:45 UTC, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end - ptr.start + 1)
> + resource_size(&ptr)
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bfbe37f0ce994e7a9945653d7624fadc5c500a9f

cheers
