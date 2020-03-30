Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9244FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4D720732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ5RG68A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgC3P0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:26:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34289 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3P0n (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:26:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so19372531qke.1
        for <Linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lD5y6sXydqp5IeSLcGH43kX5bMZsJtkhuJ0lGTQcRgc=;
        b=OJ5RG68ASlfedc4CNwGFjDZC14/KWA84wRYlpsx56fUnLDSgMlEAQx9bpTY6ewwKBF
         ZeiqKyfAvKPVMvvuOoQTL4yWmLUFayJS1FV9U8oyEmI5ZEtJWLglcjeFVux5UZEJyvwr
         WxRZdgsYuaXuXJW46SlczRcSWr0yF/Dn+vHJfzpu8I1Ga0K7DXTRMJu6O9fZ34Pue94w
         hexNVnUMB3Gwbe1jGe0IlSHa99d6NZYDxYdDEO6ZVj4c8zP7X1nmzJlFiqaeidtiVaOe
         J4Pio/ISU8PWdgrEDLEqoDNJ6JQreHweXvx2B+lvfG7g/rS4/k9MMLKg5eTtb9CwYoTE
         kAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lD5y6sXydqp5IeSLcGH43kX5bMZsJtkhuJ0lGTQcRgc=;
        b=YQ5YzC023Iqp4dzhERtoTfzD+cDToLr6Zubh1iER/g3QeockDJchcPNJZhizJOCJgl
         RHmUeDo6ethesa6h9oXMlduzh+qEz/lc9aw3yEl4ugVP3URBhTHkn52yhMhP4ConpMk7
         WAEdABSPK1fTI7pGzNXNv6I6GFD00RQFbTXO3MIhuzCEPLkGMVwKEkEVK0Sy/LLE4fyZ
         zihAczlZ4PN8PvcN/BslBW1lOQN1lj6A9NFi9jWJO7VklWsS0StyL1sdgZ7dWctMTpcp
         KcIGSrwlD3VN9GnNMeOXN6D+b1AFY+vsx+7a1JV87yxuKfWQkV5eWGWN36xy8T6A/Qh6
         585w==
X-Gm-Message-State: ANhLgQ1MfcVaj7aEUwnmTDZIpHUT0Sph00Zz/bROXmpexo7a58EtidcN
        kNT1jXMuSckLLbNhFXuohR4=
X-Google-Smtp-Source: ADFU+vsxoNcaipx8TSpx7ocvvgKpA98t7mcGVRKg6/EswociawEOAtrQwfYb9xwA3Lx3ZwSmn83Zzg==
X-Received: by 2002:ae9:efc8:: with SMTP id d191mr473772qkg.1.1585582002088;
        Mon, 30 Mar 2020 08:26:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u15sm11892499qte.91.2020.03.30.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:26:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8710A409A3; Mon, 30 Mar 2020 12:26:38 -0300 (-03)
Date:   Mon, 30 Mar 2020 12:26:38 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/2] perf top: support hotkey to change sort order
Message-ID: <20200330152638.GA4576@kernel.org>
References: <20200324220711.6025-1-yao.jin@linux.intel.com>
 <20200324220711.6025-2-yao.jin@linux.intel.com>
 <846be020-3f3e-55a4-2177-d77a3b63777a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846be020-3f3e-55a4-2177-d77a3b63777a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 30, 2020 at 08:43:47AM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> The v2 patch zeros the history when pressing the hotkey. Is it OK?

Yeah, I've applied it to my perf/core branch.

Thanks,

- Arnaldo
 
> Thanks
> Jin Yao
> 
> On 3/25/2020 6:07 AM, Jin Yao wrote:
> > It would be nice if we can use a hotkey in perf top browser to
> > select a event for sorting.
> > 
> > For example,
> > perf top --group -e cycles,instructions,cache-misses
> > 
> > Samples
> >                  Overhead  Shared Object             Symbol
> >    40.03%  45.71%   0.03%  div                       [.] main
> >    20.46%  14.67%   0.21%  libc-2.27.so              [.] __random_r
> >    20.01%  19.54%   0.02%  libc-2.27.so              [.] __random
> >     9.68%  10.68%   0.00%  div                       [.] compute_flag
> >     4.32%   4.70%   0.00%  libc-2.27.so              [.] rand
> >     3.84%   3.43%   0.00%  div                       [.] rand@plt
> >     0.05%   0.05%   2.33%  libc-2.27.so              [.] __strcmp_sse2_unaligned
> >     0.04%   0.08%   2.43%  perf                      [.] perf_hpp__is_dynamic_en
> >     0.04%   0.02%   6.64%  perf                      [.] rb_next
> >     0.04%   0.01%   3.87%  perf                      [.] dso__find_symbol
> >     0.04%   0.04%   1.77%  perf                      [.] sort__dso_cmp
> > 
> > When user press hotkey '2' (event index, starting from 0), it indicates
> > to sort output by the third event in group (cache-misses).
> > 
> > Samples
> >                  Overhead  Shared Object               Symbol
> >     4.07%   1.28%   6.68%  perf                        [.] rb_next
> >     3.57%   3.98%   4.11%  perf                        [.] __hists__insert_output
> >     3.67%  11.24%   3.60%  perf                        [.] perf_hpp__is_dynamic_e
> >     3.67%   3.20%   3.20%  perf                        [.] hpp__sort_overhead
> >     0.81%   0.06%   3.01%  perf                        [.] dso__find_symbol
> >     1.62%   5.47%   2.51%  perf                        [.] hists__match
> >     2.70%   1.86%   2.47%  libc-2.27.so                [.] _int_malloc
> >     0.19%   0.00%   2.29%  [kernel]                    [k] copy_page
> >     0.41%   0.32%   1.98%  perf                        [.] hists__decay_entries
> >     1.84%   3.67%   1.68%  perf                        [.] sort__dso_cmp
> >     0.16%   0.00%   1.63%  [kernel]                    [k] clear_page_erms
> > 
> > Now the output is sorted by cache-misses.
> > 
> >   v2:
> >   ---
> >   Zero the history if hotkey is pressed.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/builtin-top.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 494c7b9a1022..29ddae7e1805 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -616,6 +616,7 @@ static void *display_thread_tui(void *arg)
> >   		.arg		= top,
> >   		.refresh	= top->delay_secs,
> >   	};
> > +	int ret;
> >   	/* In order to read symbols from other namespaces perf to  needs to call
> >   	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
> > @@ -626,6 +627,7 @@ static void *display_thread_tui(void *arg)
> >   	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
> > +repeat:
> >   	perf_top__sort_new_samples(top);
> >   	/*
> > @@ -638,13 +640,18 @@ static void *display_thread_tui(void *arg)
> >   		hists->uid_filter_str = top->record_opts.target.uid_str;
> >   	}
> > -	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
> > +	ret = perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
> >   				      top->min_percent,
> >   				      &top->session->header.env,
> >   				      !top->record_opts.overwrite,
> >   				      &top->annotation_opts);
> > -	stop_top();
> > +	if (ret == K_RELOAD) {
> > +		top->zero = true;
> > +		goto repeat;
> > +	} else
> > +		stop_top();
> > +
> >   	return NULL;
> >   }
> > 

-- 

- Arnaldo
