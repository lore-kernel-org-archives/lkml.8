Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9805C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0405207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgERHeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:34:00 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37929 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:33:59 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7630920000E;
        Mon, 18 May 2020 07:33:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: Improve debug output
In-Reply-To: <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com> <20200512115323.1447922-2-gregory.clement@bootlin.com> <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com>
Date:   Mon, 18 May 2020 09:33:57 +0200
Message-ID: <87tv0dg0ii.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

> On 12. 05. 20, 13:53, Gregory CLEMENT wrote:
>> Use appropriate print helpers for debug messages.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/tty/n_gsm.c | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index d77ed82a4840..67c8f8173023 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -504,18 +504,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
>>  	else
>>  		pr_cont("(F)");
>>  
>> -	if (dlen) {
>> -		int ct = 0;
>> -		while (dlen--) {
>> -			if (ct % 8 == 0) {
>> -				pr_cont("\n");
>> -				pr_debug("    ");
>> -			}
>> -			pr_cont("%02X ", *data++);
>> -			ct++;
>> -		}
>> -	}
>> -	pr_cont("\n");
>> +	if (dlen)
>
> This test is superfluous. print_hex_dump_* won't write anything when
> zero length is passed to it.

As I will send a v3 due to the issue found on the last patch, I am also
going to fix this.

Gregory

>
>> +		print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
>>  }
>
> thanks,
> -- 
> js
> suse labs

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
