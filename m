Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18683C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF2320720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7WOfCS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgGHPE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:04:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38731 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729022AbgGHPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594220666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCfFQ9unhV8AALYAbnlDEYp86FEPgYE4PEBMEl3tJ+k=;
        b=R7WOfCS8CH2egJLXy3TPwprL/Y5FkDipLbHe9+Trl1lOEfcEZC5xA7TA/PdKx2nzn2BAaZ
        1B7wa3pzltiiWGdWvBb0z2FtR0Rl9Hnfd3+5NA6JnHE05wANKe3torwZzAlKPbFJiHj/TT
        ZLHTiC5o8guycRjAvb23iPdV9i/u7SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-_cOtDcHDMqSgQS042k_P3g-1; Wed, 08 Jul 2020 11:04:20 -0400
X-MC-Unique: _cOtDcHDMqSgQS042k_P3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FA510506EE;
        Wed,  8 Jul 2020 15:04:18 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC18910013D7;
        Wed,  8 Jul 2020 15:04:14 +0000 (UTC)
Date:   Wed, 8 Jul 2020 10:02:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 01/14] dm: use bio_uninit instead of bio_disassociate_blkg
Message-ID: <20200708140254.GA7539@redhat.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627073159.2447325-2-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27 2020 at  3:31am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> bio_uninit is the proper API to clean up a BIO that has been allocated
> on stack or inside a structure that doesn't come from the BIO allocator.
> Switch dm to use that instead of bio_disassociate_blkg, which really is
> an implementation detail.  Note that the bio_uninit calls are also moved
> to the two callers of __send_empty_flush, so that they better pair with
> the bio_init calls used to initialize them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I've picked this up as a fix for 5.8

Thanks,
Mike

