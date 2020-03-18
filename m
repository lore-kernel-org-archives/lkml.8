Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C91AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EC820719
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSAFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:05:13 -0400
Received: from mailfilter06-out30.webhostingserver.nl ([195.211.73.76]:39955
        "EHLO mailfilter06-out30.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgCSAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:05:13 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 20:05:13 EDT
X-Halon-ID: 1000f29b-6973-11ea-8bfb-001a4a4cb958
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
        id 1000f29b-6973-11ea-8bfb-001a4a4cb958;
        Thu, 19 Mar 2020 00:49:09 +0100 (CET)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1jEiQv-003Org-PS; Thu, 19 Mar 2020 00:49:09 +0100
Subject: Re: [PATCH v1 2/3] driver core: Read atomic counter once in
 driver_probe_done()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
 <20200309141111.40576-2-andriy.shevchenko@linux.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <80e2fbb3-c69d-c2a8-f177-25c304062b29@gmail.com>
Date:   Thu, 19 Mar 2020 00:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309141111.40576-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 09-03-2020 om 15:11 schreef Andy Shevchenko:
> Between printing the debug message and actual check atomic counter can be
> altered. For better debugging experience read atomic counter value only once.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Ferry Toth <fntoth@gmail.com>

> ---
>   drivers/base/dd.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 43720beb5300..efd0e4c16ba5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -669,9 +669,10 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>    */
>   int driver_probe_done(void)
>   {
> -	pr_debug("%s: probe_count = %d\n", __func__,
> -		 atomic_read(&probe_count));
> -	if (atomic_read(&probe_count))
> +	int local_probe_count = atomic_read(&probe_count);
> +
> +	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
> +	if (local_probe_count)
>   		return -EBUSY;
>   	return 0;
>   }
> 

