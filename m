Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A2C207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n9qPb4fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbgE0OoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:44:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388395AbgE0OoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:44:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04REVscQ007165;
        Wed, 27 May 2020 10:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V74IByYP7Z+nmBGilBdtMNLhYRNbdp/U2s9sQQbupt8=;
 b=n9qPb4fTeiJihbBZ6iahQiadDQ2gCOAwyicivS2UGyI3sSHaTgG91lKlbmD0YvwA/qDv
 nqtqL9Lus7/Ad/ot63D4dfqLWNlUag0X4kla1M3HdHr4VvPthUANRYc2p+CCkbGNO0B9
 I/+c9MZqs1QKz5foMXeAlCF9NCqFo4XIA7koaK5y0gFMQcuA15YwkU+C7vtWyodho21B
 8yz/NplqSwokCswErhSC2kuYDIJWLK1kl60g0M8VBZPZAre5kD3NuTtLFA+eRxl5GqhC
 ryoSxh6KGuNSyBUcFDgKcFTJZAPPQMtMw9ZwgatCmLAOkfQE40dgBR3oNhtqcWfLUhZ+ Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 316vrwshpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:42:59 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04REXJiV013271;
        Wed, 27 May 2020 10:42:59 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 316vrwshnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:42:59 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04REe1lh015385;
        Wed, 27 May 2020 14:42:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 316uf8b8jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 14:42:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04REgtD556819748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 14:42:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F731AE051;
        Wed, 27 May 2020 14:42:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6630BAE04D;
        Wed, 27 May 2020 14:42:53 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.113.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 May 2020 14:42:53 +0000 (GMT)
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
 <20200519211829.p2d454nz3h3mdxsa@treble>
 <20200519214637.GS9040@rlwimi.vmware.com>
 <20200520141604.npsaelrakozqzur6@treble>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <c0e767a9-4672-8b1d-c486-374f3f252d44@linux.vnet.ibm.com>
Date:   Wed, 27 May 2020 20:12:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520141604.npsaelrakozqzur6@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> From: Matt Helsley <mhelsley@vmware.com>
> Subject: [PATCH] objtool: Enable compilation of objtool for all architectures
> 
> Objtool currently only compiles for x86 architectures. This is
> fine as it presently does not support tooling for other
> architectures. However, we would like to be able to convert other
> kernel tools to run as objtool sub commands because they too
> process ELF object files. This will allow us to convert tools
> such as recordmcount to use objtool's ELF code.
> 
> Since much of recordmcount's ELF code is copy-paste code to/from
> a variety of other kernel tools (look at modpost for example) this
> means that if we can convert recordmcount we can convert more.
> 
> We define weak definitions for subcommand entry functions and other weak
> definitions for shared functions critical to building existing
> subcommands. These return 127 when the command is missing which signify
> tools that do not exist on all architectures.  In this case the "check"
> and "orc" tools do not exist on all architectures so we only add them
> for x86. Future changes adding support for "check", to arm64 for
> example, can then modify the SUBCMD_CHECK variable when building for
> arm64.
> 
> Objtool is not currently wired in to KConfig to be built for other
> architectures because it's not needed for those architectures and
> there are no commands it supports other than those for x86. As more
> command support is enabled on various architectures the necessary
> KConfig changes can be made (e.g. adding "STACK_VALIDATION") to
> trigger building objtool.
> 
> [ jpoimboe: remove aliases, add __weak macro, add error messages ]
> 
> Cc: Julien Thierry <jthierry@redhat.com>
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>


A minor nit-pick in objtool.h

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

> ---
[...]

> diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
> index d89616b2ca39..528028a66816 100644
> --- a/tools/objtool/objtool.h
> +++ b/tools/objtool/objtool.h
> @@ -19,4 +19,9 @@ struct objtool_file {
>  	bool ignore_unreachables, c_file, hints, rodata;
>  };
> 
> +int check(const char *objname, bool orc);
> +int orc_dump(const char *objname);
> +int create_orc(struct objtool_file *file);
> +int create_orc_sections(struct objtool_file *file);
> +
>  #endif /* _OBJTOOL_H */

above hunk will not apply cleanly on patch 2 of the series, it expects
a new line after struct objtool which is missing in patch 2. 

-- 
Kamalesh
