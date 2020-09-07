Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB80C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA8D2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497742;
	bh=RZjmdONo/8i3kJYH8JYLbprcFOu0SZPUSptiPG3+JEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=whJ9NF9Jxbx2mwh2zZeDwToVmz/L/slci56k35I2plGBLMnv2U9f8YfPSZG2uzDPR
	 zsF23WG7FrKQHRp6DyRBpYZsDwxc34BbqlUW36VfAoWawsGdMy/9X9aOaGhIw8/tHQ
	 bn1Zps8mN5UfD4pdIXdCzlmYBPwp86naVvILPB7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgIGQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbgIGQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:55:20 -0400
Received: from localhost (unknown [122.167.151.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3A7208C7;
        Mon,  7 Sep 2020 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599497719;
        bh=RZjmdONo/8i3kJYH8JYLbprcFOu0SZPUSptiPG3+JEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwRkdSlw5ifquH2bt94iscfeZG6J1FXzC4tRR6o8+GXw3c+zxXVee+dciGSpRatRD
         FOe/cOXEOSxHizq4KgmRS3LDI/dSft/VsggBsFaslSg6ite+vI3pdsqNDKfLwA8KKN
         ERkb/4eBAxxzkgyAIMy4+dkj34ZnikDrJjZPZvVc=
Date:   Mon, 7 Sep 2020 22:25:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        guennadi.liakhovetski@linux.intel.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] soundwire: stream: fix an invalid free
Message-ID: <20200907165511.GE2639@vkoul-mobl>
References: <20200905192613.420-1-trix@redhat.com>
 <20200907141402.GC2639@vkoul-mobl>
 <93b672ef-76c9-e87c-4526-897b0af01945@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93b672ef-76c9-e87c-4526-897b0af01945@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-20, 07:25, Tom Rix wrote:
> 
> On 9/7/20 7:14 AM, Vinod Koul wrote:
> > Hello Tom,
> >
> > On 05-09-20, 12:26, trix@redhat.com wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> clang static analyzer reports this problem
> >>
> >> stream.c:872:2: warning: Argument to kfree() is a constant
> >>   address (18446744073709551092), which is not memory
> >>   allocated by malloc()
> >>         kfree(stream);
> >>         ^~~~~~~~~~~~~
> >>
> >> In sdw_shutdown_stream() the stream to free is set by
> >> a call to snd_soc_dai_get_sdw_stream().  The problem block
> >> is the check if the call was successful.
> >>
> >> 	if (!sdw_stream) {
> >> 		dev_err(rtd->dev, "no stream found...
> >> 		return;
> >> 	}
> >>
> >> When snd_soc_dai_get_sdw_stream() fails, it does not
> >> always return null, sometimes it returns -ENOTSUPP.
> >>
> >> So also check for error codes.
> >> Fixes: 4550569bd779 ("soundwire: stream: add helper to startup/shutdown streams")
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >> ---
> >>  drivers/soundwire/stream.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> >> index 6e36deb505b1..950231d593c2 100644
> >> --- a/drivers/soundwire/stream.c
> >> +++ b/drivers/soundwire/stream.c
> >> @@ -1913,7 +1913,7 @@ void sdw_shutdown_stream(void *sdw_substream)
> >>  
> >>  	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
> >>  
> >> -	if (!sdw_stream) {
> >> +	if (IS_ERR_OR_NULL(sdw_stream)) {
> > Thanks for the patch. Please see commit 3471d2a192ba ("soundwire:
> > stream: fix NULL/IS_ERR confusion") in soundwire-next. This has already
> > been updated to IS_ERR() and Bard has already sent patches for
> > snd_soc_dai_get_sdw_stream() to return proper values.
> >
> > So I you can rerun this on next, you should see this fixed.
> 
> I am working on linux-next, so I will see Bard's patch when it lands there.

It should be already there... And I checked, looks like there was no
linux-next for last few days and it should be back tomorrow so should be
there

> 
> Sorry for not working on soundwire-next, but since i am fixing everywhere linux-next is easiest. 

Agree, timing this time around!

-- 
~Vinod
