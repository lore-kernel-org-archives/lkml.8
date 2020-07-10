Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F75C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0491220767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594351814;
	bh=bemyJMruDfG7EqbloAkBTt8qYNZGMcKOiBWcS6RcoCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rcFOZ78hnn7i65kMyXYXnLroAs7zGMxZnwj5uMExf1F3QOFRMMFXyD9nDYjfc+ZNx
	 C1kPjzKoNho71+YezfExCjfEHxR8K+tBFIlwa53T+I1MWABrw12idX43uf+8Jkai+0
	 s23Gp0FQuI+uF51wpdjxlnoVDU6/hFXHoEcOusHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJDaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGJDaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:30:12 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F8B2065C;
        Fri, 10 Jul 2020 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594351811;
        bh=bemyJMruDfG7EqbloAkBTt8qYNZGMcKOiBWcS6RcoCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dy1ecCxeXdRwgg2h+vLymmUHJXBt1j3UsYd0f74Pa/2QUn1cx8o3sNKLB8HqcqEsf
         2cUXlvkTp0GxNSx+X6IeGCgCcm02bYYVTnjj+Sw4Rf5Epm9hw56FHokQ7CM9KObx7o
         y+dt0CC9LYVT5e3BkqduvPU89MUVhDdWx2EPfJtU=
Date:   Fri, 10 Jul 2020 12:30:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] perf-probe: Warn if the target function is GNU
 Indirect function
Message-Id: <20200710123008.3af0e5ea78a9ff95d36a29d8@kernel.org>
In-Reply-To: <20200709143654.pw2maoxivsjho6op@two.firstfloor.org>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
        <159428205174.56570.17588311835868886287.stgit@devnote2>
        <20200709143654.pw2maoxivsjho6op@two.firstfloor.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 07:36:54 -0700
Andi Kleen <andi@firstfloor.org> wrote:

> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 1e95a336862c..671176d39569 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -379,6 +379,11 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
> >  			address = sym->start;
> >  		else
> >  			address = map->unmap_ip(map, sym->start) - map->reloc;
> > +		if (sym->type == STT_GNU_IFUNC) {
> > +			pr_warning("Warning: The probe address (0x%lx) is in a GNU indirect function.\n"
> > +				"This may not work as you expected unless you intend to probe the indirect function.\n",
> 
> I would say something like this.
> 
> Consider identifying the final function used at run time and set the
> probe directly on that.
> 
> I think that's more useful to the user.

Hmm, would you mean the default function which may be used for the symbol?
Let me check how we can find it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
