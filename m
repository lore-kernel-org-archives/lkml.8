Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29933C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B3E222D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBQRNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:13:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgBQRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:13:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH8re4138020
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:13:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gmvbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:13:53 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:13:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 17:13:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HHDkK636503712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 17:13:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65D8D42047;
        Mon, 17 Feb 2020 17:13:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2133E4203F;
        Mon, 17 Feb 2020 17:13:46 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Feb 2020 17:13:46 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:13:44 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
References: <20200208141052.48476-1-natechancellor@gmail.com>
 <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
 <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
X-TM-AS-GCONF: 00
x-cbid: 20021717-4275-0000-0000-000003A2DB4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021717-4276-0000-0000-000038B6E05F
Message-Id: <your-ad-here.call-01581959624-ext-8482@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_11:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:46:28PM -0700, Nathan Chancellor wrote:
> On Sat, Feb 08, 2020 at 12:17:20PM -0800, Joe Perches wrote:
> > On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > > 
> > > ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> > > of type 'const u8 *' (aka 'const unsigned char *') converts between
> > > pointers to integer
> > > types with different sign [-Wpointer-sign]
> > >                                   (char *) entropy, (char *) entropy,
> > >                                                     ^~~~~~~~~~~~~~~~
> > > ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> > > parameter 'src' here
> > >                             u8 *dest, const u8 *src, long src_len)
> > >                                                 ^
> > > 2 warnings generated.
> > > 
> > > Fix the cast to match what else is done in this function.
> > > 
> > > Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/862
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  arch/s390/boot/kaslr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> > > index 5d12352545c5..5591243d673e 100644
> > > --- a/arch/s390/boot/kaslr.c
> > > +++ b/arch/s390/boot/kaslr.c
> > > @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
> > >  		*(unsigned long *) prng.parm_block ^= seed;
> > >  		for (i = 0; i < 16; i++) {
> > >  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> > > -				  (char *) entropy, (char *) entropy,
> > > +				  (u8 *) entropy, (u8 *) entropy,
> > 
> > Why not change the function to take void *?
> > 
> > static inline int cpacf_kmc(unsigned long func, void *param,
> > 			    u8 *dest, const u8 *src, long src_len)
> > 
> > vs:
> > 
> > static inline int cpacf_kmc(unsigned long func, void *param,
> > 			    void *dest, const void *src, long src_len)
> > 
> > and remove the casts?
> 
> I can certainly do that if the maintainers prefer it.
> 
> Cheers,
> Nathan
KBUILD_CFLAGS contains -Wno-pointer-sign but special arch/s390/boot code
has a separate set of build flags. Anyhow the change makes sense as it is.
Applied to fixes, thanks

