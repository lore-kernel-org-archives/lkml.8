Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2F20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Jjj+4cBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391643AbgEZT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391077AbgEZT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:29:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:29:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l3so10028599qvo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5fwwIxFH7f/kmk6i7Ys4k2g6xkiprlXV/4qEUFv3VY=;
        b=Jjj+4cBaHIOHD3iKYk3v1Zd4y9fojiMHEJuA23ZKtbL20G7/sbDIELB8VrH2rmum2p
         FP0gJRsB93BFxGU3Lq6dFO5QHP0Yj97RAveuNnyzIU+GVXleV0tgkpTXmN2XzNpNx4MG
         uPChc7VcNq2vdA0sf6E6QgCKV23WT7c8IoQSJpzEpRDUU+atZ6A2UswWNtc8VQ/bvX8k
         XJi9C3F9NQyLIMQlRIL8PZgjkG1/U/Jb55X/8QT0D+/QUVWMUGXzrBQ62gdRsFy+0zNj
         6QlUKLhxwulSsR4Sff86ZDnWUpxdu5M3UPL11pG6xjGbDfVhaQV47NZ82/SJY5G7b+0D
         Kexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5fwwIxFH7f/kmk6i7Ys4k2g6xkiprlXV/4qEUFv3VY=;
        b=AXAFcO9K39s4kTU8sLWPmgsuVwn8EoeoL0Y8vtN5kpX1cTZ7crLwfu2D8FG11WTXEZ
         gGg847ll0v7fEX/VwIDkoDYt7sVCW9m9LO7GN/vRCkBuNbf7hdL9BQLNQus4Fnc6RW/6
         e7pTd63AytH5MYJcLDqQ53AZ5n/9rppWVRNC5Ux1gsaeoa7k16smYbO1OC2xeB4cEdfh
         L2XahoCC126FCPvYTFzrK1m7rH5x6AFugdkKQwAo5BxRapGcoS1qJJTIMB/VXzcUdEFA
         tc0m8wxoaIsG/NmH4MMScvcfGRgnBIGpoJdsUot7f2MbobpTqIu02HJHdUe8NLqtye0J
         YLmw==
X-Gm-Message-State: AOAM533OGZIx5AAa30SU1KX+lFqZRf9m6wu7BuBHnffJ/8Ii6uS2bB1r
        kJ84EfvI/E6A8dJTN6YeMZwKag==
X-Google-Smtp-Source: ABdhPJxQWxKIVBoJ0YrveWR4sYvmn2r7zS3iKLOrRM/uNbbN1S3sWnhqnHkzJGKIbRL2eu8NBOCzzA==
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr283126qvy.83.1590521339800;
        Tue, 26 May 2020 12:28:59 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a24sm522072qto.10.2020.05.26.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:28:59 -0700 (PDT)
Date:   Tue, 26 May 2020 15:28:56 -0400
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526192856.GF991@lca.pw>
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526185850.GE991@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:58:53PM -0400, Qian Cai wrote:
> On Tue, May 26, 2020 at 01:43:49PM -0400, Waiman Long wrote:
> > It was found by Qian Cai that lockdep splat sometimes appears with the
> > "BUG: MAX_LOCKDEP_ENTRIES too low" message on linux-next. On a 32-vcpu VM
> > guest with a v5.7-rc7 based kernel, I looked at how many of the various
> > table entries were being used after bootup and after a parallel kernel
> > build (make -j32). The tables below show the usage statistics.
> 
> I think this approach could help the situatin on this AMD server.
> However, I don't understand why this particular system starts to exceed
> the MAX_LOCKDEP_ENTRIES. All other Intel, powerpc, amd64 and s390
> running the same workload have only < 20k at the end, but on this AMD
> server,

Correction -- Intel is also quite close to exceed it.

direct dependencies:                 29836 [max: 32768]

arm64:

direct dependencies:                 25268 [max: 32768]

