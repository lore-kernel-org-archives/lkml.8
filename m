Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BE21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVH2ixxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:41:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgFQQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592412103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/k/xClA9+2hYuzh1XXM/hvm+D0ZEKs/cLEa2dBU6DKY=;
        b=dVH2ixxJ7Vp/uMnF5MoExqsWB1ODeMk8ByLxavudyH0xatiwlTQd/X7Zzi54bD+qLKXxn7
        6n64C5b26Okh64HND/BgAZi5UEYG5mqqxc8mmj9d6ZcyCGDUN08I23uUtgFvqE43R2r2Lf
        PDWNKemqQGmvPunQvBuWdePrlzF2ZtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fYJfJdjHNyCKNT-QaEcWbQ-1; Wed, 17 Jun 2020 12:41:39 -0400
X-MC-Unique: fYJfJdjHNyCKNT-QaEcWbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCCB0891C5B;
        Wed, 17 Jun 2020 16:41:13 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6C16EDBE;
        Wed, 17 Jun 2020 16:41:10 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:41:09 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Huaisheng Ye <yehs2007@zoho.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: dm writecache: correct uncommitted_block when discarding
 uncommitted entry
Message-ID: <20200617164108.GA12131@redhat.com>
References: <20200612155911.96528-1-yehs2007@zoho.com>
 <alpine.LRH.2.02.2006130839480.27500@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006130839480.27500@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13 2020 at  8:40am -0400,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> 
> 
> On Fri, 12 Jun 2020, Huaisheng Ye wrote:
> 
> > From: Huaisheng Ye <yehs1@lenovo.com>
> > 
> > When uncommitted entry has been discarded, correct wc->uncommitted_block
> > for getting the exact number.
> > 
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> 
> Acked-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Also, add:
> Cc: stable@vger.kernel.org

I picked this up for 5.8 but I inverted the patch order because this
stable@ fix was dependent on the prior patch to skip waiting if in pmem
mode (due to locality of changes within same function).

See:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.8&id=39495b12ef1cf602e6abd350dce2ef4199906531

Mike

