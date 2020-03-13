Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D699C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F520746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCML15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726414AbgCML14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:27:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DBN8Zs063038
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:27:55 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yr8kmhp62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:27:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 13 Mar 2020 11:22:53 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Mar 2020 11:22:48 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02DBMlsH43057466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 11:22:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCD55205F;
        Fri, 13 Mar 2020 11:22:47 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id B859E5204F;
        Fri, 13 Mar 2020 11:22:44 +0000 (GMT)
Date:   Fri, 13 Mar 2020 16:52:44 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20031311-4275-0000-0000-000003ABA74A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031311-4276-0000-0000-000038C0C8AB
Message-Id: <20200313112244.GC25144@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [2020-03-12 17:41:58]:

> On 3/12/20 5:13 PM, Srikar Dronamraju wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [2020-03-12 14:51:38]:
> > 
> >> > * Vlastimil Babka <vbabka@suse.cz> [2020-03-12 10:30:50]:
> >> > 
> >> >> On 3/12/20 9:23 AM, Sachin Sant wrote:
> >> >> >> On 12-Mar-2020, at 10:57 AM, Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> >> >> >> * Michal Hocko <mhocko@kernel.org> [2020-03-11 12:57:35]:
> >> >> >>> On Wed 11-03-20 16:32:35, Srikar Dronamraju wrote:
> >> I think we do need well defined and documented rules around node_to_mem_node(),
> >> cpu_to_node(), existence of NODE_DATA, various node_states bitmaps etc so
> >> everyone handles it the same, safe way.
> 
> So let's try to brainstorm how this would look like? What I mean are some rules
> like below, even if some details in my current understanding are most likely
> incorrect:
> 

Agree.

> with nid present in:
> N_POSSIBLE - pgdat might not exist, node_to_mem_node() must return some online
> node with memory so that we don't require everyone to search for it in slightly
> different ways
> N_ONLINE - pgdat must exist, there doesn't have to be present memory,
> node_to_mem_node() still has to return something else (?)

Right, think this has been taken care of at this time.

> N_NORMAL_MEMORY - there is present memory, node_to_mem_node() returns itself
> N_HIGH_MEMORY - node has present high memory
> 

dont see any problems with the above two to. That leaves us with N_POSSIBLE.

> > 
> > Other option would be to tweak Kirill Tkhai's patch such that we call
> > kvmalloc_node()/kzalloc_node() if node is online and call kvmalloc/kvzalloc
> > if the node is offline.
> 
> I really would like a solution that hides these ugly details from callers so
> they don't have to workaround the APIs we provide. kvmalloc_node() really
> shouldn't crash, and it should fallback automatically if we don't give it
> __GFP_THISNODE
> 

Agree thats its better to make API's robust where possible.

> However, taking a step back, memcg_alloc_shrinker_maps() is probably rather
> wasteful on systems with 256 possible nodes and only few present, by allocating
> effectively dead structures for each memcg.
> 

If we dont allocate now, we would have to allocate them when we online the
nodes. To me it looks better to allocate as soon as the nodes are onlined,

> SLUB tries to be smart, so it allocates the per-node per-cache structures only
> when the node goes online in slab_mem_going_online_callback(). This is why
> there's a crash when such non-existing structures are accessed for a node that's
> not online, and why they shouldn't be accessed.
> 
> Perhaps memcg should do the same on-demand allocation, if possible.
> 

Right.

-- 
Thanks and Regards
Srikar Dronamraju

