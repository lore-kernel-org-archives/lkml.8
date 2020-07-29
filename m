Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B3022CBB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG2Nvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2474 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2Nvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:51:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TDWsVU119229;
        Wed, 29 Jul 2020 09:51:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jpwdq5ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:51:30 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06TDXBaj119834;
        Wed, 29 Jul 2020 09:51:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jpwdq5dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:51:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TDjqDQ027428;
        Wed, 29 Jul 2020 13:51:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx553j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 13:51:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TDnwVX61473274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 13:49:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE834C052;
        Wed, 29 Jul 2020 13:51:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8B2A4C044;
        Wed, 29 Jul 2020 13:51:23 +0000 (GMT)
Received: from localhost (unknown [9.145.151.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jul 2020 13:51:23 +0000 (GMT)
Date:   Wed, 29 Jul 2020 15:51:22 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux plumbers + clang + s390 virtualized testing
Message-ID: <your-ad-here.call-01596030682-ext-1369@work.hours>
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716112840.GC8484@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=912 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=1 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:28:40PM +0200, Heiko Carstens wrote:
> Hi Nick,
> 
> > We were very excited to see your patches going by for enabling Clang
> > support for s390.  Since then, we've added s390 builds to our
> > continuous integration setup.
> > 
> > We've been running into a few issues with doing virtualized boot tests
> > of our kernels on s390.
> > 
> > I was curious if you'll both be attending Linux plumbers conf?  If we
> > carve out time for an s390+clang talk, would this be of interest to
> > you to attend?
> 
> I will not attend, however cannot speak for Vasily. He will have to
> answer as soon as he returns - besides that enabling Clang support for
> s390 was done by Vasily anyway :)

I will attend and it would surely be interesting to me and other
s390 folks. Your efforts are greatly appreciated!

BTW I believe basic Clang support for s390 came earlier in 5.2 with
a lot of efforts from Arnd Bergmann.

My part was fixing recent breakages and bugging our s390 clang team
(which did all the great work) to get kernel specific features support
in clang 10 and 11 to reach features parity with gcc. And eventually
doing few adjustments so that features which came with clang 10 and
11 are working smoothly. That is s390 "asm goto" support and specific
compiler flags for ftrace support and stack packing.
