Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C97C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16442206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587385083;
	bh=GD6yKftMiFUcgIV6wTVwHE7yEFYw9iJR2KXH1JFWqIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZWEOqV09ATGh5lGDy4n1Qjw4L3N3AkfGDzi7M+J7DeI7O76frN55wBDYmBUoYE84
	 WsuqQ+QLDl+68mbWg/6cyYZpPpdAP8QGUNZkhVwWnHroQ4VYNjwabHQL0Z70Aku95I
	 hlfZtEgnt6erGIQ+fH2hyQ9HppET5Fgv67ZgBLRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDTMSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDTMSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:18:01 -0400
Received: from localhost (unknown [171.61.106.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69EC206B9;
        Mon, 20 Apr 2020 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587385081;
        bh=GD6yKftMiFUcgIV6wTVwHE7yEFYw9iJR2KXH1JFWqIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uPBVK41YVu/dXIrss/tCWROOew4ZD1hUthru4+AxfzYQwR1g4lhcy9WiA0hXdSW9
         Z7tDa5Q/wN4FSL4cjaRYUunfcsIDyIQSgXP/Gs9pYGtFG0e7O1jKtNEe7j3BlJiBYo
         Ph6UcHZLSqRdwGrixHNA032YLFoWHzzMS7r871uw=
Date:   Mon, 20 Apr 2020 17:47:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420121752.GY72691@vkoul-mobl>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
 <20200420120348.GA6507@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420120348.GA6507@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 13:03, Mark Brown wrote:
> On Mon, Apr 20, 2020 at 12:38:16PM +0530, Vinod Koul wrote:
> > On 20-04-20, 16:01, Kuninori Morimoto wrote:
> 
> > > Now ALSA SoC needs to use asoc_rtd_to_codec(),
> > > otherwise, it will be compile error.
> 
> > Applied, thanks
> 
> This fix is needed in the ASoC tree - are you OK with me applying it
> there?

Sure..

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
