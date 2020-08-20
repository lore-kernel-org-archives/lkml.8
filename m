Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA53C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69D42224D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgHTJ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:27:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:59310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgHTJ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E3EAC7D;
        Thu, 20 Aug 2020 09:26:39 +0000 (UTC)
Date:   Thu, 20 Aug 2020 11:26:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20200820092611.GD17365@zn.tnic>
References: <20200820161239.25a9b3f4@canb.auug.org.au>
 <20200820082149.GB17365@zn.tnic>
 <20200820191502.1df900be@canb.auug.org.au>
 <20200820092221.GU2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820092221.GU2026@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:22:21AM +0200, David Sterba wrote:
> (Dunno why not an alias but it works the same way.)

I have this alias:

	one = show -s --pretty='format:%h (\"%s\")'

and so I do

$ git one <sha1>

and then paste it after Fixes:

I have it this way because quoting commits is kinda very frequent
operation, not only for Fixes: tags.

:-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
