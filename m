Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137DFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6624214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCDFsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:48:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgCDFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:48:21 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0245j71Z118398
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 00:48:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yhpwmhmr7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:48:19 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 4 Mar 2020 05:48:17 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 05:48:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0245m86839846112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 05:48:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04DEA4C06A;
        Wed,  4 Mar 2020 05:48:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 602E94C059;
        Wed,  4 Mar 2020 05:48:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 05:48:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7F1EAA023A;
        Wed,  4 Mar 2020 16:48:02 +1100 (AEDT)
Subject: Re: [PATCH v3 20/27] powerpc/powernv/pmem: Forward events to
 userspace
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
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
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Date:   Wed, 04 Mar 2020 16:48:06 +1100
In-Reply-To: <d50b19fc-b88a-b4de-4cc5-07790a4ddac0@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
         <20200221032720.33893-21-alastair@au1.ibm.com>
         <d50b19fc-b88a-b4de-4cc5-07790a4ddac0@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030405-4275-0000-0000-000003A82ABD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030405-4276-0000-0000-000038BD34F1
Message-Id: <6417f5b4e7f30daafaea7cef4b6fc3da46354b08.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 18:02 +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:> @@ -938,6 +955,51 @@
> static 
> int ioctl_controller_stats(struct ocxlpmem *ocxlpmem,
> >   	return rc;
> >   }
> >   
> > +static int ioctl_eventfd(struct ocxlpmem *ocxlpmem,
> > +		 struct ioctl_ocxl_pmem_eventfd __user *uarg)
> > +{
> > +	struct ioctl_ocxl_pmem_eventfd args;
> > +
> > +	if (copy_from_user(&args, uarg, sizeof(args)))
> > +		return -EFAULT;
> > +
> > +	if (ocxlpmem->ev_ctx)
> > +		return -EINVAL;
> 
> I think EBUSY is more appropriate here.
> 

Ok

> > +
> > +	ocxlpmem->ev_ctx = eventfd_ctx_fdget(args.eventfd);
> > +	if (!ocxlpmem->ev_ctx)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ioctl_event_check(struct ocxlpmem *ocxlpmem, u64 __user
> > *uarg)
> > +{
> > +	u64 val = 0;
> > +	int rc;
> > +	u64 chi = 0;
> > +
> > +	rc = ocxlpmem_chi(ocxlpmem, &chi);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_ELA)
> > +		val |= IOCTL_OCXL_PMEM_EVENT_ERROR_LOG_AVAILABLE;
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_CDA)
> > +		val |= IOCTL_OCXL_PMEM_EVENT_CONTROLLER_DUMP_AVAILABLE;
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_CFFS)
> > +		val |= IOCTL_OCXL_PMEM_EVENT_FIRMWARE_FATAL;
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_CHFS)
> > +		val |= IOCTL_OCXL_PMEM_EVENT_HARDWARE_FATAL;
> > +
> > +	rc = copy_to_user((u64 __user *) uarg, &val, sizeof(val));
> > +
> > +	return rc;
> > +}
> > +
> >   static long file_ioctl(struct file *file, unsigned int cmd,
> > unsigned long args)
> >   {
> >   	struct ocxlpmem *ocxlpmem = file->private_data;
> > @@ -966,6 +1028,15 @@ static long file_ioctl(struct file *file,
> > unsigned int cmd, unsigned long args)
> >   		rc = ioctl_controller_stats(ocxlpmem,
> >   					    (struct
> > ioctl_ocxl_pmem_controller_stats __user *)args);
> >   		break;
> > +
> > +	case IOCTL_OCXL_PMEM_EVENTFD:
> > +		rc = ioctl_eventfd(ocxlpmem,
> > +				   (struct ioctl_ocxl_pmem_eventfd
> > __user *)args);
> > +		break;
> > +
> > +	case IOCTL_OCXL_PMEM_EVENT_CHECK:
> > +		rc = ioctl_event_check(ocxlpmem, (u64 __user *)args);
> > +		break;
> >   	}
> >   
> >   	return rc;
> > @@ -1107,6 +1178,146 @@ static void dump_error_log(struct ocxlpmem
> > *ocxlpmem)
> >   	kfree(buf);
> >   }
> >   
> > +static irqreturn_t imn0_handler(void *private)
> > +{
> > +	struct ocxlpmem *ocxlpmem = private;
> > +	u64 chi = 0;
> > +
> > +	(void)ocxlpmem_chi(ocxlpmem, &chi);
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_ELA) {
> > +		dev_warn(&ocxlpmem->dev, "Error log is available\n");
> > +
> > +		if (ocxlpmem->ev_ctx)
> > +			eventfd_signal(ocxlpmem->ev_ctx, 1);
> > +	}
> > +
> > +	if (chi & GLOBAL_MMIO_CHI_CDA) {
> > +		dev_warn(&ocxlpmem->dev, "Controller dump is
> > available\n");
> > +
> > +		if (ocxlpmem->ev_ctx)
> > +			eventfd_signal(ocxlpmem->ev_ctx, 1);
> > +	}
> > +
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t imn1_handler(void *private)
> > +{
> > +	struct ocxlpmem *ocxlpmem = private;
> > +	u64 chi = 0;
> > +
> > +	(void)ocxlpmem_chi(ocxlpmem, &chi);
> > +
> > +	if (chi & (GLOBAL_MMIO_CHI_CFFS | GLOBAL_MMIO_CHI_CHFS)) {
> > +		dev_err(&ocxlpmem->dev,
> > +			"Controller status is fatal, chi=0x%llx, going
> > offline\n", chi);
> > +
> > +		if (ocxlpmem->nvdimm_bus) {
> > +			nvdimm_bus_unregister(ocxlpmem->nvdimm_bus);
> > +			ocxlpmem->nvdimm_bus = NULL;
> > +		}
> > +
> > +		if (ocxlpmem->ev_ctx)
> > +			eventfd_signal(ocxlpmem->ev_ctx, 1);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +
> > +/**
> > + * ocxlpmem_setup_irq() - Set up the IRQs for the OpenCAPI
> > Persistent Memory device
> > + * @ocxlpmem: the device metadata
> > + * Return: 0 on success, negative on failure
> > + */
> > +static int ocxlpmem_setup_irq(struct ocxlpmem *ocxlpmem)
> > +{
> > +	int rc;
> > +	u64 irq_addr;
> > +
> > +	rc = ocxl_afu_irq_alloc(ocxlpmem->ocxl_context, &ocxlpmem-
> > >irq_id[0]);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = ocxl_irq_set_handler(ocxlpmem->ocxl_context, ocxlpmem-
> > >irq_id[0],
> > +				  imn0_handler, NULL, ocxlpmem);
> > +
> > +	irq_addr = ocxl_afu_irq_get_addr(ocxlpmem->ocxl_context,
> > ocxlpmem->irq_id[0]);
> > +	if (!irq_addr)
> > +		return -EINVAL;
> > +
> > +	ocxlpmem->irq_addr[0] = ioremap(irq_addr, PAGE_SIZE);
> > +	if (!ocxlpmem->irq_addr[0])
> > +		return -EINVAL;
> 
> Something other than EINVAL for these two

Ok

> 
> > +
> > +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_IMA0_OHP,
> > +				      OCXL_LITTLE_ENDIAN,
> > +				      (u64)ocxlpmem->irq_addr[0]);
> > +	if (rc)
> > +		goto out_irq0;
> > +
> > +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_IMA0_CFP,
> > +				      OCXL_LITTLE_ENDIAN, 0);
> > +	if (rc)
> > +		goto out_irq0;
> > +
> > +	rc = ocxl_afu_irq_alloc(ocxlpmem->ocxl_context, &ocxlpmem-
> > >irq_id[1]);
> > +	if (rc)
> > +		goto out_irq0;
> > +
> > +
> > +	rc = ocxl_irq_set_handler(ocxlpmem->ocxl_context, ocxlpmem-
> > >irq_id[1],
> > +				  imn1_handler, NULL, ocxlpmem);
> > +	if (rc)
> > +		goto out_irq0;
> > +
> > +	irq_addr = ocxl_afu_irq_get_addr(ocxlpmem->ocxl_context,
> > ocxlpmem->irq_id[1]);
> > +	if (!irq_addr) {
> > +		rc = -EFAULT;
> > +		goto out_irq0;
> > +	}
> > +
> > +	ocxlpmem->irq_addr[1] = ioremap(irq_addr, PAGE_SIZE);
> > +	if (!ocxlpmem->irq_addr[1]) {
> > +		rc = -EINVAL;
> > +		goto out_irq0;
> > +	}
> > +
> > +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_IMA1_OHP,
> > +				      OCXL_LITTLE_ENDIAN,
> > +				      (u64)ocxlpmem->irq_addr[1]);
> > +	if (rc)
> > +		goto out_irq1;
> > +
> > +	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_IMA1_CFP,
> > +				      OCXL_LITTLE_ENDIAN, 0);
> > +	if (rc)
> > +		goto out_irq1;
> > +
> > +	// Enable doorbells
> > +	rc = ocxl_global_mmio_set64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_CHIE,
> > +				    OCXL_LITTLE_ENDIAN,
> > +				    GLOBAL_MMIO_CHI_ELA |
> > GLOBAL_MMIO_CHI_CDA |
> > +				    GLOBAL_MMIO_CHI_CFFS |
> > GLOBAL_MMIO_CHI_CHFS |
> > +				    GLOBAL_MMIO_CHI_NSCRA);
> 
> We don't actually do anything in the handlers with NSCRA...

Good catch, this belongs in the overwrite patch (which was dropped from
this series).

> 
> > +	if (rc)
> > +		goto out_irq1;
> > +
> > +	return 0;
> > +
> > +out_irq1:
> > +	iounmap(ocxlpmem->irq_addr[1]);
> > +	ocxlpmem->irq_addr[1] = NULL;
> > +
> > +out_irq0:
> > +	iounmap(ocxlpmem->irq_addr[0]);
> > +	ocxlpmem->irq_addr[0] = NULL;
> > +
> > +	return rc;
> > +}
> > +
> >   /**
> >    * probe_function0() - Set up function 0 for an OpenCAPI
> > persistent memory device
> >    * This is important as it enables templates higher than 0 across
> > all other functions,
> > @@ -1216,6 +1427,11 @@ static int probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >   		goto err;
> >   	}
> >   
> > +	if (ocxlpmem_setup_irq(ocxlpmem)) {
> > +		dev_err(&pdev->dev, "Could not set up OCXL IRQs\n");
> > +		goto err;
> > +	}
> > +
> >   	if (setup_command_metadata(ocxlpmem)) {
> >   		dev_err(&pdev->dev, "Could not read OCXL command
> > matada\n");
> >   		goto err;
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > index b953ee522ed4..927690f4888f 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > @@ -103,6 +103,10 @@ struct ocxlpmem {
> >   	struct pci_dev *pdev;
> >   	struct cdev cdev;
> >   	struct ocxl_fn *ocxl_fn;
> > +#define SCM_IRQ_COUNT 2
> > +	int irq_id[SCM_IRQ_COUNT];
> > +	struct dev_pagemap irq_pgmap[SCM_IRQ_COUNT];
> > +	void *irq_addr[SCM_IRQ_COUNT];
> 
> I think this should be tagged __iomem
> 

Ok

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

