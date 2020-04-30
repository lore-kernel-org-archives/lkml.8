Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F2C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D537214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588236614;
	bh=ghrQEmeIlI+g1P6iSZ6DPBPbRnUsSttZWP+GFYy29mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QCJbk7D7XJ6GV7FbRi32wPhxr9JeUHL/zX8fOebWOp3EBNw/3oYKZh+otbB+WAr7c
	 FzZYa6VfG4jtkVsRh9TNH79tYXrWBsjtLu9Ve3ZTXJk+spDPPXg05gpiCorXSU//Sr
	 Li42Aer1PVkM4B1dpM6oDC7/ZWOhvsBA2xdod84U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3IuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgD3IuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:50:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D6E20787;
        Thu, 30 Apr 2020 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588236612;
        bh=ghrQEmeIlI+g1P6iSZ6DPBPbRnUsSttZWP+GFYy29mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaqhsY86LNEksszvxHtMCCMJEREzCEgFGgqb0u5DpNO5Dv36tLHp1jXriMGXRhM6g
         0IQfo4XYD7e8ikcmo5LrxJpxAG57PPiEbMIZrBHCTsBbTMMLAlK3QtxxjXDdsIS1PV
         0We4M0prTxcdZvZteHR81YOQBz0OW3xRfgcS5GXM=
Date:   Thu, 30 Apr 2020 10:50:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v3 1/1] binder: transaction latency tracking for user
 build
Message-ID: <20200430085010.GE2496467@kroah.com>
References: <1586929044-12708-2-git-send-email-Frankie.Chang@mediatek.com>
 <1588234439-7959-1-git-send-email-Frankie.Chang@mediatek.com>
 <1588234439-7959-2-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588234439-7959-2-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:13:59PM +0800, Frankie Chang wrote:
> Record start/end timestamp for binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),
> if yes, printing related information for tracing.
> 
> /* Implement details */
> - Add tracepoint/trace at free transaction.
>   Since the original trace_binder_transaction_received cannot
>   precisely present the real finished time of transaction, adding a
>   trace_binder_free_transaction at the point of free transaction
>   may be more close to it.
> 
> - Add latency tracer module to monitor slow transaction.
>   The trace_binder_free_transaction would not be enabled
>   by default. Monitoring which transaction is too slow to
>   cause some of exceptions is important. So we hook the
>   tracepoint to call the monitor function.
> 
> - Move some struct from core file to header file.
>   Need some struct defined in core file in latency trace module
>   In addition, moving all structs to header file makes module
>   more extendable, and make all these strcuts to be defined
>   in the same file.
> 
> Signed-off-by: Frankie Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/Kconfig                 |    8 +
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |  408 +-----------------------------
>  drivers/android/binder_internal.h       |  416 +++++++++++++++++++++++++++++++
>  drivers/android/binder_latency_tracer.c |  105 ++++++++
>  drivers/android/binder_trace.h          |   49 ++++
>  6 files changed, 583 insertions(+), 404 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c

What changed from previous versions?  That always needs to go below the
--- line, as is documented in the kernel documentation.

Please fix that up and resend a v4.

thanks,

greg k-h
