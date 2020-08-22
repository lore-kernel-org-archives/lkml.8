Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEEC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77072080D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHVVDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:03:37 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:47968 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727005AbgHVVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:03:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 18045180101ED;
        Sat, 22 Aug 2020 21:03:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drum98_630e40427045
X-Filterd-Recvd-Size: 1615
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Aug 2020 21:03:32 +0000 (UTC)
Message-ID: <b3be3e91364781dc5211ef99dec6d9649076b701.camel@perches.com>
Subject: Re: [PATCH net-next] net: Remove unnecessary intermediate variables
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     Jianlin.Lv@arm.com, netdev@vger.kernel.org, kuba@kernel.org,
        Song.Zhu@arm.com, linux-kernel@vger.kernel.org
Date:   Sat, 22 Aug 2020 14:03:31 -0700
In-Reply-To: <20200822.135941.1718174258763815012.davem@davemloft.net>
References: <20200822020431.125732-1-Jianlin.Lv@arm.com>
         <20200822.123315.787815838209253525.davem@davemloft.net>
         <ae154f9a96a710157f9b402ba21c6888c855dd1e.camel@perches.com>
         <20200822.135941.1718174258763815012.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 13:59 -0700, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Sat, 22 Aug 2020 13:39:28 -0700
> 
> > It _might_ be slightly faster to use inlines
> 
> We are not using the inline directive in foo.c files and are letting
> the compiler decide.
> 
> Please don't give out advice like this.

Actually, I checked with and without inline
before posting the proposal.

The compiler didn't inline the code without it.
Not even with just static inline.
For gcc 9.3 only the __always_inline did.
That's the only version I checked.



