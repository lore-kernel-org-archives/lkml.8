Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4345C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A242067C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHTeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:34:25 -0400
Received: from gentwo.org ([3.19.106.255]:43440 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgCHTeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:34:25 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 8A8C03F1C0; Sun,  8 Mar 2020 19:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8845B3E998;
        Sun,  8 Mar 2020 19:34:24 +0000 (UTC)
Date:   Sun, 8 Mar 2020 19:34:24 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     David Rientjes <rientjes@google.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
In-Reply-To: <alpine.DEB.2.21.2003041231020.260792@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003081929460.14266@www.lameter.com>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com> <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com> <202003031820.7A0C4FF302@keescook> <beb7abda-2648-aae7-31c5-51da6f02380a@suse.cz>
 <alpine.DEB.2.21.2003041231020.260792@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020, David Rientjes wrote:

> I'm not sure how dependent the CONFIG_SLUB_DEBUG users are on being able
> to modify these are runtime (they've been around for 12+ years) but I
> agree that it seems particularly dangerous.

The order of each individual slab page is stored in struct page. That is
why every slub slab page can have a different order. This enabled fallback
to order 0 allocations and also allows a dynamic configuration of the
order at runtime.

> The slub_debug kernel command line options are already pretty
> comprehensive as described by Documentation/vm/slub.rst.  I *think* these
> tunables were primarily introduced for kernel debugging and not general
> purpose, perhaps with the exception of "order".

What do you mean by "general purpose? Certainly the allocator should not
blow up when forcing zero order allocations.

> So I think we may be able to fix "order" with a combination of my patch as
> well as a fix to the freelist randomization and that the others should
> likely be made read only.

Hmmm. races increases as more metadata is added that is depending on the
size of the slab page and the number of objects in it.

