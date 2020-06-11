Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CFC20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591882888;
	bh=dwsh5Cvyoqe9Dzjok1OJ6LyY169lE50rTvCoXelm20w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2R1ymr5yiMDzFvuIemGqzerr6qjbvXDpJpFeFjzQMVKqiKFqoGF4QDQvJH2IefYB9
	 bVB31kJBJj1nwnU1kVe1wu89cAVMbK+u+0Cji6R3bBRDn/KD9ZitAOiAW5hnJSu9Wl
	 9dlyf5auR6GcRP6Si2J+VoqWNBDQE1hyxOTeZ0eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFKNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFKNlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:41:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA47620760;
        Thu, 11 Jun 2020 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591882884;
        bh=dwsh5Cvyoqe9Dzjok1OJ6LyY169lE50rTvCoXelm20w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdnI3ZGKvzbksW8i5iA0Tbiy+Sik6IgWLNTW/oAKYmTsz+1bOGdOQTqiJn+4GOiQl
         JTzSFdrFMHKtgrzx3xheWUkpq/CwT6/kano1mb1GsTkMInYAJHZo3V4Wo/O/Y5Yadb
         YKUQS+ctfmB5E/N72nomZ8GllSV6JWi9KVKU1R8A=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 117C040AFD; Thu, 11 Jun 2020 10:41:22 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:41:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 00/10] perf parse-events: enable more flex/bison warnings
Message-ID: <20200611134122.GF18482@kernel.org>
References: <20200610215100.256599-1-irogers@google.com>
 <20200611090249.GC1786122@krava>
 <20200611130758.GA18482@kernel.org>
 <20200611133854.GD18482@kernel.org>
 <20200611134038.GE18482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611134038.GE18482@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 10:40:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> 
> debian:10 is going well so far, some of the builds passed

  25 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)

