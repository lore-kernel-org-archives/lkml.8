Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD05C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B079217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599513934;
	bh=RTavEjSkrxeijJfKGHo4c96d6R3BDjCdWO5/Wq/K5/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QKvCLtRJ1+Y0WbTFuauRWifUSi+bmyLLiRKTukvf85NxQd7FvYr4/NowynZLiUdyk
	 8yBdnrDAlf0Ijf37R/XzX+zlfZE2m0crNB9wp/z3wXIr0Tthy/Ku9EqaT8WehqdzWF
	 kC18jS9TUKRjnTA9q6BBpFDW4Otsl80wamXGO7i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIGVZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgIGVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:25:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF8821919;
        Mon,  7 Sep 2020 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599513928;
        bh=RTavEjSkrxeijJfKGHo4c96d6R3BDjCdWO5/Wq/K5/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bN89ZMsMR6tDr348wW4Fn4C+HapYAbXreD8EBEseZ2oxdKgkH1iv9SvAo7ZWZefSj
         kuynvjbe91e9JI09aXROw9uGwN6iaphtWKBgdRUVHkT+pFwabK8y4qBL9eGkKH1ZFH
         57F8PHQDvb8ufU67mczyfrScBDkJ0ukeOn5iSx6A=
Date:   Mon, 7 Sep 2020 22:25:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] compiler-gcc: improve version error
Message-ID: <20200907212522.GB13815@willie-the-truck>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-8-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902225911.209899-8-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:59:11PM -0700, Nick Desaulniers wrote:
> As Kees suggests, doing so provides developers with two useful pieces of
> information:

I struggle to parse this. "doing so" what? These things are supposed to
be in the imperative.

Will
