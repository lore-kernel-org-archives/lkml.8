Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC12C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0264C20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgCZLQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:16:15 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34165 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbgCZLQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:16:14 -0400
Received: from [192.168.0.2] (ip5f5af065.dynamic.kabel-deutschland.de [95.90.240.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CCBCA206442F5;
        Thu, 26 Mar 2020 12:16:10 +0100 (CET)
Subject: Re: [Intel-wired-lan] [PATCH] igb: Use a sperate mutex insead of
 rtnl_lock()
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        "David S. Miller" <davem@davemloft.net>
References: <20200326103926.20888-1-kai.heng.feng@canonical.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <432c9705-7aca-d213-5c00-204ed2aeb9c9@molgen.mpg.de>
Date:   Thu, 26 Mar 2020 12:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326103926.20888-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kai-Heng,


Thank you.

There is a small typo in the commit summary: s*epa*rate.

Am 26.03.20 um 11:39 schrieb Kai-Heng Feng:
> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> fixed race condition between close and power management ops by using
> rtnl_lock().
> 
> This fix is a preparation for next patch, to prevent a dead lock under
> rtnl_lock() when calling runtime resume routine.

Do you refer with *this fix* to the referenced commit? Or do you mean 
the patch you just sent?

How can the issue be reproduced?

> However, we can't use device_lock() in igb_close() because when module
> is getting removed, the lock is already held for igb_remove(), and
> igb_close() gets called during unregistering the netdev, hence causing a
> deadlock. So let's introduce a new mutex so we don't cause a deadlock
> with driver core or netdev core.

Is there a bug report with more details?

If this fixes a regression, please add the appropriate `Fixes:` tag.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b46bff8fe056..dc7ed5dd216b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -288,6 +288,8 @@ static const struct igb_reg_info igb_reg_info_tbl[] = {
>   	{}
>   };
>   
> +static DEFINE_MUTEX(igb_mutex);
> +
>   /* igb_regdump - register printout routine */
>   static void igb_regdump(struct e1000_hw *hw, struct igb_reg_info *reginfo)
>   {
> @@ -4026,9 +4028,14 @@ static int __igb_close(struct net_device *netdev, bool suspending)
>   
>   int igb_close(struct net_device *netdev)
>   {
> +	int err = 0;
> +
> +	mutex_lock(&igb_mutex);
>   	if (netif_device_present(netdev) || netdev->dismantle)
> -		return __igb_close(netdev, false);
> -	return 0;
> +		err = __igb_close(netdev, false);
> +	mutex_unlock(&igb_mutex);
> +
> +	return err;
>   }
>   
>   /**
> @@ -8760,7 +8767,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
>   	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
>   	bool wake;
>   
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
>   	netif_device_detach(netdev);
>   
>   	if (netif_running(netdev))
> @@ -8769,7 +8776,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
>   	igb_ptp_suspend(adapter);
>   
>   	igb_clear_interrupt_scheme(adapter);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
>   
>   	status = rd32(E1000_STATUS);
>   	if (status & E1000_STATUS_LU)
> @@ -8897,13 +8904,13 @@ static int __maybe_unused igb_resume(struct device *dev)
>   
>   	wr32(E1000_WUS, ~0);
>   
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
>   	if (!err && netif_running(netdev))
>   		err = __igb_open(netdev, true);
>   
>   	if (!err)
>   		netif_device_attach(netdev);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
>   
>   	return err;
>   }

The rest looks fine.


Kind regards,

Paul
