Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EC72064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHCMSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:18:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64325
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbgHCMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:18:05 -0400
X-IronPort-AV: E=Sophos;i="5.75,430,1589234400"; 
   d="scan'208";a="355857185"
Received: from clt-128-93-177-162.vpn.inria.fr ([128.93.177.162])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 14:18:04 +0200
Date:   Mon, 3 Aug 2020 14:18:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] coccinelle: api: add kvfree script
In-Reply-To: <a8d8eade-1d98-b8d9-7c66-bd05b22af751@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008031416301.27678@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200731210026.7186-1-efremov@linux.com> <alpine.DEB.2.22.394.2008022142550.2531@hadrien> <a8d8eade-1d98-b8d9-7c66-bd05b22af751@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Aug 2020, Denis Efremov wrote:

>
>
> On 8/2/20 11:24 PM, Julia Lawall wrote:
> >> +@initialize:python@
> >> +@@
> >> +# low-level memory api
> >> +filter = frozenset(['__vmalloc_area_node'])
> >> +
> >> +def relevant(p):
> >> +    return not (filter & {el.current_element for el in p})
> >
> > Is this used?
>
> I'll remove it in v8. Or do you want me to add iterate_dir_item() in the list?

What is that?

>
> >
> > Otherwise, I think it would be good to not warn about a use of kvfree
> > if that use is reachable from a kvmalloc.  There seems to be such a false
> > positive in fs/btrfs/send.c, on line 1118.
>
> I don't know how to handle this case without position filter.
> It's too complex. In iterate_dir_item() there is:
> buf = kmalloc(buf_len, GFP_KERNEL);
> while(...) {
> 	if (...) {
> 		if (is_vmalloc_addr(buf)) {
> 			vfree(buf);
> 			...
> 		} else {
> 			char *tmp = krealloc(buf, ...);
>
> 			if (!tmp)
> 				kfree(buf);
> 			...
> 		}
> 		if (!buf) {
> 			buf = kvmalloc(buf_len, GFP_KERNEL);
> 			...
> 		}
> 	}
> }
> kvfree(buf);
>
> Adding "when != kvfree(E)" is not enough:
> * E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
> *       kvmalloc_array\)(...)@k
> 	... when != is_vmalloc_addr(E)
> +	when != kvfree(E)
> 	when any
> * \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p

Why not just

@ok exists@
position p;
expression E;
@@

E = kvalloc(...)
...
kvfree@p(...)

Probably that is what you mean by a position filter, but why not add a
position filter?

julia


> >
> > It also seems that when there are both a kmalloc and a vmalloc, there is
> > no warning if kfree or vfree is used.  Is that intentional?
> >
>
> No, I will try to address it in v8.
>
> Regards,
> Denis
>
