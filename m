Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59CAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5F206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WnPmI+js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbgDAQJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:09:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgDAQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:09:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031FvVZF104391;
        Wed, 1 Apr 2020 16:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uokiotoiiXWiPxukwvDObNN9ROwuv4dXFLRcVdokIVo=;
 b=WnPmI+jsoel6+/wdc22Os+HQPbmpAMD2BOghBRdAyQpo+hcvM57fs1mI5In2nCRGwpLC
 WF0IL50sKla9Ue17E26DW3LFtWaxRM+AwIhDkbVovtUa8yj1csdF10GyjroMzbaENxFP
 S5Hk+6n8J5XASyjd5ulhURBTYcdBJrW05dGNCWUWSCd+8y6psLpk/EUa50PQ4yijVb+m
 jM1VIqSvgj9dPhty1SRAPWEr8Fx1VSmn+LqelKIeFimO+KuZAH+EpXr/OE6kBLYWTtkc
 sUD5gzU3AkH2adOdexpF8uhx57MWnXZ4wSg2GGC0vu6inGArMPCFdds+RQ416aF22Cbx cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cev6dhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:09:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031G72EK180154;
        Wed, 1 Apr 2020 16:09:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2gw0vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:09:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031G9A9I001656;
        Wed, 1 Apr 2020 16:09:10 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 09:09:10 -0700
Date:   Wed, 1 Apr 2020 12:09:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401160048.GU22681@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > On 01.04.20 17:42, Michal Hocko wrote:
> > > I am sorry but I have completely missed this patch.
> > > 
> > > On Wed 11-03-20 20:38:48, Shile Zhang wrote:
> > >> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
> > >> initialise the deferred pages with local interrupts disabled. It is
> > >> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> > >> initializing deferred pages").
> > >>
> > >> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
> > >> the boot CPU, which could caused the tick timer long time stall, system
> > >> jiffies not be updated in time.
> > >>
> > >> The dmesg shown that:
> > >>
> > >>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
> > >>
> > >> Obviously, 1ms is unreasonable.
> > >>
> > >> Now, fix it by restore in the pending interrupts for every 32*1204 pages
> > >> (128MB) initialized, give the chance to update the systemd jiffies.
> > >> The reasonable demsg shown likes:
> > >>
> > >>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> > >>
> > >> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
> > > 
> > > I dislike this solution TBH. It effectivelly conserves the current code
> > > and just works around the problem. Why do we hold the IRQ lock here in
> > > the first place? This is an early init code and a very limited code is
> > > running at this stage. Certainly nothing memory hotplug related which
> > > should be the only path really interested in the resize lock AFAIR.
> > 
> > Yeah, I don't think ACPI and friends are up yet.
> 
> Just to save somebody time to check. The deferred initialization blocks
> the further boot until all workders are done - see page_alloc_init_late
> (kernel_init path).

Ha, I just finished following all the hotplug paths to check this out, and as
you all know there are a *lot* :-) Well at least we're in agreement.

> > > This needs a double checking but I strongly believe that the lock can be
> > > simply dropped in this path.

This is what my fix does, it limits the time the resize lock is held.
