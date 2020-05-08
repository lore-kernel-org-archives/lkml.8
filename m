Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876AAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B98206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfKE7YzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHLdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:33:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHLdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588937621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUaD54dhP6CyORHGARRRLxb30JmQ8bFTb+bifqt8BeQ=;
        b=EfKE7YzBCND7cfz/NbWWvw8oxSMqms6d43jVkJTqU+TEvQitsCHBfCVPMWVW8m1Hr+dSM3
        XofeIeotw2q4TTsg0AQ/X5toSu1oEl/78g+dtqunq3l3Sq5GihnSyXI6+XLChEAss83QEO
        53EdggiOe381eV5MinPnK6ddSCmqa5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-AK-dIrTcMw2yIIF1LWHTgg-1; Fri, 08 May 2020 07:33:39 -0400
X-MC-Unique: AK-dIrTcMw2yIIF1LWHTgg-1
Received: by mail-wm1-f72.google.com with SMTP id o11so2794174wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUaD54dhP6CyORHGARRRLxb30JmQ8bFTb+bifqt8BeQ=;
        b=fMTG0pK26DJcAoUoIjHLGA13Hdq+9wEu8opQahISnObFk0RWuqpV0+L7zTd/pd2NUZ
         PSzCp88Kg1zPRjSy9UlHH/mLEN4sv5zvr4k7cnb38ywn1Am7HqYUyN6P2XkJZWHG+l8e
         SZk+W7c2cZ4AjO7oiAq8Hwe1EmerBTKKTme03S/ssmfOzkRJuCs+45hVNeIJiUdgKKD0
         wYUDels8vA+wllh8GIQ6qo/zoP2si6Tu3AS8oOOHh+w87NMpo45U26hzv/VItkmWJlLZ
         aOsJtevV9TAFC7zKmeFVtwb6UE6+v43Ys7nNGExRlmiPkK9pd1WaV6ww3fDfjL1+wrN1
         pKqA==
X-Gm-Message-State: AGi0PuYDSlofH86IEiOJfqJMNaN/BuldTe1Vssvs4ZiSY7l0Yp7QyLwW
        evsPYj70P7Z7THFwo+I2hnx4gAm/D4aNeP5WzU0csitMUNfzo1f1cs4/3ilpzYmRtRRns6cSrRT
        N+T6B8z6+Ko2LrF388gOkqu5o
X-Received: by 2002:adf:e38b:: with SMTP id e11mr2468109wrm.343.1588937618193;
        Fri, 08 May 2020 04:33:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLhHfuD+UO7MNp5uy7H5OQHsM6tcVMk7aOaRwpc+SNq3kBZBfJlJcoYssuDF78Ba63ydoy3TQ==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr2468092wrm.343.1588937618007;
        Fri, 08 May 2020 04:33:38 -0700 (PDT)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id w83sm13378751wmb.37.2020.05.08.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:33:37 -0700 (PDT)
Date:   Fri, 8 May 2020 13:33:36 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
Message-ID: <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
 <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:21:47AM -0600, Jason A. Donenfeld wrote:
> > Should we untangle -O3 from depending on ARC first maybe?
> 
> Oh, hah, good point. Yes, I'll do that for a v2, but will wait another
> day for feedback first.

Just keep in mind that my previous attempt [1] failed because of too
many false positive warnings despite -O3 really uncovered a couple of
bugs in the codebase.

Lets hope your attempt will be more successfull. I'll happily offer my
review tag ;).

Also Cc'ing Andrew who (IIRC) tried to took my sumbission and Arnd who
tried to clean up the mess afterwards.

[1] https://lore.kernel.org/lkml/20191211104619.114557-1-oleksandr@redhat.com/

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

