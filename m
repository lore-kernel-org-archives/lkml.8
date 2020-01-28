Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB87206A4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgA1X5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:57:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgA1X5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:57:06 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SNd1uv039837;
        Tue, 28 Jan 2020 18:56:59 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrk2fxqk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 18:56:58 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00SNt1EF134993;
        Tue, 28 Jan 2020 18:56:58 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrk2fxqjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 18:56:58 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00SNtIva020067;
        Tue, 28 Jan 2020 23:56:57 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2xrda6nnwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 23:56:57 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SNuuco58982910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 23:56:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69928C6059;
        Tue, 28 Jan 2020 23:56:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A611C6055;
        Tue, 28 Jan 2020 23:56:56 +0000 (GMT)
Received: from localhost (unknown [9.41.179.160])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 23:56:56 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Scott Cheloha <cheloha@linux.ibm.com>
Cc:     Nathan Fontenont <ndfont@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/drmem: cache LMBs in xarray to accelerate lookup
In-Reply-To: <20200128221113.17158-1-cheloha@linux.ibm.com>
References: <20200128221113.17158-1-cheloha@linux.ibm.com>
Date:   Tue, 28 Jan 2020 17:56:55 -0600
Message-ID: <87pnf3i188.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_09:2020-01-28,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=1
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=758 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Cheloha <cheloha@linux.ibm.com> writes:
> LMB lookup is currently an O(n) linear search.  This scales poorly when
> there are many LMBs.
>
> If we cache each LMB by both its base address and its DRC index
> in an xarray we can cut lookups to O(log n), greatly accelerating
> drmem initialization and memory hotplug.
>
> This patch introduces two xarrays of of LMBs and fills them during
> drmem initialization.  The patch also adds two interfaces for LMB
> lookup.

Good but can you replace the array of LMBs altogether
(drmem_info->lmbs)? xarray allows iteration over the members if needed.
