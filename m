Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4814C2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlDuCyZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHKCMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:12:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728007AbgHKCME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597111923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpcJWKRDr1Tg2kVpFQO3d+MuEZkKwcEPtilWjHV8dpk=;
        b=PlDuCyZQmX0fbpSmO8+91ebJB69fgIlMq+Gnz9ipn+VBdXuvHNj5Ch1sTuoIcw58sfAl/Q
        tusOWYMPK7saSQTt30YhWU/trYBlBDiuXyKdzF+aRIMuISGKk42QuOYPZUCnd/0mFuCdqk
        HmXXinNhnOhlBAGNX2nTMZtjqs54oLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-w0WbHjeRNuulnv2U_K15Og-1; Mon, 10 Aug 2020 22:11:59 -0400
X-MC-Unique: w0WbHjeRNuulnv2U_K15Og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75EEE1DF0;
        Tue, 11 Aug 2020 02:11:58 +0000 (UTC)
Received: from localhost (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 089BA61983;
        Tue, 11 Aug 2020 02:11:54 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:11:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
Message-ID: <20200811021152.GW14854@MiWiFi-R3L-srv>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
 <20200723091142.GR32539@MiWiFi-R3L-srv>
 <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 07/23/20 at 11:21am, Mike Kravetz wrote:
> On 7/23/20 2:11 AM, Baoquan He wrote:
...
> >> But is kernel expected to warn for all such situations where the user
> >> requested resources could not be allocated completely ? Otherwise, it
> >> does not make sense to add an warning for just one such situation.
> > 
> > It's not for just one such situation, we have already had one to warn
> > out in mm/hugetlb.c, please check hugetlb_hstate_alloc_pages().
> 
> Those are a little different in that they are warnings based on kernel
> command line parameters.
> 
> > As Mike said, in one time of persistent huge page number setting,
> > comparing the old value with the new vlaue is good enough for customer
> > to get the information. However, if customer want to detect and analyze
> > previous setting failure, logging message will be helpful. So I think
> > logging the failure or partial success makes sense.
> 
> I can understand the argument against adding a new warning for this.
> You could even argue that this condition has existed since the time
> hugetlb was added to the kernel which was long ago.  And, nobody has
> complained enough to add a warning.  I have even heard of a sysadmin
> practice of asking for a ridiculously large amount of hugetlb pages
> just so that the kernel will allocate as many as possible.  They do
> not 'expect' to get the ridiculous amount they asked for.  In such
> cases, this will be a new warning in their log.
> 
> As mentioned in a previous e-mail, when one sets nr_hugepages by writing
> to the sysfs or proc file, one needs to read the file to determine if the
> number of requested pages were actually allocated.  Anyone who does not
> do this is just asking for trouble.  Yet, I imagine that it may happen.
> 
> To be honest, I do not see this log message as something that would be
> helpful to end users.  Rather, I could see this as being useful to support
> people.  Support always asks for system logs and this could point out a
> possible issue with hugetlb usage.
> 
> I do not feel strongly one way or another about adding the warning.  Since
> it is fairly trivial and could help diagnose issues I am in favor of adding
> it.  If people feel strongly that it should not be added, I am open to
> those arguments.

Ping!

It's been a while, seems no objection to log the message. Do you
consider accepting this patch or offering an Ack?

Thanks
Baoquan

