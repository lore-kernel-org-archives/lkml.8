Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E6C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2978B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585757569;
	bh=eG74YUyRGVWLvF3Nw/DW4zo1XuzuqcNT8s5LXQkBqBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t0dxo4ggxv0d2IsnygM+mDmE29gxLsINCRXfW4CwlR+R9uOSEgg+ID9oJpnJbRJ81
	 zk1oGjke/U1yGx4KtcVPl5kXr7zDvq/BuxN67MPTfcvKC4F3hah64a0XGQZyt3f2q8
	 HJS5Zw92b2faQV6T01vCiuR8vc1HZD/gFDSVKygc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbgDAQMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:12:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41462 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbgDAQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:12:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so719949wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HOz2zhkw4iljGmp422o1/l5fbhE5jqc02RjkyFJxQo=;
        b=XcWaXowWIcA2N0qxqnlHj49VREUp+x2UZcgFBlARWXgavmUQUuvDkf+X38iTB2A9aW
         lyJohgMEeALG4OOqxQXsby14V7piibAY/ZDT/E8BYBEBuz5Edev9K5fJuixsY1ZLfNXe
         cOpa1ve6NtnY29vqDYjveBcR5pWQ0f8eTFC2CPppfQHfvLwDKROTIW376+z1D+PniBVt
         rqbEHGuWD4bviQk0dMcNCYjKyFck36E0Xq2K1UC8lb2/Y/IsAkhhGmGBw8gGziC6+iGp
         CpZh3PtiWosa127GKrJuJhF48JXCrM6PCo+5rTPXx2pqZPwGKSFB+uhf/wF4V6+XzVnX
         4C4g==
X-Gm-Message-State: ANhLgQ1U3ykz0zEkjSIgWTWSO0lQXoEl8FAUGm/EkNTnEM/8fdiSsU+E
        TVxcKd5sGyZTo+PCpAgv3v8=
X-Google-Smtp-Source: ADFU+vt1zKgJs9RiwLMbYZioJpRWOvDXIbqrS9E36qARyrIIrNdJHMbJaJA/cmZ5Cyqg6uzTkfQldg==
X-Received: by 2002:adf:f304:: with SMTP id i4mr25183059wro.46.1585757565470;
        Wed, 01 Apr 2020 09:12:45 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g128sm3267892wmf.27.2020.04.01.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:12:44 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:12:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401161243.GW22681@dhcp22.suse.cz>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
> On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> > On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > > On 01.04.20 17:42, Michal Hocko wrote:
> > > > I am sorry but I have completely missed this patch.
> > > > 
> > > > On Wed 11-03-20 20:38:48, Shile Zhang wrote:
> > > >> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> > > >> initialise the deferred pages with local interrupts disabled. It is
> > > >> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> > > >> initializing deferred pages").
> > > >>
> > > >> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> > > >> the boot CPU, which could caused the tick timer long time stall, system
> > > >> jiffies not be updated in time.
> > > >>
> > > >> The dmesg shown that:
> > > >>
> > > >>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
> > > >>
> > > >> Obviously, 1ms is unreasonable.
> > > >>
> > > >> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> > > >> (128MB) initialized, give the chance to update the systemd jiffies.
> > > >> The reasonable demsg shown likes:
> > > >>
> > > >>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> > > >>
> > > >> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
> > > > 
> > > > I dislike this solution TBH. It effectivelly conserves the current code
> > > > and just works around the problem. Why do we hold the IRQ lock here in
> > > > the first place? This is an early init code and a very limited code is
> > > > running at this stage. Certainly nothing memory hotplug related which
> > > > should be the only path really interested in the resize lock AFAIR.
> > > 
> > > Yeah, I don't think ACPI and friends are up yet.
> > 
> > Just to save somebody time to check. The deferred initialization blocks
> > the further boot until all workders are done - see page_alloc_init_late
> > (kernel_init path).
> 
> Ha, I just finished following all the hotplug paths to check this out, and as
> you all know there are a *lot* :-) Well at least we're in agreement.

Good to have it double checked!
 
> > > > This needs a double checking but I strongly believe that the lock can be
> > > > simply dropped in this path.
> 
> This is what my fix does, it limits the time the resize lock is held.

Just remove it from the deferred intialization and add a comment that we
deliberately not taking the lock here because abc

-- 
Michal Hocko
SUSE Labs
