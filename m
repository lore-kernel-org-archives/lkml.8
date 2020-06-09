Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E6C2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNfXRCcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgFIXDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:03:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:03:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059N33L0169324;
        Tue, 9 Jun 2020 23:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MGVZvDqcuMlZe++v/Ety2bhMoDiErGWUbymYlqHLHGQ=;
 b=SNfXRCcbGGUvlE2cFIKylsz7QSj+rJf/ofo8qKfbozqhBtkypKxAnGNGb31nfwvLyW77
 q9WuPxRtn/WJViDi/BtkMXNPZYzOJCpsEuijE890as/y2RZBTuWdi/rmLFQiMu7NAGbF
 RH3Z0V9I5T5i4U8jSaSsvsGmE/hHFzvvEcNoPdsYKbrE2YpuShh76utfBxJ6EN/E9EaH
 n5kEvQI+1KzR44Nu1v4PlXTC+hDOseR/2y1zZIA+Mtk3VQmezFKhgm7sI4eegLiGvX4Y
 JxEDmc+/yEjZSKOA5EK5nwSV8feTiUnIdM3E5cwe9zmCbjyJORwEByljL57AGHVgrihH Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepnsbgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 23:03:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059MrsGX027095;
        Tue, 9 Jun 2020 23:03:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31gmqp901a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 23:03:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059N3Lru029897;
        Tue, 9 Jun 2020 23:03:21 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 16:03:20 -0700
Date:   Tue, 9 Jun 2020 19:03:45 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200609230345.bq6jstgpvu63vbwo@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 06:54:51PM -0400, Daniel Jordan wrote:
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
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Sistare <steven.sistare@oracle.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---

Forgot the v1 changes:

 - Thanks to David for the idea to make this conditional based on
   virtualization.
 - Update performance numbers to account for 4fb6eabf1037 (David)
