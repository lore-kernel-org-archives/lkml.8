Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443272072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8EUJRx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFKK6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:58:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgFKK6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591873124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsI8dawBpC+7XupP+pkPY6TXUqe3ihbrIjlqp72MMqs=;
        b=B8EUJRx+vLNJdxjHft82Gf/V07YDEuHEDHMpfO8Zft9Q/cOGR/ZEdo9vMLvcZZZplJn8Xh
        VNxXCR73vylXzvGgV5F6wHaDGIpv56vpviGKXgZu7r7mqgBFNrkKMXeBkGoZE4fpIJBruw
        6o0kop4dusQyZiEtYl8Xh+axioe9lp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-1u-74tPAPfGxpdUJpFtgzA-1; Thu, 11 Jun 2020 06:58:39 -0400
X-MC-Unique: 1u-74tPAPfGxpdUJpFtgzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC24107ACF2;
        Thu, 11 Jun 2020 10:58:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D7167BE62;
        Thu, 11 Jun 2020 10:58:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 11 Jun 2020 12:58:37 +0200 (CEST)
Date:   Thu, 11 Jun 2020 12:58:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH? v2] powerpc: Hard wire PT_SOFTE value to 1 in gpr_get()
 too
Message-ID: <20200611105830.GB12500@redhat.com>
References: <20190917121256.GA8659@redhat.com>
 <20190917143753.GA12300@redhat.com>
 <20200610150224.GA6793@redhat.com>
 <321e6865-1762-c459-56c4-0cc89c7c2a7e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321e6865-1762-c459-56c4-0cc89c7c2a7e@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11, Madhavan Srinivasan wrote:
>
>
> On 6/10/20 8:37 PM, Oleg Nesterov wrote:
> >Hi,
> >
> >looks like this patch was forgotten.
>
> yep, I missed this. But mpe did have comments for the patch.
>
> https://lkml.org/lkml/2019/9/19/107

Yes, and I thought that I have replied... apparently not, sorry!

So let me repeat, I am fine either way, I do not understand this
ppc-specific code and I can't really test this change.

Let me quote that email from Michael:

	> We could do it like below. I'm 50/50 though on whether it's worth it, or
	> if we should just go with the big ifdef like in your patch.
	
up to you ;)

Hmm. And yes,

> >>This is not consistent and this breaks
> >>http://sourceware.org/systemtap/wiki/utrace/tests/user-regs-peekpoke

this is 404.

Jan, could correct the link above?

Oleg.

