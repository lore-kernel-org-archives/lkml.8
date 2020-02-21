Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C5DC35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5619207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBUUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:03:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgBUUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:03:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LJq6M1023464;
        Fri, 21 Feb 2020 15:03:05 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y9tkdcrxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 15:03:05 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01LJqp4L024213;
        Fri, 21 Feb 2020 15:03:05 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y9tkdcrxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 15:03:05 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01LK146K024904;
        Fri, 21 Feb 2020 20:03:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2y6897nekp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 20:03:04 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LK33ha44499376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 20:03:03 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 022AB136053;
        Fri, 21 Feb 2020 20:03:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4E7136051;
        Fri, 21 Feb 2020 20:03:02 +0000 (GMT)
Received: from localhost (unknown [9.41.179.160])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 20:03:02 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Scott Cheloha <cheloha@linux.ibm.com>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Suchanek <msuchanek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenont <ndfont@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] pseries/hotplug-memory: leverage xarray API to simplify code
In-Reply-To: <20200221172901.1596249-3-cheloha@linux.ibm.com>
References: <20200128221113.17158-1-cheloha@linux.ibm.com> <20200221172901.1596249-3-cheloha@linux.ibm.com>
Date:   Fri, 21 Feb 2020 14:03:02 -0600
Message-ID: <87pne7so7d.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_07:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=747 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

Scott Cheloha <cheloha@linux.ibm.com> writes:
> -#define for_each_drmem_lmb_in_range(lmb, start, end)		\
> -	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
> -
> -#define for_each_drmem_lmb(lmb)					\
> -	for_each_drmem_lmb_in_range((lmb),			\
> -		&drmem_info->lmbs[0],				\
> -		&drmem_info->lmbs[drmem_info->n_lmbs - 1])

A couple things.

This will conflict with "powerpc/pseries: Avoid NULL pointer dereference
when drmem is unavailable" which is in linuxppc/next-test:
   
   https://patchwork.ozlabs.org/patch/1231904/

Regardless, I don't think trading the iterator macros for open-coded
loops improve the code:

> -	for_each_drmem_lmb(lmb) {
> +	for (i = 0; i < drmem_info->n_lmbs; i++) {
> +		lmb = &drmem_info->lmbs[i];

[...]

> +struct xarray;
> +extern struct xarray *drmem_lmb_xa;

drmem_lmb_xa should go in the drmem_info structure if you can't make it
static in drmem.c.

>  
>  /*
>   * The of_drconf_cell_v1 struct defines the layout of the LMB data
> @@ -71,23 +66,6 @@ static inline u32 drmem_lmb_size(void)
>  	return drmem_info->lmb_size;
>  }
>  
> -#define DRMEM_LMB_RESERVED	0x80000000
> -
> -static inline void drmem_mark_lmb_reserved(struct drmem_lmb *lmb)
p> -{
> -	lmb->flags |= DRMEM_LMB_RESERVED;
> -}
> -
> -static inline void drmem_remove_lmb_reservation(struct drmem_lmb *lmb)
> -{
> -	lmb->flags &= ~DRMEM_LMB_RESERVED;
> -}
> -
> -static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
> -{
> -	return lmb->flags & DRMEM_LMB_RESERVED;
> -}

The flag management is logically separate from the iterator changes, so
splitting that out would ease review.

Looking further... yes, this needs to be a series of smaller changes
please.
