Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2273C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8912311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="biM7AnJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgHFQnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:43:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728943AbgHFQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:37:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076E1IGX080885;
        Thu, 6 Aug 2020 10:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=oaAEJb826W7ksaLamBDtymDY8M970iPeRS07nHJ31qQ=;
 b=biM7AnJdvEOH5cMoMa8In/ItG0EFHlyb05YodG6AakRTQaw8UhG1aA6ic2SMVjxSoyDC
 e37JyDNcs998CosuDb37vftuEVv391ydUZo5JtPHwE2jGU6p+bjmzfQAk8KTX4U+6BsI
 kLNHT++BRgg2bEay8eBo7mVTDjzUN4P1D2Hss1sLp8DREY0SlJMyWtfgwZF9gfWUs0u1
 otVrtG5uGQKbcrNhBrNOdPEsMbJ2F3DCKV0xoamWzGMCf4uINHheuqIgODIudczp46dN
 KZUpJFtE/MptPk6sFv3I5nXn5bQWKotFdkwpIGiz6f4E/7crh2ev2mDPtrS+Puj4Ax0f 4g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32r9wtyt7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 10:10:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076E772b025010;
        Thu, 6 Aug 2020 14:10:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh5hw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 14:10:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076E9xKF65012028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 14:09:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B2AA405F;
        Thu,  6 Aug 2020 14:09:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED15A4060;
        Thu,  6 Aug 2020 14:09:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu,  6 Aug 2020 14:09:56 +0000 (GMT)
Date:   Thu, 6 Aug 2020 19:39:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     peterz@infradead.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/topology: Allow archs to override cpu_smt_mask
Message-ID: <20200806140955.GC31068@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200804033307.76111-1-srikar@linux.vnet.ibm.com>
 <20200804104520.GB2657@hirez.programming.kicks-ass.net>
 <20200804121007.GJ24375@linux.vnet.ibm.com>
 <20200804124755.GJ2674@hirez.programming.kicks-ass.net>
 <87ft90z6dy.fsf@mpe.ellerman.id.au>
 <20200806085429.GX2674@hirez.programming.kicks-ass.net>
 <87d044yn9z.fsf@mpe.ellerman.id.au>
 <20200806131547.GC2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200806131547.GC2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_09:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* peterz@infradead.org <peterz@infradead.org> [2020-08-06 15:15:47]:

> > But my understanding is most LPARs don't get migrated back and forth,
> > they'll start life on a P8 and only get migrated to a P9 once when the
> > customer gets a P9. They might then run for a long time (months to
> > years) on the P9 in P8 compat mode, not because they ever want to
> > migrate back to a real P8, but because the software in the LPAR is still
> > expecting to be on a P8.
> > 
> > I'm not a real expert on all the Enterprisey stuff though, so someone
> > else might be able to give us a better picture.
> > 
> > But the point of mentioning the migration stuff was mainly just to
> > explain why we feel we need to present SMT8 to userspace even on P9.
> 
> OK, fair enough. The patch wasn't particularly onerous, I was just
> wondering why etc..
> 
> The case of starting on a P8 and being migrated to a P9 makes sense to
> me; in that case you'd like to rebuild your sched domains, but can't go
> about changing user visible topolofy information.
> 
> I suppose:
> 
> Acked-by; Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> An updated Changelog that recaps some of this discussion might also be
> nice.

Okay, will surely do the needful.

-- 
Thanks and Regards
Srikar Dronamraju
