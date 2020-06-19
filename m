Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8852080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAEVZWgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgFSJkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:40:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732008AbgFSJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592559599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+4pGpzA+J7PaKdgXI23WVmSsTE+DNjVpwlPS2q569Q=;
        b=bAEVZWgP40qom++wNzBoKCYi9vhlJ+cswvXrdybM0pw9dLGkbTC3tSDjLWIsAnVsXpfUgH
        Hvd6o17aml1ECdLNjX1+8FeRfjcpt+dciejuqHHPDezwv2LeWFlA/mdlojBvzXZJuELFUj
        Tqmv9uekVtLzjuRRWiSFxeCPQAMaiPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-xICsVpg_MVSG2_GCJ1rTXQ-1; Fri, 19 Jun 2020 05:39:55 -0400
X-MC-Unique: xICsVpg_MVSG2_GCJ1rTXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4006107B788;
        Fri, 19 Jun 2020 09:39:53 +0000 (UTC)
Received: from carbon (unknown [10.40.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5596B5D9CA;
        Fri, 19 Jun 2020 09:39:47 +0000 (UTC)
Date:   Fri, 19 Jun 2020 11:39:45 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, brouer@redhat.com,
        Larry Woodman <lwoodman@redhat.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200619113945.15ff3b15@carbon>
In-Reply-To: <20200619012712.GD135965@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
        <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
        <20200617024147.GA10812@carbon.lan>
        <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
        <20200617033217.GE10812@carbon.lan>
        <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
        <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
        <20200618104344.6a96ac04@carbon>
        <20200619012712.GD135965@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:27:12 -0700
Roman Gushchin <guro@fb.com> wrote:

> Theoretically speaking it should get worse (especially for non-root allocations),
> but if the difference is not big, it still should be better, because there is
> a big expected win from memory savings/smaller working set/less fragmentation etc.
> 
> The only thing I'm slightly worried is what's the effect on root allocations
> if we're sharing slab caches between root- and non-root allocations. Because if
> someone depends so much on the allocation speed, memcg-based accounting can be
> ignored anyway. For most users the cost of allocation is negligible.
> That's why the patch which merges root- and memcg slab caches is put on top
> and can be reverted if somebody will complain.

In general I like this work for saving memory, but you also have to be
aware of the negative consequences of sharing slab caches.  At Red Hat
we have experienced very hard to find kernel bugs, that point to memory
corruption at a completely wrong kernel code, because other kernel code
were corrupting the shared slab cache.  (Hint a workaround is to enable
SLUB debugging to disable this sharing).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

