Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73956C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4612720801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8RD+f7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgBQQSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:18:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgBQQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DFUB5V81zRaDC7ZmoCE9+/0gTABeogaVMtnx4Pt5r14=; b=O8RD+f7rxUCCVFMYS+dEa/lNex
        TUvJYWUtzT48kVTNZnhD6W7RNxZMc1ZfOTmJx8WEpcgAn5WJI9FZB4zHUnI/zgHbxlKE4pLulGabp
        hUdUABxC6EDxKANtOljn47hPJro1p9IjyBpQj4jV3s7NDstGSojy8eZ0Zlaa4ungViuLzOq9IZkm+
        7YxS+ENkRHTh1EVslfDsmfnH/e5sbHq1+KefrW7kXe4UsOOEvWwNstx2IcOh0M2Dnd6rVf82tT/YO
        JI5YjjQ8w64wCE7lF0m/l5lZ6ZcZ2BGHIfYqeVLvP2ug48BTTVqHuq2SK9bUmk6jmEkfdZxct6vJd
        eNeDoibQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j62-0002hw-D6; Mon, 17 Feb 2020 16:18:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 576D8300565;
        Mon, 17 Feb 2020 17:16:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5ACF2B910515; Mon, 17 Feb 2020 17:18:06 +0100 (CET)
Date:   Mon, 17 Feb 2020 17:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 0/6] Optimize cgroup context switch
Message-ID: <20200217161806.GN14879@hirez.programming.kicks-ass.net>
References: <20191206231539.227585-1-irogers@google.com>
 <20200214075133.181299-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Please don't thread to the last series; I only found this by accident
because I was looking at an email Kan referenced.

Now I have to go find how to break threading in Mutt again :/
