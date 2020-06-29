Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D513C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A49206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9TU9zrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgF2TRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:17:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55572 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731963AbgF2TRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCU9JjYn8E5EJ3tgtkZ8fJQcI1jYdB8KZDv2+twV1/g=;
        b=A9TU9zrrWi35e6LxvVRWC3ssuzs97B2pnNvjC9jSNTDhQEBT9f1+XUZBVBY+pT4wv2TJz0
        nDd9TUFapZWDpwXTSOtU3jc5nu8RU5GUfJq5dw6Q00NNVSePLwZPSXMTBuDc91BabDWL7y
        KuQJGaJiUKHGRXov1guNRhxcMQP4/2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-UuU0pLxkNTqGodv5frl3IQ-1; Mon, 29 Jun 2020 15:17:04 -0400
X-MC-Unique: UuU0pLxkNTqGodv5frl3IQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09FE91362B;
        Mon, 29 Jun 2020 19:17:02 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 261F71C4;
        Mon, 29 Jun 2020 19:17:00 +0000 (UTC)
Date:   Mon, 29 Jun 2020 21:17:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/13] tools/libperf: avoid moving of fds at
 fdarray__filter() call
Message-ID: <20200629191700.GC3031756@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
 <fada6325-2e6a-0de4-918f-0bc7d1410c52@linux.intel.com>
 <20200625171405.GL2719003@krava>
 <688910f3-289e-d63e-79e3-0a17a6df0e9e@linux.intel.com>
 <20200626093745.GM2719003@krava>
 <6582201a-9570-709f-f6e9-5a644296f49d@linux.intel.com>
 <b2a868bb-b434-7814-d577-944efc5369aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a868bb-b434-7814-d577-944efc5369aa@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 06:11:52PM +0300, Alexey Budankov wrote:

SNIP

> >>
> >> I'm confused, are you talking about file descriptors limit now?
> >> this wont be affected by epoll change.. what do I miss?
> > 
> > Currently there is already uname -n limit on the amount of open file descriptors
> > and Perf tool process is affected by that limit.
> > 
> > Moving to epoll() will impose one more max_user_watches limit and that can additionally
> > confine Perf applicability even though default value on some machines currently
> > is high enough.
> 
> Prior making v9 I would prefer to agree on some design to be implemented in order to
> avoid guessing and redundant reiterating.
> 
> Options that I see as good balanced ones are 1) or 5), + non screwing of fds to fix
> staleness of pos(=fdarray__add()).
> 
> Are there any thoughts so far?

let's try it and discuss over the code

jirka

