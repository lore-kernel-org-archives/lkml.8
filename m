Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D8D20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593505189;
	bh=GhPQvOxQYxn4OCbLRhQnz9NsFcYnYCPuk1ZnCBU2bb4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UmpUZgow2CPsVkyEY2WLVUIpMpQy4LXvOkbay1n3aPH1QaDYw8K9aYZ7vh4RKzLkJ
	 gHrfsBhfVO9m9mEYQgftYkZuTxvGhbnzHZDYOJrDDWaljIIKADbAnFIUOWSF0jP/tl
	 yizM/5ZkXuZwZgFYyAsDlbp1mhJaonLrh8espUi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgF3ITs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:19:48 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:32814 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbgF3ITp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:19:45 -0400
Received: by mail-ej1-f67.google.com with SMTP id n26so5645280ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvNDb619PND9BSnOO/FTgYwwF+7N75fMEl+ZD4EKqsM=;
        b=eMWO5dMpyuuKoC1e3H/9ut0wE3rsfuQc1TdA6U+47Ka3S1BXmH0febTyfL7ODEZ9U6
         /PvdRkUcK28YmLGj1STJsT510Ys3Ld4MXYbrtFDmEVMnA4jVuDLde//gehcXTVZQ5c/j
         AB2MY7zkzMXZjlcWZ7mQ0SQtJNM2nSQr2yBVSpdT2HwUdvGWcrXak+NMyOUDam9jcCBQ
         iBRve8SFn6OQz+SBQCcEb0UCv2Jhy+lwKi0ufnBAwg4RrnQouYHgcQCJg6MYYShpqlc9
         5NKzEG+BhfTGtQKqcaA16XNdmYtFlUemfO8E8XtzqoX3/BGC7fhRYpjnUK+bwXBAA6DV
         GboQ==
X-Gm-Message-State: AOAM533/prxHtrU/ZdIeczcvefDckW95KxTnRxTR8vTHF7UQZ/toZBe6
        l2uXjDt08JML+TR/xKpVsxI=
X-Google-Smtp-Source: ABdhPJx1S2bMBQqMtx4WXGh/d/lkwjOBn+S/nzIRGYuA9KRMjCqnTzm3OP/1N3JVGlohhgDY6AJQBw==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr17835137ejc.195.1593505183733;
        Tue, 30 Jun 2020 01:19:43 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id w8sm1999763eds.41.2020.06.30.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 01:19:43 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] misc/phantom.c: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dubov <oakad@yahoo.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
 <20200629081531.214734-5-vaibhavgupta40@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <164d7366-27f5-c764-3122-5c4a0239e66f@kernel.org>
Date:   Tue, 30 Jun 2020 10:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629081531.214734-5-vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 06. 20, 10:15, Vaibhav Gupta wrote:
> With the support of generic PM callbacks, drivers no longer need to use
> legacy .suspend() and .resume() in which they had to maintain PCI states
> changes and device's power state themselves. All required operations are
> done by PCI core.
> 
> Driver needs to do only device-specific operations.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

From the driver's POV:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>  drivers/misc/phantom.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
> index 6a5ed0e25ff1..ce72e46a2e73 100644
> --- a/drivers/misc/phantom.c
> +++ b/drivers/misc/phantom.c
> @@ -457,31 +457,26 @@ static void phantom_remove(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -#ifdef CONFIG_PM
> -static int phantom_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused phantom_suspend(struct device *dev_d)
>  {
> -	struct phantom_device *dev = pci_get_drvdata(pdev);
> +	struct phantom_device *dev = dev_get_drvdata(dev_d);
>  
>  	iowrite32(0, dev->caddr + PHN_IRQCTL);
>  	ioread32(dev->caddr + PHN_IRQCTL); /* PCI posting */
>  
> -	synchronize_irq(pdev->irq);
> +	synchronize_irq(to_pci_dev(dev_d)->irq);
>  
>  	return 0;
>  }
>  
> -static int phantom_resume(struct pci_dev *pdev)
> +static int __maybe_unused phantom_resume(struct device *dev_d)
>  {
> -	struct phantom_device *dev = pci_get_drvdata(pdev);
> +	struct phantom_device *dev = dev_get_drvdata(dev_d);
>  
>  	iowrite32(0, dev->caddr + PHN_IRQCTL);
>  
>  	return 0;
>  }
> -#else
> -#define phantom_suspend	NULL
> -#define phantom_resume	NULL
> -#endif
>  
>  static struct pci_device_id phantom_pci_tbl[] = {
>  	{ .vendor = PCI_VENDOR_ID_PLX, .device = PCI_DEVICE_ID_PLX_9050,
> @@ -491,13 +486,14 @@ static struct pci_device_id phantom_pci_tbl[] = {
>  };
>  MODULE_DEVICE_TABLE(pci, phantom_pci_tbl);
>  
> +static SIMPLE_DEV_PM_OPS(phantom_pm_ops, phantom_suspend, phantom_resume);
> +
>  static struct pci_driver phantom_pci_driver = {
>  	.name = "phantom",
>  	.id_table = phantom_pci_tbl,
>  	.probe = phantom_probe,
>  	.remove = phantom_remove,
> -	.suspend = phantom_suspend,
> -	.resume = phantom_resume
> +	.driver.pm = &phantom_pm_ops,
>  };
>  
>  static CLASS_ATTR_STRING(version, 0444, PHANTOM_VERSION);
> 


-- 
js
