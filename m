Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CDC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB1A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCXJgn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:36:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgCXJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:36:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O9YLCc006158
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:36:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7d41ds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 05:36:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Tue, 24 Mar 2020 09:36:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 09:36:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O9aYB232964816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 09:36:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D19842042;
        Tue, 24 Mar 2020 09:36:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C7442041;
        Tue, 24 Mar 2020 09:36:33 +0000 (GMT)
Received: from [9.199.50.248] (unknown [9.199.50.248])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 09:36:32 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <87a746cdva.fsf@linux.ibm.com>
Date:   Tue, 24 Mar 2020 15:06:31 +0530
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org
Content-Transfer-Encoding: 8BIT
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
 <87a746cdva.fsf@linux.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032409-0008-0000-0000-00000362E88A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032409-0009-0000-0000-00004A845422
Message-Id: <33E32320-C371-4A41-A3E1-4B9D2DDAFBFC@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=901
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 24-Mar-2020, at 2:45 PM, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
> 
> Sachin Sant <sachinp@linux.vnet.ibm.com> writes:
> 
>> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
>> 
>> Bisect leads me to  commit d41e2f3bd546 
>> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>> 
>> Reverting this commit helps and the tests complete without any crash.
> 
> 
> Can you try this change?
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index aadb7298dcef..3012d1f3771a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 			ms->usage = NULL;
> 		}
> 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +		/* Mark the section invalid */
> +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> 	}
> 
> 	if (section_is_early && memmap)
> 

This patch works for me. The test ran successfully without any crash/failure.

Thanks
-Sachin

> a pfn_valid check involves pnf_section_valid() check if section is
> having MEM_MAP. In this case we did end up  setting the ms->uage = NULL.
> So when we do that tupdate the section to not have MEM_MAP.
> 
> -aneesh

