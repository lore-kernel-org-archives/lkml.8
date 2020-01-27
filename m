Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEADC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE4B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEl7HxHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgA0LTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:19:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729043AbgA0LTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580123944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BErR0RwzOsFrhtcTHHOPAGFQ2vAoXbVb7DYzS0T3Rg4=;
        b=EEl7HxHBKJ/e9BmMVkvriTuDIpsTjwPLIF/E23lRd8e7EByZGiic9UCs/ulvFdChWS2rga
        6kVDoJdM1ikHoOuNyOW64UI9aICfzzbQkbutrNfpnZ5eyibDLzavuvCOcoCOXOHY5jHXYX
        DHdErWWnlL+NwG9uE8golLAWnzTHC7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-CAdF87FDMpmBX3H00_ZRLw-1; Mon, 27 Jan 2020 06:12:38 -0500
X-MC-Unique: CAdF87FDMpmBX3H00_ZRLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 883A5107B272;
        Mon, 27 Jan 2020 11:12:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E60D381;
        Mon, 27 Jan 2020 11:12:36 +0000 (UTC)
Date:   Mon, 27 Jan 2020 12:12:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
Message-ID: <20200127111234.GA1114818@krava>
References: <20200127100031.1368732-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127100031.1368732-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 07:00:31PM +0900, Namhyung Kim wrote:

SNIP

> -
> -	if (strlen(path) < maxlen) {
> -		strcpy(buf, path);
> -		return 0;
> -	}
> -	return -1;
> -}
> -
>  static int open_cgroup(const char *name)
>  {
>  	char path[PATH_MAX + 1];
> @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
>  	int fd;
>  
>  
> -	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> +	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))

nice, but could you please follow fs API names and change the
name to cgroupfs__mountpoint

I think we don't need to define the rest of the functions now,
if they are not used

	#define FS(name)                                \
		const char *name##__mountpoint(void);   \
		const char *name##__mount(void);        \
		bool name##__configured(void);          \

just follow the function name

thanks,
jirka

>  		return -1;
>  
>  	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

