Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5615C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FADB20884
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592487005;
	bh=WaYgBZaJqu7hn1fWtwnsUeQaFB0XHj77UgqJjlHIrbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PwPrSrKps3dvwFq4vVk+u3P+Q7pI+GZxW3pokEcfEhkia7lSvPqIeNjrXEZ5fnEg2
	 SD9FroOUqoyOT4sJSwud1My431ubrIcbqwbNSjpg+SQRodX+pHUiWeVCTLnLIWV/Ms
	 DFJtZxceIWjB5sIeo5tmo4bh+8oo5VxwVXlmSeJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgFRN37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgFRN36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:29:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686DA2083B;
        Thu, 18 Jun 2020 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592486998;
        bh=WaYgBZaJqu7hn1fWtwnsUeQaFB0XHj77UgqJjlHIrbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJYhtXYE1qfEQR+EANdrGw14k2DYDo/Hbl8UEMB9L0K3qOJUVlMfDCIfG2Lw/yrtb
         Q0yrV4WGBk1rCoAFMkdYx0USc2lN8sKh67tEk6agQLTvGukLEa6pb9RwE38REl3+oB
         Ij6ghKmL5XZ1xmVyZaKEuDF6X3bf5ZArnayhK3yM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73450405FF; Thu, 18 Jun 2020 10:29:56 -0300 (-03)
Date:   Thu, 18 Jun 2020 10:29:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4] perf tools: Check libasan and libubsan in
 Makefile.config
Message-ID: <20200618132956.GB26403@kernel.org>
References: <1592445961-28044-1-git-send-email-yangtiezhu@loongson.cn>
 <20200618125746.GD2369163@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618125746.GD2369163@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 18, 2020 at 02:57:46PM +0200, Jiri Olsa escreveu:
> On Thu, Jun 18, 2020 at 10:06:01AM +0800, Tiezhu Yang wrote:
> > When build perf with ASan or UBSan, if libasan or libubsan can not find,
> > the feature-glibc is 0 and there exists the following error log which is
> > wrong, because we can find gnu/libc-version.h in /usr/include, glibc-devel
> > is also installed.
> > 
> > [yangtiezhu@linux perf]$ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'

<SNIP>

> > After install libasan and libubsan, the feature-glibc is 1 and the build
> > process is success, so the cause is related with libasan or libubsan, we
> > should check them and print an error log to reflect the reality.
 
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> > 
> > v2:
> >   - Check libasan and libubsan in tools/build/Makefile.feature
> >   - Modify the patch subject
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Applied after changing the subject to:

[PATCH] perf build: Fix error message when asking for -fsanitize=address without required libraries

Will test now.

- Arnaldo
