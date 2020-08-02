Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14333C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0840D2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 20:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgHBUYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:24:25 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9164 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgHBUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:24:24 -0400
X-IronPort-AV: E=Sophos;i="5.75,427,1589234400"; 
   d="scan'208";a="462198836"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:24:21 +0200
Date:   Sun, 2 Aug 2020 22:24:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] coccinelle: api: add kvfree script
In-Reply-To: <20200731210026.7186-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008022142550.2531@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200731210026.7186-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@initialize:python@
> +@@
> +# low-level memory api
> +filter = frozenset(['__vmalloc_area_node'])
> +
> +def relevant(p):
> +    return not (filter & {el.current_element for el in p})

Is this used?

Otherwise, I think it would be good to not warn about a use of kvfree
if that use is reachable from a kvmalloc.  There seems to be such a false
positive in fs/btrfs/send.c, on line 1118.

It also seems that when there are both a kmalloc and a vmalloc, there is
no warning if kfree or vfree is used.  Is that intentional?

julia


> +
> +@choice@
> +expression E, E1;
> +position kok, vok;
> +@@
> +
> +(
> +  if (...) {
> +    ...
> +    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
> +          kmalloc_node\|kzalloc_node\|kmalloc_array\|
> +          kmalloc_array_node\|kcalloc_node\)(...)@kok
> +    ...
> +  } else {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> +          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
> +          __vmalloc_node\)(...)@vok
> +    ...
> +  }
> +|
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
> +        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
> +  ... when != E = E1
> +      when any
> +  if (\(!E\|E == NULL\)) {
> +    ...
> +    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
> +          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
> +          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
> +          __vmalloc_node\)(...)@vok
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
> +* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +*       kcalloc_node\)(...)@k
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
> +      when != is_vmalloc_addr(E)
> +      when any
> +* \(vfree\|vfree_atomic\|kvfree\)(E)@p
> +
> +@pvfree depends on patch exists@
> +expression E;
> +position k != choice.kok;
> +@@
> +
> +  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
> +        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
> +        kcalloc_node\)(...)@k
> +  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
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
> +* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +*       __vmalloc_node_range\|__vmalloc_node\)(...)@v
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|kvfree\)(E)@p
> +
> +@pkfree depends on patch exists@
> +expression E;
> +position v != choice.vok;
> +@@
> +
> +  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
> +        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
> +        __vmalloc_node_range\|__vmalloc_node\)(...)@v
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
> +* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +*       kvmalloc_array\)(...)@k
> +  ... when != is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
> +
> +@pkvfree depends on patch exists@
> +expression E;
> +@@
> +
> +  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> +        kvmalloc_array\)(...)
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
> --
> 2.26.2
>
>
