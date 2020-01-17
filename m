Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59954C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6842082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579270467;
	bh=825RQFuUXuZSLIfbHZMXkgtEmPV3IvQekBXX4Vh26hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SD/IPNq45/IEjmy1Pv5y1TImyYSb+9RG+K8SGlpZ4cPG+5splTmdCAdsyC1n2JtEb
	 puSf/euOnOslVWebnO7+B30ps3xDqnoip5H0SJaqZL+HjSzGPChTUMYeWFlKthDHpQ
	 UfkdFKFrJL8LxlCIstxsHjPJcdHb8j43OBGj/No8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAQOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:14:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgAQOOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:14:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5C5206B7;
        Fri, 17 Jan 2020 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579270464;
        bh=825RQFuUXuZSLIfbHZMXkgtEmPV3IvQekBXX4Vh26hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDoh99OCtdVB4p026/Rsk8DXKiUUCCFsi4NFgzaPHseVEXofHDfpq5+jCqJJe7noc
         05ffWk2QQ/6IXQgl1FUfjwlIvsqYBkdmPxcVU1KK27/ITUltrTis++D3zyprFvhkTF
         0UmjRePbKqzgoqkNpW2z+XRqzpZwKNkiicmd4w5U=
Date:   Fri, 17 Jan 2020 15:14:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     roman.sudarikov@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 0/2] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
Message-ID: <20200117141421.GA1856891@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:37:57PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> The previous version can be found at:
> v3: https://lkml.kernel.org/r/20200113135444.12027-1-roman.sudarikov@linux.intel.com
> 
> Changes in this revision are:
> v3 -> v4:
> - Addressed comments from Greg Kroah-Hartman:
>   1. Reworked handling of newly introduced attribute.
>   2. Required Documentation update is expected in the follow up patchset

What follow up patchset?  Please include it here so we can properly
review if the code you have matches the documentation and if it makes
sense to do it that way.

thanks,

greg k-h
