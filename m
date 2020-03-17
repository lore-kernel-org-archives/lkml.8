Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D55C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564E2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584433761;
	bh=8zYOibsTES81lzDVKT5Acos+gREQ/gzEriHSAFk9KFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=StaJYuunnd3p0wnvnPxYfE+ioi1akUI+CtXwGTfzI6KlIK3xMaC3TMi1Rs4hpL4aS
	 +CaJk3juZvesFEwizHYRsCK2N+N6Y+eVqud2O08+TiwpGf3EbXnCsvsLQ7/Yl3qsnW
	 mtYHQYyQu9xC/1QqEl3uDPtWpefr3XuAShM4tf6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCQI3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:29:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42616 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:29:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so24460568wrm.9;
        Tue, 17 Mar 2020 01:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wAIk4DL6bwX6X4hEBIHh+kWSNyLcbub91KA8tHHHRo=;
        b=UPM+dNBtZwxJe9TAi0hTbj7yopIfWkEuY2oEoQLxAsaIEoBkEnQcjmLNFGuqC2NUV+
         ugqjKFUx9IcL54WJQrtPuAvZWgs5W7rXyg+Ui9hhtgelt2mdnCFfzrYZCAd4NLqjl4XA
         i+GSbJgq708R9jABMtCa6VbN7JxNg95OyUwgA+4ctgBJT4wbYwXo/JFG/WFIx/Zl+fvR
         Dkyd0g373CEan99MvBlqMy4PvAhFcDsRMRMbpjQ7g4+q8cMHtPqxNeVqofCeSufqoy3M
         /FrFJVFaJeI1oTcGC0FgDlgLkn+dJ0tmL543WWVB2EyjMWDEURVcMdKkCRm5koJQM3yj
         7woQ==
X-Gm-Message-State: ANhLgQ1NB48J/CYDN7+3sFjFJJSilwu0ZRbJaa7ims0EPZzJ3m4fuXw5
        T3hJRe3UPUIFHQ8Hvcp5pi0=
X-Google-Smtp-Source: ADFU+vtRCX5NUpwX52GydJiSEFAALOfdTj1N3Zg+KwSO45zWC3wQWr+svNsTDVRa8D4IMiuUnabBgg==
X-Received: by 2002:adf:a155:: with SMTP id r21mr4682249wrr.264.1584433755663;
        Tue, 17 Mar 2020 01:29:15 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id a1sm3544746wru.75.2020.03.17.01.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:29:14 -0700 (PDT)
Date:   Tue, 17 Mar 2020 09:29:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
Message-ID: <20200317082913.GE26018@dhcp22.suse.cz>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312092531.GU23944@dhcp22.suse.cz>
 <BL0PR02MB5601B50A2D9AEE6318D51893E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312132642.GW23944@dhcp22.suse.cz>
 <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea2e014-17ea-6d1e-a6cd-775fb6550cd2@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-03-20 15:53:21, Vlastimil Babka wrote:
> On 3/12/20 2:26 PM, Michal Hocko wrote:
> > On Thu 12-03-20 12:54:19, Ivan Teterevkov wrote:
> >> 
> >> Absolutely agree, the semantics of the vm_swappiness is perplexing.
> >> Moreover, the same get_scan_count treats vm_swappiness and cgroups
> >> memory.swappiness differently, in particular, 0 disables the memcg swap.
> >> 
> >> Certainly, the patch adds some additional exposure to a parameter that
> >> is not trivial to tackle but it's already getting created with a magic
> >> number which is also confusing. Is there any harm to be done by the patch
> >> considering the already existing sysctl interface to that knob?
> > 
> > Like any other config option/kernel parameter. It is adding the the
> > overall config space size problem and unless this is really needed I
> > would rather not make it worse.
> 
> Setting the vm_swappiness specific case aside, I wonder if if would be
> useful to be able to emulate any sysctl with a kernel parameter,
> i.e. boot the kernel with sysctl.vm.swappiness=X
> There are already some options that provide kernel parameter as well
> as sysctl, why not just support all.

This sounds like a much better idea than a case by case handling. I
wouldn't be surprised if some kernel parameters would duplicate sysctl
values. I cannot judge the implementation unfortunately but from a quick
glance it makes sense to me. Especially where you hooked it into because
not all handlers are simple setters for a global value. Some of them
have a much more complicated logic which requires a lot of
infrastructure to be set up already. So putting do_sysctl_args right
before the init is executed should be good enough.

Care to post an RFC to a larger audience? Let's see where we get from
there.

> Quick and dirty proof of concept:
> @@ -1367,6 +1384,8 @@ static int __ref kernel_init(void *unused)
>  
>  	rcu_end_inkernel_boot();
>  
> +	do_sysctl_args();
> +
>  	if (ramdisk_execute_command) {
>  		ret = run_init_process(ramdisk_execute_command);
>  		if (!ret)
-- 
Michal Hocko
SUSE Labs
