Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6677AC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506624650
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibJ4yxev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGIcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:32:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34883 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581064321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aL2Km/dBEpan3J9Haz80g0IwUlEFP1QZ7JNkl7An7tY=;
        b=ibJ4yxev1VJkhnXCRsTivxFMgiZWoFP3RT+dG3G6j2XISdQ/aS3tS5igNxaJFZebVR8kxb
        g8ygyM1rMcPaUf5WQBcFtJ0hraaX9SjNf8kSbC9zt9OVH4NKr/h9AX8OJdPNLDaGB7kWn3
        va8VZrRoGlPxyxJlouOlzi+siBHgpAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-avDrBAESOwG3kSNcluShBA-1; Fri, 07 Feb 2020 03:31:55 -0500
X-MC-Unique: avDrBAESOwG3kSNcluShBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93BD68010D6;
        Fri,  7 Feb 2020 08:31:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D3860BEC;
        Fri,  7 Feb 2020 08:31:41 +0000 (UTC)
Date:   Fri, 7 Feb 2020 09:31:38 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200207083138.2duukfbf5lykwzox@kamzik.brq.redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-7-peterx@redhat.com>
 <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
 <20200205154617.GA378317@xz-x1>
 <20200205171109.2a7ufrhiqowkqz6e@kamzik.brq.redhat.com>
 <20200205173939.GD378317@xz-x1>
 <20200206224042.GK700495@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206224042.GK700495@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 05:40:42PM -0500, Peter Xu wrote:
> On Wed, Feb 05, 2020 at 12:39:39PM -0500, Peter Xu wrote:
> > On Wed, Feb 05, 2020 at 06:11:09PM +0100, Andrew Jones wrote:
> > > On Wed, Feb 05, 2020 at 10:46:17AM -0500, Peter Xu wrote:
> > > > On Wed, Feb 05, 2020 at 10:28:52AM +0100, Andrew Jones wrote:
> > > > > On Tue, Feb 04, 2020 at 09:58:38PM -0500, Peter Xu wrote:
> > > > > > Remove the clear_dirty_log test, instead merge it into the existing
> > > > > > dirty_log_test.  It should be cleaner to use this single binary to do
> > > > > > both tests, also it's a preparation for the upcoming dirty ring test.
> > > > > > 
> > > > > > The default test will still be the dirty_log test.  To run the clear
> > > > > > dirty log test, we need to specify "-M clear-log".
> > > > > 
> > > > > How about keeping most of these changes, which nicely clean up the
> > > > > #ifdefs, but also keeping the separate test, which I think is the
> > > > > preferred way to organize and execute selftests. We can use argv[0]
> > > > > to determine which path to take rather than a command line parameter.
> > > > 
> > > > Hi, Drew,
> > > > 
> > > > How about we just create a few selftest links that points to the same
> > > > test binary in Makefile?  I'm fine with compiling it for mulitple
> > > > binaries too, just in case the makefile trick could be even easier.
> > > 
> > > I think I prefer the binaries. That way they can be selectively moved
> > > and run elsewhere, i.e. each test is a standalone test.
> > 
> > Sure, will do.
> 
> Or... Shall we still keep one binary, but by default run all the
> supported logging mode in sequence in a single dirty_log_test?  Say,
> run "./dirty_log_test" will run all supported tests one by one; run
> "./dirty_log_test -M LOG_MODE" will only run specific mode.
> 
> With this patch it's fairly easy to achieve this too.
>

Works for me.

Thanks,
drew 

