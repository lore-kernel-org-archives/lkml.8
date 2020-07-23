Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307EBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1820771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595479679;
	bh=fy1TB8rjpKHadG1jVEEzeFm3kN+ZDLJr33KVmJVqxI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQZvf0sO17AcUYcrP1AYe9EK68ARfiX/dUsjKxMegr/kNb0Nd7VN3eFfqSfsNCvRY
	 3KWx7ZRX2ZeIfEQ/QAdG3bw3J2QJwFLjxVl+Ej1eKlgKuhVfzaqpRXXNI/XvlncN0U
	 hOLPxDt8vcs17gzYC9TMe6EdzwWyyoipoLwEtxbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGWErj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgGWErj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:47:39 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0807420768;
        Thu, 23 Jul 2020 04:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595479659;
        bh=fy1TB8rjpKHadG1jVEEzeFm3kN+ZDLJr33KVmJVqxI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3CZDCC9pU2t1v8t9bgg/NiGEiQ5K9OLbJysPolh2dVRXRZ65RtzNQ7g/Jx1H77FS
         sYMxkgq1ENZwdSKE11kKhcvq/iSanNA2W8V+GXCHSoLzhb44bgCE8za+4CmxQO1HuQ
         xqt/5HZRkAqWwUwGZr52fpPOiocS1eHLvmR8goZE=
Date:   Thu, 23 Jul 2020 10:17:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        ckeepax@opensource.cirrus.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
Message-ID: <20200723044734.GU12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
 <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
 <19cfe3fe-4b99-0976-679d-28523d7b9990@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19cfe3fe-4b99-0976-679d-28523d7b9990@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 10:36, Pierre-Louis Bossart wrote:
> 
> > > >    * and the stream properties
> > > > + * @set_codec_params: Sets the compressed stream codec
> > > > parameters, Optional
> > > > + * This can be called in during gapless next track codec change
> > > > only to set
> > > > + * codec params
> > > 
> > > Would it be clearer if this was called set_next_codec_params()? or
> > > set_next_track_codec_params()?
> > > 
> > > Having set_params() and set_codec_params() is a bit confusing since
> > > the semantic difference is not captured in the callback name.
> > 
> > set_next_track_codec_params seems more sensible as its next track params.
> > Will change this in next version!
> 
> maybe set_params() and set_next_track_params() are enough, not sure if the
> codec reference helps?

params typically refers to whole set of compress parameters which
includes buffer information and codec parameters, so codec reference
would help.

-- 
~Vinod
