Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4AC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB5620722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i2geK7cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgELOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50560 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbgELOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CEb3lS040127;
        Tue, 12 May 2020 14:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iZX0vpfj4/FmfDVyUC3t3DN/LcDWMEdqRaJHSY+KNck=;
 b=i2geK7cGN8wVAmB/U87v0qnFX1QsR+WN2KKy8qIbb+ZositxYdc6rT4+ETuMUIi3Xjmj
 eX7DYE4M+zq4HYpt9DaOc7HzJrm4UDhvMlC+eTemHmsxN96P4VGD18ymE1Xh0hy3vZPY
 uwBSyd8DhPHJ+ooXn+PhWRrbZpM0jUy1nDKA0qYpVKZycQGp7gqWeAzUSxI0ZbIY1QCf
 24MMrrFizuvMUp9g6oM1XzMr4U0t6opTHWA39SjWztIEcXiJWxB7m2y9k6KRVyypT2vs
 r9tiTRBoAfxVs0UwJSn7xAFR6RIOl7GtLi4Ly/QRmQ+KyGVcg/XirDJmbnedcrsjm1Xp ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30x3mbuccf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 14:36:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CESNMe105391;
        Tue, 12 May 2020 14:36:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30x69tbdhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 14:36:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CEasTW008459;
        Tue, 12 May 2020 14:36:54 GMT
Received: from [10.175.218.127] (/10.175.218.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 07:36:54 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, jmoyer@redhat.com
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
Date:   Tue, 12 May 2020 15:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=5 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=5 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 11:55 PM, Dan Williams wrote:
> @@ -561,13 +580,26 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  	if (start == U64_MAX)
>  		return -EINVAL;
>  
> +	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> +			* (dev_dax->nr_range + 1), GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +
>  	alloc = __request_region(res, start, size, dev_name(dev), 0);
> -	if (!alloc)
> +	if (!alloc) {
> +		kfree(ranges);
>  		return -ENOMEM;
> +	}

Noticed this yesterday while looking at alloc_dev_dax_range().

Is it correct to free @ranges here on __request_region failure?

IIUC krealloc() would free dev_dax->ranges if it succeeds, leaving us without
any valid ranges if __request_region failure case indeed frees @ranges. These
@ranges are being used afterwards when we delete the interface and free the
assigned regions. Perhaps we should remove the kfree() above and set
dev_dax->ranges instead before __request_region; or alternatively change the
call order between krealloc and __request_region? FWIW, krealloc checks if the
object being reallocated already meets the requested size, so perhaps there's no
harm with going with the former.

	Joao
