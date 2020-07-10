Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F473C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153322077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594384641;
	bh=kGJSTjLX0V52wppHj+UqmzpCnQZBkGJku76RlUsl9IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=06eyFSaY6EWLEVpxY5zmXee2AFVtWHXEWSLSUqGf4glZEvItV+Tk1JphwPM2dwb8f
	 XomN09VqoMT30VkItM5/AACNYP79FxGV9oUrgtSMSGH5DG4KZ1sJSffJVuDNjhDGml
	 iYQQCr2xlgn3FAS6bmRip+cPeaXcBN5jVqG/p+Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGJMhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJMhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:37:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.179.81.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C621720772;
        Fri, 10 Jul 2020 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384637;
        bh=kGJSTjLX0V52wppHj+UqmzpCnQZBkGJku76RlUsl9IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXxIu8yfnGBbvXH1IjXDI5x8qklJlWhqn7QbYvHbyfR1s5D+HmnYDNuO0dKitIgX7
         PY1uKxWMqwOf/sikSyaNFOgbIcW/pX+lMw/CQQ6EwXMZhWEykazbwtKML+GDfPUmGf
         jyMhiAMoXsz87nauJQZze1mZn+WzxUymM8sLxOmI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37AF1405FF; Fri, 10 Jul 2020 09:37:14 -0300 (-03)
Date:   Fri, 10 Jul 2020 09:37:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: report bpf errors
Message-ID: <20200710123714.GD22500@kernel.org>
References: <20200707211449.3868944-1-irogers@google.com>
 <20200708184732.GC3581918@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708184732.GC3581918@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 08, 2020 at 08:47:32PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 07, 2020 at 02:14:49PM -0700, Ian Rogers wrote:
> > Setting the parse_events_error directly doesn't increment num_errors
> > causing the error message not to be displayed. Use the
> > parse_events__handle_error function that sets num_errors and handle
> > multiple errors.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> looks good
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
