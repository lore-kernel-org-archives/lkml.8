Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF677C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B942E207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUX6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:58:35 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:36191 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUX6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:58:33 -0400
Received: from 2CD-RMPB.local (unknown [113.89.247.200])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 1A4884816D2;
        Sat, 22 Aug 2020 07:58:30 +0800 (CST)
Subject: Re: [PATCH] xhci: Always restore EP_SOFT_CLEAR_TOGGLE even if ep
 reset failed
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200821070652.27782-1-dinghui@sangfor.com.cn>
 <20200821073147.GA1681156@kroah.com>
 <c6275105-a204-fe23-2dae-2bfa6c06a839@linux.intel.com>
From:   Ding Hui <dinghui@sangfor.com.cn>
Message-ID: <576e0013-a11e-4ffb-3964-cc9aba204245@sangfor.com.cn>
Date:   Sat, 22 Aug 2020 07:58:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <c6275105-a204-fe23-2dae-2bfa6c06a839@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0IfQk0fTk8dT0waVkpOQkNLTk9ISktJQklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46TAw6GD8uPDIJT00SEQky
        PzNPCg9VSlVKTkJDS05PSEpLTUxDVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKSkhVQ0JVSU9MVUlLS1lXWQgBWUFJQkxCNwY+
X-HM-Tid: 0a741375a16393bakuws1a4884816d2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/21 4:44 下午, Mathias Nyman wrote:
> On 21.8.2020 10.31, Greg KH wrote:
>> On Fri, Aug 21, 2020 at 03:06:52PM +0800, Ding Hui wrote:
>>> Some devices driver call libusb_clear_halt when target ep queue
>>> is not empty. (eg. spice client connected to qemu for usb redir)
>>>
>>> Before commit f5249461b504 ("xhci: Clear the host side toggle
>>> manually when endpoint is soft reset"), that works well.
>>> But now, we got the error log:
>>>
>>>      EP not empty, refuse reset
>>>
>>> xhch_endpoint_reset failed and left ep_state's EP_SOFT_CLEAR_TOGGLE
>>> bit is still on
>>>
>>> So all the subsequent urb sumbit to the ep will fail with the
>>> warn log:
>>>
>>>      Can't enqueue URB while manually clearing toggle
>>>
>>> We need restore ep_state EP_SOFT_CLEAR_TOGGLE bit after
>>> xhci_endpoint_reset, even if it is failed.
>>>
>>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> 
> Thanks, nice catch.
> 
>>> ---
>>>   drivers/usb/host/xhci.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Shouldn't this have a Fixes: tag on it and be backported to the affected
>> stable trees?

Sorry for missing the tags, this is my first kernel patch :-)

> 
> It should, but I like this patch and want it in, so I'll add the tags this time.

Thanks for correcting my commit msg

> 
> Thanks
> -Mathias
> 


-- 
Thanks,
-dinghui
