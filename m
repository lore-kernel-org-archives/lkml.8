Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BB42072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgFIPZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:25:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgFIPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:25:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059F4I5i079404;
        Tue, 9 Jun 2020 11:24:47 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jb0md19u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 11:24:47 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059FGGNL020904;
        Tue, 9 Jun 2020 15:24:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 31g2s7tgsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 15:24:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059FOgOe47775890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 15:24:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6430CA4055;
        Tue,  9 Jun 2020 15:24:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BF91A4040;
        Tue,  9 Jun 2020 15:24:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.223])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 15:24:41 +0000 (GMT)
Date:   Tue, 9 Jun 2020 18:24:39 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200609152439.GG1149842@linux.ibm.com>
References: <20200603232311.GA205619@roeck-us.net>
 <20200604083512.GN6857@suse.de>
 <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
 <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
 <CAHk-=wjm+RrcTjB7KYCCsOouE2EyzRcwWUE9TVq6OCYYAt9Zyw@mail.gmail.com>
 <20200605081644.GS6857@suse.de>
 <20200605100059.GB7524@linux.ibm.com>
 <20200609121056.GB3871@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609121056.GB3871@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_09:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0
 cotscore=-2147483648 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=1 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=864 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Tue, Jun 09, 2020 at 02:10:56PM +0200, Joerg Roedel wrote:
> Hi Mike,
> 
> On Fri, Jun 05, 2020 at 01:00:59PM +0300, Mike Rapoport wrote:
> > We already have include/asm-generic/pgalloc.h, so maybe something like
> > that patch below would fork. This is not even compile tested.
> > 
> > diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> 
> I experimented a bit with your diff, but it turned out that moving the
> page-table allocation functions/macros to asm-generic/pgalloc.h does not
> work on all architectures.
> 
> The reason is that some archs don't use that header at all (e.g. ARC)
> and have their own version of the functions defined there. That could
> all be made working, but I decided to no open this can of worms for now.
> 
> So I sent out a patch which moves the p?d_alloc_track() functions/macros
> to a separate header and include it only in mm/vmalloc.c and
> lib/ioremap.c. 

I'm planning to open this can of worms eventually, but having
p?d_alloc_track() in a separate header wouldn't be the biggest of my
problems :)

> That compiles on all architectures where current Linus'
> master also builds (it does not for Alpha, CSky, Mips and Mips64), and
> as usual Hexagon and Unicore32 are not tested because I have no working
> compiler for those.
> 
> Regards,
> 
> 	Joerg

-- 
Sincerely yours,
Mike.
