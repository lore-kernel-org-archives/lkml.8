Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC27C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FDF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="kADJdAdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbgDNVLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:11:32 -0400
Received: from saul.pp3345.net ([163.172.111.124]:38578 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733025AbgDNVLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:11:23 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id 3BA379A460D;
        Tue, 14 Apr 2020 23:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586898672; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=dlSDoutPT33xOVXUFaJb/6vXllGM0ISsKTqsxM9cpT0=;
        b=kADJdAdBnCzNpbP1Tk5AcFKwIID3OpRRqCYqSr5KRV02Z/J8YwOdGwiqiUg2Z9hTaqTori
        bibno0ZXercCDBJWOihH4wZ9VaTkyJFpWpldGzonYitnC0w1+MlGmrz2Dfbhkv3NGo4jmY
        GGMMOVeYGfd0KgV/xBAxuU/QsA23D2cUS3c924BCNOTsiVl4PHU4nHcJ6u9c/0445RatH2
        fIprRdmhfk6+M+TjKjKkh0xBX8HRf4OR5lUhXPLTZUn6GtokvU93sdAKSTXJPiprBS1w0R
        LmgF0hnW5Ulf69YYSOlbK0qN+UTsp2ekLl0T9nisyhNBao7ULVqvCN4IX1hjIg==
Message-ID: <2cfe44c96818515939050ad19e9c248e50519be2.camel@pp3345.net>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB
 quantization range" property
From:   Yussuf Khalil <dev@pp3345.net>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Simon Ser <contact@emersion.fr>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue, 14 Apr 2020 23:11:07 +0200
In-Reply-To: <20200414123404.GT3456981@phenom.ffwll.local>
References: <20200413214024.46500-1-dev@pp3345.net>
         <20200413214024.46500-6-dev@pp3345.net>
         <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
         <87ftd6mi3e.fsf@intel.com> <87d08amhy5.fsf@intel.com>
         <20200414123404.GT3456981@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 14:34 +0200, Daniel Vetter wrote:
> On Tue, Apr 14, 2020 at 02:21:06PM +0300, Jani Nikula wrote:
> > On Tue, 14 Apr 2020, Jani Nikula <jani.nikula@linux.intel.com>
> > wrote:
> > > On Mon, 13 Apr 2020, Simon Ser <contact@emersion.fr> wrote:
> > > > On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <
> > > > dev@pp3345.net> wrote:
> > > > 
> > > > > DRM now has a globally available "RGB quantization range"
> > > > > connector
> > > > > property. i915's "Broadcast RGB" that fulfils the same
> > > > > purpose is now
> > > > > considered deprecated, so drop it in favor of the DRM
> > > > > property.
> > > > 
> > > > For a UAPI point-of-view, I'm not sure this is fine. Some user-
> > > > space
> > > > might depend on this property, dropping it would break such
> > > > user-space.
> > > 
> > > Agreed.
> > > 
> > > > Can we make this property deprecated but still keep it for
> > > > backwards
> > > > compatibility?
> > > 
> > > Would be nice to make the i915 specific property an "alias" for
> > > the new
> > > property, however I'm not sure how you'd make that happen.
> > > Otherwise
> > > juggling between the two properties is going to be a nightmare.
> > 
> > Ah, the obvious easy choice is to use the property and enum names
> > already being used by i915 and gma500, and you have no problem.
> > Perhaps
> > they're not the names you'd like, but then looking at the total
> > lack of
> > consistency across property naming makes them fit right in. ;)
> 
> Yeah if we don't have contradictory usage across drivers when
> modernizing
> these properties, then let's just stick with the names already there.
> It's
> not pretty, but works better since more userspace/internet howtos
> know how
> to use this stuff.
> -Daniel

Note that i915's "Broadcast RGB" isn't the same as gma500's: i915 has an
"Automatic" option, whereas gma500 does not. Also, radeon has a property called
"output_csc" that fulfills a similar purpose. Looking at the code, though, it
seems that radeon does not adhere to the standard correctly (or I am missing
something).

An alternative would be to leave the existing driver-specific properties and
change them to be pseudo-aliases for the "RGB quantization range" property.
This can be done by letting the drivers read from and write to the new property
when user-space tries to read or modify the driver's property. This way we could
retain full backwards compatibility for all drivers equally.

What do you think?

Regards
Yussuf

