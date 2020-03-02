Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D87EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234D2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCBRvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:51:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbgCBRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:51:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022HpmEA021166
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 12:51:51 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbf2a28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:51:50 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Mon, 2 Mar 2020 17:51:17 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 17:51:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022Hp8EA36372512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 17:51:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B71B4C04E;
        Mon,  2 Mar 2020 17:51:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F86F4C046;
        Mon,  2 Mar 2020 17:51:07 +0000 (GMT)
Received: from pic2.home (unknown [9.145.49.157])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 17:51:07 +0000 (GMT)
Subject: Re: [PATCH v3 13/27] powerpc/powernv/pmem: Read the capability
 registers & wait for device ready
To:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
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
 <20200221032720.33893-14-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Mon, 2 Mar 2020 18:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-14-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030217-0028-0000-0000-000003E01506
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030217-0029-0000-0000-000024A53ED2
Message-Id: <3d2de7c1-ee95-ed6c-0346-4a1d20a0b75e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_06:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/02/2020 à 04:27, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch reads timeouts & firmware version from the controller, and
> uses those timeouts to wait for the controller to report that it is ready
> before handing the memory over to libnvdimm.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/platforms/powernv/pmem/Makefile  |  2 +-
>   arch/powerpc/platforms/powernv/pmem/ocxl.c    | 92 +++++++++++++++++++
>   .../platforms/powernv/pmem/ocxl_internal.c    | 19 ++++
>   .../platforms/powernv/pmem/ocxl_internal.h    | 24 +++++
>   4 files changed, 136 insertions(+), 1 deletion(-)
>   create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/Makefile b/arch/powerpc/platforms/powernv/pmem/Makefile
> index 1c55c4193175..4ceda25907d4 100644
> --- a/arch/powerpc/platforms/powernv/pmem/Makefile
> +++ b/arch/powerpc/platforms/powernv/pmem/Makefile
> @@ -4,4 +4,4 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
>   
>   obj-$(CONFIG_OCXL_PMEM) += ocxlpmem.o
>   
> -ocxlpmem-y := ocxl.o
> +ocxlpmem-y := ocxl.o ocxl_internal.o
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index 3c4eeb5dcc0f..431212c9f0cc 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/module.h>
>   #include <misc/ocxl.h>
> +#include <linux/delay.h>
>   #include <linux/ndctl.h>
>   #include <linux/mm_types.h>
>   #include <linux/memory_hotplug.h>
> @@ -215,6 +216,36 @@ static int register_lpc_mem(struct ocxlpmem *ocxlpmem)
>   	return 0;
>   }
>   
> +/**
> + * is_usable() - Is a controller usable?
> + * @ocxlpmem: the device metadata
> + * @verbose: True to log errors
> + * Return: true if the controller is usable
> + */
> +static bool is_usable(const struct ocxlpmem *ocxlpmem, bool verbose)
> +{
> +	u64 chi = 0;
> +	int rc = ocxlpmem_chi(ocxlpmem, &chi);
> +
> +	if (rc < 0)
> +		return false;
> +
> +	if (!(chi & GLOBAL_MMIO_CHI_CRDY)) {
> +		if (verbose)
> +			dev_err(&ocxlpmem->dev, "controller is not ready.\n");
> +		return false;
> +	}
> +
> +	if (!(chi & GLOBAL_MMIO_CHI_MA)) {
> +		if (verbose)
> +			dev_err(&ocxlpmem->dev,
> +				"controller does not have memory available.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   /**
>    * allocate_minor() - Allocate a minor number to use for an OpenCAPI pmem device
>    * @ocxlpmem: the device metadata
> @@ -328,6 +359,48 @@ static void ocxlpmem_remove(struct pci_dev *pdev)
>   	}
>   }
>   
> +/**
> + * read_device_metadata() - Retrieve config information from the AFU and save it for future use
> + * @ocxlpmem: the device metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int read_device_metadata(struct ocxlpmem *ocxlpmem)
> +{
> +	u64 val;
> +	int rc;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CCAP0,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	ocxlpmem->scm_revision = val & 0xFFFF;
> +	ocxlpmem->read_latency = (val >> 32) & 0xFF;
> +	ocxlpmem->readiness_timeout = (val >> 48) & 0x0F;
> +	ocxlpmem->memory_available_timeout = val >> 52;
> +
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CCAP1,
> +				     OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	ocxlpmem->max_controller_dump_size = val & 0xFFFFFFFF;
> +
> +	// Extract firmware version text
> +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_FWVER,
> +				     OCXL_HOST_ENDIAN, (u64 *)ocxlpmem->fw_version);
> +	if (rc)
> +		return rc;
> +
> +	ocxlpmem->fw_version[8] = '\0';
> +
> +	dev_info(&ocxlpmem->dev,
> +		 "Firmware version '%s' SCM revision %d:%d\n", ocxlpmem->fw_version,
> +		 ocxlpmem->scm_revision >> 4, ocxlpmem->scm_revision & 0x0F);
> +
> +	return 0;
> +}
> +
>   /**
>    * probe_function0() - Set up function 0 for an OpenCAPI persistent memory device
>    * This is important as it enables templates higher than 0 across all other functions,
> @@ -368,6 +441,7 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	struct ocxlpmem *ocxlpmem;
>   	int rc;
> +	u16 elapsed, timeout;
>   
>   	if (PCI_FUNC(pdev->devfn) == 0)
>   		return probe_function0(pdev);
> @@ -422,6 +496,24 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err;
>   	}
>   
> +	if (read_device_metadata(ocxlpmem)) {
> +		dev_err(&pdev->dev, "Could not read metadata\n");



Need to set rc



> +		goto err;
> +	}
> +
> +	elapsed = 0;
> +	timeout = ocxlpmem->readiness_timeout + ocxlpmem->memory_available_timeout;
> +	while (!is_usable(ocxlpmem, false)) {
> +		if (elapsed++ > timeout) {
> +			dev_warn(&ocxlpmem->dev, "OpenCAPI Persistent Memory ready timeout.\n");
> +			(void)is_usable(ocxlpmem, true);


I guess that extra call to is_usable() is just to log the cause of the 
error. However, with some bad luck, the call could now succeed.


   Fred


> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		msleep(1000);
> +	}
> +
>   	rc = register_lpc_mem(ocxlpmem);
>   	if (rc) {
>   		dev_err(&pdev->dev, "Could not register OpenCAPI persistent memory with libnvdimm\n");
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> new file mode 100644
> index 000000000000..617ca943b1b8
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 IBM Corp.
> +
> +#include <misc/ocxl.h>
> +#include <linux/delay.h>
> +#include "ocxl_internal.h"
> +
> +int ocxlpmem_chi(const struct ocxlpmem *ocxlpmem, u64 *chi)
> +{
> +	u64 val;
> +	int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHI,
> +					 OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	*chi = val;
> +
> +	return 0;
> +}
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> index 9cf3e42750e7..ba0301533d00 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> @@ -97,4 +97,28 @@ struct ocxlpmem {
>   	void *metadata_addr;
>   	struct resource pmem_res;
>   	struct nd_region *nd_region;
> +	char fw_version[8+1];
> +
> +	u32 max_controller_dump_size;
> +	u16 scm_revision; // major/minor
> +	u8 readiness_timeout;  /* The worst case time (in seconds) that the host shall
> +				* wait for the controller to become operational following a reset (CHI.CRDY).
> +				*/
> +	u8 memory_available_timeout;   /* The worst case time (in seconds) that the host shall
> +					* wait for memory to become available following a reset (CHI.MA).
> +					*/
> +
> +	u16 read_latency; /* The nominal measure of latency (in nanoseconds)
> +			   * associated with an unassisted read of a memory block.
> +			   * This represents the capability of the raw media technology without assistance
> +			   */
>   };
> +
> +/**
> + * ocxlpmem_chi() - Get the value of the CHI register
> + * @ocxlpmem: the device metadata
> + * @chi: returns the CHI value
> + *
> + * Returns 0 on success, negative on error
> + */
> +int ocxlpmem_chi(const struct ocxlpmem *ocxlpmem, u64 *chi);
> 

