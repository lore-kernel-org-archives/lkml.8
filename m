Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8801C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857AF206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgC3Pzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:55:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45726 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3Pzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:55:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id t4so931668plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vqMlIY4CwYibDEJ9TyvLZiDUXi7z7rzq9FLu/dGvS5E=;
        b=Z/l0T/u0HruuqTC4eFDr51UoCtv5sM1gcCeGoggtNz32O7azA0z9i7uGYg2JeJ8ey/
         6gAEAyj9+PZTI1dDZvM90V36gp323abEuX3HPpdwaDxBfnNBaA8dw6w01wrPIDVWXOgQ
         6oFufB3LaAmAlLPUxkGpWMecfztFI3JJR+QaRcfA/cnbe6wG+p+tj2t7PKWKe7UFrlDn
         nL3/rdOwCUFyoBl/uvNSFo3TFnmesukaMMCE209xjgYet1xi6MjrmMaS3RXJ2z7sI0tR
         F8f84pVgHdgbX3Lm8w1aZqTiI7ENK6tSaBvMkdIZm8517TgkNP4PjdB/KfB8HPecndIo
         S2Yw==
X-Gm-Message-State: AGi0PuZeay1Myrd4fizvcJ1IUKBY+/sqAXWfsKIofFw75Fxyp+0cXtE4
        l8ZEyoWbkQTIVJQ6ueItVvc=
X-Google-Smtp-Source: APiQypLG+zHRr1QDgHfHrS55bEBmIevqM557WQZBCWw+oAV2e7y/pED0DMpyu4z5HHcS+RaXFbQ0lQ==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr3779pjp.124.1585583750671;
        Mon, 30 Mar 2020 08:55:50 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id o3sm1012282pgk.21.2020.03.30.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:55:49 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:55:46 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] A couple of important fixes for i915 on 5.4
Message-ID: <20200330155546.GB2022@sultan-box.localdomain>
References: <20200330033057.2629052-1-sultan@kerneltoast.com>
 <20200330085128.GC239298@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330085128.GC239298@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:51:28AM +0200, Greg KH wrote:
> On Sun, Mar 29, 2020 at 08:30:55PM -0700, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > 
> > Hi,
> > 
> > This patchset contains fixes for two pesky i915 bugs that exist in 5.4.
> 
> Any reason you didn't also cc: the developers involved in these patches,
> and maintainers?
> 
> Please resend and do that.
> 
> thanks,
> 
> greg k-h

CC'd. Sorry about that.

Sultan
