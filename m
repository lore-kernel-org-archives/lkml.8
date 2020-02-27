Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F9C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA334246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582840369;
	bh=lmuF2usYvPwgBiy7m/ddx0T0+Q46dPbQkAUTaKMr60c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqvtJwwXFsvlbL6Fe12zJfOYDlCebUXYfm8+P8lUs5PTEezD7rwDZY27UCRaINoaP
	 Qu9eviw7wizFlrVfXo+waALLb1f7dVSWwdt65GkxMDQTlZj0LMkPB1m+b9f4JCitUV
	 nvT4zV4cEXlz0AC/slbp+Vi7e7w0BvIMCrXF5kXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgB0Vwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:52:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45829 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgB0Vwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:52:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so517334pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a8tz7pn6WYS1zSkKOSE65k1PsuDxpcFOThMRyfGsXzE=;
        b=Nu/xJQJcfGP5wjtq6rtG/YhcMWcwj5otv44cx4FAAyishIVQiJQUHZjthXqMGPt5mx
         q3ZItdbyNqwOLeJLnUgK7Ij7Xz6qHMF8gxezXja59kyh659wtD/c5NTCYvpI+N/feY7n
         zJynnhsSZEQvADPTbT7WzlnuziaDLdClsJDtRzZKzVGSZ6ioBrHzl0Ow/2N5dnIxDwyY
         9YvVLFUhSv6Qld1wjqqIcFdYhanLQItBzbmIXkZWjk92iQPuWJbeSrBKk9Hu7M3RwsDg
         R5oJGClkDbCW5J5gP35HFIkaV7DyO9w8adVx4dA7AvU1PlUG49dEnAi8TDjSV0rKmRxD
         uqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8tz7pn6WYS1zSkKOSE65k1PsuDxpcFOThMRyfGsXzE=;
        b=BuVV9mXJBbmkOs2BvAMVEAB7ISiBPjfgCa1Fp0ItkkrR+HxU46D//UD0tcw/qyoibo
         42xcH3vvglxlOV30E/xtEUWQw67bxBkFRWPkBphGyr4eRZo6cA/SijI1Bc44UHF/4b5i
         OzdIM3m4VKiYaqsngVtWCba1O66r8ALcYwOt8UE+szJ7rx/FkD/4WjUHA9uesKMMjXbm
         1Bt30C++Cqi9SO4/XqQqu6hlsJ4vrjAjTUz0gRcco3tmOAQl2UT4zmcdmL9DOHsxhIUH
         9GcMJp/UtUTfDCKYRb3pUx44mh0QpqtyTEtJSDxlTo6aOkXhcNAot/Muij/n4rk6BgPO
         5+zQ==
X-Gm-Message-State: APjAAAWjxGfiMOiXfMatjikwcXTvmGkrspaWkCCsjo8aY5WDmay4AULV
        1wJbD5MH5KSyb5QoZvEN1+w=
X-Google-Smtp-Source: APXvYqwMWOfBtYQa9aLe/LcC/6wxpuCKtnPAnSxFoNQzxZ7DvSIHHrLoB+J3JktcFJ99CvsUTlYRhQ==
X-Received: by 2002:a63:36cd:: with SMTP id d196mr1396472pga.280.1582840361366;
        Thu, 27 Feb 2020 13:52:41 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id w25sm8060951pfi.106.2020.02.27.13.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:52:37 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:52:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 10/30] mm/zsmalloc: Add missing annotation for
 migrate_read_lock()
Message-ID: <20200227215235.GB215068@google.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-11-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214204741.94112-11-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:47:21PM +0000, Jules Irenge wrote:
> Sparse reports a warning at migrate_read_lock()()
> 
>  warning: context imbalance in migrate_read_lock() - wrong count at exit
> 
> The root cause is the missing annotation at migrate_read_lock()
> Add the missing __acquires(&zspage->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
