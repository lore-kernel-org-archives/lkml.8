Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F39206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuP5+XLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgERIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:51:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbgERIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589791865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBa1sRdRwUUWtnTpcqYTLRqGp5y5xwQ2N96sP7/a2EE=;
        b=KuP5+XLNNXNrpWnqqHFC414N54vV8Emw6PoqQiSsjIOhoSbS1RlX+Wvc9DlkFl1IubcnuF
        NXPMz76YHgFusbW6EfzHlRFEkcVkZtV7zHlisMAHwz737cszywGRPPHcuYe56QdZmOzi7X
        1ThtaHxEARVjuiOJuKnw0l63+3ZyaZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-d7XMtz7cMu6sbCBBlZTWhg-1; Mon, 18 May 2020 04:51:03 -0400
X-MC-Unique: d7XMtz7cMu6sbCBBlZTWhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D940618A0724;
        Mon, 18 May 2020 08:51:01 +0000 (UTC)
Received: from krava (unknown [10.40.195.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 124E56ED80;
        Mon, 18 May 2020 08:50:59 +0000 (UTC)
Date:   Mon, 18 May 2020 10:50:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        irogers@google.com, kim.phillips@amd.com
Subject: Re: [PATCH 0/3] perf/x86/rapl: Enable RAPL for AMD Fam17h
Message-ID: <20200518085058.GB3726797@krava>
References: <20200515215733.20647-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515215733.20647-1-eranian@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:57:30PM -0700, Stephane Eranian wrote:
> This patch series adds support for AMD Fam17h RAPL counters. As per
> AMD PPR, Fam17h support Package RAPL counters to monitor power usage.
> The RAPL counter operates as with Intel RAPL. As such, it is beneficial
> to share the code.
> 
> The series first moves the rapl.c file to common perf_events x86 and then
> adds the support.
> From the user's point of view, the interface is identical with
> /sys/devices/power. The energy-pkg event is the only one supported.
> 
> $ perf stat -a --per-socket -I 1000 -e power/energy-pkg/
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> 
> Stephane Eranian (3):
>   perf/x86/rapl: move RAPL support to common x86 code
>   perf/x86/rapl: refactor code for Intel/AMD sharing
>   perf/x86/rapl: add AMD Fam17h RAPL support
> 
>  arch/x86/events/Kconfig            |  8 ++---
>  arch/x86/events/Makefile           |  1 +
>  arch/x86/events/intel/Makefile     |  2 --
>  arch/x86/events/probe.c            |  4 +++
>  arch/x86/events/{intel => }/rapl.c | 55 +++++++++++++++++++++++++-----
>  arch/x86/include/asm/msr-index.h   |  3 ++
>  6 files changed, 58 insertions(+), 15 deletions(-)
>  rename arch/x86/events/{intel => }/rapl.c (92%)

looks good to me, intel rapl keeps working for me ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

