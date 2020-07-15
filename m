Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8136920658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WmDHlBA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGOQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:04:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGOQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:01:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlEKq035568;
        Wed, 15 Jul 2020 16:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6UwNJBozS5Fm/gYrc3f/+HHTTdKUvXgAqHENd6eVNP4=;
 b=WmDHlBA9+S02t3dRwtZ9VfPlAbwlySN6lYtGSCqMaVxjC4ZCodpZN9hIJrpxNxUbEzqK
 1PDKHAl5TxOEEcJpVMejURtJ7lSn1/WSdnrYMNidGVy0bgVLqsZVUUilIN1fch84/cKS
 r6IfF9ZZ/YI19gwQCcGxnZyAOBj1sLEgOEHrEmdgfv9t59iy8omhIxSs1QmdFQfXxzPb
 95BmFO4oADnCGH9hI8/jhKz4UUurC+ngFzTEpKsmp3YdKkmpqza7w/eKyhxcAIQDAxuM
 hX5DIEk0IzHnNRADuJaDWM66IHSUrJoCfvWW81VZhOuvGRLRphd+gXneAZAeYqVc8qES og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3275cmc9y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:00:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlp2C114397;
        Wed, 15 Jul 2020 15:58:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32a4cqsrhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 15:58:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FFwjbB005043;
        Wed, 15 Jul 2020 15:58:45 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 08:58:45 -0700
Date:   Wed, 15 Jul 2020 11:59:13 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/mm: use max memory block size on bare metal
Message-ID: <20200715155913.plxsu7h55xif2jic@ca-dmjordan1.us.oracle.com>
References: <20200714205450.945834-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714205450.945834-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 04:54:50PM -0400, Daniel Jordan wrote:
> Some of our servers spend significant time at kernel boot initializing
> memory block sysfs directories and then creating symlinks between them
> and the corresponding nodes.  The slowness happens because the machines
> get stuck with the smallest supported memory block size on x86 (128M),
> which results in 16,288 directories to cover the 2T of installed RAM.
> The search for each memory block is noticeable even with
> commit 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in
> xarray to accelerate lookup").
> 
> Commit 078eb6aa50dc ("x86/mm/memory_hotplug: determine block size based
> on the end of boot memory") chooses the block size based on alignment
> with memory end.  That addresses hotplug failures in qemu guests, but
> for bare metal systems whose memory end isn't aligned to even the
> smallest size, it leaves them at 128M.
> 
> Make kernels that aren't running on a hypervisor use the largest
> supported size (2G) to minimize overhead on big machines.  Kernel boot
> goes 7% faster on the aforementioned servers, shaving off half a second.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>

Darn.  David, I forgot to add your ack from v2.  My assumption is that it still
stands after the minor change in this version, but please do correct me if I'm
wrong.
