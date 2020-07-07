Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6814AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C2206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGGMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:13:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbgGGMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:13:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067C5aQR092236;
        Tue, 7 Jul 2020 08:13:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324fapy7t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:13:10 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067C5aq0092226;
        Tue, 7 Jul 2020 08:13:10 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324fapy7sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 08:13:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067C6dPo022704;
        Tue, 7 Jul 2020 12:13:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h3bpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 12:13:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067CD5im10879242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 12:13:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0BC2A4054;
        Tue,  7 Jul 2020 12:13:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5545CA4062;
        Tue,  7 Jul 2020 12:13:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.169])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Jul 2020 12:13:04 +0000 (GMT)
Date:   Tue, 7 Jul 2020 15:13:02 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200707121302.GB9411@linux.ibm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707115454.GN5913@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_07:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=1 malwarescore=0
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> On Tue 07-07-20 13:59:15, Jia He wrote:
> > This exports memory_add_physaddr_to_nid() for module driver to use.
> > 
> > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > NUMA_NO_NID is detected.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/mm/numa.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index aafcee3e3f7e..7eeb31740248 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >  
> >  /*
> >   * We hope that we will be hotplugging memory on nodes we already know about,
> > - * such that acpi_get_node() succeeds and we never fall back to this...
> > + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >   */
> >  int memory_add_physaddr_to_nid(u64 addr)
> >  {
> > -	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> 
> Does it make sense to export a noop function? Wouldn't make more sense
> to simply make it static inline somewhere in a header? I haven't checked
> whether there is an easy way to do that sanely bu this just hit my eyes.

We'll need to either add a CONFIG_ option or arch specific callback to
make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
implementations coexist ...

> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
