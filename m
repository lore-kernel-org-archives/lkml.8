Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E30C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCBR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:58:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgCBR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:58:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022HpmZb021174
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 12:58:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfnbf2fg7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:58:54 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Mon, 2 Mar 2020 17:58:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 17:58:43 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022HwfGx50790480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 17:58:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1D094C044;
        Mon,  2 Mar 2020 17:58:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4A84C04A;
        Mon,  2 Mar 2020 17:58:40 +0000 (GMT)
Received: from pic2.home (unknown [9.145.49.157])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 17:58:40 +0000 (GMT)
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
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
 <20200221032720.33893-16-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Mon, 2 Mar 2020 18:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-16-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030217-0008-0000-0000-000003588719
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030217-0009-0000-0000-00004A79B3A6
Message-Id: <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
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
> Similar to the previous patch, this adds support for near storage commands.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---


Is any of these new functions ever called?

   Fred


>   arch/powerpc/platforms/powernv/pmem/ocxl.c    |  6 +++
>   .../platforms/powernv/pmem/ocxl_internal.c    | 41 +++++++++++++++++++
>   .../platforms/powernv/pmem/ocxl_internal.h    | 37 +++++++++++++++++
>   3 files changed, 84 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> index 4e782d22605b..b8bd7e703b19 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> @@ -259,12 +259,18 @@ static int setup_command_metadata(struct ocxlpmem *ocxlpmem)
>   	int rc;
>   
>   	mutex_init(&ocxlpmem->admin_command.lock);
> +	mutex_init(&ocxlpmem->ns_command.lock);
>   
>   	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_ACMA_CREQO,
>   				      &ocxlpmem->admin_command);
>   	if (rc)
>   		return rc;
>   
> +	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_NSCMA_CREQO,
> +					  &ocxlpmem->ns_command);
> +	if (rc)
> +		return rc;
> +
>   	return 0;
>   }
>   
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> index 583f48023025..3e0b133feddf 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> @@ -133,6 +133,47 @@ int admin_response_handled(const struct ocxlpmem *ocxlpmem)
>   				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
>   }
>   
> +int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code)
> +{
> +	u64 val;
> +	int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHI,
> +					 OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
> +		return -EBUSY;
> +
> +	return scm_command_request(ocxlpmem, &ocxlpmem->ns_command, op_code);
> +}
> +
> +int ns_response(const struct ocxlpmem *ocxlpmem)
> +{
> +	return command_response(ocxlpmem, &ocxlpmem->ns_command);
> +}
> +
> +int ns_command_execute(const struct ocxlpmem *ocxlpmem)
> +{
> +	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_NSCRW);
> +}
> +
> +bool ns_command_complete(const struct ocxlpmem *ocxlpmem)
> +{
> +	u64 val = 0;
> +	int rc = ocxlpmem_chi(ocxlpmem, &val);
> +
> +	WARN_ON(rc);
> +
> +	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
> +}
> +
> +int ns_response_handled(const struct ocxlpmem *ocxlpmem)
> +{
> +	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHIC,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
> +}
> +
>   void warn_status(const struct ocxlpmem *ocxlpmem, const char *message,
>   		     u8 status)
>   {
> diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> index 2fef68c71271..28e2020f6355 100644
> --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> @@ -107,6 +107,7 @@ struct ocxlpmem {
>   	struct ocxl_context *ocxl_context;
>   	void *metadata_addr;
>   	struct command_metadata admin_command;
> +	struct command_metadata ns_command;
>   	struct resource pmem_res;
>   	struct nd_region *nd_region;
>   	char fw_version[8+1];
> @@ -175,6 +176,42 @@ int admin_command_complete_timeout(const struct ocxlpmem *ocxlpmem,
>    */
>   int admin_response_handled(const struct ocxlpmem *ocxlpmem);
>   
> +/**
> + * ns_command_request() - Issue a near storage command request
> + * @ocxlpmem: the device metadata
> + * @op_code: The op-code for the command
> + * Returns an identifier for the command, or negative on error
> + */
> +int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code);
> +
> +/**
> + * ns_response() - Validate a near storage response
> + * @ocxlpmem: the device metadata
> + * Returns the status code of the command, or negative on error
> + */
> +int ns_response(const struct ocxlpmem *ocxlpmem);
> +
> +/**
> + * ns_command_execute() - Notify the controller to start processing a pending near storage command
> + * @ocxlpmem: the device metadata
> + * Returns 0 on success, negative on error
> + */
> +int ns_command_execute(const struct ocxlpmem *ocxlpmem);
> +
> +/**
> + * ns_command_complete() - Is a near storage command executing
> + * @ocxlpmem: the device metadata
> + * Returns true if the previous admin command has completed
> + */
> +bool ns_command_complete(const struct ocxlpmem *ocxlpmem);
> +
> +/**
> + * ns_response_handled() - Notify the controller that the near storage response has been handled
> + * @ocxlpmem: the device metadata
> + * Returns 0 on success, negative on failure
> + */
> +int ns_response_handled(const struct ocxlpmem *ocxlpmem);
> +
>   /**
>    * warn_status() - Emit a kernel warning showing a command status.
>    * @ocxlpmem: the device metadata
> 

