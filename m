Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F4C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CF9207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XSlT6svp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAPQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:42:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35465 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAPQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:42:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so19388779qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9QE+LiR9p5+Rf6la4xwWf8GBTBoS3t/ZtAxNnRV06w=;
        b=XSlT6svpQF6nyePrDNcw3mK3DVodnWYihXivlGOCaQJzN08v+8Q7IpWsA+jgk+chSN
         iOr+CJ0MglJ7e/UF/mitK3eCl6sxBxbaUkG0GZeFVPH9bOvKwF+3U67HVm6XWaS3kPvu
         zBwDrFq+4FZWKhOy14L6LboCalNQEpKUVK0+8F9JP7nIk+APLQ23X+6IrveLkf+qmA2U
         WMHRLLUoKEA5Jc3yT3HKWCbejWJ0cw1zzHH0KDiMIBZTNM6Ls8RU9w/546r7NUCOmOrL
         85RCE7D9OkL8TeXEUV3flv7M1c1sUSpyBScQ7BzMJHUjgRFE/mMoLgRh3LsEF9Wa7OaS
         vl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9QE+LiR9p5+Rf6la4xwWf8GBTBoS3t/ZtAxNnRV06w=;
        b=XsQ+i+E83BHbdk/PHMd7qh/lmH2VGlFuITthi0dNt4IAR8eYZUUpRts6PEBa3oBOMe
         c/ks8PXkTriwbmWVoKWUIKJ0KRqLnNyf5oItvuypqWBqVc/gUikOT606UrG3dDxT8NJ5
         Jo6hnbzZAQIakct0o42IUl1rp9dlAWw8vWIGktwB1rJm0ji6/A9z5nzeY2T6/cwACtwM
         jFeMZeABXNXU8IG5B9GOled1uudSdXmqLVPu7TeSogzdnb9t2j8SWhuRBXDUzbMwG9xA
         0rB3YQMDK1nSUxMEaQPS5UQYIhGftWszvrvhA0oKNjzC+O3mA0X/N5IG9J4PL2OYgTi4
         1E9w==
X-Gm-Message-State: APjAAAUbCjd/K7LV7t1zkhBGlx1GVG4E9FzrqRevgGsUPfLdoBp5NdFt
        Hv+niflrJDJFCupgiZtuitc/mA==
X-Google-Smtp-Source: APXvYqySzySo51TXep6EqsPITQBtocJvlfi1ukosJSOLAfK/96Fmm2WbUvhYipDHcE9PO9YzQvYqjQ==
X-Received: by 2002:ac8:7b24:: with SMTP id l4mr3244090qtu.3.1579192973797;
        Thu, 16 Jan 2020 08:42:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id f4sm10245757qka.89.2020.01.16.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:42:52 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:42:52 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/6] mm: kmem: cleanup (__)memcg_kmem_charge_memcg()
 arguments
Message-ID: <20200116164252.GA57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-2-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:54PM -0800, Roman Gushchin wrote:
> The first argument of memcg_kmem_charge_memcg() and
> __memcg_kmem_charge_memcg() is the page pointer and it's not used.
> Let's drop it.
> 
> Memcg pointer is passed as the last argument. Move it to
> the first place for consistency with other memcg functions,
> e.g. __memcg_kmem_uncharge_memcg() or try_charge().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
