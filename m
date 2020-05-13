Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75326CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A320671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgEMOQU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:16:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731192AbgEMOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:16:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DEAJGO024747;
        Wed, 13 May 2020 10:16:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3101m7cs0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 10:16:15 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04DEANsv025168;
        Wed, 13 May 2020 10:16:15 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3101m7cryq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 10:16:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DEFYdR019846;
        Wed, 13 May 2020 14:16:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3100ub0pnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 14:16:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04DEGAGW53019102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 14:16:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35D37A4067;
        Wed, 13 May 2020 14:16:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B60D3A4060;
        Wed, 13 May 2020 14:16:09 +0000 (GMT)
Received: from localhost (unknown [9.85.73.183])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 May 2020 14:16:09 +0000 (GMT)
Date:   Wed, 13 May 2020 19:46:06 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf powerpc: Don't ignore sym-handling.c file
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Cc:     jolsa@kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
        <88066ce0-f586-b88d-75b5-2706684818d7@linux.ibm.com>
        <20200512132737.GH28888@kernel.org>
In-Reply-To: <20200512132737.GH28888@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Message-Id: <1589379305.x6l3ijih7z.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_06:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 cotscore=-2147483648
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Mon, May 11, 2020 at 11:45:09PM +0530, Sandipan Das escreveu:
>> 
>> On 09/05/20 4:51 pm, Ravi Bangoria wrote:
>> > Commit 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
>> > removed powerpc specific sym-handling.c file from Build. This wasn't
>> > caught by build CI because all functions in this file are declared
>> > as __weak in common code. Fix it.
>> > 
>> > Fixes: 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
>> > Reported-by: Sandipan Das <sandipan@linux.ibm.com>
>> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> > ---
>> >  tools/perf/arch/powerpc/util/Build | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
>> > index e5c9504f8586..e86e210bf514 100644
>> > --- a/tools/perf/arch/powerpc/util/Build
>> > +++ b/tools/perf/arch/powerpc/util/Build
>> > @@ -2,6 +2,7 @@ perf-y += header.o
>> >  perf-y += kvm-stat.o
>> >  perf-y += perf_regs.o
>> >  perf-y += mem-events.o
>> > +perf-y += sym-handling.o
>> >  
>> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
>> >  perf-$(CONFIG_DWARF) += skip-callchain-idx.o
>> > 
>> 
>> Thanks for fixing this!
>> 
>> Acked-by: Sandipan Das <sandipan@linux.ibm.com>
> 
> Leo, Naveen, can you comment on this?

Shoot -- this is a bad miss, I should have caught it. FWIW:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen
