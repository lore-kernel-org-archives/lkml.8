Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F93F20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2ELtpHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgFWRid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:38:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbgFWRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:38:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NHMfSd015056;
        Tue, 23 Jun 2020 17:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nflC2fPKqz65v971/J4lWndyYO3MG6PAmjsjYWn0c5g=;
 b=P2ELtpHFmem51Lif4W4MkVlNXOGyZCWxRcuT+FGSSPkfzikv2wLhKuht5ki5rCC4qj+4
 s2NUA6vsfJW676wDIs7W1iwHypIqQo2ScwK2YD6Len1nEd6K7HqXLyFgylwAj5QRGw4r
 z7M4oA6rgbzdUacn0mmtbO/nWKx5AO5RK9mOZO+TfSr4GDhPj97W/HsCmi5vUnb+QdbQ
 OKFLnWGPAgqDiwX2HuTaoPiLoBJ93tEiiJ9uJctd7ezcI7tApiig76B3cTAE3h9B/KwA
 B9nVUyb2k1SrqZ67CNr8/EHkYq7z02OWLnIH8ul8NGB+ayLxi0N7DLLzPrGSfBHagFgF Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31uk2rs960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 17:38:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NHO3f3128912;
        Tue, 23 Jun 2020 17:38:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31uk3h0pnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 17:38:14 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05NHc8GT021769;
        Tue, 23 Jun 2020 17:38:08 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 17:38:08 +0000
Subject: Re: [PATCH v2 10/15] docs: hugetlbpage.rst: fix some warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
 <86b6796b1a84e18b24314ecd29318951c1479ca2.1592895969.git.mchehab+huawei@kernel.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5ca27419-7496-8799-aeed-3042c9770ba8@oracle.com>
Date:   Tue, 23 Jun 2020 10:38:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <86b6796b1a84e18b24314ecd29318951c1479ca2.1592895969.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 12:09 AM, Mauro Carvalho Chehab wrote:
> Some new command line parameters were added at hugetlbpage.rst.
> Adjust them in order to properly parse that part of the file,
> avoiding those warnings:
> 
>     Documentation/admin-guide/mm/hugetlbpage.rst:105: WARNING: Unexpected indentation.
>     Documentation/admin-guide/mm/hugetlbpage.rst:108: WARNING: Unexpected indentation.
>     Documentation/admin-guide/mm/hugetlbpage.rst:109: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/admin-guide/mm/hugetlbpage.rst:112: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/admin-guide/mm/hugetlbpage.rst:120: WARNING: Unexpected indentation.
>     Documentation/admin-guide/mm/hugetlbpage.rst:121: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/admin-guide/mm/hugetlbpage.rst:132: WARNING: Unexpected indentation.
>     Documentation/admin-guide/mm/hugetlbpage.rst:135: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fixes: cd9fa28b5351 ("hugetlbfs: clean up command line processing")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 23 +++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 5026e58826e2..015a5f7d7854 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -101,37 +101,48 @@ be specified in bytes with optional scale suffix [kKmMgG].  The default huge
>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
>  
>  Hugetlb boot command line parameter semantics
> -hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
> +
> +hugepagesz
> +	Specify a huge page size.  Used in conjunction with hugepages
>  	parameter to preallocate a number of huge pages of the specified
>  	size.  Hence, hugepagesz and hugepages are typically specified in
> -	pairs such as:
> +	pairs such as::
> +
>  		hugepagesz=2M hugepages=512
> +
>  	hugepagesz can only be specified once on the command line for a
>  	specific huge page size.  Valid huge page sizes are architecture
>  	dependent.
> -hugepages - Specify the number of huge pages to preallocate.  This typically
> +hugepages
> +	Specify the number of huge pages to preallocate.  This typically
>  	follows a valid hugepagesz or default_hugepagesz parameter.  However,
>  	if hugepages is the first or only hugetlb command line parameter it
>  	implicitly specifies the number of huge pages of default size to
>  	allocate.  If the number of huge pages of default size is implicitly
>  	specified, it can not be overwritten by a hugepagesz,hugepages
>  	parameter pair for the default size.
> -	For example, on an architecture with 2M default huge page size:
> +
> +	For example, on an architecture with 2M default huge page size::
> +
>  		hugepages=256 hugepagesz=2M hugepages=512
> +
>  	will result in 256 2M huge pages being allocated and a warning message
>  	indicating that the hugepages=512 parameter is ignored.  If a hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
> -default_hugepagesz - Specify the default huge page size.  This parameter can
> +default_hugepagesz
> +	pecify the default huge page size.  This parameter can

Oops, should be 'Specify' not 'pecify'

Other than that, this looks good.  Thanks!
-- 
Mike Kravetz

>  	only be specified once on the command line.  default_hugepagesz can
>  	optionally be followed by the hugepages parameter to preallocate a
>  	specific number of huge pages of default size.  The number of default
>  	sized huge pages to preallocate can also be implicitly specified as
>  	mentioned in the hugepages section above.  Therefore, on an
> -	architecture with 2M default huge page size:
> +	architecture with 2M default huge page size::
> +
>  		hugepages=256
>  		default_hugepagesz=2M hugepages=256
>  		hugepages=256 default_hugepagesz=2M
> +
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
>  
> 
