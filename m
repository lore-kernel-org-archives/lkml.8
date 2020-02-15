Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F50DC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 05:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062DB2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 05:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBOE6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 23:58:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgBOE6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 23:58:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E83F30E;
        Fri, 14 Feb 2020 20:58:50 -0800 (PST)
Received: from [10.119.49.110] (unknown [10.119.49.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F673F68F;
        Fri, 14 Feb 2020 20:58:47 -0800 (PST)
Subject: Re: [PATCH] mm: vmscan: replace open codings to NUMA_NO_NODE
To:     Yang Shi <yang.shi@linux.alibaba.com>, minchan@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8fd535cf-e754-bded-dc40-b9013900c78e@arm.com>
Date:   Sat, 15 Feb 2020 10:28:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/13/2020 10:01 AM, Yang Shi wrote:
> The commit 98fa15f34cb3 ("mm: replace all open encodings for
> NUMA_NO_NODE") did the replacement across the kernel tree, but we got
> some more in vmscan.c since then.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

