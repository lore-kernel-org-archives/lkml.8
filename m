Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFDC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA42187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578892950;
	bh=pQmyxSK2rYvZKhrIwLap9VHfSzCEWZiVvINtuLhYf+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S1FFJ/mN1vmggjicys+0qZcRSdXbHMxZS9yqVfB57oBF/A1hnAryULFExLEawKRYV
	 3isJo2XvwuY1WM92bXKLjJPtaTPraT4eYKV1ZGyRRvtT9lKilaWEiyD7L9ovVgxFlr
	 mJ2+yk8jL4Xd0Hl3bpDQWPRp+1K49jtCQFMeB1B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAMFW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAMFW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:22:29 -0500
Received: from localhost (unknown [106.200.247.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A93121556;
        Mon, 13 Jan 2020 05:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578892948;
        bh=pQmyxSK2rYvZKhrIwLap9VHfSzCEWZiVvINtuLhYf+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXsnWQlS74pdFu0UVzYxpNsBcF1pjQrjT5BtFxF/taQ3HDzM842jYOvVocHdIWHG9
         J+i7dHx1rmbqKaLZExA0iZN52nxNbefaz3lsNVHM25Wj2b8b0dwwoSCDmehmjB0IRc
         dXZyIv9yOCMRN0Vz0016AX+lCzyP+cCrTUAuhMIM=
Date:   Mon, 13 Jan 2020 10:52:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/6] soundwire: stream: update state machine
 and add state checks
Message-ID: <20200113052224.GQ2818@vkoul-mobl>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-3-pierre-louis.bossart@linux.intel.com>
 <20200110064838.GY2818@vkoul-mobl>
 <a18c668f-4628-0fb9-ffa0-b24cdad1cc8b@linux.intel.com>
 <69ad48b0-fa3c-904a-4106-5cd9bd18de5c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69ad48b0-fa3c-904a-4106-5cd9bd18de5c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-20, 05:30, Pierre-Louis Bossart wrote:
> 
> 
> On 1/10/20 10:30 AM, Pierre-Louis Bossart wrote:
> > 
> > > > -  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
> > > > +  int sdw_prepare_stream(struct sdw_stream_runtime * stream,
> > > > bool resume);
> > > 
> > > so what does the additional argument of resume do..?
> > > 
> > > > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > > > index 178ae92b8cc1..6aa0b5d370c0 100644
> > > > --- a/drivers/soundwire/stream.c
> > > > +++ b/drivers/soundwire/stream.c
> > > > @@ -1553,8 +1553,18 @@ int sdw_prepare_stream(struct
> > > > sdw_stream_runtime *stream)
> > > 
> > > and it is not modified here, so is the doc correct or this..?
> > 
> > the doc is correct and the code is updated in
> > 
> > [PATCH 4/6] soundwire: stream: do not update parameters during
> > DISABLED-PREPARED transition
> 
> Sorry, wrong answer, my bad. The code block in the documentation is
> incorrect.
> 
> The Patch 4/6 implements the transition mentioned in the documentation, but
> the extra parameter is a left-over from an earlier version. This case is now
> handled internally. We did revert to the initial prototype after finding out
> that dealing with transitions in the caller is error-prone.

Glad that you agree with me on something!

-- 
~Vinod
