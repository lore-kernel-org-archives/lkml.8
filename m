Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A73207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yaJ2nXWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGTWz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:55:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51440 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGTWz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:55:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMlUxO064887;
        Mon, 20 Jul 2020 22:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TwMFG5S5IxfcExV8Z/lH070sE1bTnNBFGj9lhGTDUuQ=;
 b=yaJ2nXWdnrH3bkaKSgDv4SCQm5cIMMDB4MDBcIAB/buqwyWc/TJLyZszfrBzsXgKPPAW
 a0z2RISBt7H6wdMMvtOWL3xi6OU78m38fUYQSu67yB5dideAeqnFbO/2suICISM110vk
 OZV6NJZ+GxjYdlu72a9vreNB23hLY7ImlOTkkImcUt/ao/QbCrNqH7Giz2E/g1kDuBdp
 08E/MafqOBgGzj2Hyz6GBbhE0A+B8wM4T+VwXUvPWx68RAamlfz3kckS2RNFd8ugbDWU
 Q5wMFk2W7HpDA5Ml0Sl9fFS6L5iNEfr1j/rg9fMbBRaXWrpnZFekoBvsKZ3b/zbj/vqF sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32bs1m9qf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 22:55:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMmxTV120266;
        Mon, 20 Jul 2020 22:55:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32djyx4ykp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 22:55:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06KMtnY6032196;
        Mon, 20 Jul 2020 22:55:50 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 15:55:49 -0700
Subject: Re: [PATCH 4/5] doc/vm: fix typo in in the hugetlb admin
 documentation
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-5-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <25124e00-6f43-cff9-1bdc-6f0f8ee1fdc3@oracle.com>
Date:   Mon, 20 Jul 2020 15:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720062623.13135-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:26 PM, Baoquan He wrote:
> Change 'pecify' to 'Specify'.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 015a5f7d7854..f7b1c7462991 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -131,7 +131,7 @@ hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
>  default_hugepagesz
> -	pecify the default huge page size.  This parameter can
> +	Specify the default huge page size.  This parameter can
>  	only be specified once on the command line.  default_hugepagesz can
>  	optionally be followed by the hugepages parameter to preallocate a
>  	specific number of huge pages of default size.  The number of default
> 

Unfortunately, this review comment was missed when the typo was introduced.
https://lore.kernel.org/lkml/5ca27419-7496-8799-aeed-3042c9770ba8@oracle.com/

Thanks for fixing,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
