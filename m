Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D791C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4626D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgGaIsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:48:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42996
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731648AbgGaIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:48:09 -0400
X-IronPort-AV: E=Sophos;i="5.75,417,1589234400"; 
   d="scan'208";a="355689753"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 10:48:07 +0200
Date:   Fri, 31 Jul 2020 10:48:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH v4] coccinelle: api: add kvfree script
In-Reply-To: <dda490e5-35c8-f097-af2a-e42e7ba21ae0@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007311045490.2439@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200730140751.8635-1-efremov@linux.com> <alpine.DEB.2.22.394.2007302235000.2548@hadrien> <dda490e5-35c8-f097-af2a-e42e7ba21ae0@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Do the checks for the opportunities for kvmalloc really belong in this
> > rule?  That issue is not mentioned in the commit log or the description of
> > the semantic patch.
>
> I added this at the last moment. It was easy enough to add it based on existing
> patterns. I will add description for this warnings. Or do you want me to single
> out this warning to a separate rule?

It seems like a different issue.  A separate rule might be better.  Also,
there is no patch variant, so if one runs the patch mode on this script,
where the patch mode is useful, then one will miss the kvmalloc
suggestions completely.  Coccicheck has a mode where is first tries patch
and then report; I think 0-day uses this.

julia
