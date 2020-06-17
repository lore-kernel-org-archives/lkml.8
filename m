Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B118220776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592402388;
	bh=0Lz6TFQhfGp4bkoSVLTJgIT/broxuaK6TXcJSsj1HDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=veDr5MJZJblK/WH9PH3N1Hu3Z1zJQJ77ixrWois8zpUh8IosNet6+Y9z1vVLx8xxG
	 jtDDXKaP0kKIG+7f7UmMCZZpegksqHD8+6Hd3Ys3eLYrIS1viZocOdhqi9ORatLtJA
	 Yy8eZU3EHStFvJYgTfAtodw1Iv8qVAtczpJrBd6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFQN7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgFQN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:59:45 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A4E20776;
        Wed, 17 Jun 2020 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592402384;
        bh=0Lz6TFQhfGp4bkoSVLTJgIT/broxuaK6TXcJSsj1HDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMOFazE11y2j35ElYwUhFG1c7RveWXp6JEzTsPUId8PCinClymu6lifqi+kjEA+7N
         ROrH8zIGYsAXahTZqkbHkC2tTE3RRK/NU6u4KzYYp8wNMheVO4SJyvikQNeLSb7Czv
         ZpkSIhit1bCec9vwK1O92LKaEcWlRVt/o5J2bQl0=
Date:   Wed, 17 Jun 2020 19:29:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
Message-ID: <20200617135940.GU2324254@vkoul-mobl>
References: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
 <CAEkB2ET_gfNUAuoZHxiGWZX7d3CQaJYJJqS2Fspif5mFq4-xfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkB2ET_gfNUAuoZHxiGWZX7d3CQaJYJJqS2Fspif5mFq4-xfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-20, 14:17, Navid Emamdoost wrote:
> On Wed, Jun 3, 2020 at 1:52 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Calling pm_runtime_get_sync increments the counter even in case of
> > > failure, causing incorrect ref count. Call pm_runtime_put if
> > > pm_runtime_get_sync fails.
> >
> > Is it appropriate to copy a sentence from the change description
> > into the patch subject?
> >
> > How do you think about a wording variant like the following?
> Please stop proposing rewording on my patches!
> 
> I will consider updating my patches only if a maintainer asks for it.

Yeah ignore these :) no one takes this 'bot' seriously, it is annoying
yes :(

> >
> >    The PM runtime reference counter is generally incremented by a call of
> >    the function “pm_runtime_get_sync”.
> >    Thus call the function “pm_runtime_put” also in two error cases
> >    to keep the reference counting consistent.
> >
> >
> > Would you like to add the tag “Fixes” to the commit message?
> >
> > Regards,
> > Markus
> 
> 
> 
> -- 
> Navid.

-- 
~Vinod
