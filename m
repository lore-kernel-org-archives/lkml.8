Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A7C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024672078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgDQP7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:59:02 -0400
Received: from gentwo.org ([3.19.106.255]:34904 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgDQP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:59:01 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D03D83F9C5; Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id CF7753E91E;
        Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
Date:   Fri, 17 Apr 2020 15:59:00 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Bernard Zhao <bernard@vivo.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] kmalloc_index optimization(add kmalloc max size check)
In-Reply-To: <1587107376-111722-1-git-send-email-bernard@vivo.com>
Message-ID: <alpine.DEB.2.21.2004171556170.29874@www.lameter.com>
References: <1587107376-111722-1-git-send-email-bernard@vivo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Bernard Zhao wrote:

> kmalloc size should never exceed KMALLOC_MAX_SIZE.
> kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
> kmalloc_index just return index 26, but never check with OS`s max
> kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
> not create in function create_kmalloc_caches.
> We can throw an warninginfo in kmalloc at the beginning, instead of
> being guaranteed by the buddy alloc behind.

kmalloc_index(0 already bugs if the allocation is more than 64M


...

   if (size <=  64 * 1024 * 1024) return 26;
        BUG();


You could modify that to check for KMALLOC_MAX_SIZE with some more
conditionals but then kmalloc_index) is written so that the compiler gets
constant folding right.

If you have a patch like that then please verify that all c compilers in
use perform correct constant folding and do not add unnecessary code.


