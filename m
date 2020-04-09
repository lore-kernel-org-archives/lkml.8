Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC42085B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586398808;
	bh=iRS5nfmtHWdMeMQ5MMWQ1/T5MoTdMmVI2Mbi5yLgKhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qxf7TdcnymCB3PDJz0t4txXwGK9z8QsxL0L83vQdHv85Q8uOanedE3vFvxUzJmGxf
	 Ges1e+lla254a1sSX09Uw0H0vAEcU5aZuT5vimlrwJ9pY5AEgLhi6OCcf7WQJEe+au
	 SuZV7HdIQYgWYu+yBsF6+wx2AXQZNjJdC41gYsDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDICUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgDICUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:20:06 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE0320787;
        Thu,  9 Apr 2020 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586398806;
        bh=iRS5nfmtHWdMeMQ5MMWQ1/T5MoTdMmVI2Mbi5yLgKhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACbBXXd38FtV4VhKl0MWHR0q4Y+e4IV7cslrqwoctBNV5vZT16q3K93cC0sjOYJod
         tPk8p1+2u9zCVFnSQv0R/xTEWctzYjj5vYSt915BjPzL3QXcyD9sybo+Tj6K5RfGg5
         +o0cSPAEOKYjeA8MgfVzMWPw8Vyx+5yHySijxdUg=
Date:   Wed, 8 Apr 2020 19:20:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
Message-ID: <20200409022005.GA110440@google.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
 <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
 <20200407025913.GB137081@google.com>
 <2ca452cd-073a-29fa-1884-99ad1199bb97@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca452cd-073a-29fa-1884-99ad1199bb97@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07, Chao Yu wrote:
> On 2020/4/7 10:59, Jaegeuk Kim wrote:
> > On 04/07, Chao Yu wrote:
> >> On 2020/4/4 0:12, Jaegeuk Kim wrote:
> >>> This patch introduces a way to attach REQ_META/FUA explicitly
> >>> to all the data writes given temperature.
> >>>
> >>> -> attach REQ_FUA to Hot Data writes
> >>>
> >>> -> attach REQ_FUA to Hot|Warm Data writes
> >>>
> >>> -> attach REQ_FUA to Hot|Warm|Cold Data writes
> >>>
> >>> -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
> >>>           REQ_META to Hot Data writes
> >>
> >> Out of curiosity, what scenario it is used for?
> > 
> > It's testing purpose to compare the bandwidths per different IO flags.
> 
> Thanks for the hint. :)
> 
> As nobarrier was set in Android, so REQ_PREFLUSH will not be considered in
> this sysfs interface?

I don't see any diff on performance, so not interesting. :)

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> > .
> > 
