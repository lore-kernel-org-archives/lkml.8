Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2928C169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C805720801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBSSbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:31:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726609AbgBSSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:31:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JIMMO5125013
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:31:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubsfvqq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:31:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 19 Feb 2020 18:31:44 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Feb 2020 18:31:41 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01JIVemN28770560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 18:31:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906E2AE051;
        Wed, 19 Feb 2020 18:31:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AE03AE045;
        Wed, 19 Feb 2020 18:31:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.46])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Feb 2020 18:31:38 +0000 (GMT)
Date:   Wed, 19 Feb 2020 19:31:35 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 RESEND] mm/sparsemem: pfn_to_page is not valid yet on
 SPARSEMEM
References: <20200219030454.4844-1-bhe@redhat.com>
 <CAPcyv4iZCnSpypshYpXCL35yT4KZfgXqDqS8cFDGpXC-A72Utg@mail.gmail.com>
 <20200219085700.GB32242@linux.ibm.com>
 <CAPcyv4isoKSo2TtP3_VzdPQwdfc2O=KAv44LkqSSTccP7Cnh7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4isoKSo2TtP3_VzdPQwdfc2O=KAv44LkqSSTccP7Cnh7A@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20021918-0020-0000-0000-000003ABB057
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021918-0021-0000-0000-00002203B29E
Message-Id: <20200219183135.GA10266@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_05:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 spamscore=0
 mlxlogscore=665 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 08:37:25AM -0800, Dan Williams wrote:
> On Wed, Feb 19, 2020 at 12:57 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Feb 18, 2020 at 07:25:15PM -0800, Dan Williams wrote:
> > > On Tue, Feb 18, 2020 at 7:05 PM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > From: Wei Yang <richardw.yang@linux.intel.com>
> > > >
> > > > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> > > > doesn't work before sparse_init_one_section() is called. This leads to a
> > > > crash when hotplug memory:
> > >
> > > I'd also add:
> > >
> > > "On x86 the impact is limited to x86_32 builds, or x86_64
> > > configurations that override the default setting for
> > > SPARSEMEM_VMEMMAP".
> >
> > Do we also want to check how it affects, say, arm64, ia64 and ppc? ;-)
> 
> Sure, I just did not take the time to look up their respective default
> stances on SPARSEMEM_VMEMMAP. For a distro looking to backport this
> commit I think it's helpful for them to understand if they are exposed
> or not.

Looks like only i386_defconfig does not enable SPARSEMEM_VMEMMAP. All the
rest may have it disabled only with manual override.

-- 
Sincerely yours,
Mike.

