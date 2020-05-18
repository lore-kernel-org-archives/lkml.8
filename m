Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C64A207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgERHoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:44:55 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42801 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:44:55 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 51F19240012;
        Mon, 18 May 2020 07:44:53 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: Improve debug output
In-Reply-To: <20200518073829.GA3055513@kroah.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com> <20200512115323.1447922-2-gregory.clement@bootlin.com> <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com> <87tv0dg0ii.fsf@FE-laptop> <20200518073829.GA3055513@kroah.com>
Date:   Mon, 18 May 2020 09:44:52 +0200
Message-ID: <87o8qlg00b.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> On Mon, May 18, 2020 at 09:33:57AM +0200, Gregory CLEMENT wrote:
>> Hello Jiri,
>> 
>> > On 12. 05. 20, 13:53, Gregory CLEMENT wrote:
>> >> Use appropriate print helpers for debug messages.
>> >> 
>> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> >> ---
>> >>  drivers/tty/n_gsm.c | 14 ++------------
>> >>  1 file changed, 2 insertions(+), 12 deletions(-)
>> >> 
>> >> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> >> index d77ed82a4840..67c8f8173023 100644
>> >> --- a/drivers/tty/n_gsm.c
>> >> +++ b/drivers/tty/n_gsm.c
>> >> @@ -504,18 +504,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
>> >>  	else
>> >>  		pr_cont("(F)");
>> >>  
>> >> -	if (dlen) {
>> >> -		int ct = 0;
>> >> -		while (dlen--) {
>> >> -			if (ct % 8 == 0) {
>> >> -				pr_cont("\n");
>> >> -				pr_debug("    ");
>> >> -			}
>> >> -			pr_cont("%02X ", *data++);
>> >> -			ct++;
>> >> -		}
>> >> -	}
>> >> -	pr_cont("\n");
>> >> +	if (dlen)
>> >
>> > This test is superfluous. print_hex_dump_* won't write anything when
>> > zero length is passed to it.
>> 
>> As I will send a v3 due to the issue found on the last patch, I am also
>> going to fix this.
>
> Ugh, as I already applied this series, should I just revert them all, or
> are you going to send fix-ups on top of what I have applied instead?

I was about to send a new series, but I can just send fix-ups. It's up
to you.

Gregory

>
> thanks,
>
> greg k-h

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
