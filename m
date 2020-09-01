Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2FF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598958777;
	bh=QCYSdtAYLN+f++6XyOMvY/CKpRVLzqQUReDYKl7Tmk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pOo2BAXGRAGuBXy+OaodVQYkIGSUpDmBroBYleFe1zomaLT6i9MVVzcDNNW1QJJDL
	 +pH33bxWwPjzlEVRuuXm00rXSVTpWmkeRUVsdCsc0E1DcKo5I4rdx0QEM7SggpwPoW
	 64XCArga81yBfeRllIC3fQbiiBOILLjCxkYFHyLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIALJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIALC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:02:56 -0400
Received: from localhost (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CA6206EF;
        Tue,  1 Sep 2020 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958174;
        bh=QCYSdtAYLN+f++6XyOMvY/CKpRVLzqQUReDYKl7Tmk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFCek2P99Re/uJ+lbJOk+hM/WTo83VuQDJl5MTmEiSpeXuOMZHVVAFJLw4Qt1XJiJ
         8+Wb77oxTGWzZ7wN5uNn3ob2xbEdF+8vDxWmwEqr5N1tWHkdaDYZkepuJf2b8OICc3
         Yu8TDwfe2ld3easguiL64mePN/51/9jhV1b5ueno=
Date:   Tue, 1 Sep 2020 16:32:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: fix error handling
Message-ID: <20200901110244.GZ2639@vkoul-mobl>
References: <20200829153515.3840-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829153515.3840-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

On 29-08-20, 08:35, trix@redhat.com wrote:
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

The change looks good to me, but the title of patch should be revised.

The patch subject should describe the patch, in this case is setting
pointer to null on cleanup, so an appropriate subject may be"
"[PATCH]: soundwire: set defer_msg to null".

Please revise subject line and update including the ack/reviews
received

Thanks
> 
> Fixes: 99b8a5d608a6 ("soundwire: Add bank switch routine")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/soundwire/stream.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 37290a799023..6e36deb505b1 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -717,6 +717,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>  	kfree(wbuf);
>  error_1:
>  	kfree(wr_msg);
> +	bus->defer_msg.msg = NULL;
>  	return ret;
>  }
>  
> @@ -840,9 +841,10 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>  error:
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>  		bus = m_rt->bus;
> -
> -		kfree(bus->defer_msg.msg->buf);
> -		kfree(bus->defer_msg.msg);
> +		if (bus->defer_msg.msg) {
> +			kfree(bus->defer_msg.msg->buf);
> +			kfree(bus->defer_msg.msg);
> +		}
>  	}
>  
>  msg_unlock:
> -- 
> 2.18.1

-- 
~Vinod
