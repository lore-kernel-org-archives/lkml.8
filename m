Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8086C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C096F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y8MoA+jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502020AbgDNMeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501995AbgDNMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:34:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:34:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d17so7203970wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0jr+GG3LyvDkB/zvwi8pImlCt3g6GJqvkh08zDnpzk=;
        b=Y8MoA+jt5jFWw7uXusRhRJQ8ORQ00uQOwPjwmK0LCFbnGb/MKF4Hzd/Qj/EYMROORR
         uqJopqMXSv/roMf7C+iiqZZvRfqv48qxA07Kg/3ftbyBgJNlGOf6ctCXoiquytT6liQ+
         2DyBWTGgZbV4qBp0S4Yn60sxJYWX7VgFqK/Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/0jr+GG3LyvDkB/zvwi8pImlCt3g6GJqvkh08zDnpzk=;
        b=LCSCir7QcGpA5H7itWk7P45EQYOKLx35Q8RXBUKA8sE4/e78yzgu0BGfQVXCS9gtA2
         u6JhyxBzfF/LmfAd+z8tpvf6eBK4uDCGjWpIKCO+gphWabC4uW2wZiomjgtB9U/KlCNz
         JaQQVn9WXS2/zQTngmKIljO4Ath4F1zc9uGt6xTZFIrtS+l0bHnqt5ImLeP+QltvWCZL
         uvo7BZyKXq0SvcL7U20PrQjLa/OI7ifAW15Xod+kch6MKqy0K7/GXoe7k2XHjL0wpJK9
         4Hri1fgZ1QRaaJR604CSlWGcigOD9HA4uymaM/+meX2oOASS4CO2crhWjGOABE7Kziqs
         /7sw==
X-Gm-Message-State: AGi0PuaxAKlZPDjznxUf3PaAAobRj3jpJz/UJ/bDg7HzRpkCR4hZoNGu
        S3JmBsLJ7xmpgg2JE29zC/tp+j7MkfM=
X-Google-Smtp-Source: APiQypLhB5mouYy4rFQGtlVpSX6rVjC9jg0eJ/6UH9dcaDMtkDp3vzfrksr11KLN6Er/jKfsmK4Y0A==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr10089331wrr.354.1586867647689;
        Tue, 14 Apr 2020 05:34:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q17sm10461927wmj.45.2020.04.14.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:34:06 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:34:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Simon Ser <contact@emersion.fr>, Yussuf Khalil <dev@pp3345.net>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB
 quantization range" property
Message-ID: <20200414123404.GT3456981@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Simon Ser <contact@emersion.fr>, Yussuf Khalil <dev@pp3345.net>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-6-dev@pp3345.net>
 <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
 <87ftd6mi3e.fsf@intel.com>
 <87d08amhy5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d08amhy5.fsf@intel.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 02:21:06PM +0300, Jani Nikula wrote:
> On Tue, 14 Apr 2020, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 13 Apr 2020, Simon Ser <contact@emersion.fr> wrote:
> >> On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <dev@pp3345.net> wrote:
> >>
> >>> DRM now has a globally available "RGB quantization range" connector
> >>> property. i915's "Broadcast RGB" that fulfils the same purpose is now
> >>> considered deprecated, so drop it in favor of the DRM property.
> >>
> >> For a UAPI point-of-view, I'm not sure this is fine. Some user-space
> >> might depend on this property, dropping it would break such user-space.
> >
> > Agreed.
> >
> >> Can we make this property deprecated but still keep it for backwards
> >> compatibility?
> >
> > Would be nice to make the i915 specific property an "alias" for the new
> > property, however I'm not sure how you'd make that happen. Otherwise
> > juggling between the two properties is going to be a nightmare.
> 
> Ah, the obvious easy choice is to use the property and enum names
> already being used by i915 and gma500, and you have no problem. Perhaps
> they're not the names you'd like, but then looking at the total lack of
> consistency across property naming makes them fit right in. ;)

Yeah if we don't have contradictory usage across drivers when modernizing
these properties, then let's just stick with the names already there. It's
not pretty, but works better since more userspace/internet howtos know how
to use this stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
