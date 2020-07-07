Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F68AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4658F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGGMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38963 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:08:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067C3wF9120843;
        Tue, 7 Jul 2020 08:08:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32482ktmxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:08:57 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067C50rB125742;
        Tue, 7 Jul 2020 08:08:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32482ktmx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:08:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067C5pe5018078;
        Tue, 7 Jul 2020 12:08:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7uded-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 12:08:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067C8pKZ23462062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 12:08:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5951EA4065;
        Tue,  7 Jul 2020 12:08:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B16FA4067;
        Tue,  7 Jul 2020 12:08:51 +0000 (GMT)
Received: from osiris (unknown [9.171.50.201])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Jul 2020 12:08:50 +0000 (GMT)
Date:   Tue, 7 Jul 2020 14:08:49 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200707120849.GB12303@osiris>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_07:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=5 cotscore=-2147483648
 mlxlogscore=868 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:39:08PM +0200, David Hildenbrand wrote:
> This series is based on the latest s390/features branch [1]. It implements
> vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
> - Freeing empty page tables (now also done for idendity mapping).
> - Handling cases where the vmemmap of a section does not fill huge pages
>   completely.
> 
> vmemmap_free() is currently never used, unless adiing standby memory fails
> (unlikely). This is relevant for virtio-mem, which adds/removes memory
> in memory block/section granularity (always removes memory in the same
> granularity it added it).
> 
> I gave this a proper test with my virtio-mem prototype (which I will share
> once the basic QEMU implementation is upstream), both with 56 byte memmap
> per page and 64 byte memmap per page, with and without huge page support.
> In both cases, removing memory (routed through arch_remove_memory()) will
> result in
> - all populated vmemmap pages to get removed/freed
> - all applicable page tables for the vmemmap getting removed/freed
> - all applicable page tables for the idendity mapping getting removed/freed
> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
> environments.
> 
> This is the basis for real memory hotunplug support for s390x and should
> complete my journey to s390x vmem/vmemmap code for now :)
> 
> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
> accesses, doing a single range flush at the end is sufficient, both when
> removing vmemmap pages and the idendity mapping.
> 
> Along, some minor cleanups.

Hmm.. I really would like to see if there would be only a single page
table walker left in vmem.c, which handles both adding and removing
things.
Now we end up with two different page table walk implementations
within the same file. However not sure if it is worth the effort to
unify them though.
