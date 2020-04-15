Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10AAC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B352C2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586946248;
	bh=8UTd5VNRLgk5L67MAXg3c/cWS2UHVrkt6dCbxr/ugzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kYs2+tU+SyValOXMGUby15SNgnTt51glyzwYOlwl/sccN1u50I200bE39AR3q5Opc
	 6s9a72RWkJPAdrh/+NQ9R8MC3EF2uhDjgFf+S5wb+I7PaNNlQBXZn6ul22kQY60dW2
	 Zj+GnS4Kth5YfQ/vIFlD50PCDrHoHcFZbCLynKA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896473AbgDOKW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:22:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896400AbgDOKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:16:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id v8so14574028wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6RF4WufMmMDOeU7tEnVUbEzApfb4RzYUUgBLy7xNXoc=;
        b=atK5g23fPaKzTeFIhsxxRawXT3tm5i1WNpt3Fg6OCKZf/ZdtvuyaFA6sF606aW1wmR
         7PcYXEVu6AYZSmVBQTN/TNcqAG/PDS6cL/gQrWWdjLrJrzlZT11CvuhDcnIFOofVgF6a
         I6wWLwjZuEAyAVVPZSwN+JkK8AsvZVPpCuSr0YpGlaZZjGd1ubJy1GVhg8BvE0tYmwo/
         EIcf3UoobCZ64BaI4l7WyLM4azlGgKm8fUnzmyGqX/MNnL6Vth9tljSLutENLORAtkA3
         isXOCuEI6tcFbxfFFuy2TllW5ZV9c6DlX37pFGXO2Yo02JsTkQZcbST43ZxzLApF5i/m
         vkGQ==
X-Gm-Message-State: AGi0PuY/3gJvnltPR9eXsPS/Zwn+G49xHxQnn0+DAtLewUDF/7dKgo5b
        2Ddb1SePtSo6Vf/tN5JQ0Lo=
X-Google-Smtp-Source: APiQypKwwZOSZo6TKJ0VX0uh/VRxb42E0lr4O+D1OO7/WfRpILKWx7YwVM17KF5oioj4FCitYR+BbA==
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr4704758wmb.79.1586945781247;
        Wed, 15 Apr 2020 03:16:21 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id h137sm17223451wme.0.2020.04.15.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:16:20 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:16:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Dan Williams <dan.j.williams@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64/hotplug: Process MEM_OFFLINE and
 MEM_CANCEL_OFFLINE events
Message-ID: <20200415101618.GD4629@dhcp22.suse.cz>
References: <1586932784-16315-1-git-send-email-anshuman.khandual@arm.com>
 <31ce355b-abf7-ac3b-a5b4-ae1b0a52fb3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ce355b-abf7-ac3b-a5b4-ae1b0a52fb3c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-04-20 09:35:33, David Hildenbrand wrote:
> On 15.04.20 08:39, Anshuman Khandual wrote:
> > This series improves arm64 memory event notifier (hot remove) robustness by
> > enabling it to detect potential problems (if any) in the future. But first
> > it enumerates memory isolation failure reasons that can be sent across a
> > notifier. This series does not go beyond arm64 to explore if these failure
> > reason codes could be used in other existing registered memory notifiers.
> > Please do let me know if there is any other potential use cases, will be
> > happy to incorporate next time around. Also should we add similar failure
> > reasons for online_pages() as well ?
> > 
> > This series has been tested on arm64, boot tested on x86 and build tested
> > on multiple other platforms.
> > 
> 
> I'm sorry, but I have to nack this series. Why?
> 
> 1. A hotplug notifier should not have to bother why offlining failed. He
> received a MEM_GOING_OFFLINE, followed by a MEM_CANCEL_OFFLINE. That's
> all he really has to know. Undo what you've done, end of story.
> 
> 2. Patch 2 just introduces dead code that should never happen unless
> something is horribly broken in the core (memory offlined although
> nacked from notifier). And, it (for *whatever reason*) thinks it's okay
> to bail out if another noYtifier canceled offlining hotplugged memory.
> 
> I fail to see the benefit for core changes and

Agreed! If arm64 wants to check and report early bootmem memory
offlining then just do it. There is no reason to add a whole machinery
for that. Cancel notifier is indeed only supposed to restore the state
before GOING_OFFLINE.

>  4 files changed, 99 insertions(+), 13 deletions(-)

-- 
Michal Hocko
SUSE Labs
