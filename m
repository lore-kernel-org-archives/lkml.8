Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F09C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C1820720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEob0pfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHUIqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:46:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727008AbgHUIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597999582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olCjBKF17qwtakghkMirVinWe1Vu2ZqCQev6/U3Rq7c=;
        b=hEob0pfxunXvvdfZcCIfvT/2dlldl672JgvJgDbPrc086avxIZCtobu5ITj1ppj7EUEjux
        nAdFbF4wea5HxLi/2ZjKCtY0p4zVlb0UP3XiJgpGNg1pV123/5/eodNF0doUUiGBM4TTdm
        r/DTC9wGxfroCKalDJN28T9OiluEoHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-Y6UCf7X5O_yLWpjnzsdODg-1; Fri, 21 Aug 2020 04:46:20 -0400
X-MC-Unique: Y6UCf7X5O_yLWpjnzsdODg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C088D18686FA;
        Fri, 21 Aug 2020 08:46:18 +0000 (UTC)
Received: from localhost (ovpn-12-124.pek2.redhat.com [10.72.12.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66A807191C;
        Fri, 21 Aug 2020 08:46:12 +0000 (UTC)
Date:   Fri, 21 Aug 2020 16:46:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v5 0/6] mm / virtio-mem: support ZONE_MOVABLE
Message-ID: <20200821084610.GH10792@MiWiFi-R3L-srv>
References: <20200816125333.7434-1-david@redhat.com>
 <552a2a55-6082-d286-1cd4-7f7e368eebb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552a2a55-6082-d286-1cd4-7f7e368eebb4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/20 at 10:31am, David Hildenbrand wrote:
> On 16.08.20 14:53, David Hildenbrand wrote:
> > For 5.10. Patch #1-#4,#6 have RBs or ACKs, patch #5 is virtio-mem stuff
> > maintained by me. This should go via the -mm tree.
> > 
> 
> @Andrew, can we give this a churn if there are no further comments? Thanks!

Saw this series in next already.

