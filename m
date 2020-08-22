Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94557C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762D1207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgHVVUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:20:35 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:48234 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728750AbgHVVUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:20:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0C932181D341E;
        Sat, 22 Aug 2020 21:20:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rat62_2114dd627045
X-Filterd-Recvd-Size: 1723
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Aug 2020 21:20:31 +0000 (UTC)
Message-ID: <979bf21913a57f4f402fbd859891907a6ada6209.camel@perches.com>
Subject: Re: [PATCH net-next] net: Remove unnecessary intermediate variables
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>
Cc:     Jianlin.Lv@arm.com, netdev@vger.kernel.org, kuba@kernel.org,
        Song.Zhu@arm.com, linux-kernel@vger.kernel.org
Date:   Sat, 22 Aug 2020 14:20:30 -0700
In-Reply-To: <20200822.140758.1768310758210192749.davem@davemloft.net>
References: <ae154f9a96a710157f9b402ba21c6888c855dd1e.camel@perches.com>
         <20200822.135941.1718174258763815012.davem@davemloft.net>
         <b3be3e91364781dc5211ef99dec6d9649076b701.camel@perches.com>
         <20200822.140758.1768310758210192749.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 14:07 -0700, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Sat, 22 Aug 2020 14:03:31 -0700
> 
> > The compiler didn't inline the code without it.
> 
> Then the compiler had a good reason for doing so,

The "good" word choice there is slightly dubious.
Compilers make bad decisions all the time.

> or it's a compiler bug that should be reported.

<shrug>

Or just behavioral changes between versions, or
even just random compiler decisions that causes
known unrepeatable compilation output.

That happens all the time.

If you want it just as static without the
inline/__always_inline marking, let me know.


