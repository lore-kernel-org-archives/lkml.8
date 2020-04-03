Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98212077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 03:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPL+2aKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbgDCDTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 23:19:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbgDCDT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 23:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=XOG9i9h9wH5BxflLkb8p29SJ7IjpaH/ZwyrboCrvU4s=; b=OPL+2aKLCcL2Zgkla4acmM2/4s
        yac1OCIcGgrXlupwIk5VwV2Z6N3GDvTU5N4dd2QkLp5RF5XrK2KjBTP+OiZ4avbuEynHNDxXBPQ1G
        GqYD09B+/WFVKQHccytBi2cF+6YhMn7e6+WvFC7g8CdFgcb7rHEjTbbiXsgmUv1wS0Fj5XhDRujFH
        mFYizEZWLR+xjYdyMYxWyTvpG4yG/dbtEOSry77davYwJS+YgK268mYhlBSIBR1Y+d9byTfvcmA7v
        1NyJbBCo6D5DoKfcr2wwjn1LvtoLV9KS/rl+oUHzcMeWSIlm0O1fCS+aup222Zm0CzzfQmYjZleMY
        cctpsQ6g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKCrf-0002eS-CN; Fri, 03 Apr 2020 03:19:27 +0000
Subject: Re: error fn f7 (asus)
To:     "jack_solovey@ngs.ru" <jack_solovey@ngs.ru>,
        linux-kernel@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
References: <625e12e1-aee0-8b3c-8a4d-98e74739153c@ngs.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3440f96b-291f-cd5e-7fc3-c3e9c0959f22@infradead.org>
Date:   Thu, 2 Apr 2020 20:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <625e12e1-aee0-8b3c-8a4d-98e74739153c@ngs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Cc's]

On 3/8/20 11:43 PM, jack_solovey@ngs.ru wrote:
> Hello, sorry this machine translation.
> 
> Laptop  Asus N56V
> Prior to kernel 5, the FN+F7 buttons turned off the laptop screen.
> Starting with kernel 5, these buttons turn on standby mode.
> I have to use core 4.18
> 
> Linux Asus-N56VB 4.18.0-25-generic #26~18.04.1-Ubuntu SMP Thu Jun 27 07:28:31 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> Whether it is planned to return the legacy function to the fn+f7 buttons to disable the main monitor.

Hi,

Possibly caused by 78f3ac76d9e5219589718b9e4733bee21627b3f5
(platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey).

-- 
~Randy

