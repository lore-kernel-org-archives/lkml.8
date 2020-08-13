Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BE02078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMQrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:47:31 -0400
Received: from gentwo.org ([3.19.106.255]:35912 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMQra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:47:30 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 6979B3F1CD; Thu, 13 Aug 2020 16:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 675B53F1CC;
        Thu, 13 Aug 2020 16:47:30 +0000 (UTC)
Date:   Thu, 13 Aug 2020 16:47:30 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Abel Wu <wuyun.wu@huawei.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: branch optimization in free slowpath
In-Reply-To: <20200813101812.1617-1-wuyun.wu@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2008131647040.112773@www.lameter.com>
References: <20200813101812.1617-1-wuyun.wu@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020, wuyun.wu@huawei.com wrote:

> The two conditions are mutually exclusive and gcc compiler will
> optimise this into if-else-like pattern. Given that the majority
> of free_slowpath is free_frozen, let's provide some hint to the
> compilers.

Acked-by: Christoph Lameter <cl@linux.com>
