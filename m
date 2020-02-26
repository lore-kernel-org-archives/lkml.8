Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B2FC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782AD2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBZN7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:59:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgBZN7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:59:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3EC24ABEA;
        Wed, 26 Feb 2020 13:59:23 +0000 (UTC)
Subject: Re: [PATCH 2/3] mm/vma: Make vma_is_foreign() available for general
 use
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
 <1582692658-3294-3-git-send-email-anshuman.khandual@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ce0c4bc9-1884-f423-178f-306690e88a81@suse.cz>
Date:   Wed, 26 Feb 2020 14:59:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582692658-3294-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/20 5:50 AM, Anshuman Khandual wrote:
> Idea of a foreign VMA with respect to the present context is very generic.
> But currently there are two identical definitions for this in powerpc and
> x86 platforms. Lets consolidate those redundant definitions while making
> vma_is_foreign() available for general use later. This should not cause
> any functional change.
> 
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Some comment for the function wouln't hurt, but perhaps it is self-explanatory
enough.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
