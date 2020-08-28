Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CCCC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2F920C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598603164;
	bh=WdYWw5ctDJ0/ykBhQKmTe27S1stgME3YFdISaWORMcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QyNoI7N2Lt87SuNOpSxOku/cihrSfPbmb047KhecVrOQeVm9JbWszzlO3LZLhJtUP
	 ozq2HmE5Nnzc2ESxd/xWnA+njRO+eWUIXHVA7e7kfnvJViR+OqHAXZ6NX2ZkfLQC0R
	 Q+C27jFNq3NzRwkAvWWIUBo2hMPV4GXCP6pKsIWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgH1I0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgH1IZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:25:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B18720776;
        Fri, 28 Aug 2020 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598603156;
        bh=WdYWw5ctDJ0/ykBhQKmTe27S1stgME3YFdISaWORMcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7UDHNOg5sNCngZRfay2tXeVctvwTshTSRj2sHv/xvr1Z+DgikCQs4hZGRsR+kEvN
         GNUfaDiOyztoLnIbmCm+wEnKaGQCpf8PDWoEFVXn5WFfhFKWQ4YLdY3p4SSnZoxCid
         jnKsPj5BF/XNL0Z0Tpo8KkGrsO0uGnOu8uaIcw8w=
Date:   Fri, 28 Aug 2020 10:26:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qiushi Wu <wu000273@umn.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: Some questions about the patching process
Message-ID: <20200828082608.GA1083216@kroah.com>
References: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
 <20200827182730.GA712693@kroah.com>
 <CAMV6ehEwaStF7Xvy-u4p+eU9C1UObCN8eVmuJmVZRFykROdnnw@mail.gmail.com>
 <20200828062042.GF56396@kroah.com>
 <CAMV6ehGwjKit-uOSv1=mRON6Sw6258Xyr8RB3bkLm0-wFymOng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMV6ehGwjKit-uOSv1=mRON6Sw6258Xyr8RB3bkLm0-wFymOng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:59:25AM -0500, Qiushi Wu wrote:
> Hi Greg,
> Thanks for your response!
> 
> > You responded in html format which got rejected by the public list,
> > please resend in text-only and I will be glad to reply.
> >
> Sorry about this!
> 
> 
> > > 1. Linux allows anyone to submit a patch because it is an open community.
> > >
> > And how is 1. a "risk"?
> 
> We are assuming the possibility of potential malicious commit contributors
> and want to reduce the risk of accepting vulnerable patches from them.

No, you are thinking about this all wrong.

ALL contributors make mistakes, you should not be treating anyone
different from anyone else.  I think I probably have contributed more
bugs than many contributors, does that make me a "malicious"
contributor?  Or just someone who contributes a lot?

So checking on patches needs to be done for everyone, right?

We have an idea of "trust" in kernel development, it's how we work so
well.  I don't trust people not that they will always get things
"correct", but rather that they will be around to fix it when they get
it "wrong", as everyone makes mistakes, we are all human.

So we trust people who we accept pull requests from, we don't review
their contributions because we trust that they did, and again, they will
fix it when it goes wrong.

> > > We would like to know if maintainers have some methods and tools (such as
> > > Smatch, Syzbot?) to mitigate these potential issues. We are happy to
> > > discuss these issues and hope our observations could raise some awareness
> > > of them.
> >
> > How do you "raise awareness" among a developer community that is 4000
> > people each year (1000 are new each year), consisting of 450+ different
> > companies?
> 
> Yes, this is a problem. Maybe people can summarize and pubic some security
> coding guidelines for different modules of the kernel, or recommend maintainers
> to use some bug detection tools to test the patches.

We do both today quite well, why do you think this is not the case?

> > And yes, we have lots of tools, and run them all the time on all of our
> > public trees constantly.  And they fix things before they get merged and
> > sent out to the rest of the world.
> >
> > So what specific things are you wanting to discuss here?
> 
> Specifically, we are curious about what kind of tools maintainers are often
> used to test potential bugs or vulnerabilities?

We use lots, everything we do is in the open, I suggest doing some
research first please.

> Also, can these tools have a
> high coverage rate to test corner cases like error-paths, indirect calls,
> concurrency issues, etc?

Since when does code coverage actually matter as a viable metric?

Look at the tools we use, again, it's all in the open, and tell us what
we could be doing differently by offering to help us implement those
tools into our workflows.  That would be the best way to contribute
here, don't you agree?

thanks,

greg k-h
