Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A832C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD7E20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597409945;
	bh=uCL4x9xTPvVEHKN35nipD9lH7F/vIt/ze5bD2j/N9GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KiktrbGAwoIGSPo1BlGhyJFoz0KiGPHdkGXw7C9DR5xZhH8TxPNo08BwZDuGuQUGh
	 V9Tegep6a5+aGIsBSzfZD7/Msv/y87Z2tOzJxpbOQY/B1+OvrJmWvLzQHMO0hi6UPd
	 hfbRuOopgnSgSHJD7LdtfAPfADN5hzSq2oshdC1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHNM7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:59:03 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638AB2087D;
        Fri, 14 Aug 2020 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597409943;
        bh=uCL4x9xTPvVEHKN35nipD9lH7F/vIt/ze5bD2j/N9GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMEjP/RdEuWZVyI7GuEkSAskYgOyi7JToMCTTm3e9yBHyde4okZk7PQ+WueEmtX7c
         NfbrTQroZ7+GlrRXN6NNfBegWhk6CotUDFjMxkJNcMOkW1cWlNY2Ltn8Kk0/jXoOOK
         E7hIL6hctIQKieVNkFIbnwx7Y9Gauvpri0x60Elo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A1F340D3D; Fri, 14 Aug 2020 09:59:00 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:58:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/18] perf ftrace: add option '-m/--buffer-size' to
 set per-cpu buffer size
Message-ID: <20200814125859.GH13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-5-changbin.du@gmail.com>
 <20200814115318.GT13995@kernel.org>
 <20200814121250.GX13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814121250.GX13995@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 14, 2020 at 09:12:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> > It indicates that the argument is in units of 'pages', while you don't
> > state that in:
> >   
> >   $ perf ftrace -h -m
> >   
> >       -m, --buffer-size <size>
> >                             size of per cpu buffer

I did this already:

  # perf ftrace -h -m
  
   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- <command> [<options>]
  
      -m, --buffer-size <size>
                            Size of per cpu buffer, needs to use a B, K, M or G suffix.
  
  #

- Arnaldo
