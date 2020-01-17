Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD65C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50292083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b4Mr7Ihr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAQSYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:24:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37856 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:24:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HIDFPF186359;
        Fri, 17 Jan 2020 18:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=V6jdRO8DhqcENdZcDjhcv4ayNKUxDX1LtbH6Da7E+34=;
 b=b4Mr7Ihr0XV9WdlwaWg34Hl0DTRKBlJWqerwaqJco3cCtBY7/FeDhy6hUVpcVsto44uK
 6yX0cRD7SwWdMna9wbQ5LCIEnTwRD6/QKS77/hPrJxhmebfvn+9HJq1yWHKqOTHAKC7l
 nC3zc6dRW+WJbKy7zpM2na1+VI0W39bNZ+L6OKzs/x05DecBuD9+unYJX2FK22B3wEpK
 ZEMWL2dfG1bxlwt0ynLP1mLqpziNw6UJose15+KzmDa80uS0XexrsIFD0dRfTESCaWHG
 4CXVQP+bunQ/dSk35jRca/uY6pQ+CsImV4gsmNOzyPeuyx9CIo6WyJfMxkC4jw/pgovm iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74st9er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:24:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HIAmtU141255;
        Fri, 17 Jan 2020 18:24:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xk24ff8bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:24:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00HIO6VS005836;
        Fri, 17 Jan 2020 18:24:06 GMT
Received: from [10.209.227.41] (/10.209.227.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 10:24:05 -0800
Subject: Re: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep
 expression to RCU lists
To:     Amol Grover <frextrite@gmail.com>, arm-soc <arm@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20200117133048.31708-1-frextrite@gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <5d77df7f-8693-0232-dbfe-0acfc37e040f@oracle.com>
Date:   Fri, 17 Jan 2020 10:24:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200117133048.31708-1-frextrite@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 5:30 AM, Amol Grover wrote:
> inst->handles is traversed using list_for_each_entry_rcu
> outside an RCU read-side critical section but under the protection
> of knav_dev_lock.
> 
> Hence, add corresponding lockdep expression to silence false-positive
> lockdep warnings, and harden RCU lists.
> 
> Add macro for the corresponding lockdep expression.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
> v2:
> - Remove rcu_read_lock_held() from lockdep expression since it is
>    implicitly checked for.
> 
Looks fine to me.

Hi Olof, Arnd,
Can you please pick this one and apply to your driver-soc branch ?
I already sent out pull request and hence the request.

regards,
Santosh
