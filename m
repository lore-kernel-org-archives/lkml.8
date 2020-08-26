Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E458206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598460032;
	bh=Nhxs6GLEXkmk91ceSYxBRjhcy81ZD8QVkvWailiH5V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lm7Q84hxYvyTc5wzetfaHIFczwayHrffaMhwUOMDoHzcxfko8cGTIsY6C9+rSJFF9
	 Y0vs9IfbHfvFGMWjbHRPjWGkI5siSNAlOGaPSty8n7Q4DcrzzZkTH1aODNrCcCGMqN
	 Mi6EGAzziDFtBlnOFFWr3Igyn/t/RNk1eRdZSQIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHZQka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHZQkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:40:22 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5322071E;
        Wed, 26 Aug 2020 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598460022;
        bh=Nhxs6GLEXkmk91ceSYxBRjhcy81ZD8QVkvWailiH5V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/CE7/9xoULdHqEYGdYFuGogIbhVNQgRoRg1NbIRk3g1xglWTV8iEm8f0Y0khaTKo
         qoKGl301FSUks2EGYBJmhla9zwh0FLvlOECCAo+KTbjAqUcOk0udgLToVHois88arU
         mK3AbOh4P7yZmzG+RHaQw1vbQjHqPCqSbL4ud3Es=
Date:   Wed, 26 Aug 2020 22:10:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 3/4] soundwire: SDCA: add helper macro to access controls
Message-ID: <20200826164018.GF2639@vkoul-mobl>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-4-pierre-louis.bossart@linux.intel.com>
 <20200826085540.GY2639@vkoul-mobl>
 <9c078341-7e90-a4e8-da30-19e9720d93e4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c078341-7e90-a4e8-da30-19e9720d93e4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 10:00, Pierre-Louis Bossart wrote:
> 
> 
> > > +/* v1.2 device - SDCA address mapping */
> > 
> > Can you please add description of bits used by each field here,
> > something like we have done for DevId
> 
> were you referring to something like this?
> 
>  * Spec definition
>  *   Register		Bit	Contents
>  *   DevId_0 [7:4]	47:44	sdw_version
>  *   DevId_0 [3:0]	43:40	unique_id
>  *   DevId_1		39:32	mfg_id [15:8]
>  *   DevId_2		31:24	mfg_id [7:0]
>  *   DevId_3		23:16	part_id [15:8]
>  *   DevId_4		15:08	part_id [7:0]
>  *   DevId_5		07:00	class_id

Correct

> > 
> > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
> > > +						 (((fun) & 0x7) << 22) |	\
> > > +						 (((ent) & 0x40) << 15) |	\
> > > +						 (((ent) & 0x3f) << 7) |	\
> > > +						 (((ctl) & 0x30) << 15) |	\
> > > +						 (((ctl) & 0x0f) << 3) |	\
> > > +						 (((ch) & 0x38) << 12) |	\
> > > +						 ((ch) & 0x07))
> > 
> > GENMASK() for the bitmaps here please. Also it would look very neat by
> > using FIELD_PREP() here, you can skip the bit shifts and they would be
> > done by FIELD_PREP() for you.
> 
> ok.

FWIW I am testing changes to do the conversion for subsystem to use nice
stuff in bitfield.h


-- 
~Vinod
