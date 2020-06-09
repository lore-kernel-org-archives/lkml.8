Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54962207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgFIGtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:49:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFIGtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:49:22 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0596Vjqi191885;
        Tue, 9 Jun 2020 02:49:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31gg81hspu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 02:49:21 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0596Vtac192581;
        Tue, 9 Jun 2020 02:49:21 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31gg81hsp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 02:49:20 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0596k9oR002782;
        Tue, 9 Jun 2020 06:49:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 31g2s7t687-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:49:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0596nFrb57671682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 06:49:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B3AC42054;
        Tue,  9 Jun 2020 06:49:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD04B42041;
        Tue,  9 Jun 2020 06:49:14 +0000 (GMT)
Received: from osiris (unknown [9.171.82.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 06:49:14 +0000 (GMT)
Date:   Tue, 9 Jun 2020 08:49:13 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
Message-ID: <20200609064913.GA6796@osiris>
References: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
 <20200602192523.32758-1-natechancellor@gmail.com>
 <CAKwvOdnH8rxT7y1U0d=pyD19K38KwarrwA2s+Ji7ctgg+ks_kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnH8rxT7y1U0d=pyD19K38KwarrwA2s+Ji7ctgg+ks_kg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_01:2020-06-08,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=999 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:52:26PM -0700, Nick Desaulniers wrote:
> On Tue, Jun 2, 2020 at 12:25 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Currently, the VDSO is being linked through $(CC). This does not match
> > how the rest of the kernel links objects, which is through the $(LD)
> > variable.
> >
> > When clang is built in a default configuration, it first attempts to use
> > the target triple's default linker, which is just ld. However, the user
> > can override this through the CLANG_DEFAULT_LINKER cmake define so that
> > clang uses another linker by default, such as LLVM's own linker, ld.lld.
> > This can be useful to get more optimized links across various different
> > projects.
> >
> > However, this is problematic for the s390 vDSO because ld.lld does not
> > have any s390 emulatiom support:
> >
> > https://github.com/llvm/llvm-project/blob/llvmorg-10.0.1-rc1/lld/ELF/Driver.cpp#L132-L150
> >
> > Thus, if a user is using a toolchain with ld.lld as the default, they
> > will see an error, even if they have specified ld.bfd through the LD
> > make variable:
> >
> > $ make -j"$(nproc)" -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- LLVM=1 \
> >                        LD=s390x-linux-gnu-ld \
> >                        defconfig arch/s390/kernel/vdso64/
> > ld.lld: error: unknown emulation: elf64_s390
> > clang-11: error: linker command failed with exit code 1 (use -v to see invocation)
> >
> > Normally, '-fuse-ld=bfd' could be used to get around this; however, this
> > can be fragile, depending on paths and variable naming. The cleaner
> > solution for the kernel is to take advantage of the fact that $(LD) can
> > be invoked directly, which bypasses the heuristics of $(CC) and respects
> > the user's choice. Similar changes have been done for ARM, ARM64, and
> > MIPS.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1041
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks, with this, I'm more confident that the linker flags don't change.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
...
> > -KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> > -                   -Wl,--hash-style=both
> > +ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
> > +            --hash-style=both -T

I added the --build-id flag according to commit 7a0a93c51799 ("arm64:
vdso: Explicitly add build-id option") and applied the patch.
Thanks!
