Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD65C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09D02078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980826;
	bh=XDtrRJ4dCKFTtxrT4PYqUk/dD8gYaN6Q7gWe70dEA0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RHd3IGc5UCPz/jrnYAtGYwwzNsj5Pg1CtiDby+srXvNeWfVC3azlhpHPh2A9nUF0z
	 /HP+6JTFhcPPyDwMOqAhQ3KEHle94rWkDwGUpTpHCLaGj3pXSAVHlxTXt05OYPJC9C
	 SflGVhLXayevQJYaFQmsv7vW85ebdGuvWk+6M+ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgIARUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgIAPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:13:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E0D208CA;
        Tue,  1 Sep 2020 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973179;
        bh=XDtrRJ4dCKFTtxrT4PYqUk/dD8gYaN6Q7gWe70dEA0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7yvfEi+kBwJW2cwGcPlCFkeO3GtWq5ZTF8uxZ2YhYhAdwZkjAfurkxxXR7t2kEQS
         BoGjUB2Za4Uhu5gyeJhhN6CWYq8kU9N1MPl8ht2PpAAwolk20Mso8ATx/fHePMI36P
         uLtGvWBzrtlvxdSYaEM+ODIf5WxI1eJ8o9paNHmk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E71A40D3D; Tue,  1 Sep 2020 12:12:57 -0300 (-03)
Date:   Tue, 1 Sep 2020 12:12:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf tools: Disable ordered_events for report raw
 dump
Message-ID: <20200901151257.GC1424523@kernel.org>
References: <20200827134830.126721-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827134830.126721-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 27, 2020 at 03:48:29PM +0200, Jiri Olsa escreveu:
> Disable ordered_events for report raw dump, because
> for raw dump we want to see events as they are stored
> in the perf.data file, not sorted by time.

Applied to perf/urgent,

Thanks,

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-report.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index ece1cddfcd7c..3c74c9c0f3c3 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1332,6 +1332,9 @@ int cmd_report(int argc, const char **argv)
>  	if (report.mmaps_mode)
>  		report.tasks_mode = true;
>  
> +	if (dump_trace)
> +		report.tool.ordered_events = false;
> +
>  	if (quiet)
>  		perf_quiet_option();
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
