Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77663C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDEF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWefLAuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHLKh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:37:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE74C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gP+H8ubPi8ciq3uu0zTjfB2jzrjIOsQl6XOLQ6h/JG0=; b=XWefLAuFbt+O8ayDhWF1acMn6A
        Y1rFJvLv/7b17L23+DcLwp+bPc1qOz0FnRlFrNprE6qoWUTmOAoVXn6x9R1iXkLjAVUdqZJNScPCb
        rUmhoBTq7m5ZO6yun1UpGJABv9wgH1100e/xo+5vl8G3W0PiAQ+NXomZcbtUIAGgmNo148WuL2CJs
        qMnB/wo6DvmijC0l3f0hFrVoaWmJ7N/Kno8To56t7YcteSEULyCc3/CyQAJ9IOLZ8lhGU3V/sjukq
        4kkN+zkeIlK7NwsVMP4DPKvNU2gp7xqz6TO5nBoqniiDphtm7JGyW37g8vfI/kNNI23zcZnwImdjG
        tVXglD1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5o7R-0008E7-Ix; Wed, 12 Aug 2020 10:36:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD705300238;
        Wed, 12 Aug 2020 12:36:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80FE220EA5AE5; Wed, 12 Aug 2020 12:36:27 +0200 (CEST)
Date:   Wed, 12 Aug 2020 12:36:27 +0200
From:   peterz@infradead.org
To:     christian.koenig@amd.com
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] locking/rwsem: remove redundant semicolon of
 down_write_nest_lock
Message-ID: <20200812103627.GM2674@hirez.programming.kicks-ass.net>
References: <20200811111852.190209-1-christian.koenig@amd.com>
 <20200812081057.GJ2674@hirez.programming.kicks-ass.net>
 <8356e96d-8732-0e2e-e962-dec671c19eb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8356e96d-8732-0e2e-e962-dec671c19eb2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:36:14AM +0200, Christian König wrote:
> Am 12.08.20 um 10:10 schrieb peterz@infradead.org:
> > On Tue, Aug 11, 2020 at 01:18:52PM +0200, Christian König wrote:
> > > From: Guchun Chen <guchun.chen@amd.com>
> > > 
> > > Otherwise, braces are needed when using it.
> > > 
> > > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Thanks!
> 
> Do you pick it up or can I push it through drm-misc-fixes?
> 
> If the former please let me know when it hits Linus tree since I have a
> driver which contains some extra {} because of this.

Oh, in that case you can take it:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

and I'll drop it from my quilt series.
