Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8742087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598552840;
	bh=MxFjZJl44WMADt2iCSk3kahBaMEHIGUpHooEjyGWgq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oF24jnajgr6ZHPWjeJ1shxsO+Es0g4ql52hrimhHh7OVnrenrng82Zn5lC09bNhyi
	 x1OwGiV28NLQDT8B3Rdd2Cxcm1d/wpsrbhMifdxSY5WUX0GFvzafMNSiLZwMzcVx0Y
	 5A5tCD6PSNZoR4dnTM78h1bmpS5WOr7d1opUe51k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0S1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgH0S1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:27:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215112087C;
        Thu, 27 Aug 2020 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598552837;
        bh=MxFjZJl44WMADt2iCSk3kahBaMEHIGUpHooEjyGWgq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKOMproJ+l39sqPi+pOm9qQu1lnaxUtB0ssNz/oDYhNHHE3w+PbSL1ZxXLMJvfKTU
         lSv8dj/mXGRAZAIFxbYhVKmnyObGyFm01S5k6NBlGlkgV6nILJb7s1lLCBwuGWrrN6
         P4HXqMLqGyhIPm/hLWuxSGh34/BSCNfKWSIGuYuQ=
Date:   Thu, 27 Aug 2020 20:27:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qiushi Wu <wu000273@umn.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Some questions about the patching process
Message-ID: <20200827182730.GA712693@kroah.com>
References: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:34:57PM -0500, Qiushi Wu wrote:
> Dear Linux maintainers:
> 
> I'm Qiushi Wu, a Ph.D. student from the secure and reliable systems
> research group at the University of Minnesota. Our group strives to improve
> the security and reliability of the Linux kernel and has contributed quite
> a number of patches. We appreciate the openness of the Linux community, but
> would also like to discuss some questions about the patching process. It
> would be great if you could let us know your thoughts.
> 
> We recently found that minor patches such as one fixing a memory leak may
> introduce more critical security bugs like double free. Sometimes the
> maintainers can capture the introduced security bugs, sometimes not. This
> is understandable because the introduced bugs can be subtle and hard to
> catch due to the complexity. We are more concerned when “bad” submitters
> intentionally and stealthily introduce such security bugs via seemingly
> good patches, as they indeed have a chance to get the actually bad patches
> accepted. This is not impossible because people have incentives---to plant
> a vulnerability in a targeted driver, to get bounty rewards, etc.
> 
> Based on our patching experience, we observe several things related to the
> risks.
> 
> 1. Linux allows anyone to submit a patch because it is an open community.
> 
> 2. Maintainers tend to not accept preventive patches, i.e., a patch for a
> bug that is not really there yet, but it can be likely formed in the
> future.

How can you create a patch to prevent a bug that is not present?

But no, this is not true, look at all of the kernel hardening features
added to the kernel over the past 5+ years.  Those are specifically to
help handle the problem when there are bugs in the kernel, so that "bad
things" do not happen when they occur.

> 3. The patch review is mainly manual, so sometimes the introduced security
> bugs could be missed.

We are human, no development process can prevent this.

> We would like to know how the Linux maintainers think about these risks.

I think 2. is wrong, so it's not a risk.

And how is 1. a "risk"?

And of course, 3., humans, well, what can you do about them?  :)

> We
> would like to know if maintainers have some methods and tools (such as
> Smatch, Syzbot?) to mitigate these potential issues. We are happy to
> discuss these issues and hope our observations could raise some awareness
> of them.

How do you "raise awareness" among a developer community that is 4000
people each year (1000 are new each year), consisting of 450+ different
companies?

And yes, we have lots of tools, and run them all the time on all of our
public trees constantly.  And they fix things before they get merged and
sent out to the rest of the world.

So what specific things are you wanting to discuss here?

thanks,

greg k-h
