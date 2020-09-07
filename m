Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B8CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8D621532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498884;
	bh=txf6Aio9R53YCpE68YY0DvhEiaYvffb68hp9MwsZtds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=piDLIuRKfJ2OvoTkM05DSsxo7Zx5WiMnol/LnC6mZfmDxjQVivrONtuZf7s439eXv
	 1mYYNI8QykoSlmDeRSu+63mPNfBR/hpK4zlJ7DQdAyOrS58fPwq/SmbaeelP38rkql
	 SbAj7L9FDUEo3nPMH9rI9SW7OGVb3CBCurIXA83M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgIGROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgIGOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:14:50 -0400
Received: from localhost (unknown [122.167.151.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5762064B;
        Mon,  7 Sep 2020 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599488048;
        bh=txf6Aio9R53YCpE68YY0DvhEiaYvffb68hp9MwsZtds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1Skm40OOG7qD2Nw8rttcooQx/f2OkkHe2QfXql+TqkgFDZbaZx83IkJKWWZ7Om2t
         W3pqYj+jnnEFkkHha3NCo5lKHtyKwCwCODphADNfLwXw/s/cZpyGna3AI7KDS0PifV
         K4feqAhde7poE89ZyoGKU9RsgNSxbhM6u3/H3puc=
Date:   Mon, 7 Sep 2020 19:44:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        guennadi.liakhovetski@linux.intel.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] soundwire: stream: fix an invalid free
Message-ID: <20200907141402.GC2639@vkoul-mobl>
References: <20200905192613.420-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905192613.420-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

On 05-09-20, 12:26, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analyzer reports this problem
> 
> stream.c:872:2: warning: Argument to kfree() is a constant
>   address (18446744073709551092), which is not memory
>   allocated by malloc()
>         kfree(stream);
>         ^~~~~~~~~~~~~
> 
> In sdw_shutdown_stream() the stream to free is set by
> a call to snd_soc_dai_get_sdw_stream().  The problem block
> is the check if the call was successful.
> 
> 	if (!sdw_stream) {
> 		dev_err(rtd->dev, "no stream found...
> 		return;
> 	}
> 
> When snd_soc_dai_get_sdw_stream() fails, it does not
> always return null, sometimes it returns -ENOTSUPP.
> 
> So also check for error codes.
> Fixes: 4550569bd779 ("soundwire: stream: add helper to startup/shutdown streams")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/soundwire/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 6e36deb505b1..950231d593c2 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1913,7 +1913,7 @@ void sdw_shutdown_stream(void *sdw_substream)
>  
>  	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
>  
> -	if (!sdw_stream) {
> +	if (IS_ERR_OR_NULL(sdw_stream)) {

Thanks for the patch. Please see commit 3471d2a192ba ("soundwire:
stream: fix NULL/IS_ERR confusion") in soundwire-next. This has already
been updated to IS_ERR() and Bard has already sent patches for
snd_soc_dai_get_sdw_stream() to return proper values.

So I you can rerun this on next, you should see this fixed.

-- 
~Vinod
