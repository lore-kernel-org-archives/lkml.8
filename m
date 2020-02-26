Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B282C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568F221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGb41qMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBZPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:22:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727023AbgBZPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pc7LaJTXjKzLJmjkIL4b44tzRohQzI/eJ799ofviMH4=;
        b=KGb41qMINhLUivdxd8yUUAr0zaoJo1rbf/m7Zxp35JtQFyl+uQU0vEfi4YtlWR6GxOPX/Q
        oInOViibxXce1QLocwWGy9D8dLPfyGXzeMqXLcsGwEPDqfOlCCeC1b33QLhGTKzKwiGMRV
        CJ6oy1FXUiDN4QpM1KTgxwNLM86kojE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-QlTG60LHMvCtUvmSaNtxuA-1; Wed, 26 Feb 2020 10:22:07 -0500
X-MC-Unique: QlTG60LHMvCtUvmSaNtxuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C7C4DB64;
        Wed, 26 Feb 2020 15:22:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF35790CC1;
        Wed, 26 Feb 2020 15:22:02 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:22:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200226152200.GB217283@krava>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
 <20200212124949.3589-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212124949.3589-4-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:49:39PM +0200, Adrian Hunter wrote:
> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.

I can't see kprobes in /proc/kallsyms, I tried making some with
perf probe and some of bcc-tools.. I'm greping for [kprobe]

could you put to changelog soem example /proc/kallsyms output?

jirka

