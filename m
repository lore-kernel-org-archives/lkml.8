Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A297820714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgG0GeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:34:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgG0GeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:34:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R6XAWE063937;
        Mon, 27 Jul 2020 02:34:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1k9764-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 02:34:07 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R6Xbjt065018;
        Mon, 27 Jul 2020 02:34:06 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1k9758-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 02:34:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R6WTua016066;
        Mon, 27 Jul 2020 06:34:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqghvjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 06:34:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R6XxdL58982608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 06:33:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 584D94204D;
        Mon, 27 Jul 2020 06:33:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E134203F;
        Mon, 27 Jul 2020 06:33:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 27 Jul 2020 06:33:56 +0000 (GMT)
Date:   Mon, 27 Jul 2020 12:03:56 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <michaele@au1.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nick Piggin <npiggin@au1.ibm.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@linux.ibm.com>,
        Anton Blanchard <anton@au1.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 00/10] Coregroup support on Powerpc
Message-ID: <20200727063356.GA9059@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200727051805.16728-1-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_04:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2020-07-27 10:47:55]:


> Changelog v3 ->v4:
> v3: https://lore.kernel.org/lkml/20200723085116.4731-1-srikar@linux.vnet.ibm.com/t/#u
> 
> powerpc/smp: Create coregroup domain
> 	if coregroup_support doesn't exist, update MC mask to the next
> 	smaller domain mask.
> 

Sorry for the double post of v4.
Please follow the other thread.

http://lore.kernel.org/lkml/20200727053230.19753-1-srikar@linux.vnet.ibm.com/t/#u

> 

-- 
Thanks and Regards
Srikar Dronamraju
