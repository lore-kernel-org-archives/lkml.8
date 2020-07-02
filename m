Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0527C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856120874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqLv/VbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgGBJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:46:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgGBJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593683162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm49XITAa3YU5qe3fjMCfJ04QxbXtAJzXaKHQsj4bIU=;
        b=PqLv/VbGm/sHavli/L4DDUouxBi/+q2fflzx21lePep0dbk5hxrYAwWrpCDeo2Y5FR2xei
        FyyAf/AuvWd2qnm3JPx9st3MBPe73gAMi5roYgEc5ESFC7RZWVZ7xeAGl06I2/Fjw/UuXF
        wuofc+UZY0XLt9NpjRyCNDnCezdB91g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34--t6KF_-cMS-AJaekxw4-BA-1; Thu, 02 Jul 2020 05:45:58 -0400
X-MC-Unique: -t6KF_-cMS-AJaekxw4-BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF731005513;
        Thu,  2 Jul 2020 09:45:56 +0000 (UTC)
Received: from ovpn-115-71.ams2.redhat.com (ovpn-115-71.ams2.redhat.com [10.36.115.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235FB78120;
        Thu,  2 Jul 2020 09:45:53 +0000 (UTC)
Message-ID: <500b4843cb7c425ea5449fe199095edd5f7feb0c.camel@redhat.com>
Subject: Re: Packet gets stuck in NOLOCK pfifo_fast qdisc
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jonas Bonn <jonas.bonn@netrounds.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Josh Hunt <johunt@akamai.com>
Cc:     Michael Zhivich <mzhivich@akamai.com>,
        David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Date:   Thu, 02 Jul 2020 11:45:52 +0200
In-Reply-To: <7fd86d97-6785-0b5f-1e95-92bc1da9df35@netrounds.com>
References: <465a540e-5296-32e7-f6a6-79942dfe2618@netrounds.com>
         <20200623134259.8197-1-mzhivich@akamai.com>
         <1849b74f-163c-8cfa-baa5-f653159fefd4@akamai.com>
         <CAM_iQpX1+dHB0kJF8gRfuDeAb9TsA9mB9H_Og8n8Hr19+EMLJA@mail.gmail.com>
         <CAM_iQpWjQiG-zVs+e-V=8LvTFbRwgC4y4eoGERjezfAT0Fmm8g@mail.gmail.com>
         <7fd86d97-6785-0b5f-1e95-92bc1da9df35@netrounds.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, 2020-07-02 at 08:14 +0200, Jonas Bonn wrote:
> Hi Cong,
> 
> On 01/07/2020 21:58, Cong Wang wrote:
> > On Wed, Jul 1, 2020 at 9:05 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > On Tue, Jun 30, 2020 at 2:08 PM Josh Hunt <johunt@akamai.com> wrote:
> > > > Do either of you know if there's been any development on a fix for this
> > > > issue? If not we can propose something.
> > > 
> > > If you have a reproducer, I can look into this.
> > 
> > Does the attached patch fix this bug completely?
> 
> It's easier to comment if you inline the patch, but after taking a quick 
> look it seems too simplistic.
> 
> i)  Are you sure you haven't got the return values on qdisc_run reversed?

qdisc_run() returns true if it was able to acquire the seq lock. We
need to take special action in the opposite case, so Cong's patch LGTM
from a functional PoV.

> ii) There's a "bypass" path that skips the enqueue/dequeue operation if 
> the queue is empty; that needs a similar treatment:  after releasing 
> seqlock it needs to ensure that another packet hasn't been enqueued 
> since it last checked.

That has been reverted with
commit 379349e9bc3b42b8b2f8f7a03f64a97623fff323

---
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 90b59fc50dc9..c7e48356132a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3744,7 +3744,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
> 
>  	if (q->flags & TCQ_F_NOLOCK) {
>  		rc = q->enqueue(skb, q, &to_free) & NET_XMIT_MASK;
> -		qdisc_run(q);
> +		if (!qdisc_run(q) && rc == NET_XMIT_SUCCESS)
> +			__netif_schedule(q);

I fear the __netif_schedule() call may cause performance regression to
the point of making a revert of TCQ_F_NOLOCK preferable. I'll try to
collect some data.

Thanks!

Paolo

