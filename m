Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D49C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20612187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka1a7c9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCBMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:51:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727267AbgCBMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583153494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FPcx9mNIhbN5J4WRPrHMT4YXzuuZ33lg/Dd3R/eu0g=;
        b=Ka1a7c9eyfqqx35lNOXm0BQMSKV5Fsulny2pBmf6V3AL4ZNy6x1D+CDK/1WFCdGRzaGZWQ
        XpeUclP8yXj5ykGhuywQVtn6dn3mfFvigNUkAFSzixrDdWYV4Wppbd/NoFDww8SPWJ5fGv
        s1gAbTSEgyLuF89EQgFvZxwBCuz2Fs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-VGenNzM1PRWg1_JG_ugdAw-1; Mon, 02 Mar 2020 07:51:31 -0500
X-MC-Unique: VGenNzM1PRWg1_JG_ugdAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95DE8800D50;
        Mon,  2 Mar 2020 12:51:29 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D300560C05;
        Mon,  2 Mar 2020 12:51:26 +0000 (UTC)
Date:   Mon, 2 Mar 2020 13:51:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 0/3] perf report: Support annotation of code without
 symbols
Message-ID: <20200302125123.GA204976@krava>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227043939.4403-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 12:39:36PM +0800, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
> 
> We should support the annotation functionality even without symbols.
> 
> The first patch uses al_addr to print because it's easy to dump
> the instructions from this address in binary for branch mode.
> 
> The second patch supports the annotation on stripped binary.
> 
> The third patch supports the hotkey 'a' on address for annotation.
> 
>  v5:
>  ---
>  Separate the hotkey 'a' implementation to a new patch
>  "perf report: Support hotkey 'a' on address for annotation"

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  v4:
>  ---
>  1. Support the hotkey 'a'. When we press 'a' on address,
>     now it supports the annotation.
> 
>  2. Change the patch title from
>     "Support interactive annotation of code without symbols" to
>     "perf report: Support interactive annotation of code without symbols"
> 
>  v3:
>  ---
>  Keep just the ANNOTATION_DUMMY_LEN, and remove the
>  opts->annotate_dummy_len since it's the "maybe in future
>  we will provide" feature.
> 
>  v2:
>  ---
>  Fix a crash issue when annotating an address in "unknown" object.
> 
> Jin Yao (3):
>   perf util: Print al_addr when symbol is not found
>   perf report: Support interactive annotation of code without symbols
>   perf report: Support hotkey 'a' on address for annotation
> 
>  tools/perf/ui/browsers/hists.c | 90 +++++++++++++++++++++++++++-------
>  tools/perf/util/annotate.h     |  1 +
>  tools/perf/util/sort.c         |  6 ++-
>  3 files changed, 78 insertions(+), 19 deletions(-)
> 
> -- 
> 2.17.1
> 

