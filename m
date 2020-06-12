Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28751C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B922074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c9DqVWlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:27:29 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94DEC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bUBhyKW0TgX82+vyX9VE1I4aaadgLyRSmyDZenRqXG4=; b=c9DqVWlN9XHVVXEGOPovDQpEAe
        FYb5pHmRpeQaPFN2e17zDrouGAyCOps/JJCFeuSE1E4LM5kC5z24NCXifxCzDePkAvYcCflUEGo+F
        ZHNsKbuDoQr9plCsjAHNLwUek+T3+IP8W3OGXiubYA5G4NZSOqgk58njAjzqKSiPdzTp6hRmlvfCk
        YKIXcM2RNPvWB+w8ehyyoGW6Xsb2tVCAeC6yOGKXWumLxlc0iAknvGpSpVoETQBfCgqgVQl0WXgWv
        Vc/Lfbs/tHKJg+RwyvKNG0Fv1cBMvTPN7L5iVvSq+gK02JW3m/YJjBxYDjh5+I8D59aaCQxdscBm+
        1GJyfn0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjji0-0004F4-D1; Fri, 12 Jun 2020 13:27:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 494533003E7;
        Fri, 12 Jun 2020 15:26:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07DD82BE34E29; Fri, 12 Jun 2020 15:26:57 +0200 (CEST)
Date:   Fri, 12 Jun 2020 15:26:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Message-ID: <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:50:11PM -0700, Matt Helsley wrote:
> +static int nop_mcount(struct section * const rels,
> +		      const char *const txtname)
> +{
> +	struct reloc *reloc;
> +	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
> +	unsigned mcountsym = 0;
> +	int once = 0;
> +
> +	list_for_each_entry(reloc, &rels->reloc_list, list) {
> +		int ret = -1;
> +
> +		if (!mcountsym)
> +			mcountsym = get_mcountsym(reloc);
> +
> +		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {

This makes no sense to me; why not have mcountsym be a 'struct symbol
*' and have get_mcountsym() return one of those.

	if (reloc->sym == mcountsym && ... )

is much nicer, no?

> +			if (make_nop) {
> +				ret = make_nop(txts, reloc->offset);
> +				if (ret < 0)
> +					return -1;
> +			}
> +			if (warn_on_notrace_sect && !once) {
> +				printf("Section %s has mcount callers being ignored\n",
> +				       txtname);
> +				once = 1;
> +				/* just warn? */
> +				if (!make_nop)
> +					return 0;
> +			}
> +		}
> +
> +		/*
> +		 * If we successfully removed the mcount, mark the relocation
> +		 * as a nop (don't do anything with it).
> +		 */
> +		if (!ret) {
> +			reloc->type = rel_type_nop;
> +			rels->changed = true;

I have an elf_write_rela(), I'll make sure to Cc you.

> +		}
> +	}
> +	return 0;
> +}
