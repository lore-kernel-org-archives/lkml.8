Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7027C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95652075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tOnfqc4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH1PB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:01:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgH1PBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:01:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SEWS0R080188;
        Fri, 28 Aug 2020 11:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=whWwP11nLkwAhTzmvg3pxCC7eFCxf/dZHtL4Lprb/U4=;
 b=tOnfqc4q6loVCIUljkUdZ3pqhjUVorJH7t74xWinwP5HsHDqw4fQQDLSCD7J04zYEfqp
 tJrAfFhIvGJZFHJtAugYY3HOCRZbbLSGykjkNyu9C2PfWJkkLCptTuEY/vTqLkk4eq1F
 gKJh4QYxHsMR1zSjFSVbLOIxFwV3xAnKoNpaudlgTFP9UttApq6hc/7MK6e43jWOxRpE
 b5weWm/n+DKsVtUAi/epMC+CiXGnqIqsLWwoUQsCa+xcimw5dcwxWQm1ycjoaat3aTSG
 BZokYd3s0jKlFOOgbwLfGRqdhYP/4zQbuifA6u8KiNBeoQZCJCMa1K+T+CXTvd+aYWP+ FQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3370k56se9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:01:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SEvF04009069;
        Fri, 28 Aug 2020 15:01:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 336124sv9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 15:01:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SF15jS30015968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 15:01:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EDFBAE057;
        Fri, 28 Aug 2020 15:01:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 866C5AE065;
        Fri, 28 Aug 2020 15:01:04 +0000 (GMT)
Received: from thinkpad (unknown [9.171.56.70])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Aug 2020 15:01:04 +0000 (GMT)
Date:   Fri, 28 Aug 2020 17:01:03 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828170103.6d954d95@thinkpad>
In-Reply-To: <20200828142137.GX24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <20200828142137.GX24045@ziepe.ca>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_08:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:21:37 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Aug 28, 2020 at 04:03:12PM +0200, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> I think the page walk code in mm/pagewalk.c has similar issues to
> GUP. I've been noodling on some patches to add the missing stack
> copies to pagewalk.c as they are clearly missing..
> 
> It would be good if this could be less GUP specific?
> 
> Generically this is about walking the page table without holding the
> page table spinlocks using READ_ONCE.

Indeed, if there were other code paths doing that, they would most
likely also be broken (at least) for s390. Alexander was already
looking into generalizing the new gup-specific helpers, but so
far we assumed that would only be "nice to have" for the future,
and not fix any real issues at the moment. So we wanted to
focus on first fixing the very real gup_fast issue.

Both approaches here probably could be generalized, by either
changing pXd_address_end() or pXd_offset(), but I guess it makes
sense to already take into account that we might need such
generalization sooner than expected.

Just to make sure, you are referring to some future / planned
changes to mm/pagewalk.c, and not some currently existing
pagetable walkers already using the READ_ONCE logic w/o
spinlocks? If those would exist already, I guess we would
already have issues on s390, independent from our conversion
to common code gup_fast.

Regards,
Gerald
