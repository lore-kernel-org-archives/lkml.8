Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD81C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B47B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgAUJzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:55:45 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47189 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgAUJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:55:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHe2sg_1579600542;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHe2sg_1579600542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 17:55:42 +0800
Subject: Re: [PATCH] pcmcia/cm4000: remove useless variable tmp
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harald Welte <laforge@gnumonks.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <37f03cf9-5666-7561-13f6-2ff72e936b7a@linux.alibaba.com>
Date:   Tue, 21 Jan 2020 17:53:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/1/21 下午5:08, Arnd Bergmann 写道:
> On Tue, Jan 21, 2020 at 9:50 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> No one care the value of 'tmp' in func cmm_write. better to remove it.
> 
> Hi Alex,
> 
>> @@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
>>         set_cardparameter(dev);
>>
>>         /* dummy read, reset flag procedure received */
>> -       tmp = inb(REG_FLAGS1(iobase));
>> +       inb(REG_FLAGS1(iobase));
> 
> I think this may cause warnings on some architectures, when inb() is a macro
> that just turns into a pointer dereference. You could write it as
> 
>      (void)inb(REG_FLAGS1(iobase));
> 
> which would not warn anywhere.
> 
>       Arnd
> 

Thanks a lot Arnd!


From 9e54770c6911ae7da7d2f74774bbef019e459bc9 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 17 Jan 2020 09:10:47 +0800
Subject: [PATCH v2] pcmcia/cm4000: remove useless variable tmp

No one care the value of 'tmp' in func cmm_write. better to remove it.

Arnd Bergmann pointed just remove may cause warning in some arch where 
inb is macro, and suggest add a cast '(void)' for this. Thanks!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/pcmcia/cm4000_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 15bf585af5d3..0f55bed6c71f 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1048,7 +1048,6 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	struct cm4000_dev *dev = filp->private_data;
 	unsigned int iobase = dev->p_dev->resource[0]->start;
 	unsigned short s;
-	unsigned char tmp;
 	unsigned char infolen;
 	unsigned char sendT0;
 	unsigned short nsend;
@@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
 	set_cardparameter(dev);
 
 	/* dummy read, reset flag procedure received */
-	tmp = inb(REG_FLAGS1(iobase));
+	(void)inb(REG_FLAGS1(iobase));
 
 	dev->flags1 = 0x20	/* T_Active */
 	    | (sendT0)
-- 
1.8.3.1

