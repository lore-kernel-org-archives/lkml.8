Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4BC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85B2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584019613;
	bh=6lb7enukKBTao9FoGQva6o4SkqbcC+IWZjrKG0LdVfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0x4osnz0wDYv72BgRrczNI9/2F8rBJ4YuAwb1QvCzqEWsoAaUd0YifZLgezhnZwul
	 fJphUMwGpMgxV3WvIvZe3xZzhXOYnGyrmZ4NryxLoFxbAfOBIcCHiG5Jjbm2oO01hu
	 9/d+E9z2TdvQeQaY9y2lhQOG4W+pPzqNKGWOM35M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCLN0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:26:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:26:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so7485328wrd.0;
        Thu, 12 Mar 2020 06:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4BJbL1v35eEIhi8zAOoH4R9OkyA1Pa/qt0AezIWPz+Y=;
        b=bdh5KUbHizwaomUcweOIOrIOA4O3vKD/UclEHlOQhloPhK3YwpoGg3yLKKzoqHpnrL
         dXcGOi/7kz0+Z/6rgG0LApfgGtwDj1xvUUB6wCDedtveLhJ4coswJWoonQcwxhPUwWHF
         XuPtG2eNYB3G9jYCccbAxDNAiiZkbR5+KCLdqKroShMZc1zBtO7g7n4xUMHietRUkHe7
         YewlYh3ASjxzmHiKoPBWK32d1v0r+I7/OhTWNXRoQ3tmB8kS5IoU22tVZKzHwbsGLTS/
         KQyS125AjEj6hACYUNh6H/q0888Z9MbufTZDZVie/p/PjUt7pvSvrgylk4VuhLQ8T07c
         xgDw==
X-Gm-Message-State: ANhLgQ1AITxYk8G/ZN3rS/YeeamCfNt77hTVM0jnJhsA3o706EEMIgG9
        hW0K/Ls43C7Xsi7PybrP3U8=
X-Google-Smtp-Source: ADFU+vtxeZw7NuCizsLMi/GIiZ/4aK7twtop/K8Ui/bChFfTyUDUr1T43Y8s8B6AZTPRaQRkHyaXGg==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr11905427wrw.157.1584019610763;
        Thu, 12 Mar 2020 06:26:50 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id w8sm12933799wmm.0.2020.03.12.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:26:49 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:26:42 +0100
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
Message-ID: <20200312132642.GW23944@dhcp22.suse.cz>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
 <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 12:54:19, Ivan Teterevkov wrote:
> On Thurs, 12 Mar 2020, Michal Hocko wrote:
> 
> > On Wed 11-03-20 17:45:58, Ivan Teterevkov wrote:
> > > This patch adds a couple of knobs:
> > >
> > > - The configuration option (CONFIG_VM_SWAPPINESS).
> > > - The command line parameter (vm_swappiness).
> > >
> > > The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS.
> > >
> > > Historically, the default swappiness is set to the well-known value
> > > 60, and this works well for the majority of cases. The vm_swappiness
> > > is also exposed as the kernel parameter that can be changed at runtime too,
> > e.g.
> > > with sysctl.
> > >
> > > This approach might not suit well some configurations, e.g.
> > > systemd-based distros, where systemd is put in charge of the cgroup
> > > controllers, including the memory one. In such cases, the default
> > > swappiness 60 is copied across the cgroup subtrees early at startup,
> > > when systemd is arranging the slices for its services, before the
> > > sysctl.conf or tmpfiles.d/*.conf changes are applied.
> > >
> > > One could run a script to traverse the cgroup trees later and set the
> > > desired memory.swappiness individually in each occurrence when the
> > > runtime is set up, but this would require some amount of work to
> > > implement properly. Instead, why not set the default swappiness as early as
> > possible?
> > 
> > I have to say I am not a great fan of more tunning for swappiness as this is quite
> > a poor tunning for many years already. It essentially does nothing in many cases
> > because the reclaim process ignores to value in many cases (have a look a
> > get_scan_count. I have seen quite some reports that setting a specific value for
> > vmswappiness didn't make any change. The knob itself has a terrible semantic to
> > begin with because there is no way to express I really prefer to swap rather than
> > page cache reclaim.
> > 
> > This all makes me think that swappiness is a historical mistake that we should
> > rather make obsolete than promote even further.
> 
> Absolutely agree, the semantics of the vm_swappiness is perplexing.
> Moreover, the same get_scan_count treats vm_swappiness and cgroups
> memory.swappiness differently, in particular, 0 disables the memcg swap.
> 
> Certainly, the patch adds some additional exposure to a parameter that
> is not trivial to tackle but it's already getting created with a magic
> number which is also confusing. Is there any harm to be done by the patch
> considering the already existing sysctl interface to that knob?

Like any other config option/kernel parameter. It is adding the the
overall config space size problem and unless this is really needed I
would rather not make it worse.
-- 
Michal Hocko
SUSE Labs
