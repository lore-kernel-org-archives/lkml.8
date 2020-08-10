Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B67022D72
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N5G4qk+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHJPyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:54:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgHJPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:54:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07AFWAIr038306;
        Mon, 10 Aug 2020 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kVOkYBFM3KYSJsS6ox2Mh1rrTKR+lZ3pN3xTSFRRNYc=;
 b=N5G4qk+VmKfVZcLO8mmGV7DlsVVmu/7JmXdIrkK8tGdj52N2cQ4Qb4dJVK0UmXRA6mW5
 P90ZkO8xSw1tDBI3XeLCpfiG9AXNfZR026lnF0YuDF2vM9NCl3riuWUhWHRD1ZZbbn9F
 lLiaI1146WQurZC0Urp8ekuNnMqYHSoOkkCj3i1qkmlNEF7z7veyR2Avj5zNWVvs3Gey
 /KJV8tcdnZvOmkorCaWIAaMclsgaGUnw5IiF93QQwjyrdIebluZNdr470YkqO2kmUdmj
 vstGPIUuZRq0DCw4C4Y61favoUQLczHiBEcWYBlc73/w3O9acIBLlnG5Nt8bjzDXNXfz ew== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32sravrxnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 11:54:06 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07AFgloh024836;
        Mon, 10 Aug 2020 15:54:04 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 32skp7sghq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 15:54:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07AFs2Zj30278122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 15:54:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A3FDA4051;
        Mon, 10 Aug 2020 15:54:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEEB8A4040;
        Mon, 10 Aug 2020 15:54:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.32.167])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Aug 2020 15:54:00 +0000 (GMT)
Date:   Mon, 10 Aug 2020 18:53:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [PATCH] x86/mm/64: Do not dereference non-present PGD entries
Message-ID: <20200810155359.GV163101@linux.ibm.com>
References: <20200807084013.7090-1-joro@8bytes.org>
 <165106f9-392f-9ca5-52c8-8d58c41c5f79@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165106f9-392f-9ca5-52c8-8d58c41c5f79@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_11:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=790 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 07:27:33AM -0700, Dave Hansen wrote:
> ... adding Kirill
> 
> On 8/7/20 1:40 AM, Joerg Roedel wrote:
> > +		lvl = "p4d";
> > +		p4d = p4d_alloc(&init_mm, pgd, addr);
> > +		if (!p4d)
> > +			goto failed;
> >  
> > +		/*
> > +		 * With 5-level paging the P4D level is not folded. So the PGDs
> > +		 * are now populated and there is no need to walk down to the
> > +		 * PUD level.
> > +		 */
> >  		if (pgtable_l5_enabled())
> >  			continue;
> 
> It's early and I'm a coffee or two short of awake, but I had to stare at
> the comment for a but to make sense of it.
> 
> It feels wrong, I think, because the 5-level code usually ends up doing
> *more* allocations and in this case, it is _appearing_ to do fewer.
> Would something like this make sense?

Unless I miss something, with 5 levels vmalloc mappings are shared at
p4d level, so allocating a p4d page would be enough. With 4 levels,
p4d_alloc() is a nop and pud is the first actually populated level below
pgd.

> 		/*
> 		 * The goal here is to allocate all possibly required
> 		 * hardware page tables pointed to by the top hardware
> 		 * level.
> 		 *
> 		 * On 4-level systems, the p4d layer is folded away and
> 		 * the above code does no preallocation.  Below, go down
> 		 * to the pud _software_ level to ensure the second
> 		 * hardware level is allocated.
> 		 */
> 
> 
> > -		pud = pud_offset(p4d, addr);
> > -		if (pud_none(*pud)) {
> > -			/* Ends up here only with 4-level paging */
> > -			pud = pud_alloc(&init_mm, p4d, addr);
> > -			if (!pud) {
> > -				lvl = "pud";
> > -				goto failed;
> > -			}
> > -		}
> > +		lvl = "pud";
> > +		pud = pud_alloc(&init_mm, p4d, addr);
> > +		if (!pud)
> > +			goto failed;
> >  	}

-- 
Sincerely yours,
Mike.
