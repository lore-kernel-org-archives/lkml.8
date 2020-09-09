Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C7B206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599666951;
	bh=VzOm3hbHGC38QpPnhgXXm5Exmh3fq0wV/ZdUr9+5gwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TSbAhCN2pgz6lS4JBg+TlwFEpegmr12h6x38xxXI3VCCT35d4DcomXXQ6eOOk8PzA
	 EfvyQV/AjB8cSNeyfQiwiDpd4HznRf4yawBgSOV1rw+FSCOADqQTxWwEPDAgN9QZ4P
	 Dqa15/+/G4DgelbSA5gk71EoBHDwMCx0Pg/7mRlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgIIPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgIIPwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:52:07 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4003E20639;
        Wed,  9 Sep 2020 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599666725;
        bh=VzOm3hbHGC38QpPnhgXXm5Exmh3fq0wV/ZdUr9+5gwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IJNX8/5fZjHHkVRxVgRvSGV5uqM4kzI2NYrjXr8Ptyg5Z/iTi9mf/UQTcq382G1mJ
         Tl+NCFKfrdmbL9vcvP6Y/NMwCBfgH2n8M0NqAEBKg/51xjdNOSairGIba3K8aD5aSB
         tGVeua677ZoeNPrC/GdItDe3IsGnG1S02StSSx5E=
Date:   Wed, 9 Sep 2020 08:52:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     syzbot <syzbot+8267241609ae8c23b248@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Subject: Re: INFO: rcu detected stall in cleanup_net (4)
Message-ID: <20200909085203.5e335c61@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <000000000000db78de05aedabb5a@google.com>
References: <000000000000db78de05aedabb5a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Sep 2020 22:29:21 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12edb935900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
> dashboard link: https://syzkaller.appspot.com/bug?extid=8267241609ae8c23b248
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c7aa5900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c92ef9900000
> 
> The issue was bisected to:
> 
> commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Date:   Sat Sep 29 00:59:43 2018 +0000
> 
>     tc: Add support for configuring the taprio scheduler


Vinicius, could you please take a look at all the syzbot reports which
point to your commit? I know syzbot bisection is not super reliable,
but at least 3 reports point to your commit now, so something's
probably going on.
