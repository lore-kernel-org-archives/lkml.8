Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADDC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BA6217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBEQHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:07:46 -0500
Received: from nautica.notk.org ([91.121.71.147]:32879 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:07:45 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 738DAC009; Wed,  5 Feb 2020 17:07:44 +0100 (CET)
Date:   Wed, 5 Feb 2020 17:07:29 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     l29ah@cock.li
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9pnet: allow making incomplete read requests
Message-ID: <20200205160729.GA10862@nautica>
References: <20200205003457.24340-1-l29ah@cock.li>
 <20200205073504.GA16626@nautica>
 <20200205154829.wbgdp2r4gslnozpa@l29ah-x201.l29ah-x201>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205154829.wbgdp2r4gslnozpa@l29ah-x201.l29ah-x201>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l29ah@cock.li wrote on Wed, Feb 05, 2020:
> On Wed, Feb 05, 2020 at 08:35:04AM +0100, Dominique Martinet wrote:
> > I'm not sure I agree on the argument there: the waiting time is
> > unbounded for a single request as well. What's your use case?
> 
> I want to interface with synthetic file systems that represent
> arbitrary data streams.
> The one where i've hit the problem is reading the log of a XMPP chat
> client that blocks if there's no new data available.

Definitely a valid use case for 9p, please rephrase your commit message
to describe the problem a bit better.

I'll wait for a v2 removing the 'total' variable from
p9_client_read_once anyway, unless you disagree.


Thanks,
-- 
Dominique
