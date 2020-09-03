Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5FC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FAF2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599152572;
	bh=S5GznL+HUXa0px3F6rIqo1KWGR2wrWuJLt1BiGDgm88=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=R3qUdRV4lZlVlCMYlMI25G/hjn+DsAPuEIGGyCIm4hf0sDyFXM7IeydS858H3pyug
	 pkUujS614EdTeHJg8BwJCYOVNWZwpQrDEFxWWJS7YaCiML+Ng1sgOGY+vtqnXF7bWd
	 Hwuk9R3/0HC2c8u+OKVhwGVHPgS+rGv0kUBebGKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgICRCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:02:50 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C0D20758;
        Thu,  3 Sep 2020 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599152570;
        bh=S5GznL+HUXa0px3F6rIqo1KWGR2wrWuJLt1BiGDgm88=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZdUnKKoSXP+4UtxOZdbtj62/VBQszlhNCH0MfC2Zq/JoMjqRSZ4S79z5O1JJW2hPv
         wOP0RG9nEr7AsjeE4+dUvcd99GSO321F26NUES+27OboMW/sdid5lHjVvK8+cjoXQW
         2yF6huEV98u1b0T8/Wf1wVFkRwbejy856K7QhBcw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 172B4352300A; Thu,  3 Sep 2020 10:02:50 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:02:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sjpark@amazon.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the jc_docs tree
Message-ID: <20200903170250.GQ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200902143101.4ea59943@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902143101.4ea59943@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:31:01PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   Documentation/memory-barriers.txt
> 
> between commit:
> 
>   537f3a7cf48e ("docs/memory-barriers.txt: Fix references for DMA*.txt files")
> 
> from the jc_docs tree and commit:
> 
>   6f6705147bab ("docs: fix references for DMA*.txt files")
> 
> from the rcu tree.
> 
> I fixed it up (they are preety much the same - I used the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

I removed my copy, and if testing goes well, it should get to you in a
few hours.

							Thanx, Paul
