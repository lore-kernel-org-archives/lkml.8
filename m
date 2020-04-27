Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24C3C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA8214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="i7mq7G6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD0S0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:26:05 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.100]:25436 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgD0S0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:26:05 -0400
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 14:26:03 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 25E897F37
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:05:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T88Ejdc6LAGTXT88EjwSjh; Mon, 27 Apr 2020 13:05:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YO/ZEFUeNMND48D5WMalVPzLhs8hz8EAhwiXufKHxFs=; b=i7mq7G6xxay3QoEF1EVwXZR1CU
        H6BWBRMRa8Z7USHKcjMhyeRwzSrFKRsexH4IAQOLFn9ybt2wzxuuiaiWdxGQ/5xBn1QiIRvIs/uil
        Zuxlbv+naVuDTpbuoa+sOS6pY9cQhWpoY1XazaTqSiPv3kYEFdo3q8n+SNa7OnztIs3lDwgRJFYIj
        x60NBj2UQDZ2wmqR6YIUdQYNHbrlSV6ONFAhU+dsaF938aJRGleQtz9MYEKFHk98lOcqpjPDFB4GL
        az4cXljIYSDb94/+ixqAI22YIERpmDZ8l3yVVFlTvGAtQf2be8+FkZ60GByHN0DbrbBerh3tTBw9p
        6ALqZCeQ==;
Received: from [201.162.241.110] (port=24934 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT88D-000BBs-Nk; Mon, 27 Apr 2020 13:05:25 -0500
Subject: Re: [RFC PATCH] mtd: lpddr: Fix bad logic in print_drs_error
To:     Joe Perches <joe@perches.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <2e19547dcec386b47923211896f43053b60ebc60.camel@perches.com>
 <20200427152913.47a48b46@xps13>
 <e2c8b5ea654600ac36949f8f0621913ceaf96ddc.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <ec299851-687c-ee15-2d1c-18687588b74a@embeddedor.com>
Date:   Mon, 27 Apr 2020 13:09:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e2c8b5ea654600ac36949f8f0621913ceaf96ddc.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT88D-000BBs-Nk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [201.162.241.110]:24934
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that this fix should be tagged for -stable.

I can create a three-patch series for this (as Miquel suggested), starting
with the patch that fix the wrong condition, so it can be ported to
-stable, separately.

I'll include you Reported-by, Joe.

Thanks
--
Gustavo

On 4/27/20 12:33, Joe Perches wrote:
> On Mon, 2020-04-27 at 15:29 +0200, Miquel Raynal wrote:
>> Hi Joe,
> 
> Hello Miquel.
> 
>> Joe Perches <joe@perches.com> wrote on Mon, 30 Mar 2020 12:56:59 -0700:
>>
>>> Update logic for broken test.
>>> Use a more common logging style.
>>>
>>> Miscellanea:
>>>
>>> o Coalesce formats
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>> ---
>>>
>>> Found by inspection of include files using printk.
>>>
>>> It appears the logic in this function is broken for the
>>> consecutive tests of
>>>
>>> 	if (prog_status & 0x3)
>>> 		...
>>> 	else if (prog_status & 0x2)
>>> 		...
>>> 	else (prog_status & 0x1)
>>> 		...
>>>
>>> Likely the first test should be
>>>
>>> 	if ((prog_status & 0x3) == 0x3)
>>
>> I had a hard time understanding the patch just with the commit log, I
>> think the above text is as important.
>>
>> In fact, would you mind doing the printk->pr_notice in a first patch,
>> and fix the wrong condition in a separate change?
>>
>>> And this function is only used in drivers/mtd/lpddr/lpddr_cmds.c
>>> perhaps it should be moved there.
>>
>> Agreed, do not hesitate to move the function as suggested in a third
>> patch.
> 
> You are the maintainer here no?
> 
> I think you (or perhaps the author Alexey Korolev but he hasn't
> been active in a decade) should be doing all this.
> 
> I just identified the logic defect.
> 
>>>  include/linux/mtd/pfow.h | 31 ++++++++++++++-----------------
>>>  1 file changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
>>> index 122f343..1c08e75 100644
>>> --- a/include/linux/mtd/pfow.h
>>> +++ b/include/linux/mtd/pfow.h
>>> @@ -127,31 +127,28 @@ static inline void print_drs_error(unsigned dsr)
>>>  	int prog_status = (dsr & DSR_RPS) >> 8;
>>>  
>>>  	if (!(dsr & DSR_AVAILABLE))
>>> -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
>>> -	if (prog_status & 0x03)
>>> -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
>>> -						"half with 41h command\n");
>>> +		pr_notice("DSR.15: (0) Device not Available\n");
>>> +
>>> +	if ((prog_status & 0x03) == 0x03)
>>> +		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
>>>  	else if (prog_status & 0x02)
>>> -		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
>>> -					"in region with Control Mode data\n");
>>> +		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
>>>  	else if (prog_status &  0x01)
>>> -		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
>>> -						"with Object Mode data\n");
>>> +		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
>>> +
>>>  	if (!(dsr & DSR_READY_STATUS))
>>> -		printk(KERN_NOTICE"DSR.7: (0) Device is Busy\n");
>>> +		pr_notice("DSR.7: (0) Device is Busy\n");
>>>  	if (dsr & DSR_ESS)
>>> -		printk(KERN_NOTICE"DSR.6: (1) Erase Suspended\n");
>>> +		pr_notice("DSR.6: (1) Erase Suspended\n");
>>>  	if (dsr & DSR_ERASE_STATUS)
>>> -		printk(KERN_NOTICE"DSR.5: (1) Erase/Blank check error\n");
>>> +		pr_notice("DSR.5: (1) Erase/Blank check error\n");
>>>  	if (dsr & DSR_PROGRAM_STATUS)
>>> -		printk(KERN_NOTICE"DSR.4: (1) Program Error\n");
>>> +		pr_notice("DSR.4: (1) Program Error\n");
>>>  	if (dsr & DSR_VPPS)
>>> -		printk(KERN_NOTICE"DSR.3: (1) Vpp low detect, operation "
>>> -					"aborted\n");
>>> +		pr_notice("DSR.3: (1) Vpp low detect, operation aborted\n");
>>>  	if (dsr & DSR_PSS)
>>> -		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
>>> +		pr_notice("DSR.2: (1) Program suspended\n");
>>>  	if (dsr & DSR_DPS)
>>> -		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
>>> -					"on locked block\n");
>>> +		pr_notice("DSR.1: (1) Aborted Erase/Program attempt on locked block\n");
>>>  }
>>>  #endif /* __LINUX_MTD_PFOW_H */
>>>
>>>
>>
>> Thanks,
>> Miquèl
> 
