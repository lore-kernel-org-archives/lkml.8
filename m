Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C1FC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375AE2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDGGIR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:08:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34652 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgDGGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:08:16 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLhPD-0005Zm-GC
        for linux-kernel@vger.kernel.org; Tue, 07 Apr 2020 06:08:15 +0000
Received: by mail-pl1-f199.google.com with SMTP id g7so1623785plj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9Ugp4stwtf/wNgGldSIENqPT9PoLpHxx5Ki/Pa6V0pE=;
        b=m7tdoe5biOOupxHK22Uu0efscW2YVFKs41ovpo0ulsmW1nzDQu4XwZvBs1dVS3P/z0
         hAOO7utP4j3NStS3zs5PMpGu9zvHAW63v8ZGhyIx+RT4l0QMj+7IlVrRYJg417x81UyW
         QzC/fz2kRxhNIC//4zIjTlLPWCy7/TrFfveM/m2R/r6IKMPitTESvr12B1SrDQBEn2lK
         vWD9Z1jpmbYgmhA5uJn50T9uMGL6Bw/2rgSGEVMfeFZLMGSsLi+G/i+E6i8Th8qU4t35
         R+esI91Vjj4UK/wKaJ9yrFDal3Grjf9hsCnMHVEZL29bVCLeKMJ4H5MqZROymLeUWexe
         dXpQ==
X-Gm-Message-State: AGi0PuYX+xyj+19AcB13s5trI0acCAWbNhQgrdSE4s+kCFIdalEb1qml
        +tTdwYzFPMg8qJpFA48BCTiwFGDiQxfkmyXD6pDMG4PX0hj3O/QAbBY0sw+oZoz0G9Oa54wElqy
        O7So4CUP+TkTwNVuY03y42XFbd7/Wsmw36KVbGHGQqg==
X-Received: by 2002:a65:6412:: with SMTP id a18mr517482pgv.322.1586239694101;
        Mon, 06 Apr 2020 23:08:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypKm7WeWP+BQJP2ssXkJwPYZCnGokYAzGuDaiDSKMicHiRR++pICN6i+unNEnOmLnyrafpR1WA==
X-Received: by 2002:a65:6412:: with SMTP id a18mr517468pgv.322.1586239693796;
        Mon, 06 Apr 2020 23:08:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 8sm13108207pfv.65.2020.04.06.23.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 23:08:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ata: ahci: Add sysfs attribute to show remapped NVMe
 device count
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <D1CCEA35-D7D4-40E3-85C4-E82FD1154AB7@canonical.com>
Date:   Tue, 7 Apr 2020 14:08:12 +0800
Cc:     anthony.wong@canonical.com,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C378B48F-FA41-4ED2-9B94-1E3102C75136@canonical.com>
References: <20200207100016.32605-1-kai.heng.feng@canonical.com>
 <D1CCEA35-D7D4-40E3-85C4-E82FD1154AB7@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

> On Feb 20, 2020, at 13:45, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
>> On Feb 7, 2020, at 18:00, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> Add a new sysfs attribute to show how many NVMe devices are remapped.
>> 
>> Userspace like distro installer can use this info to ask user to change
>> the BIOS setting.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

Any improvement I can make for this patch?

Kai-Heng

> 
>> ---
>> drivers/ata/ahci.c | 28 ++++++++++++++++++++++++----
>> drivers/ata/ahci.h |  1 +
>> 2 files changed, 25 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 11ea1aff40db..cdbd995a7a6b 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1488,7 +1488,7 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
>> static void ahci_remap_check(struct pci_dev *pdev, int bar,
>> 		struct ahci_host_priv *hpriv)
>> {
>> -	int i, count = 0;
>> +	int i;
>> 	u32 cap;
>> 
>> 	/*
>> @@ -1509,13 +1509,14 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
>> 			continue;
>> 
>> 		/* We've found a remapped device */
>> -		count++;
>> +		hpriv->remapped_nvme++;
>> 	}
>> 
>> -	if (!count)
>> +	if (!hpriv->remapped_nvme)
>> 		return;
>> 
>> -	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
>> +	dev_warn(&pdev->dev, "Found %u remapped NVMe devices.\n",
>> +		 hpriv->remapped_nvme);
>> 	dev_warn(&pdev->dev,
>> 		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
>> 
>> @@ -1635,6 +1636,18 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
>> 	}
>> }
>> 
>> +static ssize_t remapped_nvme_show(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>> +{
>> +	struct ata_host *host = dev_get_drvdata(dev);
>> +	struct ahci_host_priv *hpriv = host->private_data;
>> +
>> +	return sprintf(buf, "%u\n", hpriv->remapped_nvme);
>> +}
>> +
>> +static DEVICE_ATTR_RO(remapped_nvme);
>> +
>> static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> {
>> 	unsigned int board_id = ent->driver_data;
>> @@ -1735,6 +1748,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> 	/* detect remapped nvme devices */
>> 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
>> 
>> +	sysfs_add_file_to_group(&pdev->dev.kobj,
>> +				&dev_attr_remapped_nvme.attr,
>> +				NULL);
>> +
>> 	/* must set flag prior to save config in order to take effect */
>> 	if (ahci_broken_devslp(pdev))
>> 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>> @@ -1886,6 +1903,9 @@ static void ahci_shutdown_one(struct pci_dev *pdev)
>> 
>> static void ahci_remove_one(struct pci_dev *pdev)
>> {
>> +	sysfs_remove_file_from_group(&pdev->dev.kobj,
>> +				     &dev_attr_remapped_nvme.attr,
>> +				     NULL);
>> 	pm_runtime_get_noresume(&pdev->dev);
>> 	ata_pci_remove_one(pdev);
>> }
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index 3dbf398c92ea..d991dd46e89c 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -336,6 +336,7 @@ struct ahci_host_priv {
>> 	u32 			em_loc; /* enclosure management location */
>> 	u32			em_buf_sz;	/* EM buffer size in byte */
>> 	u32			em_msg_type;	/* EM message type */
>> +	u32			remapped_nvme;	/* NVMe remapped device count */
>> 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>> 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
>> 	struct reset_control	*rsts;		/* Optional */
>> -- 
>> 2.17.1
>> 
> 

