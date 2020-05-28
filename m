Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D7B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xx3rm++D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbgE1M2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:28:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389675AbgE1M15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:27:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SCHg4j105579;
        Thu, 28 May 2020 12:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qj7TwkNy6GSpmtn4DBIaqHpZf2eLD34oVXAXPSaBBmQ=;
 b=Xx3rm++DGiMaFVjj14hvg1DHV0Gv3osjoM8m7skZUmFXKMyHg/WIoEyoMpsFRwxGUCP6
 OOCrXZpU4UyDdeEUAUF1BoD26XWnJ6IAUxAfdefJSTk25VOEHvkzj8OP01Y7oSu/CFsy
 FTyGRqKdc5lJUkLo8KFwe+4y6k2G5qf/I8Z6gro7WH3lBF3Sl+WYscQ5IrWeXX9HR+b3
 /jjcqQ4yHtPahf0szuM3UVkhJwNxG1N05gi/34nHX/fR0y6BPfyEXLd/m4BTlQpU5OPu
 SIUxIoqZcZv5/X54tNS3vEdtRKdWB9eVFcbpF7EOFx8Zo0VgAxvozxaXYIUd3XW2jQsR Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 316u8r4pat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 12:27:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SCHcF4115358;
        Thu, 28 May 2020 12:25:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 317j5v5eef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 12:25:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SCPqLF025280;
        Thu, 28 May 2020 12:25:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 05:25:51 -0700
Date:   Thu, 28 May 2020 15:25:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjU=?= =?utf-8?Q?=5D?= workqueue:
 Remove unnecessary kfree() call in rcu_free_wq()
Message-ID: <20200528122545.GP22511@kadam>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=2
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 08:08:06PM +0800, Lai Jiangshan wrote:
> On Thu, May 28, 2020 at 5:57 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Guys, the patch is wrong.  The kfree is harmless when this is called
> > from destroy_workqueue() and required when it's called from
> > pwq_unbound_release_workfn().  Lai Jiangshan already explained this
> > already.  Why are we still discussing this?
> >
> 
> I'm also confused why they have been debating about the changelog
> after the patch was queued. My statement was about "the patch is
> a correct cleanup, but the changelog is totally misleading".
> 
> destroy_workqueue(percpu_wq) -> rcu_free_wq()
> or
> destroy_workqueue(unbound_wq) -> put_pwq() ->
> pwq_unbound_release_workfn() -> rcu_free_wq()
> 
> So the patch is correct to me. Only can destroy_workqueue()
> lead to rcu_free_wq().

It looks like there are lots of paths which call put_pwq() and
put_pwq_unlocked().

  1168  static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
  1169  {
  1170          /* uncolored work items don't participate in flushing or nr_active */
  1171          if (color == WORK_NO_COLOR)
  1172                  goto out_put;
  1173  

We don't take an extra reference in this function.

  1200  out_put:
  1201          put_pwq(pwq);
  1202  }

I don't know this code well, so I will defer to your expertise if you
say it is correct.

> 
> Still, the kfree(NULL) is harmless. But it is cleaner
> to have the patch. But the changelog is wrong, even after
> the lengthened debating, and English is not my mother tongue,
> so I just looked on.

We have tried to tell Markus not to advise people about commit messages
but he doesn't listen.  He has discouraged some contributors.  :/

regards,
dan carpenter
