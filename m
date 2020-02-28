Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D6246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZ4sdpH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgB1EZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:25:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgB1EZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FZyq9RtrT4u+zuNv6V7ds6STmcCI+bN5Z0lCFYKkYuM=; b=KZ4sdpH9I1BHewo1HRq1+8K9zD
        BtpWcAohm5dQ6qY8syRZ+RgwgLWBPfZrEDEPZHYDiSSK/zjXTPVl4pLPefzsBODjb8yBTal4NragM
        dFwgJksfP69hUJaK04308ZdX1iVXORDXr/XrS8jG7DgW8xShqTZlfw2rtDOXA77hkaQ8Em5pAq3Xr
        R8fymlIhQFAzXxjOdzgneOVpb02LvZGBNR8sfABCgVimmu5gIgNmpFGYPfnJUHLUgmgrf+khUKLbu
        LXLZFRP9hQxtnfWSyzc71q2prs5uIBAJ9X6xiEKszNYjoj9v2XbyJ7zOBMLdfcf5WOrc0i1vGOYXK
        +mi40Pxw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7XCy-0003be-9f; Fri, 28 Feb 2020 04:25:04 +0000
Subject: Re: [PATCH] of: unittest: make gpio overlay test dependent on
 CONFIG_OF_GPIO
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
References: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce8c2ef5-5402-6f1e-890a-1832610d8b0d@infradead.org>
Date:   Thu, 27 Feb 2020 20:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582863389-3118-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 8:16 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Randconfig testing found compile errors in drivers/of/unittest.c if
> CONFIG_GPIOLIB is not set because CONFIG_OF_GPIO depends on
> CONFIG_GPIOLIB.  Make the gpio overlay test depend on CONFIG_OF_GPIO.
> 
> No code is modified, it is only moved to a different location and
> protected with #ifdef CONFIG_OF_GPIO.  An empty
> of_unittest_overlay_gpio() is added in the #else.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 465 ++++++++++++++++++++++++++------------------------
>  1 file changed, 238 insertions(+), 227 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy

