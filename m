Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AE62080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598446566;
	bh=Qohh7KnymuEQHzs/9CF3j1KPAQ9eiI6pLEUhx2D4F8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w4gFFb+PrDGZicJL+EuA7J3bLe7qJa/fgJ7MBgMoaPdAXImEQYk8vTR7C/FHKV9qn
	 vm8/WeDKmeAQ63eNIdQcqJk8wZE3JaeFi4EKdR3ye1c+W+aTaO4qItmQZYnwbuVWgQ
	 oIpncQyo/0JLCWb+eJgrlSE4KtluYK+5ygA7UDb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgHZM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbgHZM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:56:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941732080C;
        Wed, 26 Aug 2020 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598446560;
        bh=Qohh7KnymuEQHzs/9CF3j1KPAQ9eiI6pLEUhx2D4F8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXPjdni7ZqKiERVzh859zCQgN69UbqLuw2vWbSSI/tpgU00/e86IxJ57n0NUhgttt
         thKMQC2fgCX05QUVPSXKT9MUHBLFKgKOQF2rtBcaKaHqbzXkf+GTES6L+veErpJnlH
         g8udzzQYcYV1UMfDwpVhGwqXymX9zZaW7ipaaSrQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5104040D3D; Wed, 26 Aug 2020 09:55:57 -0300 (-03)
Date:   Wed, 26 Aug 2020 09:55:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf test: Perf test 67 dumps core on s390
Message-ID: <20200826125557.GD1059382@kernel.org>
References: <20200825071211.16959-1-tmricht@linux.ibm.com>
 <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 25, 2020 at 02:04:30PM -0700, Ian Rogers escreveu:
> On Tue, Aug 25, 2020 at 12:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > Linux 5.9 introduced perf test case "Parse and process metrics" and
> > on s390 this test case always dumps core:

<SNIP>

> Acked-by: Ian Rogers <irogers@google.com>
> 
> This also shows up with address sanitizer on all architectures
> (perhaps change the patch title) and perhaps add a "Fixes: <commit>"
> tag.

$ git tag --contains 0a507af9c681ac2adedc5fe1b2d534e27be85446
perf-tools-2020-08-10
perf-tools-2020-08-14
perf-tools-tests-2020-07-02
perf-tools-tests-2020-07-17
perf-tools-tests-2020-08-05
perf-tools-tests-2020-08-06
v5.9-rc1
v5.9-rc2
$


I added this:

Fixes: 0a507af9c681ac2a ("perf tests: Add parse metric test for ipc metric")

As Jiri forgot to add that sentinel when he first introduced this
pmu_event table, iterators depend on the .name to be NULL to stop.

And added Jiri to the CC, as well as Namhyung Kim, as they are listed in
MAINTAINERS as reviewers for perf:

PERFORMANCE EVENTS SUBSYSTEM
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>

And help me with reviewing all this, thanks,

- Arnaldo
