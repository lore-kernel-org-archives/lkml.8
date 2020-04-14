Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16973C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46AF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBSDD4vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504819AbgDNTbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504778AbgDNT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:29:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD0C025481
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:23:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u65so389763pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uh/180abQgmQ6BQ7TjempJNClKOaOSf5CJ7rtROtEkE=;
        b=cBSDD4vrRu2upc6r3gqJwDFaQSWjr+17rSaxPc9/xT79CnR00LWsE6Ow6sJurp1BA5
         po/AGG98n8lFdQkAWQi+CDtNlbASVECECHMr16HNxN9EVzyN5lct4/KaV7JhTeAhmfNT
         CKC8vf8rOhffLDtmFRV+XGP/WKpHS7KYBhA2LK/IE5BCOMeA2Ghn6uO2g403g5XEb8Td
         Uve+jkNURH8epjGee6h9MMB6pIfcQF3E87ZvJhDA4xKu1VYlkBUjJCrZpS2hmnejTScy
         1uswIyb9bK+TkRw9Y86yKCQWXYLICDOT4HYWtWHkkmGoZls7DTUZxI1i4bRJFzx8C59w
         fcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uh/180abQgmQ6BQ7TjempJNClKOaOSf5CJ7rtROtEkE=;
        b=mnXRgZNkQf9hi0QS6XIxMSY5UB3Sk+a7st/b7w/pv7CzOi5qJNOubmvJYAysOXbufy
         PxOdE8igtI6QoY6wImK4TYQiRSdu3Tt4O3PVjMU15hZe0oQ2y4BKWIYQfVTrcLwMaL9A
         m3oxrlFezKbBX7Dp7r1ZPIo7Bqi7bW3ijl9qUy7/6Gmp36cPiemZ172NWJ6YoPiZAgJ6
         B4h5o4Prl7ucbE+A3z6xfAJrwS+tCjOk9lwxJZxFydqJVgM7fLaSs7c7D9qmBEwnJxFh
         JJVxiSg6V00nebx0FUsuxsCJTiYMPIKExDXKfULitqxduC/Ua2xt41lq8J+j8biM/8lK
         TXjw==
X-Gm-Message-State: AGi0PuYHnYJc4xlxBYINqQ3p+r4k6+Lo5XL/gc4ci0/9N+rIT9Z4HzyM
        HJ3w2DPsyUBGDZJusVaaVNfsmw==
X-Google-Smtp-Source: APiQypIh8dv6EhpHtZfx/oK6c8hvmtzPrPegZc68gIU5zluDsBPHkcGRRKdcXzhMGJ8v56855PjPYw==
X-Received: by 2002:a63:ca41:: with SMTP id o1mr24177997pgi.419.1586892210952;
        Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 3sm1147978pgh.75.2020.04.14.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:23:30 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:23:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Hillf Danton <hdanton@sina.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <20200414064441.GC23359@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004141222260.2583@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <20200410145520.17864-1-hdanton@sina.com> <alpine.DEB.2.21.2004101231240.249689@chino.kir.corp.google.com> <20200414064441.GC23359@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Christoph Hellwig wrote:

> > I'll rely on Christoph to determine whether it makes sense to add some 
> > periodic scavening of the atomic pools, whether that's needed for this to 
> > be merged, or wheter we should enforce some maximum pool size.
> 
> I don't really see the point.  In fact the only part of the series
> I feel uneasy about is the growing of the pools, because it already
> adds a fair amount of complexity that we might not need for simple
> things, but shrinking really doesn't make any sense.  So I'm tempted
> to not ever support shrinking, and even make growing optional code under
> a new config variable.  We'll also need a way to query the current size
> through e.g. a debugfs file.
> 

New debugfs file sounds good, I'll add it.  If we want to disable dynamic 
expansion when the pool is depleted under a new config option, let me 
know.
