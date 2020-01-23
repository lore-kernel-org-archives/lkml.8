Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75057C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E022207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BL3EE5wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgAWWhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:37:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWWhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:37:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NMXWTL152728;
        Thu, 23 Jan 2020 22:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=twSlqPMGsFaKsPqtLDOGPEfCE5WJVeourO0erbXFb+o=;
 b=BL3EE5wARB+Fxqxyn9Zej/CHGYh0zDIEfdwHdAa/3ow/7jSc2HfshkS1roplNG7oJ5On
 ZhXS/xSGWyqsvBe/o4rm0n3ibZdMyCBEx6BN9FQRaN0jRrX8xAatT8dDXEs96hV744tT
 k/9BNNmKnQEI4dv78IE1ndrfls69gy71kWF5WpS/Wja/mtQZBHkXni2Pm6gOUIy8prH8
 et4wp7xvqhjBXbx98pr2eUV+sIFW/jxez8QKFxZPTkM6hg51scAj2Z5qVrRjrprxhIhF
 QiNGVNWQ2proAwAV1+c11qCj8zBR5Ubgc2Q5+yL2xlzbnnz+PFVOk9ut+A3XrB52gB23 AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseuwj60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 22:37:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NMY4px067679;
        Thu, 23 Jan 2020 22:37:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xppq9rmt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 22:37:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NMbTTo011428;
        Thu, 23 Jan 2020 22:37:29 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 14:37:29 -0800
Date:   Thu, 23 Jan 2020 17:37:43 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC 1/4] workqueue: fix selecting cpu for queuing work
Message-ID: <20200123223743.pfcibulfsugpqbsc@ca-dmjordan1.us.oracle.com>
References: <20191211104601.16468-1-hdanton@sina.com>
 <20191211105919.10652-1-hdanton@sina.com>
 <20191211230735.r5xpmgwfjjkzxwaf@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211230735.r5xpmgwfjjkzxwaf@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:07:35PM -0500, Daniel Jordan wrote:
> [please cc maintainers]
> 
> On Wed, Dec 11, 2019 at 06:59:19PM +0800, Hillf Danton wrote:
> > Round robin is needed only for unbound workqueue and wq_unbound_cpumask
> > has nothing to do with standard workqueues, so we have to select cpu in
> > case of WORK_CPU_UNBOUND also with workqueue type taken into account.
> 
> Good catch.  I'd include something like this in the changelog.
> 
>   Otherwise, work queued on a bound workqueue with WORK_CPU_UNBOUND might
>   not prefer the local CPU if wq_unbound_cpumask is non-empty and doesn't
>   include that CPU.
> 
> With that you can add
> 
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Any plans to repost this patch, Hillf?  If not, I can do it while retaining
your authorship.

Adding back the context, which I forgot to keep when adding the maintainers.

> > Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
> > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > ---
> > 
> > --- a/kernel/workqueue.c
> > +++ c/kernel/workqueue.c
> > @@ -1409,16 +1409,19 @@ static void __queue_work(int cpu, struct
> >  	if (unlikely(wq->flags & __WQ_DRAINING) &&
> >  	    WARN_ON_ONCE(!is_chained_work(wq)))
> >  		return;
> > +
> >  	rcu_read_lock();
> >  retry:
> > -	if (req_cpu == WORK_CPU_UNBOUND)
> > -		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> > -
> >  	/* pwq which will be used unless @work is executing elsewhere */
> > -	if (!(wq->flags & WQ_UNBOUND))
> > -		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
> > -	else
> > +	if (wq->flags & WQ_UNBOUND) {
> > +		if (req_cpu == WORK_CPU_UNBOUND)
> > +			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> >  		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
> > +	} else {
> > +		if (req_cpu == WORK_CPU_UNBOUND)
> > +			cpu = raw_smp_processor_id();
> > +		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
> > +	}
> >  
> >  	/*
> >  	 * If @work was previously on a different pool, it might still be
> > 
> > 
