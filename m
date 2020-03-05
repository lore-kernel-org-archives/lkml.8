Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F3CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAC2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ez62A0YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCESjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:39:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCESjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=M6vTzTe4xnlnvoinOU2S0M2cXZtLs7RQd9tRNZ5w7ZA=; b=Ez62A0YYueTD5jhpOxTpm18Xc+
        pRK9D1LxkHmMOdaOZ68YJ2AVEyf0FK4IA6hFwnYHj6MMIuCQLtSOCg588u8BvMcp8ViSx7FC9ePzi
        aGEe0uDTJ/aX6BrsAvxCmIlBjirVbqHEriGONzwBnrcQ0lMpizV9OLDWfjxzIB/Z9koJoXo/jOZm6
        FpHH6MzJFT1aCAX1HquOBP8wjPaFoUSETuE00ZIUmxOdoJC6s0Tfrbaxa1DFpcgKsqgmbOItuI3U/
        uSz9qnprfWvjc3WGCHZrTacuOxLkIBHITeVWdv72Lohk0ZGWVU0RyX5oQcaucPrperpkt/SJXeQOK
        3iPLA+5Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9vOo-0000Md-ND; Thu, 05 Mar 2020 18:39:10 +0000
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
Date:   Thu, 5 Mar 2020 10:39:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 9:56 AM, Markus Elfring wrote:
>> If you would (could) be more concrete (or discrete) in your suggestions,
>> I would be glad to comment on them.
> 
> Does this view indicate any communication difficulties?

Probably.

> Which of the possibly unanswered issues do you find not concrete enough so far?

e.g.:
>>>  Will the clarification become more constructive for remaining challenges?


-- 
~Randy

