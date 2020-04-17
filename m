Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44541C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4F6221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDQHBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:01:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbgDQHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:01:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H6XwhH086697
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:01:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30f4uhc1dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:01:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Fri, 17 Apr 2020 08:01:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Apr 2020 08:01:07 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H71QiW53149902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 07:01:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F69611C058;
        Fri, 17 Apr 2020 07:01:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 866AF11C050;
        Fri, 17 Apr 2020 07:01:25 +0000 (GMT)
Received: from localhost (unknown [9.85.75.158])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Apr 2020 07:01:25 +0000 (GMT)
Date:   Fri, 17 Apr 2020 12:31:20 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: POWER9 crash due to STRICT_KERNEL_RWX (WAS: Re: Linux-next POWER9
 NULL pointer NIP...)
To:     Qian Cai <cai@lca.pw>, Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw>
        <87eeszlb6u.fsf@mpe.ellerman.id.au>
        <0675B22E-8F32-432C-9378-FDE159DD1729@lca.pw>
        <20200407093054.3eb23e45@gandalf.local.home>
        <EA9F9A54-87BC-477A-BE8A-7D53F80C5223@lca.pw>
        <20200409101413.35d9c72d@gandalf.local.home>
        <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw>
        <161662E3-5D9C-4C15-919C-CFEFE4CC35CB@lca.pw>
        <69F0448F-CA5B-497D-B8AF-2848175B9477@lca.pw>
In-Reply-To: <69F0448F-CA5B-497D-B8AF-2848175B9477@lca.pw>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20041707-0012-0000-0000-000003A603D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041707-0013-0000-0000-000021E34692
Message-Id: <1587106774.1oa2whm69m.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_01:2020-04-14,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=936 adultscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=2 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

Qian Cai wrote:
> OK, reverted the commit,
> 
> c55d7b5e6426 (“powerpc: Remove STRICT_KERNEL_RWX incompatibility with RELOCATABLE”)
> 
> or set STRICT_KERNEL_RWX=n fixed the crash below and also mentioned in this thread,
> 
> https://lore.kernel.org/lkml/15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw/

Do you see any errors logged in dmesg when you see the crash?  
STRICT_KERNEL_RWX changes how patch_instruction() works, so it would be 
interesting to see if there are any ftrace-related errors thrown before 
the crash.


- Naveen

