Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F4D206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFNJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 05:17:30 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59425 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgFNJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 05:17:29 -0400
X-IronPort-AV: E=Sophos;i="5.73,510,1583190000"; 
   d="scan'208";a="454614095"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 11:17:27 +0200
Date:   Sun, 14 Jun 2020 11:17:27 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvfree script
In-Reply-To: <7ce5499c-037e-e192-b19e-58cb6f700b9f@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006141117040.4736@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <alpine.DEB.2.21.2006052249160.28300@hadrien> <7ce5499c-037e-e192-b19e-58cb6f700b9f@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jun 2020, Denis Efremov wrote:

>
>
> On 6/5/20 11:51 PM, Julia Lawall wrote:
> > Also, there is no need to exceed 80 characters here.  You can put a
> > newline in the middle of a \( ... \)
>
> It's required. Looks like it's impossible to break "when" lines.

That's true. Sorry for the noise.

julia

>
> ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\|kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...); ... }
>
> Thanks,
> Denis
>
