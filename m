Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764522077E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTB4MhSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCRSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:45:40 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39385 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSpj (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:45:39 -0400
Received: by mail-qv1-f67.google.com with SMTP id v38so9466677qvf.6
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5D/2pRx5TAliHZwQpFNzLx6PYHuT4zVWZ5tV6Tg1OdM=;
        b=UTB4MhSJ+M26WihZftneOeMQd7YzP1nEYEmuQruTjL6M/1V0DL6zjrnFchAo+S9WPQ
         21dQvW2JTBfjcIIx7qfJWFmaEwOJNDAhT8v2iWX20q9idCP4w9Tcp+DCT7osviDZW6qH
         AKzYK7gWOWZuUnZ01VTaXiGVtv7vkDkAc+k5fCv/iu1lM4WfcycflZ+3/5E85VK8Ao0P
         V66elJ0YtcRscS6MwsvAkaVAIE04KZ4rWVxDJPM2c7vx7aM81xsQAUQJpN0tVqX1Y/4I
         Gpx2b1uhSwMQqPxhyd+YQj41fh41KoRLGHY0BPSMnss/mQczBZeUuzo4oUyQ4b1uCsng
         JuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5D/2pRx5TAliHZwQpFNzLx6PYHuT4zVWZ5tV6Tg1OdM=;
        b=gHBBPETCoduYay4QULHRN7eYVhi4kaUeFFke7Q9iTyqlRmyRDdHBqQY9N3MhKY7xHg
         5fR7epa3twMGKEsAgT43CFrXTrhm/pRR4OWxWfW9/JOMuUfojh0vteLbcyN3a1+ZynhJ
         tzJykRAu8GtS+aEqvvM7UKN0H1dprPDzcd9Kr0Vz6/m9z118AZag53IXijqUnGrjB2Tt
         AbDeBbMNGUZ0ZFFrRKvQPqxI0rJLe2ZdAy2DX3I8AQs0iXBNJ8c2xfBaDW/1FlGlZ6VD
         2cWnldo9NqpvtT4UwdTOEFkbxKLBkykJlmChBphahIudFvP3uIuIPwzHvjgSSbbekqfI
         Dqpw==
X-Gm-Message-State: ANhLgQ1Is5/PjaBNijx5iNZHzDYTayl2UI6tsL68gwIvWxegVyG/vmA9
        ELm/EXpyu+JSX1S7eePu4BM=
X-Google-Smtp-Source: ADFU+vvPgR2rR/lEAOMCbZlAcHBAkJU5ZffG2ath4tO05j2aNd5MNbiQlrhBEQpg6SIDHicoldPzbQ==
X-Received: by 2002:a0c:e88d:: with SMTP id b13mr5917279qvo.219.1584557138488;
        Wed, 18 Mar 2020 11:45:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p23sm4552928qkm.39.2020.03.18.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:45:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63CC3404E4; Wed, 18 Mar 2020 15:45:35 -0300 (-03)
Date:   Wed, 18 Mar 2020 15:45:35 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20200318184535.GK11531@kernel.org>
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200220013616.19916-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220013616.19916-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 20, 2020 at 09:36:14AM +0800, Jin Yao escreveu:
> When performing "perf report --group", it shows the event group information
> together. By default, the output is sorted by the first event in group.
> 
> It would be nice for user to select any event for sorting. This patch
> introduces a new option "--group-sort-idx" to sort the output by the
> event at the index n in event group.
> 
> For example,
> 
> Before:

Tested and applied, I also did the following simplifications, to try and
follow naming conventions and use less lines to do the same thing:

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 35224b366305..025f4c7f96bf 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -151,44 +151,35 @@ static int field_cmp(u64 field_a, u64 field_b)
 	return 0;
 }
 
-static int pair_fields_alloc(struct hist_entry *a, struct hist_entry *b,
-			     hpp_field_fn get_field, int nr_members,
-			     u64 **fields_a, u64 **fields_b)
+static int hist_entry__new_pair(struct hist_entry *a, struct hist_entry *b,
+				hpp_field_fn get_field, int nr_members,
+				u64 **fields_a, u64 **fields_b)
 {
-	struct evsel *evsel;
+	u64 *fa = calloc(nr_members, sizeof(*fa)),
+	    *fb = calloc(nr_members, sizeof(*fb));
 	struct hist_entry *pair;
-	u64 *fa, *fb;
-	int ret = -1;
-
-	fa = calloc(nr_members, sizeof(*fa));
-	fb = calloc(nr_members, sizeof(*fb));
 
 	if (!fa || !fb)
-		goto out;
+		goto out_free;
 
 	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
+		struct evsel *evsel = hists_to_evsel(pair->hists);
 		fa[perf_evsel__group_idx(evsel)] = get_field(pair);
 	}
 
 	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
+		struct evsel *evsel = hists_to_evsel(pair->hists);
 		fb[perf_evsel__group_idx(evsel)] = get_field(pair);
 	}
 
 	*fields_a = fa;
 	*fields_b = fb;
-	ret = 0;
-
-out:
-	if (ret != 0) {
-		free(fa);
-		free(fb);
-		*fields_a = NULL;
-		*fields_b = NULL;
-	}
-
-	return ret;
+	return 0;
+out_free:
+	free(fa);
+	free(fb);
+	*fields_a = *fields_b = NULL;
+	return -1;
 }
 
 static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
@@ -206,8 +197,7 @@ static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
 	if (idx < 1 || idx >= nr_members)
 		return cmp;
 
-	ret = pair_fields_alloc(a, b, get_field, nr_members,
-				&fields_a, &fields_b);
+	ret = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
 	if (ret) {
 		ret = cmp;
 		goto out;
@@ -254,8 +244,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return ret;
 
 	nr_members = evsel->core.nr_members;
-	i = pair_fields_alloc(a, b, get_field, nr_members,
-			      &fields_a, &fields_b);
+	i = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
 	if (i)
 		goto out;
 
