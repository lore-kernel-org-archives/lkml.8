Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC733C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A6E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgB0IBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:01:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgB0IBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D20E1AD05;
        Thu, 27 Feb 2020 08:01:18 +0000 (UTC)
Subject: Re: [PATCH V2 3/3] mm/vma: Make is_vma_temporary_stack() available
 for general use
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
 <1582782965-3274-4-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3770de46-c833-c956-91bd-71cacd464f10@suse.cz>
Date:   Thu, 27 Feb 2020 09:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582782965-3274-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 6:56 AM, Anshuman Khandual wrote:
> Currently the declaration and definition for is_vma_temporary_stack() are
> scattered. Lets make is_vma_temporary_stack() helper available for general
> use and also drop the declaration from (include/linux/huge_mm.h) which is
> no longer required. While at this, rename this as vma_is_temporary_stack()
> in line with existing helpers. This should not cause any functional change.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
