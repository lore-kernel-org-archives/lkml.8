Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D9DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA9A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB4sy+pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAJRKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:10:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54027 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAJRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:10:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so1215569pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBvXLyc1YHRba12d1qGOEAYppdC7uysd/CuW1Cdr6XE=;
        b=JB4sy+pmPxNmEF/IdqEUR4mvTdV9p7qM1GbSFbiOx+lPHtjw21+yh3LyCdNHutFle3
         oNfFdIM17nKtIUnrPFaH30yfEcIU8rZIxG+HQ/vIxaCBN9wccSmvvDjNUkHOzHW74bbK
         UbDCOFCQcWSEKDM+Zfh8d1OybJn/+DtMAe76/m2XcfjrnXJa4sOR5YPNIONcQNZT/dTM
         wI+E5MsdSSnOUcoVfETiO13aGp/6LYAQx60L27zX4xESNKkyJRm20JTK7go67aubHdrc
         j6yr4ScXzkAXLzEQCLMbRyONEGuwDDMMU7b4Pgz/I0GXhHeDS2+x1jrT8egiJhG1Y1+k
         COVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBvXLyc1YHRba12d1qGOEAYppdC7uysd/CuW1Cdr6XE=;
        b=ndsMcwwRwQE4WgFGmhQ1B0ImGVuRBEmpJodqyrYA7ecTRtOQbV61Pfb6xM6wsIBVgz
         WoMkDzToYHrqHyLrBNV1Nb2Qspg5W45XEdQiockg0q68XSdGIcl9WJoSSE8IzWFCytQn
         jhDju4HQ4gMgagy1nDCxIBGrbRDB+rew7fxCIL71Ba1nZrBR/WCmr+ClsLVDE/2PCLg6
         guw/jJE2tABJrcUGWZueAOZarOto51hEOClnfgg6PpsFJCvAaN4vHqeLuVEUegAiWEmh
         fYpmxIZiJFn6ow3DFgemnICBCWswAp1LIWl5KdSg2x8YZpC3xprbCGeWj6/HTi6NDb4z
         tWPg==
X-Gm-Message-State: APjAAAWdCJAEFM0s9HvVNnXACuImU8QOd9wbAlD1BsVM7HI/Epu8Gxje
        jJ9hTTlk182zIixBEneVYuc=
X-Google-Smtp-Source: APXvYqyiUQHL4oDGEs33ymGs27Au9/cwS1DqjKduPQN1wB28qGjOj93x44RdJ71530eJVmu4wl22gQ==
X-Received: by 2002:a17:90a:c583:: with SMTP id l3mr6263355pjt.58.1578676239815;
        Fri, 10 Jan 2020 09:10:39 -0800 (PST)
Received: from workstation-kernel-dev ([103.211.17.220])
        by smtp.gmail.com with ESMTPSA id b8sm3730301pfr.64.2020.01.10.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:10:39 -0800 (PST)
Date:   Fri, 10 Jan 2020 22:40:33 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110171033.GA23748@workstation-kernel-dev>
References: <20200110132356.27110-1-frextrite@gmail.com>
 <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 01:31:34AM +0900, Keith Busch wrote:
> On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> > +#define subsys_lock_held() \
> > +	lockdep_is_held(&subsys->lock)
> 
> This macro requires "struct nvmet_subsys *subsys" was previously declared
> in the function using it, which isn't obvious when looking at the users. I
> don't think that's worth the conciseness.
> 

Hey Keith,
If I understand correctly, you're saying `*subsys` is always declared in the
function using it, right? I too think, this could cause confusion to the person
going through the code, I'll fix it right away.

Thanks
Amol

> > @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
> >  	} else {
> >  		struct nvmet_ns *old;
> >  
> > -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> > +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> > +							subsys_lock_held()) {
> >  			BUG_ON(ns->nsid == old->nsid);
> >  			if (ns->nsid < old->nsid)
> >  				break;
