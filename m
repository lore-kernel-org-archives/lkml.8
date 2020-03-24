Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C937C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F8C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCXIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:41:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgCXIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:41:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O8XtGS058800
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:41:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuv4uyg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:41:25 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Tue, 24 Mar 2020 08:41:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 08:41:17 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O8fHBa58327132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 08:41:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87A22A4051;
        Tue, 24 Mar 2020 08:41:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62EAAA4069;
        Tue, 24 Mar 2020 08:41:15 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.56.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Mar 2020 08:41:15 +0000 (GMT)
Subject: Re: [PATCH] objtool: Documentation: document UACCESS warnings
To:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@redhat.com,
        peterz@infradead.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200323212538.GN2452@worktop.programming.kicks-ass.net>
 <20200324001321.39562-1-ndesaulniers@google.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Tue, 24 Mar 2020 14:11:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324001321.39562-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032408-0008-0000-0000-00000362E1E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032408-0009-0000-0000-00004A844D4C
Message-Id: <90c16f02-9364-651e-6dea-8758a698d2ce@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 5:43 AM, Nick Desaulniers wrote:
> Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:
>   call to memset() with UACCESS enabled
> 
> Document how to fix these for future travelers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/876
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good, a minor nitpick below.

> ---
>  .../Documentation/stack-validation.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
> index de094670050b..156fee13ba02 100644
> --- a/tools/objtool/Documentation/stack-validation.txt
> +++ b/tools/objtool/Documentation/stack-validation.txt
> @@ -289,6 +289,26 @@ they mean, and suggestions for how to fix them.
>        might be corrupt due to a gcc bug.  For more details, see:
>        https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
> 
> +9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
> +
> +   This means that an unexpected call to a non-whitelisted function exists
> +   outside of arch-specific guards.
> +   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
> +   ARM: PAN: uaccess_enable()/uaccess_enable()
                                 ^^^^^^ 
                                uaccess_disable() 

> +
> +   These functions should called to denote a minimal critical section around
> +   access to __user variables. See also: https://lwn.net/Articles/517475/

-- 
Kamalesh

