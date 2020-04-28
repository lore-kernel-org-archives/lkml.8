Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7963C206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVWMBvyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD1JtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:49:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgD1JtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588067339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0XdWdmx06pmDIyCJ8DxJdoMcs4kX2jAJaFbg18kv3c=;
        b=DVWMBvyPvTk7o/8bx1LxbnrdmLOzCz5W4CHp7AY0QrYSm3HjfbpQuM3Aw+kbXQ+N72kAbq
        N1IPA4OrIOKIeMzjGlP8QXaCIiuir9wXuXsSOV5LlbtN7NAjOpMPlJ5wvrJEkoOaGJi6qn
        lZj6QIbyq7rX8yXauVWEJO94ChW4Hs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-M1YCHmVqPait_5HAofQHkw-1; Tue, 28 Apr 2020 05:48:57 -0400
X-MC-Unique: M1YCHmVqPait_5HAofQHkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E980B462;
        Tue, 28 Apr 2020 09:48:55 +0000 (UTC)
Received: from krava (unknown [10.40.196.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A183648C1;
        Tue, 28 Apr 2020 09:48:53 +0000 (UTC)
Date:   Tue, 28 Apr 2020 11:48:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 4/7] perf bpf: Decouple creating the evlist from adding
 the SB event
Message-ID: <20200428094851.GE1476763@krava>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-5-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427211935.25789-5-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 06:19:32PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
> requiring that the evlist be allocated beforehand.

hum, this seems to be done in previous patch, maybe you
need to squash this with the previous one?

jirka

> 
> This will allow using the same side band thread and evlist to be used
> for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
> after they are generated.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf-event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index 2c7a50509659..68f315c3df5b 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -45,7 +45,7 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> -static inline int evlist__add_bpf_sb_event(struct evlist **evlist __maybe_unused,
> +static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
>  					   struct perf_env *env __maybe_unused)
>  {
>  	return 0;
> -- 
> 2.21.1
> 

