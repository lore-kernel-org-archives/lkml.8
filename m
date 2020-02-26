Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B5C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D584206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBZIm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:42:59 -0500
Received: from mail.loongson.cn ([114.242.206.163]:33182 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgBZIm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:42:59 -0500
Received: from [10.130.0.70] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axb+iPL1ZenOQTAA--.1S3;
        Wed, 26 Feb 2020 16:42:55 +0800 (CST)
Subject: Re: [PATCH 2/2] USB: core: Fix potential memory leak in
 usb_get_configuration()
To:     Johan Hovold <johan@kernel.org>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
 <1582697723-7274-2-git-send-email-yangtiezhu@loongson.cn>
 <20200226080906.GV32540@localhost>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c7dfaa07-dd34-600d-2a69-95a65f966dfc@loongson.cn>
Date:   Wed, 26 Feb 2020 16:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200226080906.GV32540@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axb+iPL1ZenOQTAA--.1S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43uFykWrWDXFWUZFy3XFb_yoW8Zrykpa
        18XayYyFW5JFWfJa1kGas5WayFgan7Aa45Crya9w4Dur43Aa1YkFnakr1FvF97Gr97AF40
        qayFg3W7KrWDC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjMKZJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2020 04:09 PM, Johan Hovold wrote:
> On Wed, Feb 26, 2020 at 02:15:23PM +0800, Tiezhu Yang wrote:
>> Make sure to free all the allocated memory before exiting from the function
>> usb_get_configuration() when an error is encountered.
> There's no leak in this function as far as I can tell. Any allocated
> memory is released in usb_destroy_configuration() when the last
> reference to the struct usb_device is dropped.

Yes, you are right, the allocated memory in usb_get_configuration()
will be released in usb_destroy_configuration().

By the way, is it better to release the allocated memory as early as 
possible
in usb_get_configuration()? Just like this:

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index bb63ee0..dd4ebeb 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -885,12 +885,17 @@ int usb_get_configuration(struct usb_device *dev)

         length = ncfg * sizeof(char *);
         dev->rawdescriptors = kzalloc(length, GFP_KERNEL);
-       if (!dev->rawdescriptors)
+       if (!dev->rawdescriptors) {
+               kfree(dev->config);
                 return -ENOMEM;
+       }

         desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
-       if (!desc)
+       if (!desc) {
+               kfree(dev->config);
+               kfree(dev->rawdescriptors);
                 return -ENOMEM;
+       }

         for (cfgno = 0; cfgno < ncfg; cfgno++) {
                 /* We grab just the first descriptor so we know how long

Thanks,

Tiezhu Yang

>
>> Additionally, just initialize the variable "bigbuffer" with NULL to avoid
>> the following build warning:
>>
>>    CC      drivers/usb/core/config.o
>> drivers/usb/core/config.c: In function ‘usb_get_configuration’:
>> drivers/usb/core/config.c:956:2: warning: ‘bigbuffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    kfree(bigbuffer);
>>    ^
> No need to mention warnings that you introduce yourself while creating
> your patch. It can give the false impression that your addressing an
> existing issue.
>
> Johan

