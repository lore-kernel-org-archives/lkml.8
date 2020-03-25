Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0CC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0612206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585126547;
	bh=9clGNzS6IpvWJjMCHdTXabts4XuLn+Vaf1OgCvL6CO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aEz3OxlZUfw1lf7WIoyuRNUtcSKTi+mn+c1v3QGPD+4Kt9taaTapylVRgTanX7SOI
	 VwBoMGSKG7JT55SHFUlcGe1NLkCqfq5xPui3YXFZ/rkoOQJ2bAS2X0gb2d/QSU41SI
	 +/jBVOmHsBdD4ImQ+NLgvj3XRviFX8iLnKqPLBTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCYIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:55:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33512 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgCYIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id w25so1577915wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A0OMbVybEpaW+w1C0n6/qu2u7s7M3HMJ+OsMULSR4sI=;
        b=INatbJ1zpjx/upydrHaGJRlTY0MoG/t1dP7z2pQMcKrRZpC2FoULfdiepFwso432T3
         pKsYilMPbVAQiksfTNVTwIm1mYyzzjNwDNw5cUARtWf0AcdpdK1bh525ghcxI6MAcwRp
         /OAEGnvOoyl0U8dV82Sq2K3N9nTYYoXK2KdosKfjqev9FEZRA6BvPiEzSa1O+wC9n5AU
         Oj7AXgr1SDdlQ71TJLL/obmZOrFzd4+cUm5u1z0VP9r4Ol+4racqqNYU9KlKZ7zDzYEc
         geXhCCuOgPyI1wJtm79qRy/qtQVbYBdAF/tfN38S70nj4/Dsedr/I623Z6bKOzWtJmu/
         XHng==
X-Gm-Message-State: ANhLgQ3E6kRyB7WOd2f1l4RDrfn7twD+bs+UZQpzyF2UQXdBySF5LUJ/
        j6o30Wz66Smb/rWPQnR8Dqo=
X-Google-Smtp-Source: ADFU+vuA/5ocaWVVNlpCYn5BnzvuJ6qnAuLXSyHHVlX4ChU1l/XeQ0Gm6/esgK8FoNtoa2aiIXY24w==
X-Received: by 2002:a1c:2e92:: with SMTP id u140mr2384030wmu.84.1585126540155;
        Wed, 25 Mar 2020 01:55:40 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id t193sm8428993wmt.14.2020.03.25.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:55:39 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:55:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, vbabka@suse.cz
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of
 /proc/zoneinfo
Message-ID: <20200325085537.GZ19542@dhcp22.suse.cz>
References: <20200324142229.12028-1-bhe@redhat.com>
 <20200324142229.12028-5-bhe@redhat.com>
 <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
 <20200325055331.GB9942@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325055331.GB9942@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-03-20 13:53:31, Baoquan He wrote:
> On 03/24/20 at 12:25pm, David Rientjes wrote:
> > On Tue, 24 Mar 2020, Baoquan He wrote:
> > 
> > > This moving makes the layout of /proc/zoneinfo more sensible. And there
> > > are 4 zones at most currently, it doesn't need to scroll down much to get
> > > to the 1st populated zone, even though the 1st populated zone is MOVABLE
> > > zone.
> > > 
> > 
> > Doesn't this introduce risk that it will break existing parsers of 
> > /proc/zoneinfo in subtle ways?
> > 
> > In some cases /proc/zoneinfo is a tricky file to correctly parse because 
> > you have to rely on the existing order in which it is printed to determine 
> > which zone is being described.  We need to print zones even with unmanaged 
> > pages, for instance, otherwise userspace may be unaware of which zones are 
> > supported and what order they are in.  That's important to be able to 
> > construct the proper string to use when writing vm.lowmem_reserve_ratio.
> > 
> > I'd prefer not changing the order of /proc/zoneinfo if it can be avoided 
> > just because the risk outweighs the reward that we may break some 
> > initscript parsers.
> 
> Oh, I may not describe the change and result clearly. This patch doesn't
> change zone order at all.  I only move the per-node stats to the front of
> each node, the zone order is completely kept the same, still DMA, DMA32,
> NORMAL, MOVABLE.

Even this can break existing parsers. Fixing that up is likely not hard
and existing parsers would be mostly debugging hacks here and there but
I do miss any actual justification except for you considering it more
sensible. I do not remember this would be a common pain point for people
parsing this file. If anything the overal structure of the file makes it
hard to parse and your patches do not really address that. We are likely
too late to make the output much more sensible TBH.

That being said, I haven't looked more closely on your patches because I
do not have spare cycles for that. Your justification for touching the
code which seems to be working relatively well is quite weak IMHO, yet
it adds a non zero risk for breaking existing parsers.
-- 
Michal Hocko
SUSE Labs
