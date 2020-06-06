Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F42E207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 08:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgFFIQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 04:16:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:22401
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgFFIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 04:16:38 -0400
X-IronPort-AV: E=Sophos;i="5.73,479,1583190000"; 
   d="scan'208";a="350759538"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 10:16:36 +0200
Date:   Sat, 6 Jun 2020 10:16:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: add kzfree script
In-Reply-To: <378e709b-695a-be84-f4b3-f25dfcdc6ec7@linux.com>
Message-ID: <alpine.DEB.2.21.2006061011280.2578@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <20200604204846.15897-1-efremov@linux.com> <alpine.DEB.2.21.2006042254240.2577@hadrien> <378e709b-695a-be84-f4b3-f25dfcdc6ec7@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jun 2020, Denis Efremov wrote:

> It looks like a good idea to add type cast, like:
>
> +// Ignore kzfree definition
> +// Ignore kasan test
> +@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
> +expression *E;
> +position p;
> +type T;
> +@@
> +
> +* \(memset\|memset_explicit\)((T)E, 0, ...);
> +  ... when != E
> +      when strict
> +* \(kfree\|vfree\|kvfree\)(E)@p;
> +
>
> and to exclude file "mm/util.c" because it will contain the definition of
> kvfree_sensitive().
>
> I will wait for your recommendation about commented lines and will send v3 after.

Instead of the file in things, maybe it would be simpler to say:

position p : script:ocaml() { not (List.mem (List.hd p).current_element ["kzfree";"..."]) };

Or:

@initialize:ocaml@
@@

let relevant p =
   not (List.mem (List.hd p).current_element ["kzfree";"..."])

and then

position p : script:ocaml() { relevant p };

Or the python counterpart.  It's true that the script is probably not
relevant to those files at all, but listing the specific functions would
avoid the need for the comments and make the issue more clear.

It's just a suggestion.  If you prefer the file in solution, that's ok
too.

julia
