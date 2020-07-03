Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A87C20BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGCM7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:59:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgGCM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:59:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 063CUb5E062981;
        Fri, 3 Jul 2020 08:58:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 321cve9ke5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 08:58:30 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 063CWM5N068303;
        Fri, 3 Jul 2020 08:58:30 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 321cve9kdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 08:58:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 063CkiGd024370;
        Fri, 3 Jul 2020 12:58:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 31wwch6tw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 12:58:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 063CwQNW63176796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jul 2020 12:58:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73BE052051;
        Fri,  3 Jul 2020 12:58:26 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id DDCCA5204E;
        Fri,  3 Jul 2020 12:58:23 +0000 (GMT)
Date:   Fri, 3 Jul 2020 18:28:23 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Michal Such?nek <msuchanek@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200703125823.GA26243@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
 <20200703105944.GS18446@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200703105944.GS18446@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_06:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0 cotscore=-2147483648
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007030086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michal Hocko <mhocko@kernel.org> [2020-07-03 12:59:44]:

> > Honestly, I do not have any idea. I've traced it down to
> > Author: Andi Kleen <ak@suse.de>
> > Date:   Tue Jan 11 15:35:48 2005 -0800
> > 
> >     [PATCH] x86_64: Fix ACPI SRAT NUMA parsing
> > 
> >     Fix fallout from the recent nodemask_t changes. The node ids assigned
> >     in the SRAT parser were off by one.
> > 
> >     I added a new first_unset_node() function to nodemask.h to allocate
> >     IDs sanely.
> > 
> >     Signed-off-by: Andi Kleen <ak@suse.de>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> > which doesn't really tell all that much. The historical baggage and a
> > long term behavior which is not really trivial to fix I suspect.
> 
> Thinking about this some more, this logic makes some sense afterall.
> Especially in the world without memory hotplug which was very likely the
> case back then. It is much better to have compact node mask rather than
> sparse one. After all node numbers shouldn't really matter as long as
> you have a clear mapping to the HW. I am not sure we export that
> information (except for the kernel ring buffer) though.
> 
> The memory hotplug changes that somehow because you can hotremove numa
> nodes and therefore make the nodemask sparse but that is not a common
> case. I am not sure what would happen if a completely new node was added
> and its corresponding node was already used by the renumbered one
> though. It would likely conflate the two I am afraid. But I am not sure
> this is really possible with x86 and a lack of a bug report would
> suggest that nobody is doing that at least.
> 

JFYI,
Satheesh copied in this mailchain had opened a bug a year on crash with vcpu
hotplug on memoryless node. 

https://bugzilla.kernel.org/show_bug.cgi?id=202187

-- 
Thanks and Regards
Srikar Dronamraju
