Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA489C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9060B2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdyV+Mrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCYTpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:45:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35265 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgCYTpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:45:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so1669329pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fT51JITI/R6tUXu2+U8t7/7SudwFVF/4mYDYH5hINGs=;
        b=BdyV+MrhBAqfFueYJW3JN6gP4VkHwpfFCKps/8+JC/+CUuSbVCQh/yiG7tsINMMa30
         A1YUWNufqpwqw7N6EIlhYPb8riEVPEFzWYraVf5uQhPfPdczVePmDRD48CWEkJbzd6C0
         bJ3/5K6xLTR7HEmYC+tLDWxPoz/R1WsK+C0mOSg6P7/2SHM2HSFscrOE6vgVeU6rf8Ke
         dkveg/Uc2kIbL4DvDWZDsokcio8MUTcUQj9IvQVBy8iuSz/oubfCwpP+129xhhE7ojXb
         3fRDQTeNTUnAdu0aNmpy2inrTlOKqfhKsYh0Gs5Tbm/jao77Z+MnqLKrJfxMqWmuflFj
         3hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fT51JITI/R6tUXu2+U8t7/7SudwFVF/4mYDYH5hINGs=;
        b=C36WUww8BiPvMDG2lJkGcw5wwVMt/HUD2R5H5bTufuAmy79ofMxg62bH5ngT+Fb7VJ
         hcEp/QLdHk7iv1sZsH2H1zTAqhNsN9T0HZPWst8GM6Bx0iO1K7Ew9xSlXTG7swNS1G9o
         82OtFaJg9HYdEAtfSxXjY2KOD6vzFojwnjRS0+IIbOeJfpxoCYcUfy9+/jqDz09v50zy
         NEthLEV2LstU+g1wtCBEiMo0P6uBbNbVoc1fhPpp7mGnvn29gOpTaKsb+WGpoSQE7SPj
         wPGE6MWXYy/i2ROts04JJeApkMLGrei7yZ3VpRoc7iI/+TCpJdi89vLwltwv08bpNJ2B
         ShcA==
X-Gm-Message-State: ANhLgQ1FmdYpPg+TP1xQrTOuk8ghRQjm7kZQHf0poE4Fuln799zVHVL4
        P/j+OcfwlBtZacnqsBHSPKTAhg==
X-Google-Smtp-Source: ADFU+vthJvbagwjWYQ9rj0cIytrpK3pwQlicfE4ifFd9KcJSlBRDD+au9x66fUUppHlr/vOP+1o03A==
X-Received: by 2002:a63:b22:: with SMTP id 34mr4593624pgl.78.1585165520542;
        Wed, 25 Mar 2020 12:45:20 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m29sm8401249pgl.35.2020.03.25.12.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:45:19 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:45:18 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Baoquan He <bhe@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front
 of /proc/zoneinfo
In-Reply-To: <20200325142315.GC9942@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.21.2003251242060.51844@chino.kir.corp.google.com>
References: <20200324142229.12028-1-bhe@redhat.com> <20200324142229.12028-5-bhe@redhat.com> <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com> <20200325055331.GB9942@MiWiFi-R3L-srv> <20200325085537.GZ19542@dhcp22.suse.cz>
 <20200325142315.GC9942@MiWiFi-R3L-srv>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Baoquan He wrote:

> > Even this can break existing parsers. Fixing that up is likely not hard
> > and existing parsers would be mostly debugging hacks here and there but
> > I do miss any actual justification except for you considering it more
> > sensible. I do not remember this would be a common pain point for people
> > parsing this file. If anything the overal structure of the file makes it
> > hard to parse and your patches do not really address that. We are likely
> > too late to make the output much more sensible TBH.
> > 
> > That being said, I haven't looked more closely on your patches because I
> > do not have spare cycles for that. Your justification for touching the
> > code which seems to be working relatively well is quite weak IMHO, yet
> > it adds a non zero risk for breaking existing parsers.
> 
> I would take the saying of non zero risk for breaking existing parsers.
> When considering this change, I thought about the possible risk. However,
> found out the per-node stats was added in 2016 which is not so late, and
> assume nobody will rely on the order of per-node stats embeded into a
> zone. But I have to admit any concern or worry of risk is worth being
> considerred carefully since /proc/zoneinfo is a classic interface.
> 

For context, we started parsing /proc/zoneinfo in initscripts to be able 
to determine the order in which vm.lowmem_reserve_ratio needs to be set 
and this required my kernel change from 2017:

commit b2bd8598195f1b2a72130592125ac6b4218988a2
Author: David Rientjes <rientjes@google.com>
Date:   Wed May 3 14:52:59 2017 -0700

    mm, vmstat: print non-populated zones in zoneinfo

Otherwise, we found, it's much more difficult to determine how this array 
should be structured.  So at least we parse this file very carefully, I'm 
not sure how much others do, but it seems like an unnecessary risk for 
little reward.  I'm happy to see it has been decided to drop this patch 
and patch 5.

> So, in view of objections from you and David, I would like to drop this
> patch and patch 5. It's a small improvement, not worth taking any risk.
> But if it goes back to this time of 2017, I would like to spend some
> time to defend it :-)
> 
> commit e2ecc8a79ed49f7838b4fdf352c4c48cec9424ac
> Author: Mel Gorman <mgorman@techsingularity.net>
> Date:   Thu Jul 28 15:47:02 2016 -0700
> 
>     mm, vmstat: print node-based stats in zoneinfo file
> 
> 
> 
