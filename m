Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7224820B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s1cPznPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEFPke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:40:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgEFPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:40:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Fbepv058881;
        Wed, 6 May 2020 15:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=u9YRqhjsd5q90YS3XgAURj//X9gBQ/Yx8tv2Q2a0T94=;
 b=s1cPznPoJAQuids8kpAzAPQOcoloJWuFkDIu4ui8VWolcvJjpJ7S2VX/Ib8KW2QMQRZM
 9I5hvxrwtwrVpGyNt/PTjTg5iJ0myvpbc1kXkT/vI5aDy31QqcfrmibxYPM9kXjR4DgD
 rLZSM894fa744Bw0EtoxFd46sqp9hIbhx+4VoZ8EvVWJ3zNG4KwX05xF55VruAN3Cy9m
 UXEkfOdYDOTjYR2mcH5CB1sYA62TXOuiWGUvfrfc2Uev/bBgeWgTvT3mV+N7ayWjWl4V
 UvhxpMlhedsizNXdoyaI5ep93d5IeVSNJuXlndYC9s139GyZd+TOX84D4X1mmz24Aj4M NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09rb5vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:39:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FbTTK156529;
        Wed, 6 May 2020 15:39:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnjtw2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:39:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046FdgZT013634;
        Wed, 6 May 2020 15:39:42 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:39:42 -0700
Subject: Re: [patch V4 part 1 15/36] kprobes: Lock kprobe_mutex while showing
 kprobe_blacklist
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
        Will Deacon <will@kernel.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.571125195@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <6cc6b979-c5e5-6898-5879-ba5dac413e61@oracle.com>
Date:   Wed, 6 May 2020 17:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.571125195@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Lock kprobe_mutex while showing kprobe_blacklist to prevent updating the
> kprobe_blacklist.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/158523417665.24735.10253198878535635600.stgit@devnote2
> 
> ---
>   kernel/kprobes.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2426,6 +2426,7 @@ static const struct file_operations debu
>   /* kprobes/blacklist -- shows which functions can not be probed */
>   static void *kprobe_blacklist_seq_start(struct seq_file *m, loff_t *pos)
>   {
> +	mutex_lock(&kprobe_mutex);
>   	return seq_list_start(&kprobe_blacklist, *pos);
>   }
>   
> @@ -2452,10 +2453,15 @@ static int kprobe_blacklist_seq_show(str
>   	return 0;
>   }
>   
> +static void kprobe_blacklist_seq_stop(struct seq_file *f, void *v)
> +{
> +	mutex_unlock(&kprobe_mutex);
> +}
> +
>   static const struct seq_operations kprobe_blacklist_seq_ops = {
>   	.start = kprobe_blacklist_seq_start,
>   	.next  = kprobe_blacklist_seq_next,
> -	.stop  = kprobe_seq_stop,	/* Reuse void function */
> +	.stop  = kprobe_blacklist_seq_stop,
>   	.show  = kprobe_blacklist_seq_show,
>   };
>   
> 
