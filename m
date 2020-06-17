Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CAEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55BC2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592431503;
	bh=QORfCT/Xyhe7gLua5bW25Wkpcctw8H30A6GURI1tECg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=enVA4d+lqp302IqkFJIhKETi/puhvdBavxUUiqVRdhHKK8qwV+Csxw8NPt9EFmhb6
	 jAFSBSTnmY0SyUomY28hGASaNBeTr4Yb+o8dScNOBhAK8BulyYmOVwUNRjbsCgURxr
	 wo3mIB2FXI9pNmbv+GEyPs2+5uDBQPrLQeDrJ1uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgFQWFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:05:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39270 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgFQWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:05:02 -0400
Received: by mail-il1-f194.google.com with SMTP id p5so3870655ile.6;
        Wed, 17 Jun 2020 15:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+CsQR2qsSoI73GnHFqoZfpGxUfo0rIGsGeEXk1ewMAk=;
        b=rzWXEup+hshMAqedUwBV7c7tAWOBi5zi7bJTaz/kgV0o7RxfS02KjQVLSf7/nFMw9H
         SiEo8fNafK6g6KHmFLPXtpR8Azuv8WmAXUK3AfxIYFg0VESewmLcVRLsT2KqSbr2kJzp
         HDLFxcw6wgxGB/zVDHAf8ew7xMzTh5v0VoQKDAF8x2UuVR7qn13a2WfvAA0jBw07Zf9b
         K8t+zzP1VapZ138DbIrr10itneHvKC546oA0XXEJVDPm+iyPpTjKS5+6vHcj0lC0pR+H
         gZniJ5CQaIcXj/GMW7ccIyVN286ULcT5qax2VEKKR38gKbr02LSmwi8wNDKnSpcVVXpk
         Cxig==
X-Gm-Message-State: AOAM531b6g+HuGy3QpAKij/s8lf0shclptGblRuH1xkNidGtJB1o1kVy
        sNmAdCEdCCvwGF/weLd0rg==
X-Google-Smtp-Source: ABdhPJxbchfeSCY4yu6rb64R7RrR97GYimVKByBST0ppb7bKIzKmF0oKQBqmLJvNwoHC3I6aOCZiWg==
X-Received: by 2002:a92:899b:: with SMTP id w27mr1147898ilk.16.1592431501074;
        Wed, 17 Jun 2020 15:05:01 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n1sm470890ilm.55.2020.06.17.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:05:00 -0700 (PDT)
Received: (nullmailer pid 2912668 invoked by uid 1000);
        Wed, 17 Jun 2020 22:04:59 -0000
Date:   Wed, 17 Jun 2020 16:04:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200617220459.GA2884884@bogus>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
 <20200610102920.GC5005@sirena.org.uk>
 <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:12:15AM -0500, Dan Murphy wrote:
> Mark
> 
> On 6/10/20 5:29 AM, Mark Brown wrote:
> > On Tue, Jun 09, 2020 at 02:20:29PM -0500, Dan Murphy wrote:
> > > On 6/9/20 1:47 PM, Mark Brown wrote:
> > > > That's really not very idiomatic for how Linux does stuff and seems to
> > > > pretty much guarantee issues with hotplugging controls and ordering -
> > > > you'd need special userspace to start up even if it was just a really
> > > > simple DSP config doing only speaker correction or something.  I'm not
> > > > sure what the advantage would be - what problem is this solving over
> > > > static names?
> > > IMO having a static name is the problem. It is an inflexible design.
> > > Besides the firmware-name property seems to be used in other drivers to
> > > declare firmwares for the boards.
> > > But if no one is complaining or submitting patches within the codecs to be
> > > more flexible with firmware then I can just hard code the name like other
> > > drivers do.
> > I'm not *completely* opposed to having the ability to suggest a name in
> > firmware, the big problem is making use of the DSP completely dependent
> > on having a DT property or doing some non-standard dance in userspace.
> 
> Well from what I see we have 4 options.
> 
> 1.  We can have a DT node like RFC'd (Need Rob's comments here)

We've obviously already allowed 'firmware-name', but the preference is 
still not putting into DT. It's really a Linux userspace interface.

> 2.  We can have a defconfig flag that hard codes the name (This will
> probably be met with some resistance if not some really bad reactions and I
> don't prefer to do it this way)
> 
> 3.  We can hard code the name of the firmware in the c file.
> 
> 4.  Dynamically derive a file name based on the I2C bus-address-device so it
> would be expected to be "2_4c_tas2563.bin".  Just need to figure out how to
> get the bus number.

Given bus numbering may not be constant, that seems like not the best 
way to match up devices. I'd assume that userspace needs some way to 
identify which instance is which already, so maybe there's other data 
you can use already.

> I don't see the user space as a viable option because the codec will have to
> load and then the user space would have to request to load the firmware and
> then more mixer controls will appear.
> 
> Again only option 1 allows us to have different firmware binaries per IC
> instance and also denotes the use of the DSP.  The DSP is not programmed
> until the user space selects the program or configuration from the binary. 
> So special audio handling is very explicit in the user space.  More then
> likely most standard distributions will not even use the DSP for this device
> it is more of a specialized use case for each product.
> 
> 
> 
