Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE8CC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5BF20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l7OF3bT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCWVzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:55:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57496 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:55:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NLsiWh140449;
        Mon, 23 Mar 2020 21:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YvIAy0wzv2+tc9aPVF5RtWgeBJRlBEGtNVz2L2/Z/U8=;
 b=l7OF3bT9wxBgDsTgSEekeq4UQlQDi7thEafWDog7Xg9UJ3oVb7I7Ib4bQY6hKtYd2jPT
 Qkq6aUIOZghWwTx/iJxA2fKIk1W9aNAMETSQeyJ8H/o3Fb7WYIXf7TWN4T4r27RqZM9L
 XeEm7hJTbuSkRvvXLQPZQFAjqFj4+CqgMWJTrvGSKl/bDMUuDON7FGlInCthfuiXXUQl
 B3Dd19mLelId9CiKRdOpiU/dmLvos34llylNSi0zkYW1cS8rpbm5YIhGT6eBfj24HMAd
 P10t8KGTYxdbzY6+vkVoOE39+L601LkkpDAqSrnnHoWhUdOklq7VxIhKBBf56dvUevsC Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yx8abx414-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 21:55:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NLpo5a182537;
        Mon, 23 Mar 2020 21:55:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yxw91gjpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 21:55:43 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NLtgBB017985;
        Mon, 23 Mar 2020 21:55:42 GMT
Received: from [10.39.222.158] (/10.39.222.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 14:55:42 -0700
Subject: Re: [Xen-devel] [PATCH v4 1/2] xen: Use evtchn_type_t as a type for
 event channels
To:     Yan Yankovskyi <yyankovskyi@gmail.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200323152343.GA28422@kbp1-lhp-F74019>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <06458b85-fb66-faac-e75a-1ccefa848cb0@oracle.com>
Date:   Mon, 23 Mar 2020 17:55:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323152343.GA28422@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/20 12:15 PM, Yan Yankovskyi wrote:
> Make event channel functions pass event channel port using
> evtchn_port_t type. It eliminates signed <-> unsigned conversion.
>
> Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>


If the difference is only the whitespace fix then

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

and I am sorry, I should have explicitly said that you don't need to resend.


