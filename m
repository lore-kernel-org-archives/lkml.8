Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF79207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599718958;
	bh=4IPFakKxzCsxB21yUqCQDDxngDYpAepaZS+PAyfbns4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D+P8bkAjMRgQazXxVaBn36DZx9foXVtFEsddols3aNLbFfEIXCXhK1W2yha857OxP
	 u9eW1yo/BunktG9Dd2NHjQ2gkVAV/EH3bhe88+7qFw+26YpJY/xfRfRXLwdWNLAtBV
	 xEnIyTP54X0d2mBrc3RT2nk6itOZcylbUAjUHL1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgIJGW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:22:29 -0400
Received: from localhost (unknown [122.179.50.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD041207DE;
        Thu, 10 Sep 2020 06:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599718948;
        bh=4IPFakKxzCsxB21yUqCQDDxngDYpAepaZS+PAyfbns4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkPFlWhbcUUDju8orcFfc7uiu2NTNaneNNJk9inedNMHK+CDwlUq3lfrRKix2KCyB
         bwbWqD5oaZ51QvBOjO9CJMz2RXQsytp2DJN6ur266+wcEvZHBs9ASTLDsZWUzWQykM
         aIsAANuZF5golAhB7qrlTDwnhu48fF6oSj0xJT8U=
Date:   Thu, 10 Sep 2020 11:52:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
Message-ID: <20200910062223.GQ77521@vkoul-mobl>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
 <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
 <20200909075555.GK77521@vkoul-mobl>
 <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184867c2-9f0c-bffe-2eb7-e9c5735614b0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 08:48, Pierre-Louis Bossart wrote:
> 
> > > > > + *	25		0 (Reserved)
> > > > > + *	24:22		Function Number [2:0]
> > > > > + *	21		Entity[6]
> > > > > + *	20:19		Control Selector[5:4]
> > > > > + *	18		0 (Reserved)
> > > > > + *	17:15		Control Number[5:3]
> > > > > + *	14		Next
> > > > > + *	13		MBQ
> > > > > + *	12:7		Entity[5:0]
> > > > > + *	6:3		Control Selector[3:0]
> > > > > + *	2:0		Control Number[2:0]
> > > > > + */
> > > > > +
> > > > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)						\
> > > > > +	(BIT(30)							|	\
> > > > 
> > > > Programmatically this is fine, but then since we are defining for the
> > > > description above, IMO it would actually make sense for this to be defined
> > > > as FIELD_PREP:
> > > > 
> > > >           FIELD_PREP(GENMASK(30, 26), 1)
> > > > 
> > > > or better
> > > > 
> > > >           u32_encode_bits(GENMASK(30, 26), 1)
> > > > 
> > > > > +	FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))	|	\
> > > > 
> > > > Why not use u32_encode_bits(GENMASK(24, 22), (fun)) instead for this and
> > > > below?
> > > 
> > > Because your comment for the v1 review was to use FIELD_PREP/FIELD_GET, and
> > > your other patches for bitfield access only use FIELD_PREP/FIELD_GET.
> > 
> > yes and looking at this, I feel u32_encode_bits(GENMASK(24, 22), (fun))
> > would look better than FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))
> > 
> > Do you agree?
> 
> The Function (fun) case is the easy one: the value is not split in two.
> 
> But look at the entity case, it's split in two:
> 
> FIELD_PREP(BIT(21), FIELD_GET(BIT(6), (ent)))			FIELD_PREP(GENMASK(12, 7),
> FIELD_GET(GENMASK(5, 0), (ent)))
> 
> same for control
> 
> FIELD_PREP(GENMASK(20, 19), FIELD_GET(GENMASK(5, 4), (ctl)))	|	
> FIELD_PREP(GENMASK(6, 3), FIELD_GET(GENMASK(3, 0), (ctl)))	|	
> 
> and same for channel number
> 
> FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), (ch)))	|	
> FIELD_PREP(GENMASK(2, 0), FIELD_GET(GENMASK(2, 0), (ch))))
> 
> I don't see how we can avoid using the FIELD_GET to extract the relevant
> bits from entity, control, channel number values.

No, you dont need FIELD_GET, that would be pointless for this helper if
that was the case

> 
> Or I am missing your point completely.

Correct

It should be:

        foo |= u32_encode_bits(val, FOO_MASK_A);

which would write val into bits represented by FOO_MASK_A by
appropriately shifting val and masking it with FOO_MASK_A

So net result is bits in FOO_MASK_A are modified with val, rest of the
bits are not touched

> 
> 
> > > > And while at it, consider defining masks for various fields rather than
> > > > using numbers in GENMASK() above, that would look better, be more
> > > > readable and people can reuse it.
> > > 
> > > Actually on this one I disagree. These fields are not intended to be used by
> > > anyone, the goal is precisely to hide them behind regmap, and the use of raw
> > > numbers makes it easier to cross-check the documentation and the code.
> > > Adding a separate set of definitions would not increase readability.
> > 
> > Which one would you prefer:
> > 
> >          #define SDCA_FUN_MASK           GENMASK(24, 22)
> > 
> >          foo |= u32_encode_bits(SDCA_FUN_MASK, fun)
> > 
> > Or the one proposed...?
> 
> Same as above, let's see what this does with the control case where we'd
> need to have four definitions:
> 
> #define SDCA_CONTROL_DEST_MASK1 GENMASK(20, 19)
> #define SDCA_CONTROL_ORIG_MASK1 GENMASK(5, 4)
> #define SDCA_CONTROL_DEST_MASK2 GENMASK(6, 3)
> #define SDCA_CONTROL_ORIG_MASK2 GENMASK(3, 0)
> 
> And the code would look like
> 
> foo |= u32_encode_bits(SDCA_CONTROL_DEST_MASK1,
> FIELD_GET(SDCA_CONTROL_ORIG_MASK1, fun));
> foo |= u32_encode_bits(SDCA_CONTROL_DEST_MASK2,
> FIELD_GET(SDCA_CONTROL_ORIG_MASK2, fun));
> 
> The original suggestion was:
> 
> FIELD_PREP(GENMASK(20, 19), FIELD_GET(GENMASK(5, 4), (ctl)))	|	
> FIELD_PREP(GENMASK(6, 3), FIELD_GET(GENMASK(3, 0), (ctl)))	|	
> 
> I prefer the original... Adding these defines doesn't really add value
> because
> a) the values will not be reused anywhere else.
> b) we need 12 of those defines
> b) we need a prefix for those defines which makes the code heavier

-- 
~Vinod
