Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A6FC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7B2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgB1EAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:00:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730736AbgB1EAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:00:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S3tCKk079398
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:00:04 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepwtehp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:00:04 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Fri, 28 Feb 2020 04:00:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Feb 2020 03:59:59 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S3xwHk56098974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 03:59:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69E15A4051;
        Fri, 28 Feb 2020 03:59:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15DEFA4040;
        Fri, 28 Feb 2020 03:59:58 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 03:59:58 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 266FFA01F5;
        Fri, 28 Feb 2020 14:59:53 +1100 (AEDT)
Subject: Re: [PATCH v4 13/13] powerpc/ptrace: move ptrace_triggered() into
 hw_breakpoint.c
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org,
        Russell Currey <ruscur@russell.cc>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1582803998.git.christophe.leroy@c-s.fr>
 <d45c91cf5f83424b8f3989b7ead28c50d8d765a9.1582803998.git.christophe.leroy@c-s.fr>
 <4e528bf2-2b53-ae93-cdcc-0c80953f40f2@c-s.fr>
 <87pndz1xsf.fsf@mpe.ellerman.id.au>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Fri, 28 Feb 2020 14:59:56 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87pndz1xsf.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022804-4275-0000-0000-000003A63229
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022803-4276-0000-0000-000038BAA584
Message-Id: <b2b97a86-2f29-af14-52c2-a69ef6202b75@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_08:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=796 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/2/20 9:16 am, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Russel,
>>
>> Le 27/02/2020 à 12:49, Christophe Leroy a écrit :
>>> ptrace_triggered() is declared in asm/hw_breakpoint.h and
>>> only needed when CONFIG_HW_BREAKPOINT is set, so move it
>>> into hw_breakpoint.c
>>
>> My series v4 is definitely buggy (I included ptrace_decl.h instead
>> instead of ptrace-decl.h), how can Snowpatch say build succeeded
>> (https://patchwork.ozlabs.org/patch/1245807/) ?
> 
> Which links to:
>    https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15895//artifact/linux/report.txt
> 
> The actual build log of which is:
>    https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15895/artifact/linux/build_new.log
> 
> Which contains:
>    scripts/Makefile.build:267: recipe for target 'arch/powerpc/kernel/ptrace/ptrace-altivec.o' failed
>    make[3]: *** [arch/powerpc/kernel/ptrace/ptrace-altivec.o] Error 1
>    make[3]: *** Waiting for unfinished jobs....
>    scripts/Makefile.build:505: recipe for target 'arch/powerpc/kernel/ptrace' failed
>    make[2]: *** [arch/powerpc/kernel/ptrace] Error 2
>    make[2]: *** Waiting for unfinished jobs....
>    scripts/Makefile.build:505: recipe for target 'arch/powerpc/kernel' failed
>    make[1]: *** [arch/powerpc/kernel] Error 2
>    make[1]: *** Waiting for unfinished jobs....
>    Makefile:1681: recipe for target 'arch/powerpc' failed
>    make: *** [arch/powerpc] Error 2
>    make: *** Waiting for unfinished jobs....
> 
> Same for ppc64le:
>    https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15896/artifact/linux/build_new.log
> 
> 
> So it seems like snowpatch always reports the build as succeeded even
> when it fails.

Turns out there was an issue in a recent change in our build script 
which caused build failures to return the wrong exit code and put the 
wrong text in the reports, because of some confusion with bash 
subshells. I've fixed it (I think).

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited

