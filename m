Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B749D2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRYWxxrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGHSqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:46:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:46:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068IacRb102685;
        Wed, 8 Jul 2020 18:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x7DLMluUC/7HOTF4xjCPNrXQSNDJXkzxrZDOZDjcHOU=;
 b=kRYWxxrIdowMMlIYOrpK8mwo6yvqOOKQZ/UCw4ZFoknBR/5aUvc0aSZicuB32KzW0Fvn
 I3hz7Izr1NPME4DCxijiFw1wqdQg9IyEKs6e7cAoD0OzTT79ZfCoFNE6Yd3Wzolw9xTi
 k4XY2G/4EGTgXiRwCyoSsY/sTfx7/3Vd5au4fRXymKaR1ntPrOfdqi926CdY++lDx7gX
 TddhRTygOJPu1+rtpQFiYvE3WS0AvRqZWJRliZnH8Dmh0ZxjY1BxCVSqjVMkkCNX8JTF
 iV2/M2AS6ZJT1SBygzDMlN1lF3RZ6kCi4n29nQ7sWbuewykLykahQf04E50OS9dZZKV1 Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 325k36876m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 18:46:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068IdBgo056916;
        Wed, 8 Jul 2020 18:46:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 325k3eb77v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 18:46:15 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 068IkA9q023673;
        Wed, 8 Jul 2020 18:46:13 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 11:46:10 -0700
Date:   Wed, 8 Jul 2020 14:46:38 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200708184638.xildzedf5f7z5a4x@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <20200619120704.GD12177@dhcp22.suse.cz>
 <20200622191739.4lekqrmjnzv2vwl2@ca-dmjordan1.us.oracle.com>
 <20200626124706.GZ1320@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626124706.GZ1320@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007080114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007080114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm back now)

On Fri, Jun 26, 2020 at 02:47:06PM +0200, Michal Hocko wrote:
> On Mon 22-06-20 15:17:39, Daniel Jordan wrote:
> > Hello Michal,
> > 
> > (I've been away and may be slow to respond for a little while)
> > 
> > On Fri, Jun 19, 2020 at 02:07:04PM +0200, Michal Hocko wrote:
> > > I believe that we should think about a future interface rather than
> > > trying to ducktape the blocksize anytime it causes problems. I would be
> > > even tempted to simply add a kernel command line option 
> > > memory_hotplug=disable,legacy,new_shiny
> > > 
> > > for disable it would simply drop all the sysfs crud and speed up boot
> > > for most users who simply do not care about memory hotplug. new_shiny
> > > would ideally provide an interface that would either export logically
> > > hotplugable memory ranges (e.g. DIMMs) or a query/action interface which
> > > accepts physical ranges as input. Having gazillions of sysfs files is
> > > simply unsustainable.
> > 
> > So in this idea, presumably the default would start off being legacy and then
> > later be changed to new_shiny?
> 
> Well it really depends. Going with disable as a default would suit most
> users much better because the vast majority simply doesn't use the
> functionality. On the other hand real users would regress unless they
> enable the option. Which is definitely not nice.

Agreed.

> Another and much less
> intrusive change would be creating sysfs interface on-demand. So until
> somebody actually tries to use the interface it won't exist. I haven't
> tried to explore how complex that would be. I am not really familiar
> with sysfs to be honest. But fundamentally nothing should prevent such a
> solution.

Hm, don't know sysfs internals either.  It seems possible that someone (or
something...) navigating around could trigger creation unintentionally--for
instance, by reading the symlinks to the memory block dirs in
/sys/devices/system/node/nodeN when trying to find another file to read in the
same place.

> Another option would be to create sysfs interface only if there is a
> hotplugable memory reported by the platform. But I am not sure we have a
> proper interface for that for all arches.

Systems that happen to have hotpluggable ranges but don't want the
overhead would still be stuck, though, it seems.


FWIW, the ideas for new_shiny sound promising.
