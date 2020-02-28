Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56691C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2430F246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfcRCBLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgB1EgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:36:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbgB1EgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=lTW94UBCUPJRu/vgnaOKmsgRovgXjQnsj+f3JMzvz1c=; b=IfcRCBLIneNu+5UXCSEUAv3LJW
        pVzVIiYsNQ9tvEhVY/XWyzm7EUzAJuy5FUvfEDbE1yY1tBcwrfSerN80p82gTFBLm5yv5FoIHveVU
        mdUXVyMOiVIavG0A/r2XN+BeRwY3POU2KmLP4niUcDhkGap1WrPpT8TUwoigO/zb2BYkgajKeLX+n
        Em9Lm6k9r5mySOlgTu64n2fbH4iyzgf8YlHOXhRET/OTHecmQnByFgtWe0+TJxwCeFTVv0LLdmrBt
        bmkgbeVh/nrvgJq80kf7eguuvTzwsSoD1AH2O3Y0bVP2Y+0aVQRyfBLN01feScl52e0LqGeyuc9Vc
        2KSGrHlQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7XNr-0008GL-6V; Fri, 28 Feb 2020 04:36:20 +0000
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
 <158278835238.14966.16157216423901327777.stgit@devnote2>
 <8514c830-319b-33e9-025a-79d399674fb3@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <130b7415-28b9-b95f-b0a4-3991b530571d@infradead.org>
Date:   Thu, 27 Feb 2020 20:36:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8514c830-319b-33e9-025a-79d399674fb3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 11:12 AM, Markus Elfring wrote:
> 
>> +The boot configuration syntax allows user to merge partially same word keys
>>  by brace. For example::
> 
> “by braces.
> For example::”?

It is fine as Masami has it IMO.

> 
> 
>> +The file /proc/bootconfig is a user-space interface to the configuration
> 
> “… is an user-…”?

No, "is a user-space" or "is a userspace" is good.


-- 
~Randy

