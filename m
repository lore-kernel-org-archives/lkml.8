Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FAC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52621741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xzmlfcsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBERjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:39:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgBERjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580924385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fNPS1hanpsq/w/5iiZBGDmbbH5rMQFQ+Y5O2+vioc0=;
        b=XzmlfcsjlZvqdTYDLKDeEM45b4nuUPXLj5EfQyP1qTuUBGbhj5zkQvV1DWygcpPGJR4DDa
        Fli5UheInzABV3GJsQNuHdNj30ScSrP8fAVGUTCSbNgMKQv8o1mkrx4Unh6Wg3GKJcCHi5
        gvlIHje2Zwl2ZysyB6XvARyztXthdcU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-NtzX1D0rPwSeoZQcSDtwfw-1; Wed, 05 Feb 2020 12:39:43 -0500
X-MC-Unique: NtzX1D0rPwSeoZQcSDtwfw-1
Received: by mail-qt1-f198.google.com with SMTP id c8so1816948qte.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fNPS1hanpsq/w/5iiZBGDmbbH5rMQFQ+Y5O2+vioc0=;
        b=FCZ9b2aW8cyy2Zlo4sA47MOubqvgPV1n6WovO+Nw2ty/+/i5xnR8uVFyBZXko5kiME
         VZbiyRCyDf5nnzlmSJUlP8qg04ZrFfh8f2DHuaSKSl5EJM+iCnCHWD6vuUZDxUBCO/CQ
         h+mo1ulq04OqSoKqkgzTxRUA+cp7/orJRYcqPynDfBpnE1ZxOkPjCJQJHqDVvOZnJJzV
         JdyTxRUDmdmu1H5cPmrWKsOcF0WHLrmV0WHN2nrOiZR+GTWTxPckDNgU9a2MRJbN7/QS
         WT1XpYHEhUoyroi29uKzts3Pr5V/eHXSiyMCM2cDEj39o8owRGoIDtbW66r4a0Oih507
         2LdQ==
X-Gm-Message-State: APjAAAXVMNjPkw0DtQ4G18SW4qen8jbRszsSboJiv40C3404eEUpALKf
        PQlNA6h1bTuToFpC2sb15I41ZgD9ijXRyyZAji/FI0pzT3pqkdQ7jS/jv8EJ7oj9tBJBu5UjfO/
        +9TgnfsEe1TbWOaLMricDT2HZ
X-Received: by 2002:a37:6446:: with SMTP id y67mr34245778qkb.59.1580924382624;
        Wed, 05 Feb 2020 09:39:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCug0s4yHW7+CpM+1AQhzW0DehWH+eRA2t80BwS6FeOzFDkgUJOm/ll+l+SL20BiLzxHUwpw==
X-Received: by 2002:a37:6446:: with SMTP id y67mr34245762qkb.59.1580924382403;
        Wed, 05 Feb 2020 09:39:42 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id o7sm139946qkd.119.2020.02.05.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:39:41 -0800 (PST)
Date:   Wed, 5 Feb 2020 12:39:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200205173939.GD378317@xz-x1>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-7-peterx@redhat.com>
 <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
 <20200205154617.GA378317@xz-x1>
 <20200205171109.2a7ufrhiqowkqz6e@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205171109.2a7ufrhiqowkqz6e@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:11:09PM +0100, Andrew Jones wrote:
> On Wed, Feb 05, 2020 at 10:46:17AM -0500, Peter Xu wrote:
> > On Wed, Feb 05, 2020 at 10:28:52AM +0100, Andrew Jones wrote:
> > > On Tue, Feb 04, 2020 at 09:58:38PM -0500, Peter Xu wrote:
> > > > Remove the clear_dirty_log test, instead merge it into the existing
> > > > dirty_log_test.  It should be cleaner to use this single binary to do
> > > > both tests, also it's a preparation for the upcoming dirty ring test.
> > > > 
> > > > The default test will still be the dirty_log test.  To run the clear
> > > > dirty log test, we need to specify "-M clear-log".
> > > 
> > > How about keeping most of these changes, which nicely clean up the
> > > #ifdefs, but also keeping the separate test, which I think is the
> > > preferred way to organize and execute selftests. We can use argv[0]
> > > to determine which path to take rather than a command line parameter.
> > 
> > Hi, Drew,
> > 
> > How about we just create a few selftest links that points to the same
> > test binary in Makefile?  I'm fine with compiling it for mulitple
> > binaries too, just in case the makefile trick could be even easier.
> 
> I think I prefer the binaries. That way they can be selectively moved
> and run elsewhere, i.e. each test is a standalone test.

Sure, will do.

-- 
Peter Xu

