Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C5C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF9E217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEIDYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:24:12 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37030 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbgEIDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:24:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Txzw3bb_1588994648;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Txzw3bb_1588994648)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 May 2020 11:24:08 +0800
Subject: Re: [PATCH] usb: roles: Switch on role-switch uevent reporting
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        chenqiwu <chenqiwu@xiaomi.com>, linux-kernel@vger.kernel.org
References: <20200508162937.2566818-1-bryan.odonoghue@linaro.org>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <fbd660ca-fe2a-8ca7-5076-f898acd1ca74@linux.alibaba.com>
Date:   Sat, 9 May 2020 11:24:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200508162937.2566818-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/5/9 ÉÏÎç12:29, Bryan O'Donoghue Ð´µÀ:
> Right now we don't report to user-space a role switch when doing a
> usb_role_switch_set_role() despite having registered the uevent callbacks.
> 
> This patch switches on the notifications allowing user-space to see
> role-switch change notifications and subsequently determine the current
> controller data-role.
> 
> example:
> PFX=/devices/platform/soc/78d9000.usb/ci_hdrc.0
> 
> root@somebox# udevadm monitor -p
> 
> KERNEL[49.894994] change $PFX/usb_role/ci_hdrc.0-role-switch (usb_role)
> ACTION=change
> DEVPATH=$PFX/usb_role/ci_hdrc.0-role-switch
> SUBSYSTEM=usb_role
> DEVTYPE=usb_role_switch
> USB_ROLE_SWITCH=ci_hdrc.0-role-switch
> SEQNUM=2432
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Wen Yang <wenyang@linux.alibaba.com>
> Cc: chenqiwu <chenqiwu@xiaomi.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/usb/roles/class.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 5b17709821df..27d92af29635 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -49,8 +49,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>   	mutex_lock(&sw->lock);
>   
>   	ret = sw->set(sw, role);
> -	if (!ret)
> +	if (!ret) {
>   		sw->role = role;
> +		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> +	}
>   
>   	mutex_unlock(&sw->lock);
>   
> 

Hi, we may also need to deal with the return value of kobject_uevent(). 
Should we move it under the line mutex_unlock(&sw->lock)?

Regards,
Wen

