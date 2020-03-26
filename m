Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E5C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585205024;
	bh=V3f33qtN90wwK2aqdwTxTva/+rqXE6VbAzP6+niREAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMbbqY04PegCdysNfJp9IAvFfVBrNSu34cxNzyJuPJxzys3i3RHWXTP1xHGlLrjHi
	 yDg4gJmYaqy0ddieyr3ejFkM50uRq3uIWzFzigVNJo89WYTThyLbLYIkd6a90Milpg
	 EmiQTwlViu92FjXwjltPL9+rU6WhiHGutik8hN38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:43:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45924 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgCZGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:43:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so6280356wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPvE1lnXsSi8Kx3PcPb+s1+Cw8243rYkgn6Gll8JJq8=;
        b=ENqZqvbW3+N/7bhcgNg7INi4Ks8pjL4QoijDA7zPI9hqrybxQlvnQ69Z+m3icFK8Pu
         Akrn4XmF3y1DfnfBpxqqt4Xkm19vrghYMlS93tumsFaaRHlwdTe3MEQsw1LD/WWrGr/k
         KQ2YaBVSCK6JeqD9rxr0CzZGVeisAwJWptbS5fZhlAZDU8oob+skVh4XCphzMB7eS0BS
         iw181CWj5QGOYNERNTTMJ4cXfEZyi5dpZD+OZOV15NFNUc14RgWUCl7jBiGWpUP9d0Sp
         yU49Tyny7FtSxXXuKAFAenK03g/H2rJeoDozHekSqj44bwp3aoC5dyJiRr9seHMznsYZ
         0m1A==
X-Gm-Message-State: ANhLgQ2jbn5zfp0YFS5uwJc1GnjBcdMXHfbYxTPJCXByIgpinaA/5EQu
        GMa2Jwd2o9xBNPZWS3vpi0D9s2Js
X-Google-Smtp-Source: ADFU+vv3KAOE5Ki5XlMlbPu6EchekM7Vf0TxjYqamCS2n9m2ZU1ZrM/BLGlbDPBnRmP7qCvjySktRQ==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr7497382wrn.293.1585205021142;
        Wed, 25 Mar 2020 23:43:41 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id w7sm2129103wrr.60.2020.03.25.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:43:39 -0700 (PDT)
Date:   Thu, 26 Mar 2020 07:43:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of
 /proc/zoneinfo
Message-ID: <20200326064339.GA27965@dhcp22.suse.cz>
References: <20200324142229.12028-1-bhe@redhat.com>
 <20200324142229.12028-5-bhe@redhat.com>
 <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
 <20200325055331.GB9942@MiWiFi-R3L-srv>
 <20200325085537.GZ19542@dhcp22.suse.cz>
 <20200325142315.GC9942@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.2003251242060.51844@chino.kir.corp.google.com>
 <20200326042454.GD9942@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326042454.GD9942@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-03-20 12:24:54, Baoquan He wrote:
> On 03/25/20 at 12:45pm, David Rientjes wrote:
> > On Wed, 25 Mar 2020, Baoquan He wrote:
> > 
> > > > Even this can break existing parsers. Fixing that up is likely not hard
> > > > and existing parsers would be mostly debugging hacks here and there but
> > > > I do miss any actual justification except for you considering it more
> > > > sensible. I do not remember this would be a common pain point for people
> > > > parsing this file. If anything the overal structure of the file makes it
> > > > hard to parse and your patches do not really address that. We are likely
> > > > too late to make the output much more sensible TBH.
> > > > 
> > > > That being said, I haven't looked more closely on your patches because I
> > > > do not have spare cycles for that. Your justification for touching the
> > > > code which seems to be working relatively well is quite weak IMHO, yet
> > > > it adds a non zero risk for breaking existing parsers.
> > > 
> > > I would take the saying of non zero risk for breaking existing parsers.
> > > When considering this change, I thought about the possible risk. However,
> > > found out the per-node stats was added in 2016 which is not so late, and
> > > assume nobody will rely on the order of per-node stats embeded into a
> > > zone. But I have to admit any concern or worry of risk is worth being
> > > considerred carefully since /proc/zoneinfo is a classic interface.
> > > 
> > 
> > For context, we started parsing /proc/zoneinfo in initscripts to be able 
> > to determine the order in which vm.lowmem_reserve_ratio needs to be set 
> > and this required my kernel change from 2017:
> > 
> > commit b2bd8598195f1b2a72130592125ac6b4218988a2
> > Author: David Rientjes <rientjes@google.com>
> > Date:   Wed May 3 14:52:59 2017 -0700
> > 
> >     mm, vmstat: print non-populated zones in zoneinfo
> > 
> > Otherwise, we found, it's much more difficult to determine how this array 
> > should be structured.  So at least we parse this file very carefully, I'm 
> > not sure how much others do, but it seems like an unnecessary risk for 
> > little reward.  I'm happy to see it has been decided to drop this patch 
> > and patch 5.
> 
> 
> OK, I see why it is in such a situation, the empty zones were not printed. 
> 
> I could still not get how vm.lowmem_reserve_ratio is set with
> /proc/zoneinfo in the old initscripts, do you see any risk if not
> filling and showing the ->lowmem_reserve[] of empty zone in
> patch 2 and 3?  Thanks in advance.

The point is why should we even care. Displaying that information
shouldn't hurt anything, right?

-- 
Michal Hocko
SUSE Labs
