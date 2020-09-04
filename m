Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD49F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIDKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:38:56 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:36622 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgIDKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:38:40 -0400
Received: from localhost (unknown [192.168.167.223])
        by regular1.263xmail.com (Postfix) with ESMTP id 92CE3408;
        Fri,  4 Sep 2020 18:38:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [10.10.77.74] (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P15473T140655923783424S1599215900940793_;
        Fri, 04 Sep 2020 18:38:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9ad19152e9ec3a302d88ebfa8cf6d6dc>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: tomasz@meresinski.eu
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
Subject: Re: [PATCH v3] HID: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk
 for BYD zhaoxin notebook
To:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     johan@kernel.org, dlaz@chromium.org, stern@rowland.harvard.edu,
        kerneldev@karsmulder.nl, jonathan@jdcox.net, tomasz@meresinski.eu
References: <20200904091322.30426-1-penghao@uniontech.com>
 <f519d8a0-9082-13c5-0222-40dd9a1fac36@redhat.com>
From:   PengHao <penghao@uniontech.com>
Message-ID: <bd5674f2-67dc-b386-f639-97ddce13b8af@uniontech.com>
Date:   Fri, 4 Sep 2020 18:38:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f519d8a0-9082-13c5-0222-40dd9a1fac36@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hans

Thanks for the review. And sorry for I'm not really familiar with
mailing list, so didn't reply early.

Actually the reason why I submit this patch, is the vendor ask we do
this, they do not want enable touchpad wakeup.

And yes, this device use hid-multitouch.


在 2020/9/4 下午6:05, Hans de Goede 写道:
> Hi,
> 
> On 9/4/20 11:13 AM, Penghao wrote:
>> Add a USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for the BYD zhaoxin notebook.
>> This notebook come with usb touchpad. And we would like to disable
>> touchpad
>> wakeup on this notebook by default.
> 
> You are still not explaining why this is necessary ?
> 
> And you did not answer my question if this touchpad is using hid-multitouch
> either ?
> 
> So NACK (rejection) from me until both questions are answered. The commi
> message for a quirk should always explain why a quirk is necessary and
> "we would like to disable touchpad wakeup on this notebook by default"
> does not explain why you want to do that.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> Signed-off-by: Penghao <penghao@uniontech.com>
>> ---
>>
>> Changes since v2:
>>   - Add changes
>>
>> Changes since v1:
>>   - Add the entries sorted by vendor ID and product ID.
>>
>>   drivers/usb/core/quirks.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
>> index 7c1198f80c23..fffe1f7f1098 100644
>> --- a/drivers/usb/core/quirks.c
>> +++ b/drivers/usb/core/quirks.c
>> @@ -393,6 +393,10 @@ static const struct usb_device_id
>> usb_quirk_list[] = {
>>       /* Generic RTL8153 based ethernet adapters */
>>       { USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },
>>   +    /* SONiX USB DEVICE Touchpad */
>> +    { USB_DEVICE(0x0c45, 0x7056), .driver_info =
>> +            USB_QUIRK_IGNORE_REMOTE_WAKEUP },
>> +
>>       /* Action Semiconductor flash disk */
>>       { USB_DEVICE(0x10d6, 0x2200), .driver_info =
>>               USB_QUIRK_STRING_FETCH_255 },
>>
> 
> 
> 
> 
> 


