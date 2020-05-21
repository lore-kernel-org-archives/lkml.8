Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B50C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE03A20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgEULvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbgEULvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:51:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A5B9B011;
        Thu, 21 May 2020 11:51:43 +0000 (UTC)
Date:   Thu, 21 May 2020 13:51:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the printk tree
Message-ID: <20200521115139.GB8397@linux-b0ei>
References: <20200521080456.49a732be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521080456.49a732be@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-21 08:04:56, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   bdb7f0530926 ("printk: Fix a typo in comment "interator"->"iterator"")
> 
> is missing a Signed-off-by from its committer.

Thanks for catching this. It should be fixed now.

Best Regards,
Petr
