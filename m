Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69AC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E82469C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWLtHwF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgBMDjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:39:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgBMDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=yDdolUswAJYNM2gWe/nLDp8PNdbQD3zNmBP/DvRpack=; b=lWLtHwF2C5HK9/uJ/8yAl74lZp
        sqBpH8n6swsY6ICDjVBi6k0g+PAqOSzIX1SRQzHtihxmkS6Uk6spX/MDgUDT0jlRdzFJuEWn40gc2
        0nrgbZI8Ylqre20rN22E3ZAidwgk+Zj9pC7rH6tikcGAtq3f+XDS+HTJFkfegzZoKRIUWpbmtiPT3
        QQTEeum4FY+lcZpWBRRKvleANEpOK9UY11t+W+c5KuOpGBFYXJXEFaazpQdMFFGewa6N/PTKtgkBP
        dHL3pwxxETaIz7qtTD+O5r2BVjvchqMDDLLOmC/S1NrwmQeRQWcF3s+Ts38T7A1AO/S46Z7mZ/2ZV
        iQRRYbmQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j25LT-0001Dw-4n; Thu, 13 Feb 2020 03:39:19 +0000
Subject: Re: linux-next: Tree for Feb 12 (Documentation/hwmon/ltc2978.rst)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20200212135836.5b03e755@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4f6b763f-25ff-22f4-7ac4-527752840aa4@infradead.org>
Date:   Wed, 12 Feb 2020 19:39:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212135836.5b03e755@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 6:58 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200211:
> 

Hi Guenter,

The changes in linux-next to Documentation/hwmon/ltc2978.rst cause a Sphinx warning:

linux-next-20200212/Documentation/hwmon/ltc2978.rst:251: WARNING: Malformed table.
Text in column margin in table line 11.

The indentation in the table that begins around line 241 is all mucked up.
I prepared a patch but it looks like a (partial) revert is what is needed.

-- 
~Randy

