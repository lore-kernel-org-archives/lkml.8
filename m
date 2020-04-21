Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUF3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:29:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgDUF3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:29:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L53AAd126624
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:29:52 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2wr20k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:29:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Tue, 21 Apr 2020 06:29:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 06:29:05 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03L5TmQg3277060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 05:29:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1227A52051;
        Tue, 21 Apr 2020 05:29:48 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.22.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C804B5204E;
        Tue, 21 Apr 2020 05:29:47 +0000 (GMT)
Date:   Tue, 21 Apr 2020 07:29:46 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/mmap.c: do not allow mappings outside of allowed
 limits
References: <cover.1584958099.git.agordeev@linux.ibm.com>
 <d6da1319114a331095052638f0ffa3ccb0be58f1.1584958099.git.agordeev@linux.ibm.com>
 <20200420195903.93455e087985b423f97bdfe3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420195903.93455e087985b423f97bdfe3@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20042105-4275-0000-0000-000003C3BBEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042105-4276-0000-0000-000038D93F74
Message-Id: <20200421052945.GA26279@oc3871087118.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_01:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=716
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:59:03PM -0700, Andrew Morton wrote:
> On Mon, 23 Mar 2020 14:29:29 +0100 agordeev@linux.ibm.com wrote:
> 
> > It is possible to request a fixed mapping address below
> > mmap_min_addr and succeed. This update adds early checks
> > of mmap_min_addr and mmap_end boundaries and fixes the
> > above issue.
> 
> Does this solve any known problems?  If not, what is the motivation for
> the change?

One can set a lowest possible address in /proc/sys/vm/mmap_min_addr 
and mmap below that bound nevertheless. Apart from it is wrong I am
not aware of any existing issue.

Thanks!

