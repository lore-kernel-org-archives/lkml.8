Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EFEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A1824969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgEHNGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgEHNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:06:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048D34s8024535;
        Fri, 8 May 2020 09:05:41 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt0m578-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:05:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048D01rw018164;
        Fri, 8 May 2020 13:05:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5wffg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:05:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048D5bR264356640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 13:05:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA1BC4C046;
        Fri,  8 May 2020 13:05:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D55094C04A;
        Fri,  8 May 2020 13:05:34 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  8 May 2020 13:05:34 +0000 (GMT)
Date:   Fri, 8 May 2020 18:35:34 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200508130534.GB1961@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com>
 <20200501031128.19584-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2005022304190.28355@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2005022304190.28355@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_12:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher Lameter <cl@linux.com> [2020-05-02 23:05:28]:

> On Fri, 1 May 2020, Srikar Dronamraju wrote:
> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -116,8 +116,10 @@ EXPORT_SYMBOL(latent_entropy);
> >   */
> >  nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
> >  	[N_POSSIBLE] = NODE_MASK_ALL,
> > +#ifdef CONFIG_NUMA
> > +	[N_ONLINE] = NODE_MASK_NONE,
> 
> Hmmm.... I would have expected that you would have added something early
> in boot that would mark the current node (whatever is is) online instead?

Do correct me, but these are structure initialization in page_alloc.c
Wouldn't these happen much before the numa initialization happens?
I think we are already marking nodes as online as soon as we detect the
nodes.

-- 
Thanks and Regards
Srikar Dronamraju
