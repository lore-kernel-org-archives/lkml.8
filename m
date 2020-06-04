Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA26C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9561D206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgFDTbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:31:25 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56336
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgFDTbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:31:25 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="350624709"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 21:31:22 +0200
Date:   Thu, 4 Jun 2020 21:31:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Matthias Maennich <maennich@google.com>
cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Julia Lawall <julia.lawall@inria.fr>,
        YueHaibing <yuehaibing@huawei.com>, jeyu@kernel.org,
        cocci@systeme.lip6.fr, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] scripts: add dummy report mode to add_namespace.cocci
In-Reply-To: <20200604164145.173925-1-maennich@google.com>
Message-ID: <alpine.DEB.2.21.2006042130080.2577@hadrien>
References: <20200604164145.173925-1-maennich@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jun 2020, Matthias Maennich wrote:

> When running `make coccicheck` in report mode using the
> add_namespace.cocci file, it will fail for files that contain
> MODULE_LICENSE. Those match the replacement precondition, but spatch
> errors out as virtual.ns is not set.
>
> In order to fix that, add the virtual rule nsdeps and only do search and
> replace if that rule has been explicitly requested.
>
> In order to make spatch happy in report mode, we also need a dummy rule,
> as otherwise it errors out with "No rules apply". Using a script:python
> rule appears unrelated and odd, but this is the shortest I could come up
> with.
>
> Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
> `make nsdeps`.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: jeyu@kernel.org
> Cc: cocci@systeme.lip6.fr
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

Shuah reported the problem to me, so you could add

Reported-by: Shuah Khan <skhan@linuxfoundation.org>


> ---
>  scripts/coccinelle/misc/add_namespace.cocci | 8 +++++++-
>  scripts/nsdeps                              | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> index 99e93a6c2e24..cbf1614163cb 100644
> --- a/scripts/coccinelle/misc/add_namespace.cocci
> +++ b/scripts/coccinelle/misc/add_namespace.cocci
> @@ -6,6 +6,7 @@
>  /// add a missing namespace tag to a module source file.
>  ///
>
> +virtual nsdeps
>  virtual report
>
>  @has_ns_import@
> @@ -16,10 +17,15 @@ MODULE_IMPORT_NS(ns);
>
>  // Add missing imports, but only adjacent to a MODULE_LICENSE statement.
>  // That ensures we are adding it only to the main module source file.
> -@do_import depends on !has_ns_import@
> +@do_import depends on !has_ns_import && nsdeps@
>  declarer name MODULE_LICENSE;
>  expression license;
>  identifier virtual.ns;
>  @@
>  MODULE_LICENSE(license);
>  + MODULE_IMPORT_NS(ns);
> +
> +// Dummy rule for report mode that would otherwise be empty and make spatch
> +// fail ("No rules apply.")
> +@script:python depends on report@
> +@@
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 03a8e7cbe6c7..dab4c1a0e27d 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -29,7 +29,7 @@ fi
>
>  generate_deps_for_ns() {
>  	$SPATCH --very-quiet --in-place --sp-file \
> -		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
>  }
>
>  generate_deps() {
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
>
