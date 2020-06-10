Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99522C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0902086A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgFJH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:59:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgFJH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:59:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A7Xd8u153818;
        Wed, 10 Jun 2020 03:59:16 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ja3ac8wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 03:59:16 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A7ulrJ018361;
        Wed, 10 Jun 2020 07:59:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 31jf1grbww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 07:59:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A7vtsR62849294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 07:57:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F37724C059;
        Wed, 10 Jun 2020 07:59:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22B8D4C046;
        Wed, 10 Jun 2020 07:59:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.121])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Jun 2020 07:59:11 +0000 (GMT)
Date:   Wed, 10 Jun 2020 10:59:09 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200610075909.GK1149842@linux.ibm.com>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de>
 <20200605100059.GB7524@linux.ibm.com>
 <20200609121056.GB3871@suse.de>
 <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11fd19b-e5b6-1bc9-6392-04dbab358b67@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_04:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 cotscore=-2147483648
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=984
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:15:42AM -0700, Guenter Roeck wrote:
> On 6/9/20 5:10 AM, Joerg Roedel wrote:
> > 
> I have stopped building unicore32 images since v4.19 since there is
> no available compiler that is still supported by the kernel. I am
> surprised that support for it has not been removed from the kernel.

Well, I've done the patches [1] and I'll send them after -rc1 is out.
It'll also give kbuild some time to verify I didn't remove too much :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=rm-unicore

> Guenter

-- 
Sincerely yours,
Mike.
