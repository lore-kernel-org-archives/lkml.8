Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9055206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHaR6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:58:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:44907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHaR6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:58:52 -0400
IronPort-SDR: g3/sF6cKjXD/hOrXzQXnRTN+qe5YIcOV1xDeG9sialCF2/SquNMhNiUmMZhFa3GMhZPSnF8uL0
 OJve9mkP+4pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144719159"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="144719159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:58:50 -0700
IronPort-SDR: fYOc4mV+5ZsEzMFn0EP2aUohQQtSKXvZuJG+9cu+/W7RFlO6aWwb2Jv32Ux4a9oUMKJEJEPtzb
 HzqZNid68gqA==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="338296641"
Received: from dgilroy-mobl.amr.corp.intel.com ([10.255.231.131])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 10:58:50 -0700
Date:   Mon, 31 Aug 2020 10:58:49 -0700 (PDT)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
X-X-Sender: mjmartin@dgilroy-mobl.amr.corp.intel.com
To:     Eric Curtin <ericcurtin17@gmail.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        fw@strlen.de, davem@davemloft.net, dcaratti@redhat.com,
        matthieu.baerts@tessares.net, pabeni@redhat.com
Subject: Re: Trying to run mptcp on my machine
In-Reply-To: <CANpvso7UExmwsRDvz_mkbYLT801bBzFcjMQiwtJZfhvn=L_7ww@mail.gmail.com>
Message-ID: <alpine.OSX.2.23.453.2008311046050.47885@dgilroy-mobl.amr.corp.intel.com>
References: <CANpvso7UExmwsRDvz_mkbYLT801bBzFcjMQiwtJZfhvn=L_7ww@mail.gmail.com>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Aug 2020, Eric Curtin wrote:

> Hi Guys,
>
> I've been trying to get mptcp up and running on my machine (xubuntu
> 20.04) with little joy. What I did was install 5,8,5 kernel from here:
>
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.5/amd64/
>
> Reboot, tried a curl:
>
> curl http://www.multipath-tcp.org
> Nay, Nay, Nay, your have an old computer that does not speak MPTCP.
> Shame on you!
>
> Checked this flag:
>
> sudo cat /proc/sys/net/mptcp/enabled
> 1
>
> Even tried to run this guy in the kernel repo with no joy
> mptcp_connect.sh. Any pointers to get mptcp running? I couldn't find
> too much documentation on how to configure it on GNU/Linux.

Hi Eric -

I think one helpful guide for you would be this recent post by Davide 
(dcaratti@redhat.com on the cc list):

https://developers.redhat.com/blog/2020/08/19/multipath-tcp-on-red-hat-enterprise-linux-8-3-from-0-to-1-subflows/

With curl, what you're seeing is that existing programs do continue to use 
regular TCP. The blog post has a section on one approach to making 
unmodified programs open sockets with IPPROTO_MPTCP.

The MPTCP upstream community has a mailing list at mptcp@lists.01.org and 
a wiki at https://github.com/multipath-tcp/mptcp_net-next/wiki - and we 
are working on more documentation with the kind of pointers you're looking 
for.

Thanks for trying out MPTCP!

--
Mat Martineau
Intel
