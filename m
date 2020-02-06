Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BBDC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166BE20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cij1Afdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgBFJbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:31:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbgBFJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580981469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psVaYKxFuuF5hk8zbxTLl+GgL61u3jQrB7tk6Ar+Q/A=;
        b=Cij1AfdcV6LoNe53DOXTMjowUqXkr4kcalsvqr+glnedcMXKZjGzgLFTcK0OJYs1nIgFAU
        kws0VHL5WaHkUoYra35owuAKK7MIOcnNHdthAwPUt7DdbyUM/sZBFIuf0MVIB7PeF6yZfz
        eyIf1FTSX7Ys+zjoYNNVleLQ2+09Xlo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-csAlQ1lhPH2j4XRZGSZmHw-1; Thu, 06 Feb 2020 04:31:07 -0500
X-MC-Unique: csAlQ1lhPH2j4XRZGSZmHw-1
Received: by mail-qv1-f71.google.com with SMTP id e26so3328387qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 01:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psVaYKxFuuF5hk8zbxTLl+GgL61u3jQrB7tk6Ar+Q/A=;
        b=iVi2h1fXi79wUwSe/a4H7qfcTEseD3LSWBRwPG7zv8uw8ojKDXAimpVcAbobWd/WYB
         KYRydS3l8IZtLnqKxkbLXW53qOJk1XUg2O3lSTAvuHV6uyoAJfpp8I0qhMmo8J4jowAR
         S0W+ZYIImYId2bEIbZ4JzGGZ22MMm2qTnQomYdDzltQkY0vpwbpMKb/X4w7r0xYERIM5
         ON0GVyKGwQPLJv6GQzVdI+5D/EXt9yP561cYPv2ipRCgfiBi4NTVMSJnlE8DbVuWTj9g
         3QW7VeLECScQWRnAmvIhCGwW+A7AxNJDI25sutUOytInbTF/v8Wo7mY0OZfYkviV/zXz
         4jsQ==
X-Gm-Message-State: APjAAAUsi3EEBTTlX+sh7by/WAhyeAd78LsxwPgEKQgv0fVgDcZ9Djro
        7rbn29jxu7upnzYe8DOtw0DGSWv0WzalxW/mVimugQfvCIQpVJQd6UeP8s3Y3oxvplzDdz0F/jw
        j2sQYxh9wz+i3qU3WRMQqabHR
X-Received: by 2002:a05:6214:1633:: with SMTP id e19mr1574651qvw.104.1580981466901;
        Thu, 06 Feb 2020 01:31:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvhH9O4kuho2eszbvtS5e0sl+BYezuhs23uPCqeDjbd7YrUd9ZJ/qbYGlJqsgoS72fpdmLfg==
X-Received: by 2002:a05:6214:1633:: with SMTP id e19mr1574635qvw.104.1580981466697;
        Thu, 06 Feb 2020 01:31:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id o6sm1127547qkk.53.2020.02.06.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 01:31:05 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:31:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "tysand@google.com" <tysand@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Message-ID: <20200206042824-mutt-send-email-mst@kernel.org>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <20200206035749-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:27:04AM +0000, Wang, Wei W wrote:
> On Thursday, February 6, 2020 5:04 PM, Michael S. Tsirkin wrote:
> > virtio_balloon_shrinker_count(struct shrinker *shrinker,
> > >  					struct virtio_balloon, shrinker);
> > >  	unsigned long count;
> > >
> > > -	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> > > +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> > 
> > I'd rather have an API for that in mm/. In particular, do we want other
> > shrinkers to run, not just pagecache? To pick an example I'm familiar
> > with, kvm mmu cache for nested virt?
> 
> We could make it extendable:
> 
> #define BALLOON_SHRINKER_AFTER_PAGE_CACHE	(1 << 0)
> #define BALLOON_SHRINKER_AFTER_KVM_MMU_CACHE	(1 << 1)
> ...
> 
> uint64_t conservative_shrinker;
> if ((conservative_shrinker | BALLOON_SHRINKER_AFTER_PAGE_CACHE) && global_node_page_state(NR_FILE_PAGES))
> 	return 0;
> 
> For now, we probably only need BALLOON_SHRINKER_AFTER_PAGE_CACHE.
> 
> Best,
> Wei

How about just making this a last resort thing to be compatible with
existing hypervisors? if someone wants to change behaviour
that really should use a feature bit ...

-- 
MST

