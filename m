Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B913EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F3720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOBH5rPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgA3RBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:01:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgA3RBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:01:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so4938483wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=guwyI7qgekZu8i8afObSu1LIGKaCue9jEjiigz8FV7o=;
        b=cOBH5rPimr2xIplZwH+uFIcSC3HVf/IyQsPBV/6E57BiZZ3lI1PG5HktyBYxWDy74W
         PAxijbtRNyBHzMdIhIApwVSzMmiQCGe44O6xqX2W9nj1D6PzilB8/yrWquPweD0i+aeq
         LEcPJCWmpYryMGqp11YAka6QJQ7iqb09HVMkWuDbyX5IW5edZo2zzlb5dsVtzFj0I+UI
         ZkGeptyaqGyB3a6rZ0Ik1vjthMsJXVcQx6km3eYFiGWMxK4Qoz1IlXolqQ8zST8mxMuG
         7BzIyn/kvUEOZmv6q5KR9pYJFfeqigwfn+7i5aZvM+wEQrwMa1CsQWiSqMIBa3k57haQ
         2Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=guwyI7qgekZu8i8afObSu1LIGKaCue9jEjiigz8FV7o=;
        b=QqiiSkAG41Exuh0qlrnyr/zoMZtId68EWRpXdDvXFJAFJHw9UO+KYOlCX644R6LRvv
         9zAUonSeKyYkIJU2nMDZfMl9KXczFyYk1Vvg+u5TW6IfnvF8V5ErxU1hK4rBGzfIfgaf
         eL1lmi6dRXTaFlRNhK0sQzS+ifU+lBxPCPMd+i/7TNB9bLUZFad0rzmj4jt6y82kWduK
         JnJBxXdiDw/JvjujR6PQyvE+O+C4jZXjRjWHpfn4Fhn3s+y6ymMyrTwJx9AtduKve4QZ
         gVIpSjUq1biLcqJVvvX4t/rbDalCCI7591JjmRXW+br+VeOzKMtplrqXjzO1vb2DPzEQ
         TClQ==
X-Gm-Message-State: APjAAAUixFkXC2NnUtxCIPhy8klPo8Kx1XnWbU61TZ5x3G+lca/78K5K
        pmhGfCAGYkpp7awsYmJb6WhPtw==
X-Google-Smtp-Source: APXvYqzWhCWkLPvBVQPtHwccNZiiWYwXr8Q2E99gdO5pqrj0Rft27YWkPuhhXR1trWLNGnB9nNGgYw==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr7069699wrs.81.1580403705987;
        Thu, 30 Jan 2020 09:01:45 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s16sm8308922wrn.78.2020.01.30.09.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 09:01:44 -0800 (PST)
Date:   Thu, 30 Jan 2020 17:01:41 +0000
From:   Quentin Perret <qperret@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     masahiroy@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com
Subject: Re: [PATCH] kbuild: allow symbol whitelisting with TRIM_UNUSED_KSYMS
Message-ID: <20200130170141.GA136787@google.com>
References: <20200129150612.19200-1-qperret@google.com>
 <20200130154530.GA7452@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130154530.GA7452@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 Jan 2020 at 07:45:30 (-0800), Christoph Hellwig wrote:
> On Wed, Jan 29, 2020 at 03:06:12PM +0000, Quentin Perret wrote:
> > CONFIG_TRIM_UNUSED_KSYMS currently removes all unused exported symbols
> > from ksymtab. This works really well when using in-tree drivers, but
> > cannot be used in its current form if some of them are out-of-tree.
> 
> NAK.  The state policy is that we don't care for out of tree modules,
> and this is useful for nothing but.

That is correct. Now, I clearly failed to explain this patch properly,
but the long term goal here _is_ to get vendors to contribute more code
upstream, and have a lot less code downstream / out-of-tree. And I hope
we can agree this would be a good thing. So let me try again, and sorry
if I missed the mark the first time.

As you probably know, the current norm on Android and many other systems
is for vendors to introduce significant changes to their downstream
kernels, and to contribute very little (if any) code back upstream.

One of the goals of the Generic Kernel Image (GKI) project together with
updatability and such is to close the gap between vendor-specific
downstream kernels and upstream. Having one unique kernel for all android
devices of the same architecture regardless of the vendor will
mechanically force all interested parties to agree on a common solution.
And we _are_ pushing for all this to reach upstream and be available to
use by the wider community.

The kernel-to-drivers ABI on Android devices varies significantly from
one vendor kernel to another today (because of changes to exported
symbols, dependencies on vendor symbols, and surely other things). The
first step for GKI is to try and put some order into this by agreeing on
one version of the ABI that works for everybody.

For practical reasons, we need to reduce the ABI surface to a subset of
the exported symbols, simply to make the problem realistically solvable.
Hence this patch.

I understand your point of view, and quite frankly agree with the
message. But I think this patch pushes in the right direction. As I see
it, things like GKI really are significant improvements, so preventing
them from happening by refusing trivial patches such as this one will,
in the long term, do more harm than good to the cause.

Thank you for your time,
Quentin
