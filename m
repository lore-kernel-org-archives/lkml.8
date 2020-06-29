Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F342C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C462063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgF2Sle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728930AbgF2Sl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:26 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TC3mjr080192;
        Mon, 29 Jun 2020 08:07:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31x1rupwev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 08:07:38 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TC4HMe081091;
        Mon, 29 Jun 2020 08:07:36 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31x1rupw9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 08:07:36 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TC2658008359;
        Mon, 29 Jun 2020 12:07:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 31wwch2637-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 12:07:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TC7PkX21823872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 12:07:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7EB74C050;
        Mon, 29 Jun 2020 12:07:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3314C063;
        Mon, 29 Jun 2020 12:07:25 +0000 (GMT)
Received: from osiris (unknown [9.171.82.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Jun 2020 12:07:25 +0000 (GMT)
Date:   Mon, 29 Jun 2020 14:07:23 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200629120723.GD4468@osiris>
References: <20200625150029.45019-1-david@redhat.com>
 <20200626192253.2281d95d@thinkpad>
 <20200626204621.55248f99@thinkpad>
 <20200629115537.GC4468@osiris>
 <0c783dbb-630c-6440-74b8-8b40af146d6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c783dbb-630c-6440-74b8-8b40af146d6a@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 cotscore=-2147483648 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=1 clxscore=1015
 malwarescore=0 mlxscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:01:22PM +0200, David Hildenbrand wrote:
> On 29.06.20 13:55, Heiko Carstens wrote:
> > On Fri, Jun 26, 2020 at 08:46:21PM +0200, Gerald Schaefer wrote:
> >> Verified with DCSS overlapping boot and standby memory, works fine.
> >> As expected, the error message changes, but I don't think that is a
> >> problem, as long as you also remove the old -ENOSPC case / comment
> >> in arch/s390/mm/extmem.c. It is actually more correct now I guess,
> >> -ENOSPC doesn't look like the correct return value anyway.
> >>
> >> Thanks for cleaning up! Looks good to me, and removes > 100 LOC,
> >> unless Heiko remembers some other issues from ancient times.
> >>
> >> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> >> Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [DCSS]
> > 
> > Looks good to me too. Gerald, thanks for looking and verifying this,
> > and David, thanks for providing the patch.
> > 
> > Applied.
> > 
> 
> Thanks Gerald and Heiko! Should I send an addon patch to tweak the
> documentation or resend this patch?

Please send an addon patch. I will merge it.
