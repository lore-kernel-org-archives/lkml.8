Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1923B20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="So6xgNGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgEFP4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:56:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgEFP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:56:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FreEV088070;
        Wed, 6 May 2020 15:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZjrWcRXhjCPQfBaBj9IYXL9NvrBVUY2eff6UWTiOghc=;
 b=So6xgNGpGBUqLKIjTkmiaX64QmrEtooajOhF5JpdghVHO6DJgcmZwNcIk1Bh74u0RYKA
 gk6RdjWQ1fuhq6dshI6vk8KrY14Ueg2oWSr3uroJLZG4Aj/lh/aQIIh7Faoml7jUsJ7D
 NevQdDdb38e9K3+84hebMHtbiZup/RBo1gXg7YbKyoU/cOp+yNkE2GjgZ8YSAzSeaNND
 473TNm14c+mdkIUrduaMYwUMeCjm4WzFCs1nkYTkmSCsSQfZiZFhpwDSUmbWkZpq85MY
 CuF1pTNkSm7lU7y4sRVdeQY/YLb5f30lSToLYp4wfYRur8UGOGZ4TIRLi5akrHZxZv+H VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09rb956-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:55:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Fpl13016852;
        Wed, 6 May 2020 15:55:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r84uhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:55:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046FtGvj008638;
        Wed, 6 May 2020 15:55:16 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:55:16 -0700
Subject: Re: [patch V4 part 1 17/36] kprobes: Support NOKPROBE_SYMBOL() in
 modules
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
 <20200505134059.771170126@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <09a1e24a-8d7a-130e-75be-629d1f588a82@oracle.com>
Date:   Wed, 6 May 2020 17:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.771170126@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Support NOKPROBE_SYMBOL() in modules. NOKPROBE_SYMBOL() records only symbol
> address in "_kprobe_blacklist" section in the module.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/158523419989.24735.6665260504057165207.stgit@devnote2
> 
> ---
>   include/linux/module.h |    2 ++
>   kernel/kprobes.c       |   17 +++++++++++++++++
>   kernel/module.c        |    3 +++
>   3 files changed, 22 insertions(+)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 369c354f9207..1192097c9a69 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -492,6 +492,8 @@ struct module {
>   #ifdef CONFIG_KPROBES
>   	void *kprobes_text_start;
>   	unsigned int kprobes_text_size;
> +	unsigned long *kprobe_blacklist;
> +	unsigned int num_kprobe_blacklist;
>   #endif
>   
>   #ifdef CONFIG_LIVEPATCH
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index b7549992b9bd..9eb5acf0a9f3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2192,6 +2192,11 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
>   	}
>   }
>   
> +static void kprobe_remove_ksym_blacklist(unsigned long entry)
> +{
> +	kprobe_remove_area_blacklist(entry, entry + 1);
> +}
> +
>   int __init __weak arch_populate_kprobe_blacklist(void)
>   {
>   	return 0;
> @@ -2231,6 +2236,12 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
>   static void add_module_kprobe_blacklist(struct module *mod)
>   {
>   	unsigned long start, end;
> +	int i;
> +
> +	if (mod->kprobe_blacklist) {
> +		for (i = 0; i < mod->num_kprobe_blacklist; i++)
> +			kprobe_add_ksym_blacklist(mod->kprobe_blacklist[i]);
> +	}
>   
>   	start = (unsigned long)mod->kprobes_text_start;
>   	if (start) {
> @@ -2242,6 +2253,12 @@ static void add_module_kprobe_blacklist(struct module *mod)
>   static void remove_module_kprobe_blacklist(struct module *mod)
>   {
>   	unsigned long start, end;
> +	int i;
> +
> +	if (mod->kprobe_blacklist) {
> +		for (i = 0; i < mod->num_kprobe_blacklist; i++)
> +			kprobe_remove_ksym_blacklist(mod->kprobe_blacklist[i]);
> +	}
>   
>   	start = (unsigned long)mod->kprobes_text_start;
>   	if (start) {
> diff --git a/kernel/module.c b/kernel/module.c
> index f7712a923d63..7be011dacd8a 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3197,6 +3197,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>   #ifdef CONFIG_KPROBES
>   	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
>   						&mod->kprobes_text_size);
> +	mod->kprobe_blacklist = section_objs(info, "_kprobe_blacklist",
> +						sizeof(unsigned long),
> +						&mod->num_kprobe_blacklist);
>   #endif
>   	mod->extable = section_objs(info, "__ex_table",
>   				    sizeof(*mod->extable), &mod->num_exentries);
> 
> 
