Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9F122D00
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWRjUi5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGWJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:11:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgGWJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595495512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOegfAFD7KmRGII6oc4i/sR1c5ZZZGyGt2xHdWoeR1E=;
        b=iWRjUi5oPgg2ybHq2AFlAinSbwmrHhcO8DAGLpdiH5PRbQPSroSZCRbmBU2y2V3oSL+8YB
        zUjePOS8guoJL/IN3DBYBaeoujTiK6n1iuHtLh0R7PhlIpqnCIUW7HQmno6BqyKY9HOtQg
        d5mU1jkB1YiMkD7AnN4zj3h/SbjtBKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-uDp4JBGwN8CN6cCd1mJACw-1; Thu, 23 Jul 2020 05:11:50 -0400
X-MC-Unique: uDp4JBGwN8CN6cCd1mJACw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C11241005504;
        Thu, 23 Jul 2020 09:11:48 +0000 (UTC)
Received: from localhost (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78D2F2DE68;
        Thu, 23 Jul 2020 09:11:45 +0000 (UTC)
Date:   Thu, 23 Jul 2020 17:11:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
Message-ID: <20200723091142.GR32539@MiWiFi-R3L-srv>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/20 at 11:46am, Anshuman Khandual wrote:
> 
> 
> On 07/23/2020 08:52 AM, Baoquan He wrote:
> > A customer complained that no message is logged wh	en the number of
> > persistent huge pages is not changed to the exact value written to
> > the sysfs or proc nr_hugepages file.
> > 
> > In the current code, a best effort is made to satisfy requests made
> > via the nr_hugepages file.  However, requests may be only partially
> > satisfied.
> > 
> > Log a message if the code was unsuccessful in fully satisfying a
> > request. This includes both increasing and decreasing the number
> > of persistent huge pages.
> 
> But is kernel expected to warn for all such situations where the user
> requested resources could not be allocated completely ? Otherwise, it
> does not make sense to add an warning for just one such situation.

It's not for just one such situation, we have already had one to warn
out in mm/hugetlb.c, please check hugetlb_hstate_alloc_pages().

As Mike said, in one time of persistent huge page number setting,
comparing the old value with the new vlaue is good enough for customer
to get the information. However, if customer want to detect and analyze
previous setting failure, logging message will be helpful. So I think
logging the failure or partial success makes sense.

Thanks
Baoquan

