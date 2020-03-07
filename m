Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D96FC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0695E206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhWWEw12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCGASL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:18:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCGASL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=fH7qPDX1r1WZFTF4wTmTa48BQqrtV6tetqMZ9bdxdZA=; b=DhWWEw12IXDRLSgTiPWgAMdM7R
        jfMBzmO0YLP2fNwFk1HfOmPrW2y05We9ANYWoEWN7J1L0xIGDLKDzGL2+uIwPOIxcQSog+j//QRkF
        IcMNMbUEcvKUTJ54bNLbjVN9yMlt9XUP81e8dz0NmE4mX6N7VTQgCH90XFcUGsNS6N/DRxj9OfVRX
        PZKO1UdAfMuRkngUUqMQqM/Lv8i7jJqiUBitoKMsPXFve2QJJWllq6l9+nGNwXqd7Gqvp3QhS5N42
        K92rb7FJtMFQJn9PX+zOFzt5zKxAZcqyEGVZUilcSsTwJV1z2BtSlphdNvpNVZlpjaCXJ7Yf0Di3g
        oxcQNpxQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jANAQ-0006jJ-RG; Sat, 07 Mar 2020 00:18:10 +0000
Subject: Re: kselftest selftest issues and clarifications
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <MWHPR13MB0895B92C9B4807D94E1E6B04FDE30@MWHPR13MB0895.namprd13.prod.outlook.com>
 <f1f991a6-6e05-6ba3-b5c1-174b93029a99@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <818d8b84-4ce2-4cbd-d561-293137c5d884@infradead.org>
Date:   Fri, 6 Mar 2020 16:18:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f1f991a6-6e05-6ba3-b5c1-174b93029a99@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 3:30 PM, Shuah Khan wrote:
>>
>> And I'm using a KBUILD_OUTPUT environment variable, rather than O=.
>> Let me know if you'd like me to build a matrix of these different build methods.
>>
> 
> This is fine. Please note that relative paths don't work in both of
> these. Something I will tackle once the bugger problems are addressed.

Please see/test/try this patch:

https://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2/


-- 
~Randy

