Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA70C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2597D206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQrcfUro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCLNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:36:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RRgNREQ8UhkO3D0KGQ+TpnJA22cUraRKriEcCp/CNIo=; b=DQrcfUrokLYL079BOwXFqbQ+KH
        EYbmsxnFf9jbmK5CabXbZeduhE7TipkWRWluji9pHuD1r1knCelnjsKgKPAvwHoOOOoHQ+sDNKeLI
        riluurvz/NiNicNGeC5hcup9GXjY6zN6FjzehX82+DRve183ox4VCgi3JWfMK68kxekJeBzTkWgYi
        kAJcH1TpnUuskFbmGH4Ss15fxNFUgbpo/YsmoHJzdLhipfsY2wLUFjklmD3mxhMDEV2Ot9TUdksYB
        yVg0Juq00nmF2rtacSR2hbLPxrgIOQhbUUWLG+u2dN9P7YTvYahNRu5qU/BwLAN65sZEfT8WDAERY
        bcYSvJ/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCO0q-00011o-8h; Thu, 12 Mar 2020 13:36:36 +0000
Date:   Thu, 12 Mar 2020 06:36:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     David Rientjes <rientjes@google.com>,
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
Message-ID: <20200312133636.GJ22433@bombadil.infradead.org>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
 <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:48:22PM +0000, Ivan Teterevkov wrote:
> On Wed, 11 Mar 2020, David Rientjes wrote:
> > On Wed, 11 Mar 2020, Ivan Teterevkov wrote:
> > > This patch adds a couple of knobs:
> > >
> > > - The configuration option (CONFIG_VM_SWAPPINESS).
> > > - The command line parameter (vm_swappiness).
> > >
> > > The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS.
> > >
> > > Historically, the default swappiness is set to the well-known value 60,
> > > and this works well for the majority of cases. The vm_swappiness is also
> > > exposed as the kernel parameter that can be changed at runtime too, e.g.
> > > with sysctl.
> > >
> > > This approach might not suit well some configurations, e.g. systemd-based
> > > distros, where systemd is put in charge of the cgroup controllers,
> > > including the memory one. In such cases, the default swappiness 60
> > > is copied across the cgroup subtrees early at startup, when systemd
> > > is arranging the slices for its services, before the sysctl.conf
> > > or tmpfiles.d/*.conf changes are applied.
> > 
> > Seems like something that can be fully handled by an initscript that would
> > set the sysctl and then iterate the memcg hierarchy propagating the
> > non-default value.  I don't think that's too much of an ask if userspace
> > wants to manipulate the swappiness value.
> > 
> 
> This is exactly what I'm trying to avoid: in some distros there is no way
> to tackle the configuration early enough, e.g. in systemd-based systems
> the systemd is the process that starts first and arranges memcg in a way
> it's configured, but unfortunately, it doesn't offer the swappiness knob.

This sounds like a systemd problem.  Have you talked to the systemd
people about fixing it in systemd?

