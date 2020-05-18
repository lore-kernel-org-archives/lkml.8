Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA2A207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERHmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:42:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41433 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgERHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:42:14 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 02E53FF80F;
        Mon, 18 May 2020 07:42:11 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: Fix waking up upper tty layer when room available
In-Reply-To: <4d3863a3-4c82-797f-6c20-b74e61a11724@suse.cz>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com> <20200512115323.1447922-4-gregory.clement@bootlin.com> <4d3863a3-4c82-797f-6c20-b74e61a11724@suse.cz>
Date:   Mon, 18 May 2020 09:42:11 +0200
Message-ID: <87r1vhg04s.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> On 12. 05. 20, 13:53, Gregory CLEMENT wrote:
>> Warn the upper layer when n_gms is ready to receive data
>> again. Without this the associated virtual tty remains blocked
>> indefinitely.
>> 
>> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  drivers/tty/n_gsm.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index d8d196645500..69200bd411f7 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -663,7 +663,7 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
>>   *	FIXME: lock against link layer control transmissions
>>   */
>>  
>> -static void gsm_data_kick(struct gsm_mux *gsm)
>> +static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
>>  {
>>  	struct gsm_msg *msg, *nmsg;
>>  	int len;
>> @@ -695,6 +695,24 @@ static void gsm_data_kick(struct gsm_mux *gsm)
>>  
>>  		list_del(&msg->list);
>>  		kfree(msg);
>> +
>> +		if (dlci) {
>> +			tty_port_tty_wakeup(&dlci->port);
>> +		} else {
>> +			int i = 0;
>> +
>> +			for (i = 0; i < NUM_DLCI; i++) {
>> +				struct gsm_dlci *dlci;
>> +
>> +				dlci = gsm->dlci[i];
>> +				if (dlci == NULL) {
>> +					i++;
>
> This "i++" looks bogus here.

You're right!
Sorry for this.

>
>> +					continue;
>> +				}
>> +
>> +				tty_port_tty_wakeup(&dlci->port);
>
>
> So simply:
> for (i = 0; i < NUM_DLCI; i++) {
>   struct gsm_dlci *dlci = gsm->dlci[i];
>   if (dlci)
>     tty_port_tty_wakeup(&dlci->port);
> }
>
> ? Or even maybe directly:
> for (i = 0; i < NUM_DLCI; i++)
>   if (gsm->dlci[i])
>     tty_port_tty_wakeup(&gsm->dlci[i]->port);

I will do this, thanks,

Gregory

>
> thanks,
> -- 
> js
> suse labs

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
