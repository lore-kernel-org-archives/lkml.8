Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6808C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBCE20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgBJR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:58:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgBJR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:58:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHt3r0167786
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:58:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1umryuna-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:58:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 10 Feb 2020 17:58:42 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 17:58:40 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AHwd4514942346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 17:58:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7142FAE051;
        Mon, 10 Feb 2020 17:58:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 216ECAE04D;
        Mon, 10 Feb 2020 17:58:39 +0000 (GMT)
Received: from localhost (unknown [9.145.76.6])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Feb 2020 17:58:39 +0000 (GMT)
Date:   Mon, 10 Feb 2020 18:58:37 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: LKML: Vasily Gorbik: [GIT PULL] s390 patches for the 5.6 merge
 window
References: <CAKwvOdkCtyGPeO2kNQSJ3adX6t6k46tf3Au-P06c1G3McRE2KQ@mail.gmail.com>
 <CAKwvOdm+1bMq-uZxe96HViKLzT7jRyxdS68KLyOXhMm2hM9F5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm+1bMq-uZxe96HViKLzT7jRyxdS68KLyOXhMm2hM9F5w@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20021017-0012-0000-0000-000003859303
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021017-0013-0000-0000-000021C20BB2
Message-Id: <your-ad-here.call-01581357517-ext-6250@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=844
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:22:20PM +0000, Nick Desaulniers wrote:
> + Vasily for real
> 
> On Fri, Feb 7, 2020, 11:02 PM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> 
> > https://lkml.org/lkml/2020/1/28/1141
> >
> > Yo, what's up with clang 10 support?
I believe s390 kernel had limited clang build support since about 5.2
(with jump labels and ftrace disabled), thanks to contributions from Arnd
Bergmann. With asm goto support in clang 9 and now everything for ftrace
in place in clang 10 s390 kernel should be in a good shape feature wise
(including KASAN). At this stage clang based tooling is the main interest.

> >
> > Can I boot this in qemu?
> >
qemu tcg seems to work fine for gcc built s390 kernels. While clang built
kernels run smoothly natively and with accel=kvm there is still something
to be fixed for accel=tcg (kernel fails to boot on both s390 and x86).

