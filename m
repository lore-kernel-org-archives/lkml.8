Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9FCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB5D20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgGaJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:59:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28706 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732075AbgGaJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:59:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V9X04r120632;
        Fri, 31 Jul 2020 05:58:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md1yx1yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:58:47 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V9XbOs121972;
        Fri, 31 Jul 2020 05:58:46 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md1yx1y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:58:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V9sVYp000688;
        Fri, 31 Jul 2020 09:58:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0vch9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 09:58:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V9wffm64422364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 09:58:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 811D2AE053;
        Fri, 31 Jul 2020 09:58:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B377AE045;
        Fri, 31 Jul 2020 09:58:39 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 31 Jul 2020 09:58:39 +0000 (GMT)
Date:   Fri, 31 Jul 2020 15:28:08 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 10/10] powerpc/smp: Implement cpu_to_coregroup_id
Message-ID: <20200731095808.GB18776@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com>
 <20200727053230.19753-11-srikar@linux.vnet.ibm.com>
 <87wo2k3yeq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87wo2k3yeq.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_03:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=925
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 18:02:21]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > Lookup the coregroup id from the associativity array.
> 

Thanks Michael for all your comments and inputs.

> It's slightly strange that this is called in patch 9, but only properly
> implemented here in patch 10.
> 
> I'm not saying you have to squash them together, but it would be good if
> the change log for patch 9 mentioned that a subsequent commit will
> complete the implementation and how that affects the behaviour.
> 

I probably got influenced by few LKML community members who always add a
stub and implement the gory details in a subsequent patch. I will surely add
the change log in patch 9 about the subsequent patches.

> cheers
> 

-- 
Thanks and Regards
Srikar Dronamraju
