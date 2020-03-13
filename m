Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1474FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FC4206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtOrXJov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCMSoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:44:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45715 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCMSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:44:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so14261300qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPfbnwPH5IIVEOK88WBUxnAB4zCTEMfYQ9J7La1tTbg=;
        b=mtOrXJovZrulNgcrS4RDduTA92bcwQ6EoHZd6HDhPnx24yD/61b7M1ibRqIANW/y98
         XxwbzvddEAuSEyZx1omYEpzvOQtzSPrvjFkmlD27cZLqiEb1GQ0E9Jsqo8Nqs7q1RwOC
         i4WPxYp2+NcMlA8MTFJx5ONtA/lwQSZTUEW8HbPG7iCMXsX4wT66wfzlDvIPQNJF857i
         3yH0KbHXRmcbP5+fPypmoyjaeKeRA9viJ7icNoAiSN7h0xcmg4aam/Zb+88ooJiy1AT/
         X6pJ4/wFQ6R5jngST5qNDBpcgRXVfo+A5qxyM5JiUCsHa4Xbsjw+6Woj2t6Za+ew7i5Q
         GJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPfbnwPH5IIVEOK88WBUxnAB4zCTEMfYQ9J7La1tTbg=;
        b=cPOEKX9fiFvKTIgWqPIhnF+PI5kPy/Ggd7spWMbZCZsiyBVmBR/Hb3F/K7hkbB36sh
         0OSfKIIg46dvCy7OBSkrYKck3kUeA+QmQeTIz9mq59elWIVOd4T/CR5sjLdSpXLoOI3B
         ACuSaquejpPfXB+W+ebvp1VaX2oDArn5TisLMpOPh6YGmU9T8clPOsItC6bRL9omGj3b
         7OdzoBnkrbAuyMheebrFUqm1J+dbF5ja3GEMsU4oOAzPCFJ2X8ol5t1k5eNj/fKsMvYI
         v1qszNWJmuYAL0JMitsvTuljH1TbgY2Kp+9FZUNsp1BZ3Jtl2logCX4RPt1DoqiP3GMA
         B5Pg==
X-Gm-Message-State: ANhLgQ3ZM5+nRfN+CLdxB7aL0NiaqIAIjChcFAu6mWk8BSEZmIN6k+if
        G0s1xiNQIl0cG3Ynp6EB6/Q=
X-Google-Smtp-Source: ADFU+vvbtdaupUA9yHFv1Qeq5VYbIquKYc8X+239uzvfBJfJtwef4zNq1Fl/NZK9tm9+9dDmCa5orA==
X-Received: by 2002:a37:a08b:: with SMTP id j133mr15266505qke.265.1584125044222;
        Fri, 13 Mar 2020 11:44:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id v19sm14731793qtb.67.2020.03.13.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:44:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3649440009; Fri, 13 Mar 2020 15:44:00 -0300 (-03)
Date:   Fri, 13 Mar 2020 15:44:00 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: print if shell directory isn't present
Message-ID: <20200313184400.GA9917@kernel.org>
References: <20200313005602.45236-1-irogers@google.com>
 <20200313093734.GB389625@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313093734.GB389625@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 10:37:34AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 12, 2020 at 05:56:02PM -0700, Ian Rogers wrote:
> > If the shell test directory isn't present the exit code will be 255 but
> > with no error messages printed. Add an error message.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/tests/builtin-test.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 5f05db75cdd8..54d9516c9839 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -543,8 +543,11 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
> >  		return -1;
> >  
> >  	dir = opendir(st.dir);
> > -	if (!dir)
> > +	if (!dir) {
> > +		pr_err("failed to open shell test directory: %s\n",
> > +			st.dir);
> >  		return -1;
> > +	}
> >  
> >  	for_each_shell_test(dir, st.dir, ent) {
> >  		int curr = i++;
> > -- 
> > 2.25.1.481.gfbce0eb801-goog
> > 
> 

-- 

- Arnaldo
