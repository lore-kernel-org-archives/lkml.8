Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F079AC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD821D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPO36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:29:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAPO36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:29:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8DE42B49E;
        Thu, 16 Jan 2020 14:29:56 +0000 (UTC)
Date:   Thu, 16 Jan 2020 15:29:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-ID: <20200116142954.l6gttssy65tuwygd@pathway.suse.cz>
References: <20200115095253.36e5iqn77n4exj3s@pathway.suse.cz>
 <D6F57A74-7608-43BE-B909-4350DE95B68C@lca.pw>
 <20200115170235.ph7lrojaktmfikm2@pathway.suse.cz>
 <7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-01-15 12:16:17, Qian Cai wrote:
> 
> 
> > On Jan 15, 2020, at 12:02 PM, Petr Mladek <pmladek@suse.com> wrote:
> > 
> > On Wed 2020-01-15 06:49:03, Qian Cai wrote:
> >> 
> >> 
> >>> On Jan 15, 2020, at 4:52 AM, Petr Mladek <pmladek@suse.com> wrote:
> >>> 
> >>> I could understand that Michal is against hack in -mm code that
> >>> would just hide a false positive warning.
> >> 
> >> Well, I don’t have any confidence to say everything this patch is
> >> trying to fix is false positives.
> > 
> > You look at this from a wrong angle. AFAIK, all lockdep reports pasted
> > in the below mentioned thread were false positives. Now, this patch
> > complicates an already complicated -mm code to hide the warning
> > and fix theoretical problems.
> 
> What makes you say all of those are false positives?

I have to admit that the 3 provided lockdep reports really looked
suspicious. I must have somehow missed/forgot about them.

If the last proposed change removes them and is acceptable for -mm
people then it looks like a reasonable solution.

Best Regards,
Petr
