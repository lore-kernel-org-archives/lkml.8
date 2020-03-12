Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B052C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED5C20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC9gPbBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCLIrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:47:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54511 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgCLIrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584002841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMGY5NDRnQ6tpPW4NbzkE3whOpE1haBikjv6YCfDFio=;
        b=DC9gPbBZHhQan4cPx/ESxx6Sp7dSXZVxlkS0krOTzFKf7PjXPLF62JPIBBGN4aIDpcRbXe
        TijJi5aGR7mNRc047ocndiyvuKOe85xsq6JvAFpAgGPJfXrI3ao/ZjldN2N6Zya2Vj24N7
        vcSLxbg03vStal1EVdJnrzc0gcE7hJs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-iotjrYj6Ow-GneWn0W_TIA-1; Thu, 12 Mar 2020 04:47:19 -0400
X-MC-Unique: iotjrYj6Ow-GneWn0W_TIA-1
Received: by mail-qv1-f70.google.com with SMTP id r16so3066083qvp.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMGY5NDRnQ6tpPW4NbzkE3whOpE1haBikjv6YCfDFio=;
        b=fyakUvuXCYmqsFR3RssEl+RCK6XBZqy0DObbsezsfGDZJBSou+TajDIgvo6co+MrwV
         0no3NXabCVV6NKDBV4DjUuQh9YIclOBnvREhsdgH2FCtT+zvv1JI0CHXhGT0rv4VVag3
         /ohf8qtbcUZpYBQ8u3o+q5JOHdv93dXRPgxthh/kpR6N13xN3c/x4tIOaUvryzEEOm+4
         yThcE5iLnflFufDrU1SCzABprabBRncmGhqLHTLv5YVGCFLNeWSRU6DqvAsekihPoBcq
         +Li8ELuaHdPleIYThzgEYNzPKZM6myiypp+vKHLQmE7oOzMT8wK3a5+yM4n3Uov0CtPM
         LHtA==
X-Gm-Message-State: ANhLgQ3wypmJpttnOfXoPp7jhbrfEf9qwqJpXqcGWXnn5cr9HQAq2TaU
        EGx4rNDVBDH68MScvYW0dPUWTVRoe9uaqIwS7xEq2GwHxvst5IxfCloguAqhZEjfmhHRuxH9moK
        Mx44NPMhMYH/4rDEU2IUmsGe8
X-Received: by 2002:ac8:70d4:: with SMTP id g20mr6375486qtp.146.1584002838845;
        Thu, 12 Mar 2020 01:47:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsV2vB8jgT9lPTI6/rXChnARxotlD8arZEu0o0XGFcCreqdYk31/Dsq3r3lSxfUv0vOD7Pnvw==
X-Received: by 2002:ac8:70d4:: with SMTP id g20mr6375478qtp.146.1584002838612;
        Thu, 12 Mar 2020 01:47:18 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id c190sm5213470qkb.80.2020.03.12.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:47:17 -0700 (PDT)
Date:   Thu, 12 Mar 2020 04:47:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200312043859-mutt-send-email-mst@kernel.org>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
 <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> 2. You are essentially stealing THPs in the guest. So the fastest
> mapping (THP in guest and host) is gone. The guest won't be able to make
> use of THP where it previously was able to. I can imagine this implies a
> performance degradation for some workloads. This needs a proper
> performance evaluation.

I think the problem is more with the alloc_pages API.
That gives you exactly the given order, and if there's
a larger chunk available, it will split it up.

But for balloon - I suspect lots of other users,
we do not want to stress the system but if a large
chunk is available anyway, then we could handle
that more optimally by getting it all in one go.


So if we want to address this, IMHO this calls for a new API.
Along the lines of

	struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
					unsigned int max_order, unsigned int *order)

the idea would then be to return at a number of pages in the given
range.

What do you think? Want to try implementing that?

-- 
MST

