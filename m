Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F49C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C982087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579270788;
	bh=1UnnLVeZLQ92n1ChKZKfzqxzORKBkvv2IdXh/d6Tjtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v5mUFgBxUSI4dmoT8W6dsJc6EeLN8GMj99T0Lwtshz96eYMDGMDnsTYVv+6ZsdnGh
	 idxu9D56j/EugNt6Yfn5JdW/rV9VPnhhrHH7q8ZYmqYks8Z+KtJoFfvTmcI8l+BpNk
	 Wv2OBU1zMhaUQszXuPSmB4fJn687mrKYNmZeEcYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQOTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgAQOTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:19:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16222083E;
        Fri, 17 Jan 2020 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579270786;
        bh=1UnnLVeZLQ92n1ChKZKfzqxzORKBkvv2IdXh/d6Tjtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+JU9uifUr2pX71XOyHKwMwqhUHm15/TeXVe5lmGSBQDEKcGI4TdOV0kZAk6dCYZP
         Sg1ZpVsOAHmBZGyZKmiFplF0fHf3M/uvaH8IKqwiqkg5mMMGnWFCx10jp4mrczdBUT
         6WQWU/M9+xVedGO4KY55CKe/wt7mtWsNd7/kEHSs=
Date:   Fri, 17 Jan 2020 15:19:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     roman.sudarikov@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200117141944.GC1856891@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:37:59PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Current version supports a server line starting Intel® Xeon® Processor
> Scalable Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
> 
> IIO stack to PMON mapping is exposed through:
>     /sys/devices/uncore_iio_<pmu_idx>/mapping
>     in the following format: domain:bus
> 
> For example, on a 4-die Intel Xeon® server platform:
>     $ cat /sys/devices/uncore_iio_0/mapping
>     0000:00,0000:40,0000:80,0000:c0

Again, horrible format, why do we have to parse this in userspace like
this?  Who will use this file?  What do they really need?

And what happens when you have too many "dies" in a system and you
overflow the sysfs file?  We have already seen this happen for other
sysfs files that assumed "oh, we will never have that many
cpus/leds/whatever in a system at one time" and now they have to go do
horrid hacks to get around the PAGE_SIZE limitation of sysfs files.

DO NOT DO THIS!

I thought I was nice and gentle last time and said that this was a
really bad idea and you would fix it up.  That didn't happen, so I am
being explicit here, THIS IS NOT AN ACCEPTABLE FILE OUTPUT FOR A SYSFS
FILE.

greg k-h
