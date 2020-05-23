Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F61C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E3120870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbgEWRpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:45:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:3490 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbgEWRpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:45:09 -0400
IronPort-SDR: XAaqXMBX43/A5PfxKwGo1spHIIsnCa3oh7ExIzFSBuknJnxoaJX7GsEFU+IceAQ5tYvoP9AsZz
 8dpCHLz2vZ6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2020 06:34:57 -0700
IronPort-SDR: IO3jCsmfjnhxYNdxnhnpaydv5y3Fg8fUowsRYODGTa5f12cF47kAxzUI6WYkPrsHLhUKKNoLuZ
 pMI+bmp6XrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,425,1583222400"; 
   d="scan'208";a="413035856"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 23 May 2020 06:34:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C0C96301A90; Sat, 23 May 2020 06:34:56 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Anand K Mistry <amistry@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf record: Use an eventfd to wakeup when done
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
        <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Date:   Sat, 23 May 2020 06:34:56 -0700
In-Reply-To: <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
        (Anand K. Mistry's message of "Wed, 13 May 2020 12:20:23 +1000")
Message-ID: <87a71y93lr.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anand K Mistry <amistry@google.com> writes:
>  	}
>  
> +	done_fd = eventfd(0, EFD_NONBLOCK);

This will make perf depend on a recent glibc or other library
that implements eventfd. Wouldn't surprise me if some kind
of build time check is needed for this to pass all of Arnaldo's
built tests.


-Andi
