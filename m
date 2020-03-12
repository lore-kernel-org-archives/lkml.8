Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70BC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E6B2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584005140;
	bh=+5Gp7w5vcJsY8vWZ7gDNnArFa78EQVe2jx3jSlUGg4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPxbvfNLgd9Ll5mgGrD9XwAMFqwCvyCD0tDoGGBoo0Jlu+v2jWiUhcHXnIWWHcy4h
	 iRz8A3oBHgnebxoY6onxdbWYuhA4BkRvJWu7PIAedDTv8gPQV1kXkp6BBxPwur+AIB
	 h0R3NkIbczZPUD9DIV6UJ12HvS8/PU4BJXlFurPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCLJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:25:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56176 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgCLJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:25:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so5227544wmi.5;
        Thu, 12 Mar 2020 02:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMMKbXhN9eUImpsZTVHPnKioeTIq6eieLdWAKaUpf5Q=;
        b=rYRyJo4r9Y64yafECUSIfNxEsCCUxWPxAZt4CF94+z2UE5cQy1zxrLKrkq+tmabAjY
         RQ2ggT5C0E10fN55vZ5uh9yPABCvh3wfPyZCcG0bDnVUTxE3zEvs7RuZpN4p4PTotxTc
         XXZnhaF/FuP8EUa39UUHU3uoCMsQlj7bwYAFTfP3c+GbaP46rLnDi0TJj9bfp7LZcFG+
         a2Hlk4d4851vGTpX/rSSg5dOb3MeDNTmzXkbN5gBIcLnAxgKpxQQBhZ8Mb5UIT3u8UNk
         dlvizuZ4CkJOhErnpm/awe+PfLm33IM447DC2jb8JL7QcO35tiN9SV2MiZDvZjvVE+hV
         jPMg==
X-Gm-Message-State: ANhLgQ3i4MwPxhogA1hhERqYOvB4144wGQADK2l+pah0wjp8uGsZ14EU
        aeDBTNusk6R3z5VkFUMQRC+di3NC
X-Google-Smtp-Source: ADFU+vuonuF0fj4AX6GKv6FiF9ZC8rUyNxOFkSydg0YUX+Sx7UVQ+93RWd3J+LrP6b3rbzvpv1EAjw==
X-Received: by 2002:a1c:56d5:: with SMTP id k204mr4046198wmb.13.1584005133477;
        Thu, 12 Mar 2020 02:25:33 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id v10sm3832526wml.44.2020.03.12.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 02:25:32 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:25:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Message-ID: <20200312092531.GU23944@dhcp22.suse.cz>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 17:45:58, Ivan Teterevkov wrote:
> This patch adds a couple of knobs:
> 
> - The configuration option (CONFIG_VM_SWAPPINESS).
> - The command line parameter (vm_swappiness).
> 
> The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS.
> 
> Historically, the default swappiness is set to the well-known value 60,
> and this works well for the majority of cases. The vm_swappiness is also
> exposed as the kernel parameter that can be changed at runtime too, e.g.
> with sysctl.
> 
> This approach might not suit well some configurations, e.g. systemd-based
> distros, where systemd is put in charge of the cgroup controllers,
> including the memory one. In such cases, the default swappiness 60
> is copied across the cgroup subtrees early at startup, when systemd
> is arranging the slices for its services, before the sysctl.conf
> or tmpfiles.d/*.conf changes are applied.
> 
> One could run a script to traverse the cgroup trees later and set the
> desired memory.swappiness individually in each occurrence when the runtime
> is set up, but this would require some amount of work to implement
> properly. Instead, why not set the default swappiness as early as possible?

I have to say I am not a great fan of more tunning for swappiness as
this is quite a poor tunning for many years already. It essentially does
nothing in many cases because the reclaim process ignores to value in
many cases (have a look a get_scan_count. I have seen quite some
reports that setting a specific value for vmswappiness didn't make any
change. The knob itself has a terrible semantic to begin with because
there is no way to express I really prefer to swap rather than page
cache reclaim.

This all makes me think that swappiness is a historical mistake that we
should rather make obsolete than promote even further.
-- 
Michal Hocko
SUSE Labs
