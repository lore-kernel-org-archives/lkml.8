Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E18AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A5520721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5z6gv2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbgE1OIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:08:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390658AbgE1OIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:08:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SE7nD5146260;
        Thu, 28 May 2020 14:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZpO6geCXEfKtvVwoUpLjfojIWR34s984zqeSiyiYS48=;
 b=h5z6gv2KVvsDaOPttrHkFk2r058+LiTdnzBMPdpxqnfYVHG7q3T+S36fH0ORBUpqinHC
 T+tM5ZqpJqf+unhhEiboocr4GyB8RcfXQE97+85u8z1EuMk2LWyHIFrhVtg+gIe3hpQ7
 QYFIfxiJJ9w37EHssl/vz0k85M/F2jAvZDRnSSi5u1007PoC9/PppOo8jYZ3K9bDFatW
 +UhXGDjaJUuX3bJScptDxT0+AG+yuK6XWk0wcrjETxBksdnDO+Uj1jldF4P+SjQk1Twa
 gkjvXe2Gbk1bXm1ybXip4fiRkgS3trZXs3aMpe07daXexjg+ZFEO8I3YgY2Ml1B0x+hp QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 318xbk58ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 14:08:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SE7d3c150848;
        Thu, 28 May 2020 14:07:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31a9ksjjga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 14:07:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SE7w0i007174;
        Thu, 28 May 2020 14:07:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 07:06:20 -0700
Date:   Thu, 28 May 2020 17:06:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjU=?= =?utf-8?Q?=5D?= workqueue:
 Remove unnecessary kfree() call in rcu_free_wq()
Message-ID: <20200528140613.GK30374@kadam>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
 <20200528122545.GP22511@kadam>
 <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=2 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:27:03PM +0800, Lai Jiangshan wrote:
> On Thu, May 28, 2020 at 8:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, May 28, 2020 at 08:08:06PM +0800, Lai Jiangshan wrote:
> > > On Thu, May 28, 2020 at 5:57 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > Guys, the patch is wrong.  The kfree is harmless when this is called
> > > > from destroy_workqueue() and required when it's called from
> > > > pwq_unbound_release_workfn().  Lai Jiangshan already explained this
> > > > already.  Why are we still discussing this?
> > > >
> > >
> > > I'm also confused why they have been debating about the changelog
> > > after the patch was queued. My statement was about "the patch is
> > > a correct cleanup, but the changelog is totally misleading".
> > >
> > > destroy_workqueue(percpu_wq) -> rcu_free_wq()
> > > or
> > > destroy_workqueue(unbound_wq) -> put_pwq() ->
> > > pwq_unbound_release_workfn() -> rcu_free_wq()
> > >
> > > So the patch is correct to me. Only can destroy_workqueue()
> > > lead to rcu_free_wq().
> >
> > It looks like there are lots of paths which call put_pwq() and
> > put_pwq_unlocked().
> >
> >   1168  static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
> >   1169  {
> >   1170          /* uncolored work items don't participate in flushing or nr_active */
> >   1171          if (color == WORK_NO_COLOR)
> >   1172                  goto out_put;
> >   1173
> >
> > We don't take an extra reference in this function.
> >
> >   1200  out_put:
> >   1201          put_pwq(pwq);
> >   1202  }
> >
> > I don't know this code well, so I will defer to your expertise if you
> > say it is correct.
> 
> wq owns the ultimate or permanent references to itself by
> owning references to wq->numa_pwq_tbl[node], wq->dfl_pwq.
> The pwq's references keep the pwq in wq->pwqs.
> 
> Only destroy_workqueue() can release these ultimate references
> and then (after maybe a period of time) deplete the wq->pwqs
> finally and then free itself in rcu callback.
> 
> Actually, in short, we don't need the care about the above
> detail. The responsibility to free rescuer is on
> destroy_workqueue(), and since it does the free early,
> it doesn't need to do it again later.
> 
> e2dca7adff8f moved the free of rescuer into rcu callback,
> and I didn't check all the changes between then and now.
> But at least now, the rescuer is not accessed in rcu mananer,
> so we don't need to free it in rcu mananer.
> 

Ah...  Thanks for the explanation!

regards,
dan carpenter

