Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D57C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E90206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFEUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:51:46 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:60942 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgFEUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:51:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,477,1583190000"; 
   d="scan'208";a="453258010"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 22:51:42 +0200
Date:   Fri, 5 Jun 2020 22:51:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvfree script
In-Reply-To: <20200605204237.85055-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006052249160.28300@hadrien>
References: <20200605204237.85055-1-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jun 2020, Denis Efremov wrote:

> Check that alloc and free types of functions match each other.

Is there a strong reason for putting the choice rule first?  It may make
things somewhat slower than necessary, if it matches in many places,
because the opportunity rule will have to detect that it doesn't care
about all of those places.

Also, there is no need to exceed 80 characters here.  You can put a
newline in the middle of a \( ... \)

julia

>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> List of patches to stable:
> - https://lkml.org/lkml/2020/6/1/713
> - https://lkml.org/lkml/2020/6/5/200
> - https://lkml.org/lkml/2020/6/5/838
> - https://lkml.org/lkml/2020/6/5/887
>
> Other patches:
> - https://lkml.org/lkml/2020/6/1/701
> - https://lkml.org/lkml/2020/6/5/839
> - https://lkml.org/lkml/2020/6/5/864
> - https://lkml.org/lkml/2020/6/5/865
> - https://lkml.org/lkml/2020/6/5/895
> - https://lkml.org/lkml/2020/6/5/901
>
> There is a false positive that I can't beat:
> fs/btrfs/send.c:1119:11-12: WARNING: kmalloc is used to allocate
> this memory at line 1036
>
>  scripts/coccinelle/api/kvfree.cocci | 196 ++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kvfree.cocci
>
> diff --git a/scripts/coccinelle/api/kvfree.cocci b/scripts/coccinelle/api/kvfree.cocci
> new file mode 100644
> index 000000000000..e3fa3d0fd2fd
> --- /dev/null
> +++ b/scripts/coccinelle/api/kvfree.cocci
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check that kvmalloc'ed memory is freed by kfree functions,
> +/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
> +/// functions.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual patch
> +virtual report
> +virtual org
> +virtual context
> +
> +
> +@choice@
> +expression E, E1;
> +position kok, vok;
> +@@
> +
> +(
> +  if (...) {
> +    ...
> +    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
> +    ...
> +  } else {
> +    ...
> +    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|__vmalloc_node@vok\)(...)
> +    ...
> +  }
> +|
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)
> +  ... when != E = E1
> +      when any
> +  if (\(!E\|E == NULL\)) {
> +    ...
> +    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|__vmalloc_node@vok\)(...)
> +    ...
> +  }
> +)
> +
> +// exclude mm/vmalloc.c because of kvmalloc* definitions
> +@opportunity depends on !patch && !(file in "mm/vmalloc.c")@
> +expression E, E1, size;
> +position p;
> +@@
> +
> +(
> +* if (\(size <= E1\|size < E1\|size = E1\|size > E1\) || ...)@p {
> +    ...
> +    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
> +    ...
> +  } else {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
> +    ...
> +  }
> +|
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
> +  ... when != E = E1
> +      when != size = E1
> +      when any
> +* if (\(!E\|E == NULL\))@p {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
> +    ...
> +  }
> +)
> +
> +@vfree depends on !patch@
> +expression E;
> +position k != choice.kok;
> +position p;
> +@@
> +
> +* E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|kcalloc_node@k\)(...)
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\|kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +* \(vfree\|vfree_atomic\|kvfree\)(E)@p
> +
> +@pvfree depends on patch exists@
> +expression E;
> +position k != choice.kok;
> +@@
> +
> +  E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|kcalloc_node@k\)(...)
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\|kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +- \(vfree\|vfree_atomic\|kvfree\)(E)
> ++ kfree(E)
> +
> +@kfree depends on !patch@
> +expression E;
> +position v != choice.vok;
> +position p;
> +@@
> +
> +* E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|__vmalloc_node_range@v\|__vmalloc_node@v\)(...)
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|kvfree\)(E)
> +
> +@pkfree depends on patch exists@
> +expression E;
> +position v != choice.vok;
> +@@
> +
> +  E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|__vmalloc_node_range@v\|__vmalloc_node@v\)(...)
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +- \(kfree\|kvfree\)(E)
> ++ vfree(E)
> +
> +@kvfree depends on !patch@
> +expression E;
> +position p, k;
> +@@
> +
> +* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...)@k
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
> +
> +@pkvfree depends on patch exists@
> +expression E;
> +@@
> +
> +  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|kvmalloc_array\)(...)
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +- \(kfree\|vfree\)(E)
> ++ kvfree(E)
> +
> +@script: python depends on report@
> +k << vfree.k;
> +p << vfree.p;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +k << vfree.k;
> +p << vfree.p;
> +@@
> +
> +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script: python depends on report@
> +v << kfree.v;
> +p << kfree.p;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +v << kfree.v;
> +p << kfree.p;
> +@@
> +
> +msg = "WARNING: vmalloc is used to allocate this memory at line %s" % (v[0].line)
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script: python depends on report@
> +k << kvfree.k;
> +p << kvfree.p;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +k << kvfree.k;
> +p << kvfree.p;
> +@@
> +
> +msg = "WARNING: kvmalloc is used to allocate this memory at line %s" % (k[0].line)
> +coccilib.org.print_todo(p[0], msg)
> +
> +@script: python depends on report@
> +p << opportunity.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
> +
> +@script: python depends on org@
> +p << opportunity.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
