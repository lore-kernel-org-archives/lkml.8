Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD0621548
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ql8e9lUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgF0NJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:09:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgF0NJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:09:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RCwW3Q157642;
        Sat, 27 Jun 2020 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=y6Z3ndKwcdvb/o527oos0Vmmml29kOeFL0WHa87IivU=;
 b=Ql8e9lUtJMlfraXeMxmr7CbqCK9xuMbtf7EWIRx61zzfGC2opBP3kGLATC2sx1f0RDA2
 d0Lvy+oGkcU29Lff/OVWhty22/vB9iokcaJ6FClpQ297FuDtl5L2ayJQDzxF7ZNUJmmv
 E0efY9Sop8sMj7xOUd25EAaXgcWhXaz9lpxi4auYpPgM6aHGFBgG/WaPE1HNt+Bf+UoY
 5LFHxswr0Nv7qmXarlD7O7Bocr93+xlVe3um0N5oefhuS5x2pIEkyzqdCUFhcMDumXn1
 hrpafsd3CKEf2aQ9rCHTQgUpIIQRcKEDTyGq285awLJVP5wytvkyghJUfa8F/Boo0Oup Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wxrmru6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Jun 2020 13:09:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RCvZxY049144;
        Sat, 27 Jun 2020 13:09:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31wu7s3k7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Jun 2020 13:09:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RD9Mij009209;
        Sat, 27 Jun 2020 13:09:22 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Jun 2020 13:09:21 +0000
Date:   Sat, 27 Jun 2020 16:09:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, robin.murphy@arm.com,
        m.szyprowski@samsung.com, hch@lst.de
Subject: Re: Passing NULL dev to dma_alloc_coherent() allowed or not?
Message-ID: <20200627130915.GF2571@kadam>
References: <1669515915.65540.1593258316061.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669515915.65540.1593258316061.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 01:45:16PM +0200, Richard Weinberger wrote:
> Hi!
> 
> While porting on an old out-of-tree driver I noticed that dma_alloc_coherent()
> was used with dev being NULL.
> 
> commit 148a97d5a02a62f81b5d6176f871c94a65e1f3af
> Author: Dan Carpenter <dan.carpenter@oracle.com>
> Date:   Wed Apr 24 17:24:37 2019 +0300
> 
>     dma-mapping: remove an unnecessary NULL check
>     
>     We already dereferenced "dev" when we called get_dma_ops() so this NULL
>     check is too late.  We're not supposed to pass NULL "dev" pointers to
>     dma_alloc_attrs().
>     
>     Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> says that dma_alloc_attrs() with dev being NULL is not allowed, but in
> include/linux/dma-mapping.h we have:
> 
> static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>                 dma_addr_t *dma_handle, gfp_t gfp)
> {
> 
>         return dma_alloc_attrs(dev, size, dma_handle, gfp,
>                         (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
> }
> 
> In Linus' tree I see at least three callers of dma_alloc_coherent() with a NULL device.
> drivers/staging/emxx_udc/emxx_udc.c:2596:                       ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
> drivers/tty/synclink.c:3667:            info->buffer_list = dma_alloc_coherent(NULL, BUFFERLISTSIZE, &info->buffer_list_dma_addr, GFP_KERNEL);
> drivers/tty/synclink.c:3777:                    BufferList[i].virt_addr = dma_alloc_coherent(NULL, DMABUFFERSIZE, &BufferList[i].dma_addr, GFP_KERNEL);
> 
> I think these callers are wrong.
> Can you please clarify?

The are wrong.  It was slightly worse when I originally sent the patch
but we fixed comedi.


https://lkml.org/lkml/2019/4/24/668

regards,
dan carpenter

