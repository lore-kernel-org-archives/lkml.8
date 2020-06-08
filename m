Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9B62076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591621137;
	bh=Udn/ECwZeBtWEDbCfPcTaufza+OKKkyBc9uRmHVaIUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TUIuzHrcYp3QgtDs15BuH6OGuQwhcLh2KB6YASgqHT9Vh+0I1xrGGSYqHctmpRXWy
	 fNZzvz4OI+osvagfa8AfCPbU5sGQ+Zo2RPH3E+rFU/5ydFZZTTCNk+iJx2c3ykoYSy
	 cqjE1DzHbu9nSk1+7EBkAyR82tIUxnexxLlRuRok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgFHM65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFHM64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:58:56 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BFB206C3;
        Mon,  8 Jun 2020 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591621136;
        bh=Udn/ECwZeBtWEDbCfPcTaufza+OKKkyBc9uRmHVaIUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYDrFLFHs0ymiK0lI5LCGx3TQEDuGS8cxZw+4zb0RuYOUm6phKPo2d64fksT93qXu
         HvAtjMcjbXK0r1K3yFrGL2pSFBL3/92MDaVZhAxik+NgKnlCKhsOQe7VUgMl9gH0S9
         m3nsn0iZ8GIJR6e72HkSlhfZUodojMR9PhKa4Tsg=
Date:   Mon, 8 Jun 2020 05:58:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: attach IO flags to the missing
 cases
Message-ID: <20200608125855.GA200855@google.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
 <20200604235023.1954-2-jaegeuk@kernel.org>
 <20200608025125.GA127000@google.com>
 <70f2b6f6-189f-bafe-6db8-7c16a4a7f6ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f2b6f6-189f-bafe-6db8-7c16a4a7f6ac@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08, Chao Yu wrote:
> Jaegeuk,
> 
> This patch should be applied before "f2fs: attach IO flags to the missing cases",
> otherwise, gcc may complain about implicit declaration of "__attach_io_flag".

Yup. Done. :P

> 
> On 2020/6/8 10:51, Jaegeuk Kim wrote:
> > This patch adds another way to attach bio flags to node writes.
> > 
> > Description:   Give a way to attach REQ_META|FUA to node writes
> >                given temperature-based bits. Now the bits indicate:
> >                *      REQ_META     |      REQ_FUA      |
> >                *    5 |    4 |   3 |    2 |    1 |   0 |
> >                * Cold | Warm | Hot | Cold | Warm | Hot |
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
