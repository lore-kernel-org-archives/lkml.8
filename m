Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DAC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A975205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgCOOLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:11:39 -0400
Received: from gentwo.org ([3.19.106.255]:43644 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgCOOLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:11:39 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 8C64E3F7A9; Sun, 15 Mar 2020 14:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8B71A3F6EC;
        Sun, 15 Mar 2020 14:11:38 +0000 (UTC)
Date:   Sun, 15 Mar 2020 14:11:38 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Kees Cook <keescook@chromium.org>
cc:     David Laight <David.Laight@ACULAB.COM>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Vitaly Nikolenko <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: Relocate freelist pointer to middle of object
In-Reply-To: <202003111039.24B8A0B@keescook>
Message-ID: <alpine.DEB.2.21.2003151410220.14449@www.lameter.com>
References: <202003051624.AAAC9AECC@keescook> <alpine.DEB.2.21.2003081919290.14266@www.lameter.com> <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com> <202003111039.24B8A0B@keescook>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Kees Cook wrote:

> > Sounds good. You could even randomize the position to avoid attacks on via
> > the freelist pointer.
>
> That's a good point. "offset" is just calculated once, and for many
> slabs, the available space is quite large. I wonder what the best

Correct.

> practice might be for how far from the edge to stay. Hmmm. Maybe simply
> carve it into thirds, and randomize the offset within the middle third?

Take off the first and last word and randomize within the space that is
left?
