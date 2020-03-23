Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217CC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6322074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzOFl+eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCWHKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:10:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27186 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbgCWHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584947400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KelROyYCjluM3/vlH+wAUHU21yGj/l+XL1RLQ+Rw5s=;
        b=SzOFl+eucQMQdlqnoqn0gneiQvIw0SL8tiWI9+9vUMDaDGyXHT5vp+qdD3zzKwypyxCc9H
        eDTkmZyUlb7Sz9MEnqlrVgRCxteVENoA5v+Iy7zFA8Q39afVKnzD8CcMboL3raBk9syt04
        mzJfbyrTRB3peSwpRVzSG0URY2lAqAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-71Ubue3VNFaQw_p3ZvZ1Mg-1; Mon, 23 Mar 2020 03:09:58 -0400
X-MC-Unique: 71Ubue3VNFaQw_p3ZvZ1Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2945A800D5B;
        Mon, 23 Mar 2020 07:09:56 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF0D94978;
        Mon, 23 Mar 2020 07:09:54 +0000 (UTC)
Date:   Mon, 23 Mar 2020 15:09:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 2/2] mm/page_alloc: integrate classzone_idx and
 high_zoneidx
Message-ID: <20200323070952.GF3039@MiWiFi-R3L-srv>
References: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584938972-7430-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584938972-7430-3-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 at 01:49pm, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> classzone_idx is just different name for high_zoneidx now.
> So, integrate them and add some comment to struct alloc_context
> in order to reduce future confusion about the meaning of this variable.
> 
> The accessor, ac_classzone_idx() is also removed since it isn't needed
> after integration.
> 
> In addition to integration, this patch also renames high_zoneidx
> to highest_zoneidx since it represents more precise meaning.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

The patch looks good, and did the basic test after applying this patch
series. FWIW:

Reviewed-by: Baoquan He <bhe@redhat.com>

