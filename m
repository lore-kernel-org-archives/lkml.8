Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690DDC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B70206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgEEOdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:33:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgEEOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:33:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045E73OF041810;
        Tue, 5 May 2020 10:33:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s50gpn5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:33:07 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045E7PCC044527;
        Tue, 5 May 2020 10:33:06 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s50gpn4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:33:06 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045EUj3A028193;
        Tue, 5 May 2020 14:33:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 30s0g5jvvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 14:33:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045EX1wo8782182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 14:33:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D997542041;
        Tue,  5 May 2020 14:33:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F5C4203F;
        Tue,  5 May 2020 14:33:01 +0000 (GMT)
Received: from oc3748833570.ibm.com (unknown [9.145.26.196])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 14:33:01 +0000 (GMT)
Received: by oc3748833570.ibm.com (Postfix, from userid 1000)
        id 39CBED80361; Tue,  5 May 2020 16:33:01 +0200 (CEST)
Date:   Tue, 5 May 2020 16:33:01 +0200
From:   Ulrich Weigand <uweigand@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        viro@zeniv.linux.org.uk, david@redhat.com,
        akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        jack@suse.cz, kirill@shutemov.name, peterz@infradead.org,
        sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200505143300.GA14113@oc3748833570.ibm.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
 <20200505135556.GA9920@oc3748833570.ibm.com>
 <fd300dca-f0b4-ce3b-4a97-244030624fbd@de.ibm.com>
 <d1de4fb2-dfe6-83fa-9973-2505d4c397ec@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1de4fb2-dfe6-83fa-9973-2505d4c397ec@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=641
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:03:00PM +0200, Christian Borntraeger wrote:
> > Just looked at 
> > commit 88b1a17dfc3ed7728316478fae0f5ad508f50397  mm: add 'try_get_page()' helper function
> > 
> > which says:
> >     Also like 'get_page()', you can't use this function unless you already
> >     had a reference to the page.  The intent is that you can use this
> >     exactly like get_page(), but in situations where you want to limit the
> >     maximum reference count.
> >     
> >     The code currently does an unconditional WARN_ON_ONCE() if we ever hit
> >     the reference count issues (either zero or negative), as a notification
> >     that the conditional non-increment actually happened.
> > 
> > If try_get_page must not be called with an existing reference, that means
> 		s/not//
> > that when we call it the page reference is already higher and our freeze
> > will never succeed. That would imply that we cannot trigger this. No?

Well, my understanding is that the "existing" reference may be one of the
references that is expected by our freeze code, in particular in gup the
existing reference is simply the one from the pte.  So in this case our
freeze *would* succeeed.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
