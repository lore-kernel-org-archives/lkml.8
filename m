Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB90422B3F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596094712;
	bh=U6xD7DWyFJngrlIfYWMFdNmXDJ0/sOwnePBKoDIiyCY=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=AN/7rq0Jtkt+rygf6EiZJ0aOvOrmqcsAC801f+nO067A52FxkglCL8e7+8OjxacGs
	 1KlknaGYTiqgj41XKUJ43OYgc676BbkAt5j2DyabJsqkAIGvk7w0/eYsHTi8lw5Vsq
	 j34L2BffV0/yxST9p2u3rsM8YJ6i/lYDAriG5w7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgG3Hic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:38:32 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36195 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3Hib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:38:31 -0400
Received: by mail-ej1-f68.google.com with SMTP id kq25so14011312ejb.3;
        Thu, 30 Jul 2020 00:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Bk3NapliV+0H200NnpApnzvIQjKB5lHRW5bg5f2EMgs=;
        b=qSqHXuo2F1YyTNX6I7zhU4DHXTp2EUkwuX3wG2NwlUJfkw3fob5Iv50plXFSdwZefz
         rwJ5afGVA/GaMvVlbmjAVCSWap1/4AKodGTSWApe9Sk09ciVTxNqgB8S67Kk5Pudhs+t
         52Ts7cI9Pd1EjxWBot+4JMoKFKZMMAF34UKCvPSiteTdVyGa053dbtX34ppDemZnlIYi
         A2Vf7DFakXh0eAVI1pHgsC4bxP6v97RZy7ii/hFKxVcBRWLzyOZTBn1QZuyp6t2Vdfyl
         XSE5WiAfJY3JZ1Cvzsb4+BfBW3Td8c2eQmtmQa4DKooviSgJgqAgqX7Zz1okDopzQW8K
         8MEg==
X-Gm-Message-State: AOAM531j3QZNGYk2HB7FdP3+MXDuDqUnam5UUXhKPS3H+SwR3bEGxXzi
        48U9b4Yh6U/nDOZ/id7rFHtbO8yX
X-Google-Smtp-Source: ABdhPJyJI1e/Nn8AuA4RIWylZnro3d/4HvhzZMo5nCfsHBXw7BZ9cIVJGLosjlGYmL4FhmtzT22HLA==
X-Received: by 2002:a17:906:858:: with SMTP id f24mr1333330ejd.543.1596094706846;
        Thu, 30 Jul 2020 00:38:26 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z17sm1993981edi.19.2020.07.30.00.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 00:38:25 -0700 (PDT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Solar Designer <solar@openwall.com>
Cc:     b.zolnierkie@samsung.com,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        xiao.zhang@windriver.com,
        DRI devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20200729130710.GA13262@openwall.com>
 <b764c575-70be-80dd-6718-e84370a7b2b3@nsfocus.com>
 <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <008a3a1d-1908-6aea-0fae-e15b4eddff02@kernel.org>
Date:   Thu, 30 Jul 2020 09:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 20, 8:46, Jiri Slaby wrote:
> Hi, OTOH, you should have CCed all the (public) lists.
> 
> On 30. 07. 20, 4:50, 张云海 wrote:
>> Zhang Xiao points out that the check should use > instead of >=,
>> otherwise the last line will be skip.
>> I agree with that, so I modify the patch.
>> Could you please verify that it is still correct and sufficient?
> 
> IMO, yes, correct -- I was thinking about this yesterday too. Just an
> example: hypothetically, if we had:
> size_row = 1
> tail = 29
> size = 30
> 
> data[29] would be the last accessible member. Writing to data + tail (as
> "29 + 1 > 30" doesn't hold, so the modified check would pass), i.e.
> data[29] is still OK. So yes, > is OK, >= would waste space and would be
> actually incorrect.
> 
>> BTW, Zhang Xiao also points out that the check after the memcpy can be
>> remove.
>> I also think that was right, but vgacon_scrollback_cur->tail may keep
>> the value vgacon_scrollback_cur->size in some case. That is not a
>> problem in vgacon_scrollback_update because of the check before the
>> memcpy. However, that may break some other code which assumes that
>> vgacon_scrollback_cur->tail won't be vgacon_scrollback_cur->size. I do
>> not know if there are such code, and if it is the code actually  should
>> check it too. But I still not remove the check in the patch to make sure
>> it won't breaks other code.
> 
> As I wrote about this yesterday:
> ===
> I am also not sure the test I was pointing out on the top of this
> message would be of any use after the change. But maybe leave the code
> rest in peace.
> ===
> 
> I would let it as is in this particular code. Especially because
> vgacon_scrolldelta takes ->tail into consideration and I was too lazy to
> study the code there. But if you are willing to study the code there and
> confirm the check is superfluous, feel free to remove it. Perhaps in a
> separate patch. I was actually testing with the check removed and didn't
> hit any issue (which means, in fact, exactly nothing).
> 
>> From ad143ede24ff4e61292cc9c96000100aacd97259 Mon Sep 17 00:00:00 2001
>> From: Yunhai Zhang <zhangyunhai@nsfocus.com>
>> Date: Tue, 28 Jul 2020 09:58:03 +0800
>> Subject: [PATCH] Fix for missing check in vgacon scrollback handling
>>
>> vgacon_scrollback_update() always left enbough room in the scrollback
> 
> "leaves enough"
> 
>> buffer for the next call, but if the console size changed that room
>> might not actually be enough, and so we need to re-check.
> 
> Also, could you add reasoning why you are adding the check to the loop
> and not outside (for instance, use your reasoning with numbers or CSI M
> as an example).
> 
> Could you add a sample output here, something like I had:
> ===
>     This leads to random crashes or KASAN reports like:
>     BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed
> ===
> 
> It's then easier to google for when this happens to someone who runs
> non-patched kernels.
> 
>> This fixes CVE-2020-14331.
>>
>> Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
>> Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
>> Reported-by: Kyungtae Kim <kt0755@gmail.com>
>> Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Greg KH <greg@kroah.com>
>> Cc: Solar Designer <solar@openwall.com>
>> Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
>> Cc: Anthony Liguori <aliguori@amazon.com>
>> Cc: Yang Yingliang <yangyingliang@huawei.com>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Oh, and we should:
> Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Yunhai Zhang <zhangyunhai@nsfocus.com>
>> ---
>>  drivers/video/console/vgacon.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
>> index 998b0de1812f..37b5711cd958 100644
>> --- a/drivers/video/console/vgacon.c
>> +++ b/drivers/video/console/vgacon.c
>> @@ -251,6 +251,10 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
>>  	p = (void *) (c->vc_origin + t * c->vc_size_row);
>>  
>>  	while (count--) {
>> +		if ((vgacon_scrollback_cur->tail + c->vc_size_row) > 

And git complains here:
.git/rebase-apply/patch:13: trailing whitespace.
                if ((vgacon_scrollback_cur->tail + c->vc_size_row) >
warning: 1 line adds whitespace errors.

There is a space at the EOL.

>> +		    vgacon_scrollback_cur->size)
>> +			vgacon_scrollback_cur->tail = 0;
>> +
>>  		scr_memcpyw(vgacon_scrollback_cur->data +
>>  			    vgacon_scrollback_cur->tail,
>>  			    p, c->vc_size_row);
> 
> thanks,
> 


-- 
js
