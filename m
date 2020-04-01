Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E876CC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585756854;
	bh=sfYgyV4pRFhyKtljKteY2NJRYfffBjzXV+KbgYiMpBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HROfPTJ2w9KfLkG0oKfIXC87Xhc0o0LLexraPZfQKXmwW8h6z/aSJTrVMKv2rAuNR
	 9mb8nuWK8pYlOaF6HK50OgA5jKTlH2JnzGsGtfVb2k9UPuMmwZoDnMpdwnvflLhvOO
	 jidvb47ORT850OmmzvNtIFXX1QemacaOz41NNc9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbgDAQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:00:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55221 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgDAQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:00:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so264079wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kwtZP4ZCi5vqZ2EqGN5Ea/71mqAg8/MW59NL+tE7PEU=;
        b=jbyUWkYqXTP608vfPlwqlCgtHxJ8COz7EoTRdjlvgviVZnQba+/eDMWecByX7CONc4
         Xt8R7TbWHKpBZtEt6perVETBCXPOScTUAenIb7DONpyZK2zY+d9P9JgCvTARWIKwTEd9
         4L1CoU+9dV4Xo6FUKBHTRnDHxcj5qwGIbLEcDMQWeAaAg1/dLFOJ6BJUyeBAKLugkTkX
         SOZXuNCNdebYn9qP3ajEIUtwsObveTr/YO2B7oa1EHDZVyRY/osCaeBELXDKKdr2Fq24
         Xqp1SHKD6H3OjOg1h4n5ZUg4tZtc6YooWrncYde1INTFPZFLCDKxQ+AP2lbAyetBFJFX
         9Uxg==
X-Gm-Message-State: AGi0PuY4IcrbUnA4xYjbX6SZh33FU6imDrn+wwY6NP4ix06KkbAW+LGI
        I+kT4y4ajLax6/LGinxLAFw=
X-Google-Smtp-Source: APiQypJ+ZLmR6gzwZ15EFyDDeZcCMemYn8xwKQ2tLvW1XAYY5uPPdgcKjNy0X5i+V1nYuj+m4i12iA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr5269134wmj.40.1585756850390;
        Wed, 01 Apr 2020 09:00:50 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id f3sm3347854wmj.24.2020.04.01.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:00:49 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:00:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401160048.GU22681@dhcp22.suse.cz>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> On 01.04.20 17:42, Michal Hocko wrote:
> > I am sorry but I have completely missed this patch.
> > 
> > On Wed 11-03-20 20:38:48, Shile Zhang wrote:
> >> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> >> initialise the deferred pages with local interrupts disabled. It is
> >> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> >> initializing deferred pages").
> >>
> >> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> >> the boot CPU, which could caused the tick timer long time stall, system
> >> jiffies not be updated in time.
> >>
> >> The dmesg shown that:
> >>
> >>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
> >>
> >> Obviously, 1ms is unreasonable.
> >>
> >> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> >> (128MB) initialized, give the chance to update the systemd jiffies.
> >> The reasonable demsg shown likes:
> >>
> >>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> >>
> >> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
> > 
> > I dislike this solution TBH. It effectivelly conserves the current code
> > and just works around the problem. Why do we hold the IRQ lock here in
> > the first place? This is an early init code and a very limited code is
> > running at this stage. Certainly nothing memory hotplug related which
> > should be the only path really interested in the resize lock AFAIR.
> 
> Yeah, I don't think ACPI and friends are up yet.

Just to save somebody time to check. The deferred initialization blocks
the further boot until all workders are done - see page_alloc_init_late
(kernel_init path).
-- 
Michal Hocko
SUSE Labs
