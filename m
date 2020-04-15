Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16020C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED918206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgDOVmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:42:23 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:33520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgDOVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:42:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 84C59181D3025;
        Wed, 15 Apr 2020 21:42:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paint15_875805ccbe953
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 21:42:09 +0000 (UTC)
Message-ID: <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date:   Wed, 15 Apr 2020 14:39:59 -0700
In-Reply-To: <20200415184945.16487-6-paulmck@kernel.org>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
         <20200415184945.16487-6-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> Also add me as Reviewer for LKMM. Previously a patch to do this was
> Acked but somewhere along the line got lost. Add myself in this patch.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
> +R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  S:	Supported
> @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
>  F:	tools/memory-model/
> +F:	Documentation/litmus-tests/

trivia:

Alphabetic ordering of F: entries please.
This should be between core-api and memory-barriers.

>  LIS3LV02D ACCELEROMETER DRIVER
>  M:	Eric Piel <eric.piel@tremplin-utc.net>

