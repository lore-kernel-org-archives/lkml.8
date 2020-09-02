Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE5C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F67207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="aMnt9GgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIBRHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:07:20 -0400
Received: from mx4.wp.pl ([212.77.101.11]:19387 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:07:19 -0400
Received: (wp-smtpd smtp.wp.pl 26334 invoked from network); 2 Sep 2020 19:07:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1599066435; bh=xLtgJOPrL3YCDxm2GC4sjGv1t6OcXxeRsL5vC9/BygE=;
          h=Subject:To:Cc:From;
          b=aMnt9GgTmjxjQ055lVFx4ljD8w3szBanRD+4tgF+j5h/xuyEZmEQeAK5JR4LGIEPd
           8vUC47ZduHt0I9C6YYEeZLI0VwglgyHcbuBIa0LLq0BE9jqeSStO32tHpJJAJKA82i
           msxD3ye6EV/H0FZHJtRsM+QAHkUnNtZHi/Sf1a3U=
Received: from 188.146.102.178.nat.umts.dynamic.t-mobile.pl (HELO [192.168.1.110]) (antoni.przybylik@wp.pl@[188.146.102.178])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 2 Sep 2020 19:07:15 +0200
Subject: Re: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a
 function
To:     Randy Dunlap <rdunlap@infradead.org>
References: <20200902161627.64686-1-antoni.przybylik@wp.pl>
 <14c3b5c1-a5d8-3843-6538-5f76c4b8d6df@infradead.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From:   "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
Message-ID: <eb24f7d2-0460-dd3b-1ab3-a9748fa193fe@wp.pl>
Date:   Wed, 2 Sep 2020 19:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <14c3b5c1-a5d8-3843-6538-5f76c4b8d6df@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WP-MailID: 1a2205470018b49782a34339a2a5f8d5
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [gRN0]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2020 18:21, Randy Dunlap wrote:
> On 9/2/20 9:16 AM, Antoni Przybylik wrote:
>> Changed return type to bool and removed inline specifier. Also added
>>   static specifier.
> why remove the inline specifier?

Greg KH wrote to me:

And really, no need to make it inline, just make it a normal function
and the compiler will inline it if needed.

> thanks.
>
>> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
>> ---
>>   drivers/staging/gdm724x/gdm_tty.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
>> index 34a13d98c029..179fc9b9400b 100644
>> --- a/drivers/staging/gdm724x/gdm_tty.c
>> +++ b/drivers/staging/gdm724x/gdm_tty.c
>> @@ -34,7 +34,7 @@ static DEFINE_MUTEX(gdm_table_lock);
>>   static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>>   static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>>   
>> -inline int gdm_tty_ready(struct gdm *gdm)
>> +static bool gdm_tty_ready(struct gdm *gdm)
>>   {
>>   	return (gdm && gdm->tty_dev && gdm->port.count);
>>   }
>>
>
Antoni Przybylik
