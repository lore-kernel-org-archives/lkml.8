Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CCC2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F852074B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgDDCmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:42:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40740 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDDCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:42:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so3879057pjb.5;
        Fri, 03 Apr 2020 19:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpCey6nXR24VHkMuvgvYPJ86L/KDUB6wcFgnfdZsomA=;
        b=ExIvO6VBdl976rPrdEe8k6NaEiGkek2YvlXKT5d5cDq71H2BwsPma7vaeNcOWtQ2xy
         KnD+Zb2IFzvUXykimNHOXWierFMonErafboTC3MDEnh3+MVHB3fgv8xsSOURH0gu8u4Q
         ctxDXii6iuzmDhwsSWtd2vGGWjiUSW0TrOlCLLIyAULXMc0t7ys+Koy1qlpNLekNJd7x
         vdCMLnPN7A5qTooQ6T67F7dUBVQVniranB2i8RBRNcFfE0G1qbcSIOAlI6tHMYdbUB9N
         1QD3AADsXQuT4IefdG61VbZCuKibc8/HzqPW6QUQPbeZ+zjM9xHO9/MjEyCJCXi+svtX
         4Xrw==
X-Gm-Message-State: AGi0PuZDk4k5aGLf8fi42HG6DTGXTGqDM4XZWHcIAcXzZPZni2dHp4PG
        sly2Jw0RChIlYXtrYT6a9aERyGhB
X-Google-Smtp-Source: APiQypLsKMCV76FWg8xK/CcpK6SZP3U8Fx2DGLw069VafyMfbQeFHdk++S3zg9eV0uup+7O5Q41n3Q==
X-Received: by 2002:a17:90a:23ed:: with SMTP id g100mr12860973pje.93.1585968120823;
        Fri, 03 Apr 2020 19:42:00 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id iq14sm6716639pjb.43.2020.04.03.19.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 19:41:59 -0700 (PDT)
Date:   Fri, 3 Apr 2020 19:41:56 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/i915: Synchronize active and retire callbacks
Message-ID: <20200404024156.GA10382@sultan-box.localdomain>
References: <20200403042948.2533-1-sultan@kerneltoast.com>
 <20200403223528.2570-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403223528.2570-1-sultan@kerneltoast.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 03:35:15PM -0700, Sultan Alsawaf wrote:
> +			ref->retire(ref);
> +			mutex_unlock(&ref->callback_lock);

Ugh, this patch is still wrong because the mutex unlock after ref->retire() is a
use-after-free. Fun times...

Sultan
