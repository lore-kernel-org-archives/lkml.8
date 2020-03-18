Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875E8C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DA820770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCRHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:50:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgCRHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:50:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I7Y5kD034868
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:50:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu719fdq0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:50:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 18 Mar 2020 07:50:16 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 07:50:12 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I7oBqa16973968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 07:50:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E13B342064;
        Wed, 18 Mar 2020 07:50:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8D042047;
        Wed, 18 Mar 2020 07:50:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 18 Mar 2020 07:50:08 +0000 (GMT)
Date:   Wed, 18 Mar 2020 13:20:08 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/page_alloc: Keep memoryless cpuless node 0 offline
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2003151416230.14449@www.lameter.com>
 <20200316085425.GB11482@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200316085425.GB11482@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20031807-0008-0000-0000-0000035F30D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031807-0009-0000-0000-00004A808A63
Message-Id: <20200318075008.GE4879@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michal Hocko <mhocko@kernel.org> [2020-03-16 09:54:25]:

> On Sun 15-03-20 14:20:05, Cristopher Lameter wrote:
> > On Wed, 11 Mar 2020, Srikar Dronamraju wrote:
> > 
> > > Currently Linux kernel with CONFIG_NUMA on a system with multiple
> > > possible nodes, marks node 0 as online at boot.  However in practice,
> > > there are systems which have node 0 as memoryless and cpuless.
> > 
> > Would it not be better and simpler to require that node 0 always has
> > memory (and processors)? A  mininum operational set?
> 
> I do not think you can simply ignore the reality. I cannot say that I am
> a fan of memoryless/cpuless numa configurations but they are a sad
> reality of different LPAR configurations. We have to deal with them.
> Besides that I do not really see any strong technical arguments to lack
> a support for those crippled configurations. We do have zonelists that
> allow to do reasonable decisions on memoryless nodes. So no, I do not
> think that this is a viable approach.
> 

I agree with Michal, kernel should accept the reality and work with
different Lpar configurations.

> > We can dynamically number the nodes right? So just make sure that the
> > firmware properly creates memory on node 0?
> 
> Are you suggesting that the OS would renumber NUMA nodes coming
> from FW just to satisfy node 0 existence? If yes then I believe this is
> really a bad idea because it would make HW/LPAR configuration matching
> to the resulting memory layout really hard to follow.
> 
> -- 
> Michal Hocko
> SUSE Labs

Michal, Vlastimil, Christoph and others, do you have any more comments,
suggestions or any other feedback. If not, can you please add your
reviewed-by, acked etc.

-- 
Thanks and Regards
Srikar Dronamraju

