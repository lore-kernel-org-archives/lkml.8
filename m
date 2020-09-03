Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DA8C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2B32065E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599122441;
	bh=/RhL1+Os0ZHjkfhSyZSXiOAfORqfkCbABBv7SoNeSus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b+wHXCH24QYGqkjAEGFJKTId6dlV0PPRjGxWclrTd6yqZbncBnbUjGensFLtRJELj
	 /EN5ZF2IAbNcbmj2cbCP3HeyvBtKnihq3jDIF5e5pDSWHhAntjmGQ+2QoHKWQmXbxy
	 jwk6F5WWgIZNoUIaSFCx4hXB9AWrvlYGK3UF2XpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgICIkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgICIki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:40:38 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A650206C0;
        Thu,  3 Sep 2020 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599122437;
        bh=/RhL1+Os0ZHjkfhSyZSXiOAfORqfkCbABBv7SoNeSus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bqv3xA8ZsbL4xC45ykIHJ3xL4LxR6kgq8JH3vNz6QsLqABuwb+j0v/e8bQtPJcnO4
         uIEC6+0nhPjNhUTiHlLZCuF18W+QHuyFLqrkKvJdff1OkX6DfTs4JFuXfaFflrpavS
         nrDQ/cuSnGXpIB5oSpsCKMZEsQDwLNImH5lnrzM8=
Date:   Thu, 3 Sep 2020 14:10:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] soundwire: fix double free of dangling pointer
Message-ID: <20200903084033.GN2639@vkoul-mobl>
References: <20200902202650.14189-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902202650.14189-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-09-20, 13:26, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this problem
> 
> stream.c:844:9: warning: Use of memory after
>   it is freed
>         kfree(bus->defer_msg.msg->buf);
>               ^~~~~~~~~~~~~~~~~~~~~~~
> 
> This happens in an error handler cleaning up memory
> allocated for elements in a list.
> 
> 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> 		bus = m_rt->bus;
> 
> 		kfree(bus->defer_msg.msg->buf);
> 		kfree(bus->defer_msg.msg);
> 	}
> 
> And is triggered when the call to sdw_bank_switch() fails.
> There are a two problems.
> 
> First, when sdw_bank_switch() fails, though it frees memory it
> does not clear bus's reference 'defer_msg.msg' to that memory.
> 
> The second problem is the freeing msg->buf. In some cases
> msg will be NULL so this will dereference a null pointer.
> Need to check before freeing.

Applied, thanks

-- 
~Vinod
