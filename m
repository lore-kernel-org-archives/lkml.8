Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB36C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9720675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoH/PZOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:33:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26510 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgCFSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583519632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=51IIugSwsBjdfy5MvP+PidoijcdiR9fhmf60EnmBLsw=;
        b=GoH/PZOhEmBdL8Lne3/UVYZJXrWslzYDLeWKdpz1+4dPM/6lq5QEeuQIcGGgtp4ZmrZFjk
        sUQsrM07KnGjfMsjxnsx6IdBqhdpeq4UDmV9FUggFkAMt1362FBa4+qp29Voaf7TZzYAOo
        H3UYoM9WM9suc7q07YGKyX1VaryZQD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-Z5xbXSL3NGmQd5kT5e7hnQ-1; Fri, 06 Mar 2020 13:33:48 -0500
X-MC-Unique: Z5xbXSL3NGmQd5kT5e7hnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96E5C18C8C00;
        Fri,  6 Mar 2020 18:33:44 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF555C1B5;
        Fri,  6 Mar 2020 18:33:42 +0000 (UTC)
Date:   Fri, 6 Mar 2020 13:33:40 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>, Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200306183340.GC23145@pauld.bos.csb>
References: <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain>
 <20200227141032.GA30178@pauld.bos.csb>
 <20200228025405.GA634650@ziqianlu-desktop.localdomain>
 <CAERHkrunq=BqB=NmS2b_BfjePX2+nNpbv1EfTWw5rExbvYHyJw@mail.gmail.com>
 <20200306024116.GA16400@ziqianlu-desktop.localdomain>
 <98719a4e-f620-dc8c-f29f-fd63c43e1597@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98719a4e-f620-dc8c-f29f-fd63c43e1597@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 10:06:16AM -0800 Tim Chen wrote:
> On 3/5/20 6:41 PM, Aaron Lu wrote:
> 
> >>> So this appeared to me like a question of: is it desirable to protect/enhance
> >>> high weight task performance in the presence of core scheduling?
> >>
> >> This sounds to me a policy VS mechanism question. Do you have any idea
> >> how to spread high weight task among the cores with coresched enabled?
> > 
> > Yes I would like to get us on the same page of the expected behaviour
> > before jumping to the implementation details. As for how to achieve
> > that: I'm thinking about to make core wide load balanced and then high
> > weight task shall spread on different cores. This isn't just about load
> > balance, the initial task placement will also need to be considered of
> > course if the high weight task only runs a small period.
> > 
> 
> I am wondering why this is not happening:  
> 
> When the low weight task group has exceeded its cfs allocation during a cfs period, the task group
> should be throttled.  In that case, the CPU cores that the low
> weight task group occupies will become idle, and allow load balance from the
> overloaded CPUs for the high weight task group to migrate over.  
> 

cpu.shares is not quota. I think it will only get throttled if it has and 
exceeds quota.  Shares are supposed to be used to help weight contention
without providing a hard limit. 


Cheers,
Phil


> Tim
> 

-- 

