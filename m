Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C31C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A2120748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P4/pJzfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgARSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:07:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39730 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:07:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00II3IWl131777;
        Sat, 18 Jan 2020 18:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=RUMWuHIuYnvZA0LwP+zxBuE0/DCOWdUGFyUQQD5rKQA=;
 b=P4/pJzfhEdJDU7JJZOE10GaVmE6eLwEi8LK1DG8FjjJVxysF8jrUWnQ7L1faMJnXpQYu
 QdVKcKqZdYVG1+zt/xo1sv2OYXwNzwcR/c605UNRaoD8VCq5rrHE4K33hvgpKE84o5yT
 x1IefSONdkDUiREXVYEvQsRMXYawt7sxXDTkbgUEsJ58fdjlg4vH7XgVuzogbJfOsXuf
 w7bEJ3wauliuLHHX7JSobJ21oGHcGFGPmZBBEyJEZex/SXv528ptBIiAesi7F6/rHnlX
 LiYEX/ZkFBL/DvEuaHTmY5azWGkIXJwRw8BbhPC12Vr4lE8u2mWoAjlIQwcPV978OtwZ FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseu1qv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 18:06:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00II3u0D024002;
        Sat, 18 Jan 2020 18:06:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xksc41da6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 18:06:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00II6W91026232;
        Sat, 18 Jan 2020 18:06:32 GMT
Received: from [192.168.86.20] (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Jan 2020 10:06:32 -0800
Subject: Re: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep
 expression to RCU lists
To:     Amol Grover <frextrite@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20200118042433.4968-1-frextrite@gmail.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <c58b6751-7502-fad4-e087-9f0bb744ebb9@oracle.com>
Date:   Sat, 18 Jan 2020 10:06:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200118042433.4968-1-frextrite@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001180149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001180149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 8:24 PM, Amol Grover wrote:
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
Thanks.
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

>   drivers/soc/ti/knav_qmss_queue.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 1ccc9064e1eb..37f3db6c041c 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -25,6 +25,8 @@
>   
>   static struct knav_device *kdev;
>   static DEFINE_MUTEX(knav_dev_lock);
> +#define knav_dev_lock_held() \
> +	lockdep_is_held(&knav_dev_lock)
>   
>   /* Queue manager register indices in DTS */
>   #define KNAV_QUEUE_PEEK_REG_INDEX	0
> @@ -52,8 +54,9 @@ static DEFINE_MUTEX(knav_dev_lock);
>   #define knav_queue_idx_to_inst(kdev, idx)			\
>   	(kdev->instances + (idx << kdev->inst_shift))
>   
> -#define for_each_handle_rcu(qh, inst)			\
> -	list_for_each_entry_rcu(qh, &inst->handles, list)
> +#define for_each_handle_rcu(qh, inst)				\
> +	list_for_each_entry_rcu(qh, &inst->handles, list,	\
> +				knav_dev_lock_held())
>   
>   #define for_each_instance(idx, inst, kdev)		\
>   	for (idx = 0, inst = kdev->instances;		\
> 
