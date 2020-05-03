Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0A2C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 09:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74FB2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 09:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="rSr4Yf2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgECJPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 05:15:16 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:58858 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgECJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 05:15:16 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 34D1518CB; Sun,  3 May 2020 11:15:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 34D1518CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588497313;
        bh=yfcoX/+hpJsCO5PGGQP4+W0+BM8RubmIhakYFRtOT9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSr4Yf2mT8SIa81KMwMR4sbV4w9ZAZZna6/qoJXBdc/YITI40wMN0f96Vl1ONQCwK
         L00kbcSzRZLfEiVL1lr+fGFX8aBGSu8CZkh91mBv9xfUTdm1YQYxqN8X5uAQL1TCDY
         kJW+RIK5UJtJpZUTFtYju+nCA+WJjVd/iNFZuBRU=
Date:   Sun, 3 May 2020 11:15:13 +0200
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Subject: Re: [PATCH 2/2] staging: vt6655: fix LONG_LINE warning
Message-ID: <20200503091513.GA8308@new.kocurkovo.cz>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
References: <1588457794-31438-1-git-send-email-mdujava@kocurkovo.cz>
 <1588457794-31438-2-git-send-email-mdujava@kocurkovo.cz>
 <e5166009d549f42b75e8d764bc9078538ce0ce4a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e5166009d549f42b75e8d764bc9078538ce0ce4a.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:11:43PM -0700, Joe Perches wrote:
>On Sun, 2020-05-03 at 00:16 +0200, Matej Dujava wrote:
>> This patch will fix LONG_LINE error from checkpatch, by createing temporary
>> variable so call to the function is not in if/else block.
>[]
>> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
>[]

Sorry, am I missing something here?

>> @@ -164,16 +164,24 @@ s_uGetTxRsvTime(
>>  )
>>  {
>>  	unsigned int uDataTime, uAckTime;
>> +	unsigned short basic_rate;
>>
>>  	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
>>
>>  	if (!bNeedAck)
>>  		return uDataTime;
>>
>> -	if (byPktType == PK_TYPE_11B) /* llb,CCK mode */
>> -		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopCCKBasicRate);
>> -	else /* 11g 2.4G OFDM mode & 11a 5G OFDM mode */
>> -		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopOFDMBasicRate);
>> +	/*
>> +	 * CCK mode  - 11b
>> +	 * OFDM mode - 11g 2.4G & 11a 5G
>> +	 */
>> +	if (byPktType == PK_TYPE_11B)
>> +		basic_rate = (unsigned short)pDevice->byTopCCKBasicRate;
>> +	else
>> +		basic_rate = (unsigned short)pDevice->byTopOFDMBasicRate;
>> +
>> +	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
>> +				     basic_rate);
>>
>>  	return uDataTime + pDevice->uSIFS + uAckTime;
>>  }
>
>perhaps simpler using a ?:
>
>	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
>				     byPktType == PK_TYPE_11B
>				     ? pDevice->byTopCCKBasicRate
>				     : pDevice->byTopOFDMBasicRate);
>
>the casts aren't necessary either as both by... fields are u8

Thank you, will resend my patch.

>
>
