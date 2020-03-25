Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA5FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F320772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCYLiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:38:00 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:17258
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbgCYLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:38:00 -0400
X-IronPort-AV: E=Sophos;i="5.72,304,1580770800"; 
   d="scan'208";a="343676712"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 12:37:57 +0100
Date:   Wed, 25 Mar 2020 12:37:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Simran Singhal <singhalsimran0@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, jeremy@azazel.net,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: kpc2000: Removing a blank
 line
In-Reply-To: <20200325095407.GA3788@simran-Inspiron-5558>
Message-ID: <alpine.DEB.2.21.2003251234560.2444@hadrien>
References: <20200325095407.GA3788@simran-Inspiron-5558>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Simran Singhal wrote:

> This patch fixes the checkpatch warning by removing a blank
> line.
> CHECK: Please don't use multiple blank lines

The subject line and the log message should be written in the imperative.
So that would be Remove, rather than Removing for the subject line.

The log message should first say what you did to fix the problem and why.
How the problem was found can come afterwards.  So you should not start
with "This patch fixes the checkpatch warning by".  "This patch" is not
useful, because it is obvious that it is a patch, based on the subject
line.  "fixes" does not given any information about what is done or why.
"the checkpatch warning" is useful, but it's not what one wants to see
first.

julia

>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
> Changes in v2:
>   - Make the subject and commit message correct by mentioning that
>     this patch specifically removes a blank line.
>
>  drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/kpc2000/kpc2000/pcie.h b/drivers/staging/kpc2000/kpc2000/pcie.h
> index cb815c30faa4..f1fc91b4c704 100644
> --- a/drivers/staging/kpc2000/kpc2000/pcie.h
> +++ b/drivers/staging/kpc2000/kpc2000/pcie.h
> @@ -6,7 +6,6 @@
>  #include "../kpc.h"
>  #include "dma_common_defs.h"
>
> -
>  /*      System Register Map (BAR 1, Start Addr 0)
>   *
>   *  BAR Size:
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200325095407.GA3788%40simran-Inspiron-5558.
>
