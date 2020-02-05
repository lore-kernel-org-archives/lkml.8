Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850ED2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6dfbKvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBERLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:11:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgBERLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580922699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8S8CnHdb9kaeTT4aNnSP/xgXypUISRlF/fMbRSU4/U=;
        b=J6dfbKvwiL+TMciyAO8bTd6CjgL3Zjak5xqJSXBz2hwB69AddWHW8cqGT9u4gt1lXsSlsB
        7f6BSN+QzqxaA/h7pbO2lEXgb7Ow/30QVwnV7pC3IvUXjXZtEePnKQQkvwd+I/r8rm3Tdo
        qyPnXXJ6omKwl/3FNLwgNWQ8ORVvgMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-DpVMEQvfOqizy1slRde0Hg-1; Wed, 05 Feb 2020 12:11:25 -0500
X-MC-Unique: DpVMEQvfOqizy1slRde0Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7470C108442F;
        Wed,  5 Feb 2020 17:11:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B020260BF7;
        Wed,  5 Feb 2020 17:11:12 +0000 (UTC)
Date:   Wed, 5 Feb 2020 18:11:09 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200205171109.2a7ufrhiqowkqz6e@kamzik.brq.redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-7-peterx@redhat.com>
 <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
 <20200205154617.GA378317@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205154617.GA378317@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:46:17AM -0500, Peter Xu wrote:
> On Wed, Feb 05, 2020 at 10:28:52AM +0100, Andrew Jones wrote:
> > On Tue, Feb 04, 2020 at 09:58:38PM -0500, Peter Xu wrote:
> > > Remove the clear_dirty_log test, instead merge it into the existing
> > > dirty_log_test.  It should be cleaner to use this single binary to do
> > > both tests, also it's a preparation for the upcoming dirty ring test.
> > > 
> > > The default test will still be the dirty_log test.  To run the clear
> > > dirty log test, we need to specify "-M clear-log".
> > 
> > How about keeping most of these changes, which nicely clean up the
> > #ifdefs, but also keeping the separate test, which I think is the
> > preferred way to organize and execute selftests. We can use argv[0]
> > to determine which path to take rather than a command line parameter.
> 
> Hi, Drew,
> 
> How about we just create a few selftest links that points to the same
> test binary in Makefile?  I'm fine with compiling it for mulitple
> binaries too, just in case the makefile trick could be even easier.

I think I prefer the binaries. That way they can be selectively moved
and run elsewhere, i.e. each test is a standalone test.

Thanks,
drew

