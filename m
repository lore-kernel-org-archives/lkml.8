Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D0C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47F20773
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCSDLb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:11:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSDLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:11:31 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 16FFCA3731E233D93E27;
        Thu, 19 Mar 2020 11:11:27 +0800 (CST)
Received: from DGGEML525-MBX.china.huawei.com ([169.254.1.76]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0487.000;
 Thu, 19 Mar 2020 11:11:21 +0800
From:   "suqiang (C)" <suqiang4@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liyou (leeyou, RTOS)" <leeyou.li@huawei.com>
Subject: RE: [PATCH V2] UIO: make maximum memory and port regions
 configurable
Thread-Topic: [PATCH V2] UIO: make maximum memory and port regions
 configurable
Thread-Index: AQHV9FfY6xaIjrFlh02wx4Qa9y4FFKhNw2YAgAF/hUA=
Date:   Thu, 19 Mar 2020 03:11:20 +0000
Message-ID: <7AF579E0012A4E4FA1B0EC683F4B7F591F96D204@dggeml525-mbx.china.huawei.com>
References: <20200307081008.26848-1-suqiang4@huawei.com>
 <20200318113352.GA2365557@kroah.com>
In-Reply-To: <20200318113352.GA2365557@kroah.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,
Thanks a lot for suggestion. I will add more information in these help texts and send PATCH V3 soon.
Furthermore, of cause it is better to make these values dynamic and grow as needed by the system. A possible way is to manage memory and port resource by a dynamic list instead of a static array.
But it costs more time to design and implement a better scheme. I will try it later and push patchs when it's finished.
This patch is a temporary way better than nothing, and I hope it could be accept.

thanks,
Qiang Su

-----Original Message-----
From: Greg KH [mailto:gregkh@linuxfoundation.org] 
Sent: Wednesday, March 18, 2020 7:34 PM
To: suqiang (C) <suqiang4@huawei.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] UIO: make maximum memory and port regions configurable

On Sat, Mar 07, 2020 at 04:10:08PM +0800, Qiang Su wrote:
> Now each uio device can only support 5 memory regions and
> 5 port regions. It is far from enough for some big system.
> On the other hand, the hard-coded style is not flexible.
> 
> Consider the marco is used as array index, so a range for the config 
> is set in menuconfig. The range is set as 1 to 512.
> The default value is still set as 5 to keep consistent with current 
> code.
> 
> Signed-off-by: Qiang Su <suqiang4@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> Changes since v1:
> - also make port regions configurable in menuconfig.
> - fix kbuild errors.
> ---
>  drivers/uio/Kconfig        | 18 ++++++++++++++++++
>  include/linux/uio_driver.h |  4 ++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig index 
> 202ee81cfc2b..cee7d93cfea2 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,22 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config MAX_UIO_MAPS
> +	depends on UIO
> +	int "Maximum of memory nodes each uio device support(1-512)"
> +	range 1 512
> +	default 5
> +	help
> +	  make the max number of memory regions in uio device configurable.
> +
> +config MAX_UIO_PORT_REGIONS
> +	depends on UIO
> +	int "Maximum of port regions each uio device support(1-512)"
> +	range 1 512
> +	default 5
> +	help
> +	  make the max number of port regions in uio device configurable.


Can you provide a lot more information in these help texts?  Explain why you would ever want to change these values, and that if you do not understand, just take the default ones.

Or, better yet, can we just make these values dynamic and grow as needed by the system?  Why are they "fixed"?

thanks,

greg k-h
