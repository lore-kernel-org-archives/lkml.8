Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF4C2468A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCBFez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:34:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCBFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:34:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0225YsFp012268
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 00:34:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfm50usx9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:34:54 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Mon, 2 Mar 2020 05:34:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 05:34:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0225YUBS55115938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 05:34:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 628A111C052;
        Mon,  2 Mar 2020 05:34:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB9411C05B;
        Mon,  2 Mar 2020 05:34:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 05:34:29 +0000 (GMT)
Received: from [9.102.43.192] (unknown [9.102.43.192])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7CC49A00BE;
        Mon,  2 Mar 2020 16:34:21 +1100 (AEDT)
Subject: Re: [PATCH v3 16/27] powerpc/powernv/pmem: Register a character
 device for userspace to interact with
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-17-alastair@au1.ibm.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Mon, 2 Mar 2020 16:34:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-17-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030205-0012-0000-0000-0000038C0E32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030205-0013-0000-0000-000021C8BFB4
Message-Id: <1e980dc7-109a-d96f-1329-1c38918e2bba@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=2
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch introduces a character device (/dev/ocxl-scmX) which further
> patches will use to interact with userspace.

As with the comments on other patches in this series, this commit 
message is lacking in explanation. What's the purpose of this device?

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/platforms/powernv/pmem/ocxl.c    | 116 +++++++++++++++++-
>   .../platforms/powernv/pmem/ocxl_internal.h    |   2 +
>   2 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index b8bd7e703b19..63109a870d2c 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -10,6 +10,7 @@
>   #include <misc/ocxl.h>
>   #include <linux/delay.h>
>   #include <linux/ndctl.h>
> +#include <linux/fs.h>
>   #include <linux/mm_types.h>
>   #include <linux/memory_hotplug.h>
>   #include "ocxl_internal.h"
> @@ -339,6 +340,9 @@ static void free_ocxlpmem(struct ocxlpmem *ocxlpmem)
>   
>   	free_minor(ocxlpmem);
>   
> +	if (ocxlpmem->cdev.owner)
> +		cdev_del(&ocxlpmem->cdev);
> +
>   	if (ocxlpmem->metadata_addr)
>   		devm_memunmap(&ocxlpmem->dev, ocxlpmem->metadata_addr);
>   
> @@ -396,6 +400,70 @@ static int ocxlpmem_register(struct ocxlpmem *ocxlpmem)
>   	return device_register(&ocxlpmem->dev);
>   }
>   
> +static void ocxlpmem_put(struct ocxlpmem *ocxlpmem)
> +{
> +	put_device(&ocxlpmem->dev);
> +}
> +
> +static struct ocxlpmem *ocxlpmem_get(struct ocxlpmem *ocxlpmem)
> +{
> +	return (get_device(&ocxlpmem->dev) == NULL) ? NULL : ocxlpmem;
> +}
> +
> +static struct ocxlpmem *find_and_get_ocxlpmem(dev_t devno)
> +{
> +	struct ocxlpmem *ocxlpmem;
> +	int minor = MINOR(devno);
> +	/*
> +	 * We don't declare an RCU critical section here, as our AFU
> +	 * is protected by a re0ference counter on the device. By the time the
> +	 * minor number of a device is removed from the idr, the ref count of
> +	 * the device is already at 0, so no user API will access that AFU and
> +	 * this function can't return it.
> +	 */
> +	ocxlpmem = idr_find(&minors_idr, minor);
> +	if (ocxlpmem)
> +		ocxlpmem_get(ocxlpmem);
> +	return ocxlpmem;
> +}
> +
> +static int file_open(struct inode *inode, struct file *file)
> +{
> +	struct ocxlpmem *ocxlpmem;
> +
> +	ocxlpmem = find_and_get_ocxlpmem(inode->i_rdev);
> +	if (!ocxlpmem)
> +		return -ENODEV;
> +
> +	file->private_data = ocxlpmem;
> +	return 0;
> +}
> +
> +static int file_release(struct inode *inode, struct file *file)
> +{
> +	struct ocxlpmem *ocxlpmem = file->private_data;
> +
> +	ocxlpmem_put(ocxlpmem);
> +	return 0;
> +}
> +
> +static const struct file_operations fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= file_open,
> +	.release	= file_release,
> +};
> +
> +/**
> + * create_cdev() - Create the chardev in /dev for the device
> + * @ocxlpmem: the SCM metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int create_cdev(struct ocxlpmem *ocxlpmem)
> +{
> +	cdev_init(&ocxlpmem->cdev, &fops);
> +	return cdev_add(&ocxlpmem->cdev, ocxlpmem->dev.devt, 1);
> +}
> +
>   /**
>    * ocxlpmem_remove() - Free an OpenCAPI persistent memory device
>    * @pdev: the PCI device information struct
> @@ -572,6 +640,11 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err;
>   	}
>   
> +	if (create_cdev(ocxlpmem)) {
> +		dev_err(&pdev->dev, "Could not create character device\n");
> +		goto err;
> +	}
> +
>   	elapsed = 0;
>   	timeout = ocxlpmem->readiness_timeout + ocxlpmem->memory_available_timeout;
>   	while (!is_usable(ocxlpmem, false)) {
> @@ -613,20 +686,59 @@ static struct pci_driver pci_driver = {
>   	.shutdown = ocxlpmem_remove,
>   };
>   
> +static int file_init(void)
> +{
> +	int rc;
> +
> +	mutex_init(&minors_idr_lock);
> +	idr_init(&minors_idr);
> +
> +	rc = alloc_chrdev_region(&ocxlpmem_dev, 0, NUM_MINORS, "ocxl-pmem");

If the driver is going to be called "ocxlpmem" can we standardise on 
that without the extra hyphen?

> +	if (rc) {
> +		idr_destroy(&minors_idr);
> +		pr_err("Unable to allocate OpenCAPI persistent memory major number: %d\n", rc);
> +		return rc;
> +	}
> +
> +	ocxlpmem_class = class_create(THIS_MODULE, "ocxl-pmem");
> +	if (IS_ERR(ocxlpmem_class)) {
> +		idr_destroy(&minors_idr);
> +		pr_err("Unable to create ocxl-pmem class\n");
> +		unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> +		return PTR_ERR(ocxlpmem_class);
> +	}
> +
> +	return 0;
> +}
> +
> +static void file_exit(void)
> +{
> +	class_destroy(ocxlpmem_class);
> +	unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> +	idr_destroy(&minors_idr);
> +}
> +
>   static int __init ocxlpmem_init(void)
>   {
> -	int rc = 0;
> +	int rc;
>   
> -	rc = pci_register_driver(&pci_driver);
> +	rc = file_init();
>   	if (rc)
>   		return rc;
>   
> +	rc = pci_register_driver(&pci_driver);
> +	if (rc) {
> +		file_exit();
> +		return rc;
> +	}
> +
>   	return 0;
>   }
>   
>   static void ocxlpmem_exit(void)
>   {
>   	pci_unregister_driver(&pci_driver);
> +	file_exit();
>   }
>   
>   module_init(ocxlpmem_init);
-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

