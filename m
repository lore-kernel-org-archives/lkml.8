Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A83C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14B214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCBMDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:03:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbgCBMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:03:15 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022BxiAc028824;
        Mon, 2 Mar 2020 07:03:09 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmwv5654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 07:03:09 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 022C14Vg016200;
        Mon, 2 Mar 2020 12:03:07 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 2yffk69qgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 12:03:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022C36mI49021324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 12:03:06 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9259BBE059;
        Mon,  2 Mar 2020 12:03:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9BCBE056;
        Mon,  2 Mar 2020 12:03:01 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.1.4])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 12:02:58 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/5] libnvdimm/pfn: Prevent raw mode fallback if
 pfn-infoblock valid
In-Reply-To: <158291747661.1609624.13504407869218712107.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158291747661.1609624.13504407869218712107.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 02 Mar 2020 17:32:50 +0530
Message-ID: <87imjnrml1.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_03:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=2 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The EOPNOTSUPP return code from the pmem driver indicates that the
> namespace has a configuration that may be valid, but the current kernel
> does not support it. Expand this to all of the nd_pfn_validate() error
> conditions after the infoblock has been verified as self consistent.
>
> This prevents exposing the namespace to I/O when the infoblock needs to
> be corrected, or the system needs to be put into a different
> configuration (like changing the page size on PowerPC).
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/pfn_devs.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index a5c25cb87116..79fe02d6f657 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -561,14 +561,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  			dev_dbg(&nd_pfn->dev, "align: %lx:%lx mode: %d:%d\n",
>  					nd_pfn->align, align, nd_pfn->mode,
>  					mode);
> -			return -EINVAL;
> +			return -EOPNOTSUPP;
>  		}
>  	}
>  
>  	if (align > nvdimm_namespace_capacity(ndns)) {
>  		dev_err(&nd_pfn->dev, "alignment: %lx exceeds capacity %llx\n",
>  				align, nvdimm_namespace_capacity(ndns));
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	/*
> @@ -581,7 +581,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  	if (offset >= resource_size(&nsio->res)) {
>  		dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
>  				dev_name(&ndns->dev));
> -		return -EBUSY;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
> @@ -589,7 +589,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  		dev_err(&nd_pfn->dev,
>  				"bad offset: %#llx dax disabled align: %#lx\n",
>  				offset, align);
> -		return -ENXIO;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	return 0;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
