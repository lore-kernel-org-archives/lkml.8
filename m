Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE26C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B81D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596116295;
	bh=IGzDKZQaLf5VbPiw3Npo5lvJH45RFV1iEm7H2NMlgy4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=QHKTPzJn1KcSdsY+bLiOE9WV91c9PvhPzoEWFCbXkiHTEPuVektS5ur5Vrqxnn1Ic
	 JpmDUI7e98eZhQTy9ljPZtwy8jqCZ8MaZnRolKQKlTCHVuOhA7PoLMkss9+wBbjEM0
	 /QIc7hcR3xWrXfeLLJLlG5rXlBYh3Oosz7t6nBXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgG3NiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:38:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41706 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:38:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id c2so14112099edx.8;
        Thu, 30 Jul 2020 06:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sb67XdiMNKw4kLYECvn8kVzTIpC9oxQwoKlyPT/fqdw=;
        b=Hb3lvN3MLyOGqptNLzji7LcsAMALRAw0xeZKkzkSCaBbtczJHJkXqD9d9y7JEK1uGD
         RLhk8EUw53U5xBkYEpvLSNstf06S7fg4SOr1QqpNpG9bLyStPu6PRidL1kscdcXWp8mM
         oTXyJDTOkGlAFXy+PgBcsKBwOKEqjv4NLSliBlccyMJjfTeNGWNdKj7Lxhf7mgsfqUDH
         i6b+/hZ4JKqwlsenl0WFI0gpT4SUGMAVbnS7qA7qFd+VUdemyPecni9/6gyk8ebuikj+
         MArTGpgXi7GCjjljjHfVb/vDd8JjgDiiQLg5J3Z5wRtyMO81qABDZvXG/CEiaYhCRRO0
         TQCA==
X-Gm-Message-State: AOAM532J6tZ3PIcprdXVEZn4RHjLr8ub/D9se0qtfQBT3gvr/1O1FF28
        V52siDH3fcK00Jmcw5PavNo=
X-Google-Smtp-Source: ABdhPJyDNlt4vhhufMGcGCRB1ChSoyT2AlgoK32HQNBg6TqRjcXaQWvxk2/Mqe03QNCpFJZG0Sml5Q==
X-Received: by 2002:a50:da05:: with SMTP id z5mr2585340edj.207.1596116288537;
        Thu, 30 Jul 2020 06:38:08 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id qk30sm4393503ejb.125.2020.07.30.06.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:38:07 -0700 (PDT)
Subject: Re: [PATCH] vgacon: Fix an out-of-bounds in
 vgacon_scrollback_update()
To:     Yang Yingliang <yangyingliang@huawei.com>, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
References: <20200713105730.550334-1-yangyingliang@huawei.com>
 <220220f1-48f7-46f6-952f-ab41fa57d6a1@kernel.org>
 <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9aecd7ac-5060-6b8d-61f8-393431eb243f@kernel.org>
Date:   Thu, 30 Jul 2020 15:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c3714d73-d5fe-c77a-e554-bb1ff4fd6980@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 20, 15:24, Yang Yingliang wrote:
> 
> On 2020/7/30 19:04, Jiri Slaby wrote:
>> On 13. 07. 20, 12:57, Yang Yingliang wrote:
>>> I got a slab-out-of-bounds report when I doing fuzz test.
>>>
>>> [  334.989515]
>>> ==================================================================
>>> [  334.989577] BUG: KASAN: slab-out-of-bounds in
>>> vgacon_scroll+0x57a/0x8ed
>>> [  334.989588] Write of size 1766 at addr ffff8883de69ff3e by task
>>> test/2658
>>> [  334.989593]
>>> [  334.989608] CPU: 3 PID: 2658 Comm: test Not tainted
>>> 5.7.0-rc5-00005-g152036d1379f #789
>>> [  334.989617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>>> BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>>> [  334.989624] Call Trace:
>>> [  334.989646]  dump_stack+0xe4/0x14e
>>> [  334.989676]  print_address_description.constprop.5+0x3f/0x60
>>> [  334.989699]  ? vgacon_scroll+0x57a/0x8ed
>>> [  334.989710]  __kasan_report.cold.8+0x92/0xaf
>>> [  334.989735]  ? vgacon_scroll+0x57a/0x8ed
>>> [  334.989761]  kasan_report+0x37/0x50
>>> [  334.989789]  check_memory_region+0x1c1/0x1e0
>>> [  334.989806]  memcpy+0x38/0x60
>>> [  334.989824]  vgacon_scroll+0x57a/0x8ed
>>> [  334.989876]  con_scroll+0x4ef/0x5e0
>> ...
>>> Because vgacon_scrollback_cur->tail plus memcpy size is greater than
>>> vgacon_scrollback_cur->size. Fix this by checking the memcpy size.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   drivers/video/console/vgacon.c | 11 ++++++++---
>>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/video/console/vgacon.c
>>> b/drivers/video/console/vgacon.c
>>> index 998b0de1812f..b51ffb9a208d 100644
>>> --- a/drivers/video/console/vgacon.c
>>> +++ b/drivers/video/console/vgacon.c
>>> @@ -243,6 +243,7 @@ static void vgacon_scrollback_startup(void)
>>>   static void vgacon_scrollback_update(struct vc_data *c, int t, int
>>> count)
>>>   {
>>>       void *p;
>>> +    int size;
>>>         if (!vgacon_scrollback_cur->data ||
>>> !vgacon_scrollback_cur->size ||
>>>           c->vc_num != fg_console)
>>> @@ -251,13 +252,17 @@ static void vgacon_scrollback_update(struct
>>> vc_data *c, int t, int count)
>>>       p = (void *) (c->vc_origin + t * c->vc_size_row);
>>>         while (count--) {
>>> +        size = vgacon_scrollback_cur->size -
>>> vgacon_scrollback_cur->tail;
>>> +        if (size > c->vc_size_row)
>>> +            size = c->vc_size_row;
>>> +
>>>           scr_memcpyw(vgacon_scrollback_cur->data +
>>>                   vgacon_scrollback_cur->tail,
>>> -                p, c->vc_size_row);
>>> +                p, size);
>> Are you sure the consumer can handle split lines? As vgacon_scrolldelta
>> (soff in particular) looks to me like it doesn't.
>>
>> Have you tested you patch? I mean with soft scrollback on the vga
>> console?
> 
> I only test the patch with the reproduce program.

Out of curiosity, what is it doing? Resize and then scroll by \n (line
feed)? Can you share it?

thanks,
-- 
js
