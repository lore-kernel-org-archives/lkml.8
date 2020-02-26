Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810BC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C021927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrFVsAm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBZDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:55:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=b9GoklgnCbBHf5t/4Fe+Ot/tCiL++5OMjYFP+RR2g9g=; b=qrFVsAm23D1fDlETZIofmLeeQS
        feBVizHCwTX1nnbUwL/7Hmm7M3nfQPnJ7BJV1FqaQSM3tRpv5GtQZJZToEW5LCJcQ8bp3KAscNe7Q
        klRvd4mI9EN41E/G3FYUUgfPv4CMLvKY7jHF4W5j+69ZYOSZNFnyUVWZMcpQagXq7FZ8h6ChoIE33
        MQcDpqYSvS9jKWtTw/GbgO9ORDvit/NAiK+TrOXJqfWB2E1I72f94ei78aprCJexhWCFHtFFSo00E
        eYX2mEp5nXybnWGeI2eAWWx+ySPdwFLA1YO5p4qOU0mPHCB3EXXQROQEujdJZ2hRloU6z66pudgpR
        9v2V/z/A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6nn0-0003zj-HH; Wed, 26 Feb 2020 03:55:14 +0000
Subject: Re: Linux Warning Report - 5.6-rc3
To:     Zzy Wysm <zzy@zzywysm.com>, linux-kernel@vger.kernel.org
References: <2BDD2716-BC2C-4DD8-B0B0-E33C56FAF0A5@zzywysm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8b4fc03d-72fa-e58f-9b3a-c02926c07aaa@infradead.org>
Date:   Tue, 25 Feb 2020 19:55:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2BDD2716-BC2C-4DD8-B0B0-E33C56FAF0A5@zzywysm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 4:17 PM, Zzy Wysm wrote:
> As of Linux 5.6-rc3, the defconfig still builds with 33 warnings.
> 
> Can we get it down to zero by the time 5.6 ships?
> 
> zzy
> 
> 
> zzy@esquivalience:~/linux-5.6-rc3$ make -j4 KCFLAGS="-Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers" > build_log_5.6-rc3


defconfig isn't very interesting IMO.  x86_64 allmodconfig has 1103 warnings
when using your KCFLAGS string.
(I am using gcc 7.5.0).  What version of gcc are you using?

-- 
~Randy

