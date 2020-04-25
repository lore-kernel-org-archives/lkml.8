Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443BB20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDYNBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYNBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:01:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6EEC2AD57;
        Sat, 25 Apr 2020 13:01:46 +0000 (UTC)
Date:   Sat, 25 Apr 2020 15:01:36 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops -14.1%
 regression
Message-ID: <20200425130136.GA28245@zn.tnic>
References: <20200425114414.GU26573@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425114414.GU26573@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:44:14PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -14.1% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 1de08dccd383482a3e88845d3554094d338f5ff9 ("x86/mce: Add a struct mce.kflags field")

I don't see how a struct mce member addition will cause any performance
regression. Please check your test case.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
