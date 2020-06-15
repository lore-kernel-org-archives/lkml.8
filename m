Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F7F2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7zGJZ9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFOWao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:30:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CEFC061A0E;
        Mon, 15 Jun 2020 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZH82kEDnO4MMkOIjGxtV0H1o39gUn4nitjKfcLCk7bA=; b=N7zGJZ9ho6W/pZmaGsLZ5NOmPb
        pGTG510/UaeSqZd3M4FvHGLwMlBWsRjEMxyDHoGVJ/gojhscjSkotbiQEnM9RVR/pKiIMxd6NVSAD
        BuiA8MJFqJIt5xrtnB0SUk6jqPGGjKL2Ek0TucFtUjPx5Zxa3GG38wWGq1Mt9/YK8mR7ZVkZYAd75
        W9FhQRpaHr9iSDm73wrzGmsGVrCdbM2fT/unVxyZI7vj7HbUVOwMtcSUHO+SM0Na0XVRiyI/9ssK+
        fXivfpbLPxNTrRMslL0kE3gdxrmeJx4wKGAXto/08t3r0uTiKcRXPi+TXeUrzua+CTXrvDwqVeffs
        Xj6Zo/bw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkxcp-0000tN-9X; Mon, 15 Jun 2020 22:30:43 +0000
Subject: Re: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for value
To:     Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
 <159197539793.80267.10836787284189465765.stgit@devnote2>
 <20200615151139.5cc223fc@oasis.local.home>
 <7abefbc81fc6aaefed6bbd2117e7bc97b90babe9.camel@perches.com>
 <20200615172123.1fe77f3c@oasis.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ddb4adb9-bf01-abd4-38dd-d6d064569d6e@infradead.org>
Date:   Mon, 15 Jun 2020 15:30:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615172123.1fe77f3c@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 2:21 PM, Steven Rostedt wrote:
> On Mon, 15 Jun 2020 12:24:00 -0700
> Joe Perches <joe@perches.com> wrote:
> 
>>> Hmm, shouldn't the above have the upside-down xmas tree format?
>>>
>>> 	struct xbc_node *leaf, *vnode;
>>> 	char *key, *end = dst + size;
>>> 	const char *val;
>>> 	char q;
>>> 	int ret = 0;  
>>
>> Please don't infect kernel sources with that style oddity.
> 
> What do you mean? It's already "infected" all over the kernel, (has
> been for years!) and I kinda like it. It makes reading variables much
> easier on the eyes, and as I get older, that means a lot more ;-)

Yeah, there is some infection, more in some places than others,
but I agree with Joe -- it's not needed or wanted by some of us.


-- 
~Randy

