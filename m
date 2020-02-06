Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E17C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C04214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGGcjWCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBFWks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:40:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47191 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgBFWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581028847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W562CeQ2Rstu/7oSeTVLCjxMDoc+cA2kZj28QIDXVLU=;
        b=NGGcjWCFYcYH9Aqq6g7Oa4V/ASgJslDZreKKBtZPZlFFQbe7LvNFKSvsFccpFpsjkw5l2H
        9KH73tA+pXIF2Zy1Ni2ZfTe/27+DJVzh2TVoPZDBTYXrEFZ+PegZAWLMKjTjQhwiaRXTey
        J1EdG13sAF2G7b26nOHKZHz43UmzuI8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-5IK2FSOxPVaoAbCd5aiZqg-1; Thu, 06 Feb 2020 17:40:46 -0500
X-MC-Unique: 5IK2FSOxPVaoAbCd5aiZqg-1
Received: by mail-qt1-f200.google.com with SMTP id p12so303789qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W562CeQ2Rstu/7oSeTVLCjxMDoc+cA2kZj28QIDXVLU=;
        b=smJeao/9NQi65oMIi5hq6JxHazsbtohYkWukMejdB9MbHNP7Uew2yITOGA3C1AVBBF
         n+EmcqVH2fiaLI8uniLjpzrypA3zXTj40Fq4Tb5OJNh9atnyhO06vW3cwJ7KZvKpkLns
         XWghJE2Lwvp1yqsnVvXz/V3E0YR7AM1ougONll0OeVlWDwgfWhv8jAvvTtK9aDXSlEvB
         VpoGoSYTlxSsm7hiOWERDs1Ct2g323nAUi/rI2khMLZ0V9F+0vcK6B3+pVHlTQQbdexH
         5KRGiq7zOkQSCmho5CfCyABSJZLqk6/NsQGs4WzfUBOUWGMQlO5C3p4G7IbL2d0Q0GNu
         NlWg==
X-Gm-Message-State: APjAAAXplvdLTEYJvEqb8dX8MwDEmglWKUDF9c0en61cD5LEvoOO94Cd
        aYfj1W6/JcaLSiVs/NQW2zr9r8zbHGNuCKkDffpnoL12qnEpG43qMbEnwNar6/zaYahHG7xFUfg
        7PzRhiZyqpEWs4xgKw3TUs+Ou
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr2404738qkk.486.1581028845852;
        Thu, 06 Feb 2020 14:40:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9H3jQJMccEXzYtFXays9K8+qBHpILOvSuY+IuWN7aXEfE94eIAwglwVCLCFzRPz0MIaA7CA==
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr2404727qkk.486.1581028845629;
        Thu, 06 Feb 2020 14:40:45 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id h23sm369207qka.6.2020.02.06.14.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:40:44 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:40:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200206224042.GK700495@xz-x1>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-7-peterx@redhat.com>
 <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
 <20200205154617.GA378317@xz-x1>
 <20200205171109.2a7ufrhiqowkqz6e@kamzik.brq.redhat.com>
 <20200205173939.GD378317@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205173939.GD378317@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 12:39:39PM -0500, Peter Xu wrote:
> On Wed, Feb 05, 2020 at 06:11:09PM +0100, Andrew Jones wrote:
> > On Wed, Feb 05, 2020 at 10:46:17AM -0500, Peter Xu wrote:
> > > On Wed, Feb 05, 2020 at 10:28:52AM +0100, Andrew Jones wrote:
> > > > On Tue, Feb 04, 2020 at 09:58:38PM -0500, Peter Xu wrote:
> > > > > Remove the clear_dirty_log test, instead merge it into the existing
> > > > > dirty_log_test.  It should be cleaner to use this single binary to do
> > > > > both tests, also it's a preparation for the upcoming dirty ring test.
> > > > > 
> > > > > The default test will still be the dirty_log test.  To run the clear
> > > > > dirty log test, we need to specify "-M clear-log".
> > > > 
> > > > How about keeping most of these changes, which nicely clean up the
> > > > #ifdefs, but also keeping the separate test, which I think is the
> > > > preferred way to organize and execute selftests. We can use argv[0]
> > > > to determine which path to take rather than a command line parameter.
> > > 
> > > Hi, Drew,
> > > 
> > > How about we just create a few selftest links that points to the same
> > > test binary in Makefile?  I'm fine with compiling it for mulitple
> > > binaries too, just in case the makefile trick could be even easier.
> > 
> > I think I prefer the binaries. That way they can be selectively moved
> > and run elsewhere, i.e. each test is a standalone test.
> 
> Sure, will do.

Or... Shall we still keep one binary, but by default run all the
supported logging mode in sequence in a single dirty_log_test?  Say,
run "./dirty_log_test" will run all supported tests one by one; run
"./dirty_log_test -M LOG_MODE" will only run specific mode.

With this patch it's fairly easy to achieve this too.

-- 
Peter Xu

