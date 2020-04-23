Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2FC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A1120781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKMTdZ84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgDWNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:24:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28808 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgDWNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587648297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuDyAj20bmjbvYj7VsEeP7XEemVCDcYopHSDDueemOo=;
        b=IKMTdZ841e3eRC6MqAXGGG083JUfn7NQC/xNrOs017m6jk9jMYSbYTsVEk6j0/C6F1None
        m4dU9LJ0hZpPcV3zXLQ+Xmnw1DixrFh6B/GhaIJJK1uwo90HWPnoUJ+H4zg5M9D4rj7gvR
        goWPbIvPQF1Zlx0BWMJEC++gbbCntv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22--jOYvudAO7eUPhq-S7CEWA-1; Thu, 23 Apr 2020 09:24:53 -0400
X-MC-Unique: -jOYvudAO7eUPhq-S7CEWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC00380B70F;
        Thu, 23 Apr 2020 13:24:51 +0000 (UTC)
Received: from krava (ovpn-115-157.ams2.redhat.com [10.36.115.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52D1C619C0;
        Thu, 23 Apr 2020 13:24:48 +0000 (UTC)
Date:   Thu, 23 Apr 2020 15:24:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/3] perf stat: Add --metrics-file option
Message-ID: <20200423132446.GN1136647@krava>
References: <20200421181337.988681-1-jolsa@kernel.org>
 <20200421181337.988681-4-jolsa@kernel.org>
 <20200421183615.GD608746@tassilo.jf.intel.com>
 <20200421185252.GA962614@krava>
 <20200421200630.GG608746@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421200630.GG608746@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:06:30PM -0700, Andi Kleen wrote:
> > > Also there are some asserts that can be triggered by expressions. I think
> > > you should fix those too and convert them to errors.
> > 
> > do you have some details on this? examples of those failures?
> 
> At a minimum 
> 
> /* Caller must make sure id is allocated */
> void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
> {
>         int idx;
>         assert(ctx->num_ids < MAX_PARSE_ID);
> 
> 
> -Andi
> 

I did it and then I realized this is already caught in the parsing
code (expr.y) with this check:

        if (ctx->num_ids + 1 >= EXPR_MAX_OTHER) {
                pr_err("failed: way too many variables\n");
                YYABORT;
        }

so that assert can stay there and shouldn't be ever hit

jirka

