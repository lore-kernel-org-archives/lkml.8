Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D88C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA320787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxF8Gb9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgDBMuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:50:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgDBMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585831801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBJyPLqFGhbd2JdWD+WaRlQquIJw7j0X5AJyxZsJMXo=;
        b=PxF8Gb9RIv2zFmjp9dGiX0EwyKCxFrYUEFWpJEV6UTlQhPR1iog3HUDMZY+r51VHYyAOMk
        mElVBdMbJrIf+HBqTrPzEqpEz0ZpTE7SjwAeuX0HZ8MBfVD7lTHKi2yBx27rPd4sFTk8du
        lXMOC63TcHtJGlqymRBss9M6jETRYTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-WChm82hsORS-s5OYgxip1A-1; Thu, 02 Apr 2020 08:49:57 -0400
X-MC-Unique: WChm82hsORS-s5OYgxip1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C82F85EE6C;
        Thu,  2 Apr 2020 12:49:54 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 031A45C290;
        Thu,  2 Apr 2020 12:49:48 +0000 (UTC)
Date:   Thu, 2 Apr 2020 14:49:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v8 6/7] tools/perf: Enable Hz/hz prinitg for
 --metric-only option
Message-ID: <20200402124946.GH2518490@krava>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
 <20200401203340.31402-7-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401203340.31402-7-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:03:39AM +0530, Kajol Jain wrote:
> Commit 54b5091606c18 ("perf stat: Implement --metric-only mode")
> added function 'valid_only_metric()' which drops "Hz" or "hz",
> if it is part of "ScaleUnit". This patch enable it since hv_24x7
> supports couple of frequency events.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/util/stat-display.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 9e757d18d713..679aaa655824 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -237,8 +237,6 @@ static bool valid_only_metric(const char *unit)
>  	if (!unit)
>  		return false;
>  	if (strstr(unit, "/sec") ||
> -	    strstr(unit, "hz") ||
> -	    strstr(unit, "Hz") ||

will this change output of --metric-only for some setups then?

Andi, are you ok with this?

other than this, the patchset looks ok to me

thanks,
jirka

>  	    strstr(unit, "CPUs utilized"))
>  		return false;
>  	return true;
> -- 
> 2.21.0
> 

