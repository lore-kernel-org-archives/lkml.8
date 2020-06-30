Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE31BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B156320672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgF3Mdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:33:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732042AbgF3Mdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:33:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UCWcBc034487;
        Tue, 30 Jun 2020 08:33:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3204yvh57b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 08:33:30 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UCX8r6039165;
        Tue, 30 Jun 2020 08:33:29 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3204yvh553-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 08:33:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UCGQOu007689;
        Tue, 30 Jun 2020 12:33:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgsq0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 12:33:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UCXOV365077476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 12:33:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FA0311C04C;
        Tue, 30 Jun 2020 12:33:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8310A11C05B;
        Tue, 30 Jun 2020 12:33:23 +0000 (GMT)
Received: from localhost (unknown [9.145.78.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Jun 2020 12:33:23 +0000 (GMT)
Date:   Tue, 30 Jun 2020 14:33:20 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Message-ID: <your-ad-here.call-01593520400-ext-3384@work.hours>
References: <20200610052154.5180-1-cai@lca.pw>
 <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
 <20200610122600.GB954@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610122600.GB954@lca.pw>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=21
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:26:00AM -0400, Qian Cai wrote:
> On Wed, Jun 10, 2020 at 07:54:50AM +0200, Dmitry Vyukov wrote:
> > On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > > from kmalloc_order() which will override KASAN redzones because a
> > > redzone was setup from the end of the allocation size to the end of the
> > > last page. Silence it by not reporting it there. An example of the
> > > report is,
> > 
> > Interesting. The reason why we did not hit it on x86_64 is because
> > clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> > thus is not instrumented. Arm64 probably does the same. However, on
> > s390 clear_page is defined to memset.
> > clear_[high]page are pretty extensively used in the kernel.
> > We can either do this, or make clear_page non instrumented on s390 as
> > well to match the existing implicit assumption. The benefit of the
> > current approach is that we can find some real use-after-free's and
> > maybe out-of-bounds on clear_page. The downside is that we may need
> > more of these annotations. Thoughts?
> 
> Since we had already done the same thing in poison_page(), I suppose we
> could do the same here. Also, clear_page() has been used in many places
> on s390, and it is not clear to me if those are all safe like this.
> 
> There might be more annotations required, so it probably up to s390
> maintainers (CC'ed) if they prefer not instrumenting clear_page() like
> other arches.
> 

Sorry for delay. I assume you tested it without CONFIG_JUMP_LABEL.
I had to fix couple of things before I was able to use init_on_alloc=1
and init_on_free=1 boot options on s390 to reproduce KASAN problem:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.8-rc3&id=998f5bbe3dbdab81c1cfb1aef7c3892f5d24f6c7
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=fixes&id=95e61b1b5d6394b53d147c0fcbe2ae70fbe09446
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=fixes&id=d6df52e9996dcc2062c3d9c9123288468bb95b52

Back to clear_page - we could certainly make it non-instrumented. But
it didn't cause any problems so far. And as Dmitry pointed out we
could potentially find additional bugs with it. So, I'm leaning
towards original solution proposed. For that you have my

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>

Thank you for looking into this!

Andrew, would you pick this change up?
Thank you

Vasily
