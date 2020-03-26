Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6486C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B417820714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCZKlg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:41:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34698 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:41:35 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jHPx7-00047x-8J
        for linux-kernel@vger.kernel.org; Thu, 26 Mar 2020 10:41:33 +0000
Received: by mail-pg1-f198.google.com with SMTP id 185so4360935pgc.22
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UeRJQevSUHXBRlf/4ze6OiB+Fx/GsXnxWvYb+Xd4brE=;
        b=NikCLABUC157DpTI09kr5MLHqNu4f580OM7SQQOIgVOedIYYclUzev2FHBbxRAQmib
         qY9NPnCaA7APOEKlmLazHqSn3viBTTAGgoV346RyEgms4KcoMBiMfQNiE8I0EgqYM4+9
         hr8on9QnPATnFIT/VQBHhpeNdUFtuhBW+ehwsd22YX2RVvtcgt2UAXKr1niOmt3OIVZe
         r2ZgwBYYd7AXBBFxIDl1rUsaeBw6mdDOghjWt2/54QK1Y9yMzO6N+VU9cZ3kn7a07gZ0
         /pG+FBpifG1b8ifLQG94Ou9G/LmIjEDt0Dspl5sE0xobI4fmnYeAAa1+cy2S/he8nexH
         iy+g==
X-Gm-Message-State: ANhLgQ02Hpr/vEAdGdY8XplI/auHN2h3cuRePQmRH4cQwnLFug+62KWU
        vyZAg07AZX4nyHijj8dNpQ7d3GnhYJDooPK3b0h2qPQe9j8Fs2DRyPUuOv4gYkw0nXGJab/ENHm
        HOuPDSdavU0AVaTch7LvuU1Tifjv3FdZ4hMZ3QAPFQA==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr2309535pja.174.1585219291696;
        Thu, 26 Mar 2020 03:41:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvtvJeTgPnEHGqTVNs/nJiX7tpC4tKYPn4puM7/6xSliRABW/x4XN6hP9XhPfgKgJi/+xPhqw==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr2309504pja.174.1585219291245;
        Thu, 26 Mar 2020 03:41:31 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id mm18sm1341970pjb.39.2020.03.26.03.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 03:41:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] igb: Use a sperate mutex insead of rtnl_lock()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200326103926.20888-1-kai.heng.feng@canonical.com>
Date:   Thu, 26 Mar 2020 18:41:28 +0800
Cc:     "Brown, Aaron F" <aaron.f.brown@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EEE6C808-A7FC-42B6-8FA7-3958EE4C0BBC@canonical.com>
References: <20200326103926.20888-1-kai.heng.feng@canonical.com>
To:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mar 26, 2020, at 18:39, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Commit 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> fixed race condition between close and power management ops by using
> rtnl_lock().
> 
> This fix is a preparation for next patch, to prevent a dead lock under
> rtnl_lock() when calling runtime resume routine.
> 
> However, we can't use device_lock() in igb_close() because when module
> is getting removed, the lock is already held for igb_remove(), and
> igb_close() gets called during unregistering the netdev, hence causing a
> deadlock. So let's introduce a new mutex so we don't cause a deadlock
> with driver core or netdev core.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please drop "igb: Use device_lock() insead of rtnl_lock()" and use this one instead.
Thanks!

Kai-Heng

> ---
> drivers/net/ethernet/intel/igb/igb_main.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b46bff8fe056..dc7ed5dd216b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -288,6 +288,8 @@ static const struct igb_reg_info igb_reg_info_tbl[] = {
> 	{}
> };
> 
> +static DEFINE_MUTEX(igb_mutex);
> +
> /* igb_regdump - register printout routine */
> static void igb_regdump(struct e1000_hw *hw, struct igb_reg_info *reginfo)
> {
> @@ -4026,9 +4028,14 @@ static int __igb_close(struct net_device *netdev, bool suspending)
> 
> int igb_close(struct net_device *netdev)
> {
> +	int err = 0;
> +
> +	mutex_lock(&igb_mutex);
> 	if (netif_device_present(netdev) || netdev->dismantle)
> -		return __igb_close(netdev, false);
> -	return 0;
> +		err = __igb_close(netdev, false);
> +	mutex_unlock(&igb_mutex);
> +
> +	return err;
> }
> 
> /**
> @@ -8760,7 +8767,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> 	bool wake;
> 
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
> 	netif_device_detach(netdev);
> 
> 	if (netif_running(netdev))
> @@ -8769,7 +8776,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	igb_ptp_suspend(adapter);
> 
> 	igb_clear_interrupt_scheme(adapter);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
> 
> 	status = rd32(E1000_STATUS);
> 	if (status & E1000_STATUS_LU)
> @@ -8897,13 +8904,13 @@ static int __maybe_unused igb_resume(struct device *dev)
> 
> 	wr32(E1000_WUS, ~0);
> 
> -	rtnl_lock();
> +	mutex_lock(&igb_mutex);
> 	if (!err && netif_running(netdev))
> 		err = __igb_open(netdev, true);
> 
> 	if (!err)
> 		netif_device_attach(netdev);
> -	rtnl_unlock();
> +	mutex_unlock(&igb_mutex);
> 
> 	return err;
> }
> -- 
> 2.17.1
> 

