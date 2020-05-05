Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E9C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FED206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tU1r3Lxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgEEOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:25:03 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:1111 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgEEOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588688701; x=1620224701;
  h=from:to:cc:date:message-id:in-reply-to:mime-version:
   subject;
  bh=ojTidh3cJPjzb7MTzavDHG/Iog3Nq7tt/PoUVo4tNM0=;
  b=tU1r3LxnO0+ug1AGRvb9Zj1USBa2ddk2a6WFEfNM3hYDMxz2gcjeaeu6
   S9WX+ETK5PKqjQvowSr4RtVHZwTjTacNovUKfhrNRZgSVur9S3kX+1f0q
   veZadMLpYQPDgLlKA+AqEqcuzvYqrMTkQEgf77sFH0PxKqi+oJTzRK7D5
   o=;
IronPort-SDR: qzP7/t0VQlCoEyHgzMOm+FcDazZKa7SPTsfmnaMXRlnRnktZMFZmGGERqIkjMST9Px+8lduc8D
 Ik2kaMA9VG2A==
X-IronPort-AV: E=Sophos;i="5.73,355,1583193600"; 
   d="scan'208";a="42794246"
Subject: Re: RE: [PATCH net 0/2] Revert the 'socket_alloc' life cycle change
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 May 2020 14:24:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id B47FFA2318;
        Tue,  5 May 2020 14:24:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 14:24:58 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 14:24:52 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     SeongJae Park <sjpark@amazon.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <gregkh@linuxfoundation.org>,
        <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Date:   Tue, 5 May 2020 16:24:37 +0200
Message-ID: <20200505142437.22822-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505124442.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D01UWA001.ant.amazon.com (10.43.160.60) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 13:44:42 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> CAUTION: This email originated from outside of the organization. Do not cli=
> ck links or open attachments unless you can confirm the sender and know the=
>  content is safe.
> 
> 
> 
> On Tue, May 05, 2020 at 09:28:39AM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > The commit 6d7855c54e1e ("sockfs: switch to ->free_inode()") made the
> > deallocation of 'socket_alloc' to be done asynchronously using RCU, as
> > same to 'sock.wq'.  And the following commit 333f7909a857 ("coallocate
> > socket_sq with socket itself") made those to have same life cycle.
> >
> > The changes made the code much more simple, but also made 'socket_alloc'
> > live longer than before.  For the reason, user programs intensively
> > repeating allocations and deallocations of sockets could cause memory
> > pressure on recent kernels.
> >
> > To avoid the problem, this commit reverts the changes.
> 
> Is it "could cause" or is it "have been actually observed to"?

Actually observed.  Sorry for lack of that explanation.  Could you please refer
to this link?
https://lore.kernel.org/netdev/20200505115402.25768-1-sjpark@amazon.com/


Thanks,
SeongJae Park
