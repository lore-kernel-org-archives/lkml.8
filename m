Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B5C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D7F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBZPAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:00:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgBZPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:00:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B20DB294899
Subject: Re: [PATCH 4/8] platform/chrome: cros_ec_chardev: Use
 cros_ec_cmd_xfer_status helper
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
 <20200220155859.906647-5-enric.balletbo@collabora.com>
 <20200225195519.GC11971@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4e441ead-44f3-1787-28a3-3e71893105f9@collabora.com>
Date:   Wed, 26 Feb 2020 15:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225195519.GC11971@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 25/2/20 20:55, Prashant Malani wrote:
> Hi Enric,
> 
> On Thu, Feb 20, 2020 at 04:58:55PM +0100, Enric Balletbo i Serra wrote:
>> This patch makes use of cros_ec_cmd_xfer_status() instead of
>> cros_ec_cmd_xfer(). In this case the change is trivial and the only
>> reason to do it is because we want to make cros_ec_cmd_xfer() a private
>> function for the EC protocol and let people only use the
>> cros_ec_cmd_xfer_status() to return Linux standard error codes.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/platform/chrome/cros_ec_chardev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
>> index c65e70bc168d..b51ab24055f3 100644
>> --- a/drivers/platform/chrome/cros_ec_chardev.c
>> +++ b/drivers/platform/chrome/cros_ec_chardev.c
>> @@ -301,7 +301,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
>>  	}
>>  
>>  	s_cmd->command += ec->cmd_offset;
>> -	ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
>> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, s_cmd);
> 
> One issue I see here is that if we were to later convert
> cros_ec_cmd_xfer_status() to cros_ec_cmd(), we would lose the
> s_cmd->result value, since I was hoping to avoid returning msg->result
> via a pointer parameter. I don't know if userspace actually uses that, but I
> am assuming it does.
> 

I'd like to avoid returning msg->result via a pointer parameter too. I didn't
analyze all the cases but I suspect that in most cases it is not really needed,
so let's start by converting to the cros_ec_cmd the cases that are clear and
let's go one by one for the ones that are not clear.

IMO cros_ec_cmd should return the same as cros_ec_cmd_xfer_status. So you should
use cros_ec_cmd_xfer_status inside cros_ec_cmd.

Regards,
 Enric

> So, should cros_ec_cmd() keep the *result pointer like so ?:
> 
> int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
>                void *outdata, u32 outsize, void *indata, u32 insize, u32 *result);
> 
> This way, we can manually re-populate s_cmd->result with |*result|.
> 
> Or, should we drop msg->result while returning s_cmd to userspace? I am
> guessing the answer is no, but thought I'd check with you first.
> 
> Best regards,
> 
> 
>>  	/* Only copy data to userland if data was received. */
>>  	if (ret < 0)
>>  		goto exit;
>> -- 
>> 2.25.0
>>
