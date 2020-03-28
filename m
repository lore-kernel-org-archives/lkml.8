Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3520C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EA9206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tE2x0AnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1ARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:17:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52418 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgC1ARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:17:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S0ECts067141;
        Sat, 28 Mar 2020 00:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TkczSJTHT6DjomI7Gw7mr8sP9DJiwrHZ4XBhfGDHUog=;
 b=tE2x0AnFwkzquTjPYPJtSSUOTIUr5cRQKsQ6brqtxlZahHmQiWQDNndbDOlVL4RCJPHr
 rDFSGgqeERza5Cgh8aWadUkNKf0JpDP6ImP12/AkMx9+Z2AXtjfmhpDOVKYrdAtgavij
 fyFSq3maRkdaitDBud33m1ofY85n+ll+p0YVa4XjNssXfzj8aaRwkrnP6oAi8vBJV5Gw
 FfVQMyPnuyHcUUZPqBgFH0/9DCcmVbOgcKiav7bi8+CmhhsUY5ZNiL334z2u2klXxnD6
 pbpcddjahDptASZ0UAYhMZaiTayoE65khSpAxJdCnOsE1n3x+6PgvmyxsQUlQ2WvFw7l LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 301m49hyy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 00:17:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S0BmQ3110319;
        Sat, 28 Mar 2020 00:17:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3003gpy4q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 00:17:19 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02S0HGS6032130;
        Sat, 28 Mar 2020 00:17:17 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 17:17:16 -0700
Date:   Fri, 27 Mar 2020 20:17:36 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200328001736.pxcnabxvrr3d6bty@ca-dmjordan1.us.oracle.com>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com>
 <20200326185822.6n56yl2llvdranur@ca-dmjordan1.us.oracle.com>
 <CA+CK2bDQ6qPfLsx=81L3_DVzvoCjkBRKvcw0Tz4Gd=Fd6pgQ3A@mail.gmail.com>
 <427ce795-0274-56e5-16e4-7be00c7145f7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427ce795-0274-56e5-16e4-7be00c7145f7@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003270199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:39:18PM +0800, Shile Zhang wrote:
> On 2020/3/27 03:36, Pavel Tatashin wrote:
> > I agree with Daniel, we should look into approach where
> > pgdat_resize_lock is taken only for the duration of updating tracking
> > values such as pgdat->first_deferred_pfn (perhaps we would need to add
> > another tracker that would show chunks that are currently being worked
> > on).
> > 
> > The vast duration of struct page initialization process should happen
> > outside of this lock, and only be taken when we update globally seen
> > data structures: lists, tracking variables. This way we can solve
> > several problems: 1. allow interrupt threads to grow zones if
> > required. 2. keep jiffies happy. 3. allow future scaling when we will
> > add inner node threads to initialize struct pages (i.e. ktasks from
> > Daniel).
> 
> It make sense, looking forward to the inner node parallel init.
> 
> @Daniel
> Is there schedule about ktasks?

Yep, and it's now padata multithreading instead of ktask since we already have
'task' in the kernel.

Current plan is to start with users in the system context, that is those that
don't require userland resource controls such as cgroup.  So I'll post a new
version of this timestamp fix pretty soon and then likely post a series that
multithreads page init.

Future work is tentatively doing other system users, remote charging for the
CPU controller, and then users that can be accounted with cgroup etc.
