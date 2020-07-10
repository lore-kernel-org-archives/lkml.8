Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F426C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C9320772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGJLcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:32:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62577 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGJLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:32:02 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06ABVlOt059266;
        Fri, 10 Jul 2020 20:31:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 10 Jul 2020 20:31:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06ABVl9i059263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 10 Jul 2020 20:31:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] vt: Reject zero-sized screen buffer size.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
References: <20200710055329.3759-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200710105500.GA1232395@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7adf8aee-9bdd-8184-6cbe-291357677edd@i-love.sakura.ne.jp>
Date:   Fri, 10 Jul 2020 20:31:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710105500.GA1232395@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/10 19:55, Greg Kroah-Hartman wrote:
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 48a8199f7845..8497e9206607 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -1126,7 +1126,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>>  		con_set_default_unimap(vc);
>>  
>>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>> -	if (!vc->vc_screenbuf)
>> +	if (ZERO_OR_NULL_PTR(vc->vc_screenbuf))
> 
> No, let's check this before we do kzalloc() please, that's just an odd
> way of doing an allocation we shouldn't have had to do.

OK. I can change to

+	if (vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
+		goto err_free;
 	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
 	if (!vc->vc_screenbuf)
 		goto err_free;

like vc_do_resize() does. But I'm currently waiting for syzbot to test this patch, for
I don't have an environment for reproducing this problem.

> 
>>  		goto err_free;
>>  
>>  	/* If no drivers have overridden us and the user didn't pass a
>> @@ -1212,7 +1212,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>>  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
>>  		return 0;
>>  
>> -	if (new_screen_size > KMALLOC_MAX_SIZE)
>> +	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>>  		return -EINVAL;
>>  	newscreen = kzalloc(new_screen_size, GFP_USER);
>>  	if (!newscreen)
>> @@ -3393,6 +3393,7 @@ static int __init con_init(void)
>>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>>  		tty_port_init(&vc->port);
>>  		visual_init(vc, currcons, 1);
>> +		/* Assuming vc->vc_screenbuf_size is sane here, for this is __init code. */
> 
> Shouldn't we also check this here, or before we get here, too?

This is an __init function. Can we somehow pass column=0 or row=0 ?

> 
> Just checking the values and rejecting that as a valid screen size
> should be sufficient.

Hmm, where are we checking that column * row does not exceed UINT_MAX, given that
"struct vc_data"->vc_{cols,rows,screenbuf_size} are "unsigned int" and we do

  vc->vc_size_row = vc->vc_cols << 1;
  vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;

in visual_init() ? Don't we need to reject earlier?

