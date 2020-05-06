Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F27206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTuf+Pgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgEFNIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:08:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgEFNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:08:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046D3grX167694;
        Wed, 6 May 2020 13:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cRGaopetToIvchIxwpM6MmjiSLvcrPB1Z6iY0n2hfSI=;
 b=NTuf+PgnbpSqZbO3enoTk9wvr/bBWAeOs6SQDan0fGKav5WnrQwT2/3VfM5cWZsQ95BK
 ZKrJl/B+PQRY/7Co19LfDvuLu28ByqUIvRBhF0dZ6xq5M1/rUGDrfHkhy0cXIrHMRVW6
 0lLf+B2MKNcaSwAtWD/ARBLgP0ZUG7cd/+UaQeJ0ocpql/ShPoiuOyHZcukGCtlmIaq9
 IRweQPRq8AZx3W0xQ+KiBNuQvSnqZzZPVKNRFbw+vsws+HE7xTM6I+ZynCi6GdJgc9HV
 ssjKGPbxCP3KdpjGXUrwpFTPTTxHwmpRlvEqMykgZFoMZBuU/B6/YO8Akj9KjVwPTV1+ bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09ra8b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:07:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046D6jLm085692;
        Wed, 6 May 2020 13:07:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7mn3xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:07:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046D7iIL001148;
        Wed, 6 May 2020 13:07:44 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 06:07:43 -0700
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.560059744@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <5eade6a3-06fc-d156-29cc-731be55eff3d@oracle.com>
Date:   Wed, 6 May 2020 15:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.560059744@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> Make sure task_work runs before any kind of userspace -- very much
> including signals -- is invoked.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -156,16 +156,16 @@ static void exit_to_usermode_loop(struct
>   		if (cached_flags & _TIF_PATCH_PENDING)
>   			klp_update_patch_state(current);
>   
> -		/* deal with pending signal delivery */
> -		if (cached_flags & _TIF_SIGPENDING)
> -			do_signal(regs);
> -
>   		if (cached_flags & _TIF_NOTIFY_RESUME) {
>   			clear_thread_flag(TIF_NOTIFY_RESUME);
>   			tracehook_notify_resume(regs);
>   			rseq_handle_notify_resume(NULL, regs);
>   		}
>   
> +		/* deal with pending signal delivery */
> +		if (cached_flags & _TIF_SIGPENDING)
> +			do_signal(regs);
> +
>   		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
>   			fire_user_return_notifiers();
>   
> 
