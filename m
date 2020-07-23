Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504372086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGWKTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWKTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:19:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38A75ACDF;
        Thu, 23 Jul 2020 10:19:58 +0000 (UTC)
Date:   Thu, 23 Jul 2020 12:19:47 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <MHocko@suse.com>,
        linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <OSalvador@suse.com>
Subject: Re: [PATCH v4 12/15] mm,hwpoison: Rework soft offline for in-use
 pages
Message-ID: <20200723101942.GA19826@linux>
References: <20200716123810.25292-1-osalvador@suse.de>
 <20200716123810.25292-13-osalvador@suse.de>
 <f7387d64d0024d15a1bc821a8e19b8f0@DB7PR04MB5180.eurprd04.prod.outlook.com>
 <c19693eb3600832976f44ffa746a263a@suse.de>
 <3b2231bf69133bb7bb8936c74b4e9c9f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2231bf69133bb7bb8936c74b4e9c9f@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:08:59AM +0200, osalvador@suse.de wrote:
> On 2020-07-20 10:27, osalvador@suse.de wrote:
> > > This means that some hugepages are dissolved, but the others not,
> > > maybe which is not desirable.
> > > I'll dig this more later but just let me share at first.
> > > 
> > > A few minor comment below ...
> > 
> > 
> > Uhm, weird.
> > 
> > I will be taking a look today.
> 
> After some digging up I __think__ I found the problem.
> I will try to fix it up and I will be running tests.

I found the problem.
I re-ran the tests again with small and large memory and 
the stats look correct this time.

After some more testing, I also fixed a list corruption that was happening
due to the same problem.

I am creating a git branch so you can re-run your tests on it as well.

-- 
Oscar Salvador
SUSE L3
