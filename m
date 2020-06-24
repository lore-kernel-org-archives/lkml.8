Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8621C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29AD20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tq1ZXb5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbgFXVNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:13:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbgFXVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:13:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OL7ti3079031;
        Wed, 24 Jun 2020 21:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=p12IwfDSTjlrVJZkgtc6h6hG3Scqk3K8QQYaIgeoBpE=;
 b=tq1ZXb5AApncz3SUYU0h5vc4uHokBZlluGIOeY4PYDPYLsTgISVzIcAqfCSnASacooKF
 BI+cJd/ySmSK/zjO79odmO/txOS5zZiVURSpP8JcyZ6bNwyyRV/qRc421QkXiFvakGnr
 EcQNFnoQImaJLmt06I50VVUdznAZ78LGMXejOWCRuf7+jQ0WLvrkSJdwb7Uh1HEYVTAq
 GZgmWHjAXqtlofkLE+vdb5qHARzxQVOEpRA2VHhVDP5446vIJI9JBQq3VJKkkzxHfCR1
 bcUcPFetaFoVXNyxGlkCU/2/LwM0nTNQKFcVre5NwAkh/6YGFDkjKuOyk3S5+dRzFy1P OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31uustw7a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 21:11:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OL8EVd117495;
        Wed, 24 Jun 2020 21:11:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31uur7xdc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 21:11:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OLAjAP004688;
        Wed, 24 Jun 2020 21:10:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 21:10:45 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 00D9A6A00F1; Wed, 24 Jun 2020 17:11:32 -0400 (EDT)
Date:   Wed, 24 Jun 2020 17:11:32 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200624211132.GB14137@char.us.oracle.com>
References: <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
 <20200330222551.GA22743@ashkalra_ubuntu_server>
 <20200427185318.GA8253@ashkalra_ubuntu_server>
 <20200623133843.GA5499@localhost.localdomain>
 <20200624002357.GA9955@ashkalra_ubuntu_server>
 <20200624070509.GA13381@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624070509.GA13381@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.snip..
> > Actually as per the boot flow :
> > 
> > setup_arch() calls reserve_crashkernel() and pci_iommu_alloc() is
> > invoked through mm_init()/mem_init() and not via initmem_init().
> > 
> > start_kernel:
> > ...
> > setup_arch()
> > 	reserve_crashkernel
> > 		reserve_crashkernel_low
> > 			-> swiotlb_size_or_default
> > 
> > ...
> > ...
> > mm_init()
> > 	mem_init()
> > 		pci_iommu_alloc
> > 			-> pci_swiotlb_detect_4gb
> > 			-> swiotlb_init
> > 
> > So as per the above boot flow, reserve_crashkernel() can get called
> > before swiotlb_detect/init, and hence, if we don't fixup or adjust
> > the SWIOTLB buffer size in swiotlb_size_or_default() then crash kernel
> > will reserve memory which will conflict/overlap with any SWIOTLB bounce
> > buffer allocated memory (adjusted or fixed up later).
> > 
> > Therefore, we need to adjust/fixup SWIOTLB bounce buffer memory in
> > swiotlb_size_or_default() function itself, before swiotlb detect/init
> > funtions get invoked.
> > 
> 
> Also to add here, it looks like swiotlb_size_or_default() is an
> interface function to get the SWIOTLB bounce buffer size for components
> which are initialized before swiotlb_detect/init, so that these 
> components can reserve or allocate their memory requirements with the
> knowledge of how much SWIOTLB bounce buffers are going to use, so
> therefore, any fixups or adjustments to SWIOTLB buffer size will need
> to be made as part of swiotlb_size_or_default(). 

That was never its purpose. It was meant as way to figure out the segment
size for DMA requests and to be used for runtime components. In fact to
be idempotent.

This is why I am disliking this usage and leaning towards something else.

But you pointed out something interesting - you are in fact needing to
adjust the size of the swiotlb based on your needs at bootup. Not any different
from say 'swiotlb' paramter.

Why not have an 'swiotlb_adjust' that is an __init that modifies the
internal swiotlb buffer sizes? Obviously we have to account for 'swiotlb'
parsing as well. The swiotlb_adjust would pick the max from those.

