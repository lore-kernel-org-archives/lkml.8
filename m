Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7BFC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A0E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD3RUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:20:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgD3RUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:20:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UH2OqJ073064;
        Thu, 30 Apr 2020 13:19:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhc3vs69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 13:19:52 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UH4DJ5084423;
        Thu, 30 Apr 2020 13:19:51 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhc3vs5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 13:19:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UHAvTE017841;
        Thu, 30 Apr 2020 17:19:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu7322e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 17:19:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UHJko756360974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 17:19:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EF4411C04C;
        Thu, 30 Apr 2020 17:19:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63DDB11C04A;
        Thu, 30 Apr 2020 17:19:45 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.14.241])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 17:19:45 +0000 (GMT)
Date:   Thu, 30 Apr 2020 19:19:42 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name,
        david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        Ulrich.Weigand@de.ibm.com
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200430191942.3ae9155f@p-imbrenda>
In-Reply-To: <172c51f7-7dd6-7dd0-153f-aedd4b10a9f3@intel.com>
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
        <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
        <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
        <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
        <20200430005310.7b25efab@p-imbrenda>
        <172c51f7-7dd6-7dd0-153f-aedd4b10a9f3@intel.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_11:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=830 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 16:52:46 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/29/20 3:53 PM, Claudio Imbrenda wrote:
> >> Actually, that's the problem.  You've gone through all these
> >> careful checks and made the page inaccessible.  *After* that
> >> process, how do you keep the page from being hit by an I/O device
> >> before it's made accessible again?  My patch just assumes that
> >> *all* pages have gone through that process and passed those
> >> checks.  
> > I don't understand what you are saying here.
> > 
> > we start with all pages accessible, we mark pages as inaccessible
> > when they are imported in the secure guest (we use the PG_arch_1
> > bit in struct page). we then try to catch all I/O on inaccessible
> > pages and make them accessible so that I/O devices are happy.   
> 
> The catching mechanism is incomplete, that's all I'm saying.

well, sendto in the end does a copy_from_user or a get_user_pages_fast,
both are covered (once we fix the make_accessible to work on FOLL_GET
too). 

> Without looking too hard, and not even having the hardware, I've found
> two paths where the "catching" was incomplete:
> 
> 	1. sendfile(), which you've patched
> 	2. sendto(), which you haven't patched
> 
> > either your quick and dirty patch was too dirty (e.g. not accounting
> > for possible races between make_accessible/make_inaccessible), or
> > some of the functions in the trace you provided should do
> > pin_user_page instead of get_user_page (or both)  
> 
> I looked in the traces for any races.  For sendto(), at least, the
> make_accessible() never happened before the process exited.  That's
> entirely consistent with the theory that it entirely missed being
> caught.  I can't find any evidence that there were races.
> 
> Go ahead and try it.  You have the patch!  I mean, I found a bug in
> about 10 minutes in one tiny little VM.

I tried your patch, but I could not reproduce the problem. I have a
Debian 10 x86_64 with the latest kernel from master and your patch on
top. is there anything I'm missing? which virtual devices are you using?
any particular .config options?

I could easily get the mm_make_accessible tracepoints, but I never
manage to trigger the mm_accessible_error ones.

are you using transparent hugepages by any chance? the
infrastructure for inaccessible pages is meant only for small pages,
since on s390x only small pages can ever be used for secure
guests and therefore become inaccessible.

> And, yes, you need to get rid of the FOLL_PIN check unless you want to
> go change a big swath of the remaining get_user_pages*() sites.

