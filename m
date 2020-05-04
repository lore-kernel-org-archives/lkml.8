Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A704FC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCA0206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyR8ZPBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgEDJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:36:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEDJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588584961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raiGMQBr/QB8sEi7LcRd99xA1ZNobBB74rqfsqcEmj8=;
        b=PyR8ZPBKn+u37tbUGuo0gW+HFEz7V2YuIqxOkCsXs9hJ/Bahfgqol6bOqlEvy2pliMLabZ
        /W3fDawPW0ZMnyOrz5Q0k9uFiKi90EyKcdL31jioEQ9wadeJoE3WdaFOEf/elyU3/hEO35
        PHD95i0CFmo77tM/WhFv+Kf4copfxbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-NTQ1e72jP8KWwUrB95dTYg-1; Mon, 04 May 2020 05:35:57 -0400
X-MC-Unique: NTQ1e72jP8KWwUrB95dTYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CA4A1B18BC0;
        Mon,  4 May 2020 09:35:56 +0000 (UTC)
Received: from gondolin (ovpn-112-215.ams2.redhat.com [10.36.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE3CB60BEC;
        Mon,  4 May 2020 09:35:54 +0000 (UTC)
Date:   Mon, 4 May 2020 11:35:51 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jared Rossi <jrossi@linux.ibm.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Message-ID: <20200504113551.2e2d1df9.cohuck@redhat.com>
In-Reply-To: <20200430212959.13070-2-jrossi@linux.ibm.com>
References: <20200430212959.13070-1-jrossi@linux.ibm.com>
        <20200430212959.13070-2-jrossi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:29:59 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check is not needed in practice as all Linux channel programs

s/is not needed/does not trigger/ ?

> are intended to use prefetch.
> 
> It is expected that all ORBs issued by Linux will request prefetch.
> Although non-prefetching ORBs are not rejected, they will prefetch
> nonetheless. A warning is issued up to once per 5 seconds when a
> forced prefetch occurs.
> 
> A non-prefetch ORB does not necessarily result in an error, however
> frequent encounters with non-prefetch ORBs indicates that channel

s/indicates/indicate/

> programs are being executed in a way that is inconsistent with what
> the guest is requesting. While there are currently no known errors
> caused by forced prefetch, it is possible in theory that forced

"While there is currently no known case of an error caused by forced
prefetch, ..." ?

> prefetch could result in an error if applied to a channel program
> that is dependent on non-prefetch.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ccw.rst |  4 ++++
>  drivers/s390/cio/vfio_ccw_cp.c  | 16 +++++++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index fca9c4f5bd9c..8f71071f4403 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -335,6 +335,10 @@ device.
>  The current code allows the guest to start channel programs via
>  START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
>  
> +Currently all channel programs are prefetched, regardless of the
> +p-bit setting in the ORB.  As a result, self modifying channel
> +programs are not supported (IPL is handled as a special case).

"IPL has to be handled as a special case by a userspace/guest program;
this has been implemented in QEMU's s390-ccw bios as of QEMU 4.1" ?

> +
>  vfio-ccw supports classic (command mode) channel I/O only. Transport
>  mode (HPF) is not supported.
>  
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 3645d1720c4b..48802e9827b6 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -8,6 +8,7 @@
>   *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>   */
>  
> +#include <linux/ratelimit.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> @@ -625,23 +626,20 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>   * the target channel program from @orb->cmd.iova to the new ccwchain(s).
>   *
>   * Limitations:
> - * 1. Supports only prefetch enabled mode.
> - * 2. Supports idal(c64) ccw chaining.
> - * 3. Supports 4k idaw.
> + * 1. Supports idal(c64) ccw chaining.
> + * 2. Supports 4k idaw.
>   *
>   * Returns:
>   *   %0 on success and a negative error value on failure.
>   */
>  int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  {
> +	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
>  	int ret;
>  
> -	/*
> -	 * XXX:
> -	 * Only support prefetch enable mode now.
> -	 */
> -	if (!orb->cmd.pfch)
> -		return -EOPNOTSUPP;
> +	/* All Linux channel programs are expected to support prefetching */

I think we want a longer comment here as well, not only in the patch
description.

"We only support prefetching the channel program. We assume all channel
programs executed by supported guests (i.e. Linux) to support
prefetching. If prefetching is not specified, executing the channel
program may still work without problems; but log a message to give at
least a hint if something goes wrong."

?

> +	if (!orb->cmd.pfch && __ratelimit(&ratelimit_state))
> +		printk(KERN_WARNING "vfio_ccw_cp: prefetch will be forced\n");

"prefetch will be forced" is a bit misleading: the code does not force
the p bit in the orb to be on, it's just the vfio-ccw cp translation
code that relies on prefetching. Maybe rather "executing unsupported
channel program without prefetch, things may break"?

Also, this message does not mention the affected device, which makes it
hard to locate the issuer in the guest. Maybe use
dev_warn_ratelimited() instead of the home-grown ratelimiting? Or did
you already try the generic ratelimiting?

>  
>  	INIT_LIST_HEAD(&cp->ccwchain_list);
>  	memcpy(&cp->orb, orb, sizeof(*orb));

