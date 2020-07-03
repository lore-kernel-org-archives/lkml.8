Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A134E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNnXRjSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGCKbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:31:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgGCKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593772272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9wR42/zNBihOWtRR68eabC3BArvWAnf6cvHZPtTPto=;
        b=XNnXRjSZd8Fp1xyWnZ6hK2JRK4xF8VmOYCzr3v7j6UJk79K5VvxAWOdiElRKONEPyxvyV1
        5s6tmOpeVLlndzrp+nTfZRQjFrKp61sTE7uV1H9aJZFdTh2kaDHtedPkVCR1NyaLdx+Wj2
        HX70BtSnIbtX8dq45y1HchAqGPNSOgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-GUIwsewSOc6N3osjIwjx1Q-1; Fri, 03 Jul 2020 06:31:11 -0400
X-MC-Unique: GUIwsewSOc6N3osjIwjx1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEEB88014D7;
        Fri,  3 Jul 2020 10:31:09 +0000 (UTC)
Received: from krava (unknown [10.40.194.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id AAF4F73FC7;
        Fri,  3 Jul 2020 10:31:07 +0000 (UTC)
Date:   Fri, 3 Jul 2020 12:31:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH -next] perf util: Fix memory leak in __parse_regs()
Message-ID: <20200703103106.GA3261456@krava>
References: <20200703093344.189450-1-zhengzengkai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703093344.189450-1-zhengzengkai@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 05:33:44PM +0800, Zheng Zengkai wrote:
> when using perf record option '-I' or '--user-regs='
> along with argument '?' to list available register names,
> memory of variable 'os' allocated by strdup() needs to be released
> before __parse_regs() returns, otherwise memory leak will occur.
> 
> Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/parse-regs-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index e687497b3aac..a4a100425b3a 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -54,7 +54,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  #endif
>  				fputc('\n', stderr);
>  				/* just printing available regs */
> -				return -1;
> +				goto error;
>  			}
>  #ifdef HAVE_PERF_REGS_SUPPORT
>  			for (r = sample_reg_masks; r->name; r++) {
> -- 
> 2.20.1
> 

