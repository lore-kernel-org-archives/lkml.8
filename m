Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3832071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="fqhlyouj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgIAUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:31:43 -0400
Received: from mx3.wp.pl ([212.77.101.9]:53676 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgIAUbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:31:42 -0400
Received: (wp-smtpd smtp.wp.pl 4693 invoked from network); 1 Sep 2020 22:31:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1598992298; bh=8yqYvUMKqSXk/Clt3FRpjdGUhFpqCSV3vm/nqSmI+Xs=;
          h=Subject:To:From:Cc;
          b=fqhlyouj79/pAIYv7HLX7zrxmo9deFClN1Jp4M+0doIQoSuFEKr5UVitfOKUJSclt
           WHRwjK1q933XXxeD0SQCINErmXVLbx3Dz8c5PZLm1swF46HRcoNmxkKMZIo9ADBMEQ
           ydwOXd99/k0QUkUbaVkyHii2PrH81z6Iu5yof3jI=
Received: from 188.146.102.178.nat.umts.dynamic.t-mobile.pl (HELO [192.168.1.110]) (antoni.przybylik@wp.pl@[188.146.102.178])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <devel@driverdev.osuosl.org>; 1 Sep 2020 22:31:38 +0200
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a function
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20200901161846.111486-1-antoni.przybylik@wp.pl>
 <20200901175024.GA1509755@kroah.com>
From:   "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Message-ID: <4cf3447d-0dfa-8072-d168-698400d177c7@wp.pl>
Date:   Tue, 1 Sep 2020 22:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901175024.GA1509755@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WP-MailID: ea52d949d95c05dd253d4b49b44ccb41
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [gYNU]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2020 19:50, Greg KH wrote:

> On Tue, Sep 01, 2020 at 06:18:46PM +0200, Antoni Przybylik wrote:
>> This approach is more elegant and prevents some problems related to
>> macros such as operator precedence in expanded expression.
>>
>> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
>> ---
>>   drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
>> index 6e813693a766..a7db0672e81d 100644
>> --- a/drivers/staging/gdm724x/gdm_tty.c
>> +++ b/drivers/staging/gdm724x/gdm_tty.c
>> @@ -27,8 +27,6 @@
>>   
>>   #define MUX_TX_MAX_SIZE 2048
>>   
>> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
>> -
>>   static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
>>   static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
>>   static DEFINE_MUTEX(gdm_table_lock);
>> @@ -36,6 +34,11 @@ static DEFINE_MUTEX(gdm_table_lock);
>>   static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>>   static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>>   
>> +static int gdm_tty_ready(gdm *gdm)
>> +{
>> +	return (gdm && gdm->tty_dev && gdm->port.count);
>> +}
> You obviously did not even build this patch, which is a bit rude, don't
> you think?
>
> :(

I'm stupid. I misconfigured the kernel. I fixed this bug and sent a new 
patch.
Linux configuration script is horrible...

Antoni Przybylik

