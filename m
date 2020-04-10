Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01097C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EA720732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XelkJSeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDJThY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:37:24 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41797 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgDJThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:37:23 -0400
Received: by mail-pg1-f176.google.com with SMTP id m13so1370776pgd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eY+CI9YUMAjOh4YqmN7BSzI+LQc+sWyi0ugJbjXN5uQ=;
        b=XelkJSeZVTY87SNnF2pKDT8Yg39E+gB8zoKeQ8MPaxZqUDd978lszegCGThMWc7fTW
         JhoatwplKpp+4hzFROpAZlqL/SeW9RSGw0hdpiKlmNOix5QRrvezLXVzSqQI3lxWwETC
         IQ1pPPDJiF3e5GyK3vOcz7UlNAW/bZK1jPyCe0P1hmWuYt5fj7fKHdtaJ0hpXf0PZKIf
         9p7CEOtWTub3VLD4phzxv1Ut1/kfFoMI+NPHc7YztpEGULG6rXcGbU0pDNs/bisWZqqM
         OFxDfNir4pgu8QctwGDEynFvUJY3BlVHvoKe3SHiz4sqzSEAm3vQYzPG7jWNsF68C9VI
         3Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eY+CI9YUMAjOh4YqmN7BSzI+LQc+sWyi0ugJbjXN5uQ=;
        b=NsSELx4ioJ8r6jGJxnbP5sxyc/ZZjyQb25Izf/BH/qjpu9mGfXWUGWBtaXvpJC5JWo
         zcO0HTevuAT/Wj+txlSyDi9Rm47bs+YH9grx/KwacmzbpcwnqjdaxZFLFc8bbnNiSlbh
         tpW6gWqN8Y6iwTCuG1Y5nxMiX5sVj3/J9J2fbV+/pOINAHkZfBu3EbasTSRjGu98qUbz
         KXbL79+bJFq+PpB8gVg1s6MLDp0L3eTuCoZnZXIhQdGMtieneVUyAuTNM1heX+GPXJVZ
         HzBuA0qIbWQxmZfA0cZrPIWPPaFAF1KmbzznBcE9kL6BbK1OdwUBdtFlt5rs0bJIoogK
         Hhow==
X-Gm-Message-State: AGi0PuY4Dm5h7664zRcvCjlqj00i3qAnsSmpINI2d5a0v6t/3tuRso9z
        KjF91Nz5NbD0TJMQjM9ZfWR91w==
X-Google-Smtp-Source: APiQypJap4XYb6OLfN6N3dmdOCNtdz9IVqLUzAY0Gi5Syeddt2+rDTEaLZ+aoQkdrBGcOUnmAt+dkg==
X-Received: by 2002:a62:5cc2:: with SMTP id q185mr6421328pfb.125.1586547441997;
        Fri, 10 Apr 2020 12:37:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n21sm2282025pgf.36.2020.04.10.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:37:21 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:37:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Hillf Danton <hdanton@sina.com>
cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <20200410145520.17864-1-hdanton@sina.com>
Message-ID: <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <20200410145520.17864-1-hdanton@sina.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020, Hillf Danton wrote:

> 
> On Wed, 8 Apr 2020 14:21:06 -0700 (PDT) David Rientjes wrote:
> > 
> > When an atomic pool becomes fully depleted because it is now relied upon
> > for all non-blocking allocations through the DMA API, allow background
> > expansion of each pool by a kworker.
> > 
> > When an atomic pool has less than the default size of memory left, kick
> > off a kworker to dynamically expand the pool in the background.  The pool
> > is doubled in size, up to MAX_ORDER-1.  If memory cannot be allocated at
> > the requested order, smaller allocation(s) are attempted.
> > 
> What is proposed looks like a path of single lane without how to
> dynamically shrink the pool taken into account. Thus the risk may
> rise in corner cases where pools are over-expanded in long run
> after one-off peak allocation requests.
> 

To us, this is actually a benefit: we prefer the peak size to be 
maintained so that we do not need to dynamic resize the pool later at the 
cost of throughput.  Genpool also does not have great support for 
scavenging and freeing unused chunks.

Perhaps we could enforce a maximum size on the pools just as we allow the 
default size to be defined by coherent_size= on the command line.  Our use 
case would not set this, however, since we have not seen egregious genpool 
sizes as the result of non-blockable DMA allocations (perhaps the drivers 
we use just play friendlier and you have seen excessive usage?).

I'll rely on Christoph to determine whether it makes sense to add some 
periodic scavening of the atomic pools, whether that's needed for this to 
be merged, or wheter we should enforce some maximum pool size.
