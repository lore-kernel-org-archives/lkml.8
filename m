Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD222072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgCEMfg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:35:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgCEMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:35:36 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025CKRKo066940
        for <linux-kernel@vger.kernel.org>; Thu, 5 Mar 2020 07:35:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg3mtcb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:35:35 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 5 Mar 2020 12:35:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 12:35:27 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025CZRKc57409556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 12:35:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0075911C058;
        Thu,  5 Mar 2020 12:35:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 936F111C04C;
        Thu,  5 Mar 2020 12:35:26 +0000 (GMT)
Received: from localhost (unknown [9.199.53.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 12:35:26 +0000 (GMT)
Date:   Thu, 05 Mar 2020 18:05:25 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf symbols: Consolidate symbol fixup issue
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
References: <20200303110407.28162-1-leo.yan@linaro.org>
        <1583405831.eapbxpc3ni.naveen@linux.ibm.com>
        <20200305120738.GA31049@leoy-ThinkPad-X240s>
In-Reply-To: <20200305120738.GA31049@leoy-ThinkPad-X240s>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20030512-4275-0000-0000-000003A8A0E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030512-4276-0000-0000-000038BDB0B6
Message-Id: <1583411597.adgw1518ss.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_03:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yan wrote:
> Hi Naveen,
> 
> On Thu, Mar 05, 2020 at 04:32:30PM +0530, Naveen N. Rao wrote:
>> Leo Yan wrote:
<snip>
>> > In the common elf__needs_adjust_symbols(), it checks elf header and 
>> > if
>> > the machine type is one of Arm64/ppc/ppc64, it checks extra condition
>> > for 'ET_DYN'.  Finally, the Arm64 DSO can be parsed properly with x86's
>> > perf tool.
>> > 
>> > Before:
>> > 
>> >   # perf script
>> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])
>> > 
>> > After:
>> > 
>> >   # perf script
>> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
>> >   main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])
>> > 
>> 
>> I am not able to reproduce this since powerpc64 kernels are not being built
>> as ET_EXEC anymore.
> 
> Thanks for reviewing!
> 
> Based on the context, I think you mean powerpc64 kernels are not being
> built as ET_DYN anymore (and now change to ET_EXEC).

D'uh, indeed, sorry!

> 
>> > v2: Fixed Arm64 and powerpc native building.
>> > 
>> > Reported-by: Mike Leach <mike.leach@linaro.org>
>> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> > ---
>> >  tools/perf/arch/arm64/util/Build            |  1 -
>> >  tools/perf/arch/arm64/util/sym-handling.c   | 19 -------------------
>> >  tools/perf/arch/powerpc/util/Build          |  1 -
>> >  tools/perf/arch/powerpc/util/sym-handling.c | 10 ----------
>> >  tools/perf/util/symbol-elf.c                |  8 +++++++-
>> >  5 files changed, 7 insertions(+), 32 deletions(-)
>> >  delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c
>> > 
<snip>
>> > diff --git a/tools/perf/util/symbol-elf.c 
>> > b/tools/perf/util/symbol-elf.c
>> > index 1965aefccb02..ee788ac67415 100644
>> > --- a/tools/perf/util/symbol-elf.c
>> > +++ b/tools/perf/util/symbol-elf.c
>> > @@ -704,8 +704,14 @@ void symsrc__destroy(struct symsrc *ss)
>> >  	close(ss->fd);
>> >  }
>> > 
>> > -bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>> > +bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>> >  {
>> > +	if (ehdr.e_machine == EM_AARCH64 ||
>> > +	    ehdr.e_machine == EM_PPC ||
>> > +	    ehdr.e_machine == EM_PPC64)
>> > +		return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL ||
>> > +		       ehdr.e_type == ET_DYN;
>> > +
>> >  	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
>> 
>> Patch looks good to me. However:
> 
> Can I add your review tag?

Yes:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> 
>> This is only used for checking kernel, so I wonder if we can simply include
>> check for ET_DYN across all architectures? This would only matter if there
>> are architectures building their kernel as ET_DYN that _don't_ want to
>> adjust symbols.
> 
> Seems only Arm64 enables the link option '-share' for LDFLAGS_vmlinux;
> I confirmed with below command:
> 
> $ find arch -name 'Makefile' -exec grep -n '\-share' {} + | grep vmlinux
> arch/arm64/Makefile:21:LDFLAGS_vmlinux          += -shared -Bsymbolic -z notext -z norelro \
> 
> Also reviewed the output for searching '\-share' for all Makefiles under
> 'arch' folder, many architectures use it for vdso but only Arm64 enables
> '-share' for vmlinux linkage.  If so, your suggestion is valid and we
> can simply include check for ET_DYN for all archs (and it's better to
> add comment for this).
> 
> I'd like to wait a bit for anyone has other ideas, and if no objection
> will send out new patch for this.

Sure, thanks for checking.


- Naveen

