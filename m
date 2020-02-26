Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E6CC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A020732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgBZA3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:29:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbgBZA33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:29:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q0Khxn121699
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:29:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yde1ug5sd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 19:29:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 26 Feb 2020 00:29:25 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 00:29:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q0TI8544302718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 00:29:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6735204F;
        Wed, 26 Feb 2020 00:29:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 73E275204E;
        Wed, 26 Feb 2020 00:29:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C7E00A00F1;
        Wed, 26 Feb 2020 11:29:12 +1100 (AEDT)
Subject: Re: [PATCH v3 06/27] ocxl: Tally up the LPC memory on a link &
 allow it to be mapped
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
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
Date:   Wed, 26 Feb 2020 11:29:16 +1100
In-Reply-To: <4c8f704b-5607-5ca0-c00e-01e412117f6b@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
         <20200221032720.33893-7-alastair@au1.ibm.com>
         <4c8f704b-5607-5ca0-c00e-01e412117f6b@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022600-0028-0000-0000-000003DDFA10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022600-0029-0000-0000-000024A31410
Message-Id: <7833545b1c276ac62651c598af27728b8cacabed.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_09:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=2
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 17:30 +0100, Frederic Barrat wrote:
> 
> Le 21/02/2020 à 04:26, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Tally up the LPC memory on an OpenCAPI link & allow it to be mapped
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   drivers/misc/ocxl/core.c          | 10 ++++++
> >   drivers/misc/ocxl/link.c          | 53
> > +++++++++++++++++++++++++++++++
> >   drivers/misc/ocxl/ocxl_internal.h | 33 +++++++++++++++++++
> >   3 files changed, 96 insertions(+)
> > 
> > diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> > index b7a09b21ab36..2531c6cf19a0 100644
> > --- a/drivers/misc/ocxl/core.c
> > +++ b/drivers/misc/ocxl/core.c
> > @@ -230,8 +230,18 @@ static int configure_afu(struct ocxl_afu *afu,
> > u8 afu_idx, struct pci_dev *dev)
> >   	if (rc)
> >   		goto err_free_pasid;
> >   
> > +	if (afu->config.lpc_mem_size || afu-
> > >config.special_purpose_mem_size) {
> > +		rc = ocxl_link_add_lpc_mem(afu->fn->link, afu-
> > >config.lpc_mem_offset,
> > +					   afu->config.lpc_mem_size +
> > +					   afu-
> > >config.special_purpose_mem_size);
> > +		if (rc)
> > +			goto err_free_mmio;
> > +	}
> > +
> >   	return 0;
> >   
> > +err_free_mmio:
> > +	unmap_mmio_areas(afu);
> >   err_free_pasid:
> >   	reclaim_afu_pasid(afu);
> >   err_free_actag:
> > diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> > index 58d111afd9f6..1e039cc5ebe5 100644
> > --- a/drivers/misc/ocxl/link.c
> > +++ b/drivers/misc/ocxl/link.c
> > @@ -84,6 +84,11 @@ struct ocxl_link {
> >   	int dev;
> >   	atomic_t irq_available;
> >   	struct spa *spa;
> > +	struct mutex lpc_mem_lock; /* protects lpc_mem & lpc_mem_sz */
> > +	u64 lpc_mem_sz; /* Total amount of LPC memory presented on the
> > link */
> > +	u64 lpc_mem;
> > +	int lpc_consumers;
> > +
> >   	void *platform_data;
> >   };
> >   static struct list_head links_list = LIST_HEAD_INIT(links_list);
> > @@ -396,6 +401,8 @@ static int alloc_link(struct pci_dev *dev, int
> > PE_mask, struct ocxl_link **out_l
> >   	if (rc)
> >   		goto err_spa;
> >   
> > +	mutex_init(&link->lpc_mem_lock);
> > +
> >   	/* platform specific hook */
> >   	rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
> >   				&link->platform_data);
> > @@ -711,3 +718,49 @@ void ocxl_link_free_irq(void *link_handle, int
> > hw_irq)
> >   	atomic_inc(&link->irq_available);
> >   }
> >   EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
> > +
> > +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size)
> > +{
> > +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> > +
> > +	// Check for overflow
> > +	if (offset > (offset + size))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&link->lpc_mem_lock);
> > +	link->lpc_mem_sz = max(link->lpc_mem_sz, offset + size);
> > +
> > +	mutex_unlock(&link->lpc_mem_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
> > +{
> > +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> > +
> > +	mutex_lock(&link->lpc_mem_lock);
> > +
> > +	if(!link->lpc_mem)
> > +		link->lpc_mem = pnv_ocxl_platform_lpc_setup(pdev, link-
> > >lpc_mem_sz);
> > +
> > +	if(link->lpc_mem)
> > +		link->lpc_consumers++;
> > +	mutex_unlock(&link->lpc_mem_lock);
> > +
> > +	return link->lpc_mem;
> > +}
> > +
> > +void ocxl_link_lpc_release(void *link_handle, struct pci_dev
> > *pdev)
> > +{
> > +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> > +
> > +	mutex_lock(&link->lpc_mem_lock);
> > +	WARN_ON(--link->lpc_consumers < 0);
> 
> Here, we always decrement the lpc_consumers count. However, it was
> only 
> incremented if the mapping was setup correctly in opal.
> 
> We could arguably claim that ocxl_link_lpc_release() should only be 
> called if ocxl_link_lpc_map() succeeded, but it would make error
> path 
> handling easier if we only decrement the lpc_consumers count if 
> link->lpc_mem is set. So that we can just call
> ocxl_link_lpc_release() 
> in error paths without having to worry about triggering the WARN_ON
> message.
> 
>    Fred
> 
> 

Ok, this makes sense.

> 
> > +	if (link->lpc_consumers == 0) {
> > +		pnv_ocxl_platform_lpc_release(pdev);
> > +		link->lpc_mem = 0;
> > +	}
> > +
> > +	mutex_unlock(&link->lpc_mem_lock);
> > +}
> > diff --git a/drivers/misc/ocxl/ocxl_internal.h
> > b/drivers/misc/ocxl/ocxl_internal.h
> > index 198e4e4bc51d..d0c8c4838f42 100644
> > --- a/drivers/misc/ocxl/ocxl_internal.h
> > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > @@ -142,4 +142,37 @@ int ocxl_irq_offset_to_id(struct ocxl_context
> > *ctx, u64 offset);
> >   u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
> >   void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
> >   
> > +/**
> > + * ocxl_link_add_lpc_mem() - Increment the amount of memory
> > required by an OpenCAPI link
> > + *
> > + * @link_handle: The OpenCAPI link handle
> > + * @offset: The offset of the memory to add
> > + * @size: The amount of memory to increment by
> > + *
> > + * Returns 0 on success, negative on overflow
> > + */
> > +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64
> > size);
> > +
> > +/**
> > + * ocxl_link_lpc_map() - Map the LPC memory for an OpenCAPI device
> > + * Since LPC memory belongs to a link, the whole LPC memory
> > available
> > + * on the link must be mapped in order to make it accessible to a
> > device.
> > + * @link_handle: The OpenCAPI link handle
> > + * @pdev: A device that is on the link
> > + *
> > + * Returns the address of the mapped LPC memory, or 0 on error
> > + */
> > +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
> > +
> > +/**
> > + * ocxl_link_lpc_release() - Release the LPC memory device for an
> > OpenCAPI device
> > + *
> > + * Offlines LPC memory on an OpenCAPI link for a device. If this
> > is the
> > + * last device on the link to release the memory, unmap it from
> > the link.
> > + *
> > + * @link_handle: The OpenCAPI link handle
> > + * @pdev: A device that is on the link
> > + */
> > +void ocxl_link_lpc_release(void *link_handle, struct pci_dev
> > *pdev);
> > +
> >   #endif /* _OCXL_INTERNAL_H_ */
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

