Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8198C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5DE20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PMA9Tx9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgESBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:41:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgESBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:41:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04J1b4i9034179;
        Tue, 19 May 2020 01:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jDTS7w/xwyzUFP6HaV5XTmjtQADYCYpRZiMlLiAahBw=;
 b=PMA9Tx9cG94UVxWndPtEg8PAYpSxLH2k2EFCpgLWmeQRQWJNBun3LKBnoD/lhuOlLSDn
 h1iuRi1a8U+5tvzo0PXeCFicxkinng7aJSeQSQNVpEKyvSbH+yHxxSRTnauR25ufnZmG
 ZB40fiUhDLAqA1gCoA+enMnDWrJ4X9p1i+OG2A20rLwZdjO1wVb21UwAZxoV+r8TpI/w
 xz4CjEKlCMDKe4DR53ak8CjuJOhIDskOB7RYcPaS814tSvmYFKJcwix4XnGwb+vPhUXm
 ABUnrAKDcBevi9/xQJXIebe6dEQIP1dpNoB/9Qn+v2j8QIGmuTHv2nH1EXGeil1ViUN8 xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kr2a33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 01:41:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04J1cM7i056366;
        Tue, 19 May 2020 01:39:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 312t3wtqtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 01:39:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04J1d740026790;
        Tue, 19 May 2020 01:39:07 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 18:39:07 -0700
Date:   Mon, 18 May 2020 21:39:30 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap: Add percpu cluster_next to reduce lock contention
 on swap cache
Message-ID: <20200519013930.zofr6iv6p5rk7kxm@ca-dmjordan1.us.oracle.com>
References: <20200514070424.16017-1-ying.huang@intel.com>
 <20200515235140.xkznql332xmqvuf2@ca-dmjordan1.us.oracle.com>
 <87zha5kauc.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zha5kauc.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:37:15PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > On Thu, May 14, 2020 at 03:04:24PM +0800, Huang Ying wrote:
> >> And the pmbench score increases 15.9%.
> >
> > What metric is that, and how long did you run the benchmark for?
> 
> I run the benchmark for 1800s.  The metric comes from the following
> output of the pmbench,
> 
> [1] Benchmark done - took 1800.088 sec for 122910000 page access
> 
> That is, the throughput is 122910000 / 1800.088 = 68280.0 (accesses/s).
> Then we sum the values from the different processes.

Ok.

> > It's just a nit but SWP_SOLIDSTATE and 'if (si->cluster_info)' are two ways to
> > check the same thing and I'd stick with the one that's already there.
> 
> Yes.  In effect, (si->flags & SWP_SOLIDSTATE) and (si->cluster_info)
> always has same value at least for now.  But I don't think they are
> exactly same in semantics.  So I would rather to use their exact
> semantics.

Oh, but I thought the swap clusters were for scaling the locking for fast
devices, so that both checks have the same semantics now, and presumably would
in the future.

It's a minor point, I'm fine either way.

> The first swap slot is the swap partition header, you cand find the
> corresponding code in syscall swapon function, below comments "Read the

Aha, thanks.
