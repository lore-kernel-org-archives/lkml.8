Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA74C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C28420684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8OWaOkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgATKM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:12:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgATKM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579515174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBwMhBXZhRdxuq/HoUDwGKfRSE/uVBbn2q1ub14ALCU=;
        b=H8OWaOkbhxFkjg2dKvv2btyuudrY45FtT30povB2v8SusjAJZfC13/xlTLsWpdQu85RB3r
        1disG54/ik6KpHs4MAL+Rf+5OALcrNYDP1lRWkypODWdlM6JMJsXtI0kqYbz2L9RNo8EBV
        6FOrfO8udjrhaas8UmMWQKOBTpFsbro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-dSSGdUXqOFeLBU2J3dAhyA-1; Mon, 20 Jan 2020 05:12:51 -0500
X-MC-Unique: dSSGdUXqOFeLBU2J3dAhyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30369800D4E;
        Mon, 20 Jan 2020 10:12:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2B7B8573A;
        Mon, 20 Jan 2020 10:12:48 +0000 (UTC)
Date:   Mon, 20 Jan 2020 11:12:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf annotate: Fix segfault with source toggle
Message-ID: <20200120101246.GH608405@krava>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
 <20200117092612.30874-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117092612.30874-4-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 02:56:12PM +0530, Ravi Bangoria wrote:
> While rendering annotate browser from perf report tui, we keep track
> of total number of lines(asm + source) in annotation->nr_entries and
> total number of asm lines in annotation->nr_asm_entries. But we don't
> reset them before starting. Thus if user annotates same function
> multiple times, we restart incrementing these fields with old values.
> 
> This causes a segfault when user tries to toggle source code after
> annotating same function multiple times. Fix it.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/annotate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index fe98d29dfbc4..df09c2070337 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2610,6 +2610,8 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
>  	struct annotation_line *al;
>  
>  	notes->max_line_len = 0;
> +	notes->nr_entries = 0;
> +	notes->nr_asm_entries = 0;

seems fair ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

also could you please make that function static (in separate change)
in your next repost?

thanks,
jirka

>  
>  	list_for_each_entry(al, &notes->src->source, node) {
>  		size_t line_len = strlen(al->line);
> -- 
> 2.24.1
> 

