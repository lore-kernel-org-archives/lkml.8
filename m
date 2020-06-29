Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D572063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgF2Skm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:40:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728265AbgF2Ska (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TBV0g4163526;
        Mon, 29 Jun 2020 07:55:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg2fm0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 07:55:44 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TBV3eg163827;
        Mon, 29 Jun 2020 07:55:44 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg2fkyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 07:55:43 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TBnns1002935;
        Mon, 29 Jun 2020 11:55:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 31wwr7s31h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:55:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TBsJVs590576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 11:54:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 393B142049;
        Mon, 29 Jun 2020 11:55:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEB1742045;
        Mon, 29 Jun 2020 11:55:38 +0000 (GMT)
Received: from osiris (unknown [9.171.82.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Jun 2020 11:55:38 +0000 (GMT)
Date:   Mon, 29 Jun 2020 13:55:37 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200629115537.GC4468@osiris>
References: <20200625150029.45019-1-david@redhat.com>
 <20200626192253.2281d95d@thinkpad>
 <20200626204621.55248f99@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626204621.55248f99@thinkpad>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=1 clxscore=1015
 adultscore=0 malwarescore=0 cotscore=-2147483648 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:46:21PM +0200, Gerald Schaefer wrote:
> Verified with DCSS overlapping boot and standby memory, works fine.
> As expected, the error message changes, but I don't think that is a
> problem, as long as you also remove the old -ENOSPC case / comment
> in arch/s390/mm/extmem.c. It is actually more correct now I guess,
> -ENOSPC doesn't look like the correct return value anyway.
> 
> Thanks for cleaning up! Looks good to me, and removes > 100 LOC,
> unless Heiko remembers some other issues from ancient times.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [DCSS]

Looks good to me too. Gerald, thanks for looking and verifying this,
and David, thanks for providing the patch.

Applied.
