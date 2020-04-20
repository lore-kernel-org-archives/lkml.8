Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEBC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5116720857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587395217;
	bh=tZzid1ierjtEP5oKAiqkEpzGVm7IESxd33GM0LkM1m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1PSu1texBl9l9xD65PXg91T9TDb6sH8/EH+47ORu2qUx9fMJy1t04s4UE+9RGWjHm
	 vInfxV7LQSIsbj5WEdjWosrNxcfpaeVtSnuJAKEY87NY/0VmnIXbPHks8OtfO1odHQ
	 l9dYFuzyEgnCkm/N0h40WHb6SKGZO6baFcGE6p70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgDTPG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgDTPG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:06:56 -0400
Received: from localhost (unknown [171.61.106.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06EB42074F;
        Mon, 20 Apr 2020 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395215;
        bh=tZzid1ierjtEP5oKAiqkEpzGVm7IESxd33GM0LkM1m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnTrdFjcnq66iqPP2QGWZYt9tnu7D9dAyGpj/SvLtzHVPIuLEAu9D479r194q2ohj
         TRMN3EMVnVMBg0eYZZ6ZIOCn8yRza0YCElOnxZOZX93K1Gtji1+vljXGuOeJND71+h
         iH2M799cDaIUUTKrG25z2brBocdlvLyI5fDL806k=
Date:   Mon, 20 Apr 2020 20:36:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420150651.GZ72691@vkoul-mobl>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
 <20200420120348.GA6507@sirena.org.uk>
 <20200420121752.GY72691@vkoul-mobl>
 <20200420140135.GD10045@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420140135.GD10045@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20, 15:01, Mark Brown wrote:
> On Mon, Apr 20, 2020 at 05:47:52PM +0530, Vinod Koul wrote:
> > On 20-04-20, 13:03, Mark Brown wrote:
> 
> > > > Applied, thanks
> 
> > > This fix is needed in the ASoC tree - are you OK with me applying it
> > > there?
> 
> > Sure..
> 
> > Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> Hrm, actually this doesn't seem to apply against the ASoC tree - looks
> like we might need a cross tree merge if there's still issues in -next.


That seems strange, it applied fine for me on -rc1. Let me know if you
are seeing issues with this...

-- 
~Vinod
