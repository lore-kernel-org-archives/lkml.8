Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB049C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE24206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgFIQWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:22:11 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44249
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgFIQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:22:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,492,1583190000"; 
   d="scan'208";a="351117269"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 18:22:05 +0200
Date:   Tue, 9 Jun 2020 18:22:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2 4/4] coccinelle: api: add selfcheck for
 memdup_user rule
In-Reply-To: <20200608150038.223747-5-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006091821010.2516@hadrien>
References: <20200608150038.223747-1-efremov@linux.com> <20200608150038.223747-5-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jun 2020, Denis Efremov wrote:

> Check that the rule matches vmemdup_user implementation.
> memdup_user is out of scope because we are not matching
> kmalloc_track_caller() function.

Is this a bit over-enginered?  More precisely, even if it is nice to check
that the API definition has the expected behavior, does it make sense to
do it in one case but not the other?

julia

>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 46 ++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index 8621bd98be1e..78fded83b197 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -14,13 +14,24 @@ virtual patch
>  virtual context
>  virtual org
>  virtual report
> +virtual selfcheck
>
>  @initialize:python@
>  @@
> -filter = frozenset(['memdup_user', 'vmemdup_user'])
> +
> +definitions = {
> +    'memdup_user': 'mm/util.c',
> +    'vmemdup_user': 'mm/util.c',
> +}
> +
> +filter = frozenset(definitions.keys())
> +coccinelle.filtered = set()
> +coccinelle.checked_files = set()
>
>  def relevant(p):
> -    return not (filter & {el.current_element for el in p})
> +    found = filter & {el.current_element for el in p}
> +    coccinelle.filtered |= found
> +    return not found
>
>  @depends on patch@
>  expression from,to,size;
> @@ -117,3 +128,34 @@ p << rv.p;
>  @@
>
>  coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
> +
> +@script:python depends on selfcheck@
> +@@
> +coccinelle.checked_files |= set(definitions.values()) & set(cocci.files())
> +
> +@finalize:python depends on selfcheck@
> +filtered << merge.filtered;
> +checked_files << merge.checked_files;
> +@@
> +
> +# Don't check memdup_user because the pattern is not capturing
> +# kmalloc_track_caller() calls
> +del definitions['memdup_user']
> +
> +# mapping between checked files and filtered definitions
> +found_defns = {}
> +for files, funcs in zip(checked_files, filtered):
> +   for file in files:
> +      found_defns[file] = funcs
> +
> +# reverse mapping of definitions
> +expected_defns = {v : set() for v in definitions.values()}
> +for k, v in definitions.items():
> +    expected_defns[v] |= {k}
> +
> +for efile, efuncs in expected_defns.items():
> +    if efile in found_defns:
> +        not_found = efuncs - found_defns[efile]
> +        if not_found:
> +            print('SELF-CHECK: the pattern no longer matches ' \
> +		  'definitions {} in file {}'.format(not_found, efile))
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
