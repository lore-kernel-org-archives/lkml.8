Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986CC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F1205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ3mw9B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBXOEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:04:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727326AbgBXOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582553049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjwC2RwdS4JbsOXKcaZw/xTAc2BeA6XkIVMV+f1T6/M=;
        b=UJ3mw9B/1BLDmgjjXfqo3ADY7D0AKzasn7IDvE7uGUQ/ixYihwk5/IxOKHjnQh8h/x8fAz
        ei3aWPOV28ACDaYcagHs2NUuK+WlWUswjYNRusrSx/Cl6+YYpXZc7UedaOz88hOZKMBw8A
        OawNmI3WaFuXfw9NH/QRbhiGm4rw2Ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-u_GYqq-GPvKE97z9nOvGNw-1; Mon, 24 Feb 2020 09:04:05 -0500
X-MC-Unique: u_GYqq-GPvKE97z9nOvGNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463FB80572C;
        Mon, 24 Feb 2020 14:04:03 +0000 (UTC)
Received: from krava (ovpn-204-48.brq.redhat.com [10.40.204.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30772909EA;
        Mon, 24 Feb 2020 14:03:59 +0000 (UTC)
Date:   Mon, 24 Feb 2020 15:03:57 +0100
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
Subject: Re: [PATCH V2 00/13] perf/x86: Add perf text poke events
Message-ID: <20200224140357.GI16664@krava>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
 <80d0902f-0b38-6f03-f4a4-f6d2693d7e25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d0902f-0b38-6f03-f4a4-f6d2693d7e25@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:50:13PM +0200, Adrian Hunter wrote:
> On 12/02/20 2:49 pm, Adrian Hunter wrote:
> > Hi
> > 
> > Here are patches to add a text poke event to record changes to kernel text
> > (i.e. self-modifying code) in order to support tracers like Intel PT
> > decoding through jump labels, kprobes and ftrace trampolines.
> > 
> > The first 8 patches make the kernel changes and the subsequent patches are
> > tools changes.
> > 
> > The next 4 patches add support for updating perf tools' data cache
> > with the changed bytes.
> > 
> > The last patch is an Intel PT specific tools change.
> > 
> > 
> > Changes in V2:
> > 
> >   perf: Add perf text poke event
> > 
> > 	Separate out x86 changes
> > 	The text poke event now has old len and new len
> > 	Revised commit message
> > 
> >   perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
> > 
> > 	New patch containing x86 changes from original first patch
> 
> Any comments?
> 

hi,
I plan to look on it hopefuly today or tomorrow

jirka

