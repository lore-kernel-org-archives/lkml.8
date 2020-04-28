Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF2EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76117206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbbo3XzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgD1SFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgD1SFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:05:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F73C03C1AB;
        Tue, 28 Apr 2020 11:05:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb4so10847744qvb.7;
        Tue, 28 Apr 2020 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tzoFlkrR/l1xCBMtThKt5cZ8Qt23wbNMT2mP4+yp+Bg=;
        b=Hbbo3XzLGb1h0Despxw961JiHLQIzEnDYiWMw0BmTrqGe8WMBXhXpAm2DeMM3A4aaO
         eaHuyBvgiM/644W5DbnT24Pd3gh94EdRZV0hnef7BKtTh0gujG8OOrpS3rvDqndqOYsy
         FYZ28vHnLvmjwnQt4CSNrTQVvHxVxvQ64YPuOVOLOVuDU8wi6kUyIbcK6PZIZSfnc368
         fs+ayUjMfQ30ivz+g7r1+6f6rhQpzbSS9whCdoc+J/67A5Hr6HlV/OK6eOyvoqEJlCoY
         slMIT6NGnt/sk2I0kfr4988GLjnDwkPW8L2RDuU3GCrEKzvVKbGLDNLJVsM6FgzQ70XL
         8UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tzoFlkrR/l1xCBMtThKt5cZ8Qt23wbNMT2mP4+yp+Bg=;
        b=RTl4HnMdNPB72MK8TH7d0E+nQDaap6O9adNzjc2uB9RKkdQvtz+CUt1wWtNBG+AN1V
         pLd0SGUdIfGqs+RJOlm3jevbfkhMyFkKWu23tAiv0dUDsaowKT/eDkPoPH9pIkEeR3Br
         O7XaP8O48FDzIhmI5kvzFAvtlzP1OG2unCpnECXfXkpB4OAlSATUJQ3EFso7Gd5Igp5l
         RtV+I85BkalhYEd7JkDFGeFoX+NdlsBH1kJg38Ly09OJZAJY4nhP3S9P3SjV61VIhog0
         wEq2xhytMA0SIRmDHGRKX91L5ufBYPdTIcS2B/zubQEESD6PEbtyD7eVXHGwE3xr4EFk
         L4IA==
X-Gm-Message-State: AGi0PuaBffm0J4NQMQ4rKHCcjSnRqYfM0lJqeFVqppOAXU3EAkjTRa07
        5lAQutCLs3wq3GJZeQHCvnk=
X-Google-Smtp-Source: APiQypKjGkTUb0O1/KI0xE3naF3CD2bOSN66RQDRR6+iq1I3+vc8bug/PW+WWXnqel21G90z/Mz4Rw==
X-Received: by 2002:ad4:49d3:: with SMTP id j19mr28093810qvy.78.1588097122620;
        Tue, 28 Apr 2020 11:05:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n92sm13936615qtd.68.2020.04.28.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:05:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF93D409A3; Tue, 28 Apr 2020 15:05:18 -0300 (-03)
Date:   Tue, 28 Apr 2020 15:05:18 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 7/7] perf record: Introduce --switch-output-event
Message-ID: <20200428180518.GF5460@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
 <20200428094839.GD1476763@krava>
 <20200428121601.GB2245@kernel.org>
 <20200428132257.GH1476763@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132257.GH1476763@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 28, 2020 at 03:22:57PM +0200, Jiri Olsa escreveu:
> On Tue, Apr 28, 2020 at 09:16:01AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > > +				pr_err("Couldn't create side band evlist.\n.");
> > > > +				goto out_child;
> > > > +			}
> > > >  		}

> > > >  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {

> > > it's getting bigger, I wonder we should put all the sb_* setup in
> > > separated functions like sb_start/sb_stop

> > Well, the rec->thread_id = pthread_self(); part is just for reusing a
> > 'perf record' specific mechanism, what to do when the event appears in
> > the side band thread ring buffer, the evlist__set_cb() also is related
> > to that, moving thread_id to evlist seems too much at this time.

> hum, I meant record specific static functions sb_start/sb_stop,
> not inside evlist.. just to have it separated

Ok, so I have the patch below on top of that series, and its all
available in my perf/switch-output-event, that is on top of more patches
collected today, all going well, this perf/switch-output-event will turn
into perf/core ang go upstream soon, then I have to loo at Adrian's
kernel+tooling patchkit,

- Arnaldo

commit a25516b4db23ba8f956b990d37ec6728e5221718
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Apr 28 14:58:29 2020 -0300

    perf record: Move side band evlist setup to separate routine
    
    It is quite big by now, move that code to a separate
    record__setup_sb_evlist() routine.
    
    Suggested-by: Jiri Olsa <jolsa@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Song Liu <songliubraving@fb.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7a6a89972691..bb3d30616bf3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1445,6 +1445,44 @@ static int record__process_signal_event(union perf_event *event __maybe_unused,
 	return 0;
 }
 
+static int record__setup_sb_evlist(struct record *rec)
+{
+	struct record_opts *opts = &rec->opts;
+
+	if (rec->sb_evlist != NULL) {
+		/*
+		 * We get here if --switch-output-event populated the
+		 * sb_evlist, so associate a callback that will send a SIGUSR2
+		 * to the main thread.
+		 */
+		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
+		rec->thread_id = pthread_self();
+	}
+
+	if (!opts->no_bpf_event) {
+		if (rec->sb_evlist == NULL) {
+			rec->sb_evlist = evlist__new();
+
+			if (rec->sb_evlist == NULL) {
+				pr_err("Couldn't create side band evlist.\n.");
+				return -1;
+			}
+		}
+
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			return -1;
+		}
+	}
+
+	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1589,36 +1627,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (rec->sb_evlist != NULL) {
-		/*
-		 * We get here if --switch-output-event populated the
-		 * sb_evlist, so associate a callback that will send a SIGUSR2
-		 * to the main thread.
-		 */
-		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
-		rec->thread_id = pthread_self();
-	}
-
-	if (!opts->no_bpf_event) {
-		if (rec->sb_evlist == NULL) {
-			rec->sb_evlist = evlist__new();
-
-			if (rec->sb_evlist == NULL) {
-				pr_err("Couldn't create side band evlist.\n.");
-				goto out_child;
-			}
-		}
-
-		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
-			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
-			goto out_child;
-		}
-	}
-
-	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
-		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
-		opts->no_bpf_event = true;
-	}
+	err = record__setup_sb_evlist(rec);
+	if (err)
+		goto out_child;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
