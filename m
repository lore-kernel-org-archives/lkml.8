Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3037FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E620663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EirR+/p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCSNvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:51:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgCSNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:51:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JDgtZM174045;
        Thu, 19 Mar 2020 13:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eWXMKVtdGsYfSp2Ry0nG0/jtLiPQGoFuRS02zDj15tQ=;
 b=EirR+/p4Rdmb9Ei0aSLzxHfRnXibD0FmfjNKVZ0k67S3QzSdmAZxs+l7fCWbNjHKF+B8
 DHZlebdIoyP/ynFl7MefE6b0IzeQ90OFxE6DUG+NB908VZl9BwJxJn6EA5PZkG/iNkUg
 zMq7/+m8JJU1tNqKtjfRYnM3y2cr1cbMW4N8IMST9xJYq8luQSpouy7ea4zbGQ7uzweC
 qaxrBUGCEYTmhE+G71BcnntMd0rZwHeZGGvpunaawKsJxR1HSx7j/SrfTnYpaFQzuloG
 c1sSaF5h1S3IJK5UrvqiIVTUA0JDlE/q2b6V63WudqzeQsy71hHL90MvCoj5vsdHNBcZ kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yrpprgeek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 13:51:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JDoesY139259;
        Thu, 19 Mar 2020 13:51:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ys90440s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 13:51:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JDpJmA011291;
        Thu, 19 Mar 2020 13:51:19 GMT
Received: from [192.168.1.140] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 06:51:18 -0700
Subject: Re: [PATCH 2/2] Documentation/vmcoreinfo: Add documentation for
 'KERNELPACMASK'
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <1584603551-23845-1-git-send-email-amit.kachhap@arm.com>
 <1584603551-23845-2-git-send-email-amit.kachhap@arm.com>
From:   John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <5235269c-e3c7-efff-6083-a05a39699735@Oracle.com>
Date:   Thu, 19 Mar 2020 08:51:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584603551-23845-2-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 2:39 AM, Amit Daniel Kachhap wrote:
> Add documentation for KERNELPACMASK variable being added to vmcoreinfo.
> 
> It indicates the PAC bits mask information of signed kernel pointers if
> ARMv8.3-A Pointer Authentication feature is present.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Dave Anderson <anderson@redhat.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 007a6b8..5cc3ee6 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -393,6 +393,12 @@ KERNELOFFSET
>   The kernel randomization offset. Used to compute the page offset. If
>   KASLR is disabled, this value is zero.
>   
> +KERNELPACMASK
> +-------------
> +
> +Indicates the PAC bits mask information if Pointer Authentication is
> +enabled and address authentication feature is present.
> +
>   arm
>   ===
>   
> 
> 


Hi,

Does this require changes to the  makedumpfile or crash utilities ?



-- 
Thank You,
John
