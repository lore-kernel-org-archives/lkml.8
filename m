Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD268C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AEA20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443619;
	bh=D1uJfmjgC/26o2z3u1zFuw7ebz3MKhc1sl8fKcEtvqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hC1wZncZ32V4s8gciKtlKnvQrH45box9kztwsa3px/m9R7BMWYJn0Wq9o2Kz9r/DY
	 FPFVUBHd/EN8hC5rJQpeFpzzExK5TjLn5rXkNYttNfjrcLs/WWFD+ECiHrFVwfYyA3
	 MiEm8cTUdB+CxCcmHvFeMiuWlNL1weAQOFOAMiTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgHZMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbgHZMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:28 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8C920897;
        Wed, 26 Aug 2020 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443407;
        bh=D1uJfmjgC/26o2z3u1zFuw7ebz3MKhc1sl8fKcEtvqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duxjQB0p/RG9lpGyNMl+3wLI/iY6Ywj0fIehqcHQRy6ik4BDUpo57UKpANLlRQY8O
         1EqLuq51Wy4AoOO/kkgVX/g7QDGd7sZiqZsXWQyan50Wc2rpumt4wwqr+KMxZIN7m/
         5Y2Bz85mXHQCqsQvBiD9JNTOcc2O9QLUW0B6pt0Q=
Date:   Wed, 26 Aug 2020 17:33:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826120323.GD2639@vkoul-mobl>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk>
 <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk>
 <s5h8se1u2or.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8se1u2or.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 12:22, Takashi Iwai wrote:
> On Wed, 26 Aug 2020 12:13:01 +0200,
> Mark Brown wrote:
> > 
> > On Wed, Aug 26, 2020 at 12:09:28PM +0200, Takashi Iwai wrote:
> > > Mark Brown wrote:
> > 
> > > > checkpatch is broken.
> > 
> > > Heh, I'm not objecting it :)
> > 
> > > OTOH, it's also true that ENOTSUPP is no good error code if returned
> > > to user-space.  Unfortunately many codes (including what I wrote) use
> > > this code mistakenly, and they can't be changed any longer...
> > 
> > It's also used internally in various places without being returned to
> > userspace, that's what's going on here - the regmap core has some
> > specific checks for -ENOTSUPP.
> 
> Sure, for such an internal usage any code can be used.
> The question is a case like this -- where the return code might be
> carried to outside.  Though, looking through the grep output, all
> callers simply return -EINVAL for any errors, so it doesn't matter
> much for now.
> 
> 
> BTW, there are a few callers of devm_regmap_init_sdw() checking the
> return value with NULL.  This will crash as the function returns the
> error pointer, and they must be checked with IS_ERR() instead.

Yes that is correct, all expect wsa codec do the incorrect thing. Will
send patches for these shortly

Thanks
-- 
~Vinod
