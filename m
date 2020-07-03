Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8BB20884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linux-powerpc-org.20150623.gappssmtp.com header.i=@linux-powerpc-org.20150623.gappssmtp.com header.b="De8MqE6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGCQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:18:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E2C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 09:18:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so34789175ejd.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qiEZaKZ9FC6yDmrpUiBYeXNjpNa2H+Da4zGNKkrzBmA=;
        b=De8MqE6obLkfjvoFPW9CRmvzox7ddURkpzlnlbuIHhuhT1ugHuW25ywzcQfHfRQFRf
         dXOm3vwqSpxXpMngdWyV5KB4W1cVUJC+A7VcC+MIV8qVStAJSY4lE4K6n1/czDejlJhF
         LK7H2rqhTlcl6dKw2adPgEJwvOqC/bK/52/T78IKh3IiCUDGdlkk2cAoQSKORZdwFMsH
         n06pPHDrAhU/v4uc+Dz35b+pIg0aCfMLnSy/1bub8Uwf/xrhhOVX3VXgCvSWxA4d7edq
         mZdTDGKBawOcplvf7HTh3glcWRRanARemg+Vr8567Qn105IeVxQC7IoP5U+dmSXI+ZdP
         BQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qiEZaKZ9FC6yDmrpUiBYeXNjpNa2H+Da4zGNKkrzBmA=;
        b=Fj8m+eDsYzCxY/HM7OM9j5HaUdm0kwiTzpVdhIYxJcL6XNf+DXS5XNsXUpDusZxZAr
         DaDBZ33035RMVHpdtJ2LnPTmsSLgFnjHSZ3i1ziX0WAZHNPBkHtMubG3uq7qsEyxFd51
         HgI9b4z8FDOFPanvukrZ0fnAp6rBRPDuuIulAV2FbaqQx5GMN3mmN3qbPtx1mmWjZthh
         zb/wvVlj8hniVhUdpzSAEb1kqUoh9lVS9bCj1ChRxrwQb0Dasu/LTQ9IOvkwDWyDEXjX
         wryBqWHVUAVp8OxWOWmCN6R7N8xtmHskvC8QRR21ABUIpRQaKkL8tzXzx1uZqwC16qNp
         xwKA==
X-Gm-Message-State: AOAM531274oXjWc+tl+YBi7MbVbSypXLn0suqEmFm9k71rsbRZZFjeaK
        G7LZ7ddX0WilO7hHmX1gGk7CgjCaheml49aUiiUxXA==
X-Google-Smtp-Source: ABdhPJzNQSVXnsqFLLCySL5wP60ViOog3L1iCfEO8JhHHdp4TE/25m2500UQlvy/RsLvr8DPsk5X+QCQrIVMvUtuToA=
X-Received: by 2002:a17:906:6897:: with SMTP id n23mr31801112ejr.473.1593793104893;
 Fri, 03 Jul 2020 09:18:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:3a1b:0:0:0:0:0 with HTTP; Fri, 3 Jul 2020 09:18:24 -0700 (PDT)
X-Originating-IP: [5.35.13.201]
In-Reply-To: <20200701165057.667799-7-vaibhavgupta40@gmail.com>
References: <20200701165057.667799-1-vaibhavgupta40@gmail.com> <20200701165057.667799-7-vaibhavgupta40@gmail.com>
From:   Denis Kirjanov <kda@linux-powerpc.org>
Date:   Fri, 3 Jul 2020 19:18:24 +0300
Message-ID: <CAOJe8K0aYeba0fOpSz6dzgWUwAP8FTyOpQc8rckWO=RPTKiprw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] sundance: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Dillow <dave@thedillows.org>,
        Ion Badulescu <ionut@badula.org>,
        Netanel Belgazal <netanel@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Zorik Machulsky <zorik@amazon.com>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jon Mason <jdmason@kudzu.us>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20, Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> With legacy PM, drivers themselves were responsible for managing the
> device's power states and takes care of register states.
>
> After upgrading to the generic structure, PCI core will take care of
> required tasks and drivers should do only device-specific operations.
>
> Thus, there is no need to call the PCI helper functions like
> pci_enable/disable_device(), pci_save/restore_sate() and
> pci_set_power_state().
>
> Compile-tested only.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Should be fine. I'll try to test it in the upcoming weekend

> ---
>  drivers/net/ethernet/dlink/sundance.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/dlink/sundance.c
> b/drivers/net/ethernet/dlink/sundance.c
> index dc566fcc3ba9..ca97e321082d 100644
> --- a/drivers/net/ethernet/dlink/sundance.c
> +++ b/drivers/net/ethernet/dlink/sundance.c
> @@ -1928,11 +1928,9 @@ static void sundance_remove1(struct pci_dev *pdev)
>  	}
>  }
>
> -#ifdef CONFIG_PM
> -
> -static int sundance_suspend(struct pci_dev *pci_dev, pm_message_t state)
> +static int __maybe_unused sundance_suspend(struct device *dev_d)
>  {
> -	struct net_device *dev = pci_get_drvdata(pci_dev);
> +	struct net_device *dev = dev_get_drvdata(dev_d);
>  	struct netdev_private *np = netdev_priv(dev);
>  	void __iomem *ioaddr = np->base;
>
> @@ -1942,30 +1940,24 @@ static int sundance_suspend(struct pci_dev *pci_dev,
> pm_message_t state)
>  	netdev_close(dev);
>  	netif_device_detach(dev);
>
> -	pci_save_state(pci_dev);
>  	if (np->wol_enabled) {
>  		iowrite8(AcceptBroadcast | AcceptMyPhys, ioaddr + RxMode);
>  		iowrite16(RxEnable, ioaddr + MACCtrl1);
>  	}
> -	pci_enable_wake(pci_dev, pci_choose_state(pci_dev, state),
> -			np->wol_enabled);
> -	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
> +
> +	device_set_wakeup_enable(dev_d, np->wol_enabled);
>
>  	return 0;
>  }
>
> -static int sundance_resume(struct pci_dev *pci_dev)
> +static int __maybe_unused sundance_resume(struct device *dev_d)
>  {
> -	struct net_device *dev = pci_get_drvdata(pci_dev);
> +	struct net_device *dev = dev_get_drvdata(dev_d);
>  	int err = 0;
>
>  	if (!netif_running(dev))
>  		return 0;
>
> -	pci_set_power_state(pci_dev, PCI_D0);
> -	pci_restore_state(pci_dev);
> -	pci_enable_wake(pci_dev, PCI_D0, 0);
> -
>  	err = netdev_open(dev);
>  	if (err) {
>  		printk(KERN_ERR "%s: Can't resume interface!\n",
> @@ -1979,17 +1971,14 @@ static int sundance_resume(struct pci_dev *pci_dev)
>  	return err;
>  }
>
> -#endif /* CONFIG_PM */
> +static SIMPLE_DEV_PM_OPS(sundance_pm_ops, sundance_suspend,
> sundance_resume);
>
>  static struct pci_driver sundance_driver = {
>  	.name		= DRV_NAME,
>  	.id_table	= sundance_pci_tbl,
>  	.probe		= sundance_probe1,
>  	.remove		= sundance_remove1,
> -#ifdef CONFIG_PM
> -	.suspend	= sundance_suspend,
> -	.resume		= sundance_resume,
> -#endif /* CONFIG_PM */
> +	.driver.pm	= &sundance_pm_ops,
>  };
>
>  static int __init sundance_init(void)
> --
> 2.27.0
>
>
