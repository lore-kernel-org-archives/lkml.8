Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3238CC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B2E206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPC6+zJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIKQ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:26:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36686 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbgIKPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:24:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BFDJlh138373;
        Fri, 11 Sep 2020 11:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IU/fKZKtEvfvRqnzr4y0McdxJCnTZkrOh7Gin8XqWlU=;
 b=WPC6+zJTaiPIgIkWddZOIIpPI/m+V3iwTn8whVN2764BdbiZOI2Y0vFsOhk/rmVY4Hxp
 6QVRWMmVhcT59QBr/fTRaFdggXsUsBvmI1GwU7yv85YOz7+JB7/FTnOD0tF/f96GwHwf
 59BxMkYvRyo2/5TLnXFhyHzY3B1AUUkypUVYD6B+u/G2x4k8VuhhSQDqf7DbMhTCkjik
 7tCvh9oLjeju916t0WHfaDg4six8toC++6X1XcHybDQRfxZ35GgUb3dleaNbwBVddWOr
 Pk6kolI3YntgyZbsf4a3CkasG5Zx9Y4J5y5HHSB+LSb90gQxpu2z86frjDhza7TIQcwn tQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gbp9r78d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:23:48 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BFD828025320;
        Fri, 11 Sep 2020 15:23:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 33c2a846bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:23:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BFNiG337814770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 15:23:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17CDD4C044;
        Fri, 11 Sep 2020 15:23:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABA384C050;
        Fri, 11 Sep 2020 15:23:43 +0000 (GMT)
Received: from [9.145.176.58] (unknown [9.145.176.58])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 15:23:43 +0000 (GMT)
Subject: Re: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200904155808.4997-1-leon@kernel.org>
 <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
 <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
 <a9d5b868b1eb4d8bb45364e9b917ca8f@AcuMS.aculab.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <0d45fd85-d109-b57f-d918-33d5991e2b09@linux.ibm.com>
Date:   Fri, 11 Sep 2020 17:23:44 +0200
MIME-Version: 1.0
In-Reply-To: <a9d5b868b1eb4d8bb45364e9b917ca8f@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=1 mlxlogscore=917
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.2020 23:49, David Laight wrote:
> I was wondering what happens if files compiled with different
> versions of gcc get linked together?

This is not supported by GCC. At runtime libgcov will reject all data
from object files compiled with a different GCC version.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
