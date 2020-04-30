Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CEC83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A1421D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD3EfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:35:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726455AbgD3EfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:35:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U4Xa7v131943;
        Thu, 30 Apr 2020 00:34:52 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjmm7xbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:34:52 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4P9DE011143;
        Thu, 30 Apr 2020 04:34:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 30mcu7x9b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:34:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4Ym6A55902454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:34:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 625615204F;
        Thu, 30 Apr 2020 04:34:48 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 31A5F52052;
        Thu, 30 Apr 2020 04:34:46 +0000 (GMT)
Date:   Thu, 30 Apr 2020 10:04:45 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] powerpc/numa: Prefer node id queried from vphn
Message-ID: <20200430043445.GE19958@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200428093836.27190-1-srikar@linux.vnet.ibm.com>
 <20200428093836.27190-3-srikar@linux.vnet.ibm.com>
 <20200429065229.GA18304@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200429065229.GA18304@in.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=836 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004300030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2020-04-29 12:22:29]:

> Hello Srikar,
> 
> 
> > +		if (nid == NUMA_NO_NODE) {
> > +			cpu = of_get_cpu_node(i, NULL);
> > +			if (cpu) {
> 
> Why are we not retaining the BUG_ON(!cpu) assert here ?
> 
> > +				nid = of_node_to_nid_single(cpu);
> > +				of_node_put(cpu);
> > +			}
> > +		}
> 
> Is it possible at this point that both vphn_get_nid(i) and
> of_node_to_nid_single(cpu) returns NUMA_NO_NODE ? If so,
> should we still call node_set_online() below ?

Yeah, I think It makes sense to retain the BUG_ON and if check.

Will incorporate both of them in the next version.

> 
> 
> >  		node_set_online(nid);
> >  	}
> > 
> > -- 
> > 2.20.1
> > 
> --
> Thanks and Regards
> gautham.

-- 
Thanks and Regards
Srikar Dronamraju
