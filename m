Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E114C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E0207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591023698;
	bh=bQWB9djgbPDpVra7hYXi42WLqLW4XW/tQUIrhT7Xwqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1aD9vrGWLjlNN4Y7mU+qXt0CrWHWDHMEtwxXaswEweYa8UL1Iw1xzgVU9W6WNo432
	 u8EpeMmnntTVBXy11S1y1nx4pVUw7j91yjvQHpUQyrBib3QGhx4oYxcbyk0bqk2mdv
	 UkK3LPoEOc/TyksZ4bdZxWV2hR2bKjoDbZnxh1lA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFAPBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAPBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:01:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 619B42065C;
        Mon,  1 Jun 2020 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591023696;
        bh=bQWB9djgbPDpVra7hYXi42WLqLW4XW/tQUIrhT7Xwqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJOyqi6dr4rTe57mBFCp6r8t1gA5Lbe8m6CO0EvGdlchWKGNzz3dl7C47HLkcl2Pa
         C3ZIZSzksthfXrI46p7g2odYTMmMbOO1NdESQyMFM0TXh17aMLfKl5SY6Yahg+yXnm
         NYkdk4qzyGWT428vhQBiAJT4sQiMPSh0Iohwo5y8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 891CB40AFD; Mon,  1 Jun 2020 12:01:34 -0300 (-03)
Date:   Mon, 1 Jun 2020 12:01:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 0/2] Add basic support for PE binary format
Message-ID: <20200601150134.GI31795@kernel.org>
References: <20200601111915.114974-1-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601111915.114974-1-rbernon@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 01, 2020 at 01:19:13PM +0200, Rémi Bernon escreveu:
> Hi,
> 
> I'm currently trying to improve compatibility between Wine and perf, and
> I would like to have you opinion on this approach.

Interesting!
 
> The main problem is that Wine uses PE binary format for most of its code
> (and of course the Windows application it runs are also using PE binary
> format), and perf is currently unable to parse them to get the symbol
> table or even to find the debug file location from build_id or
> .gnu_debuglink section.

Unfortunate
 
> I know that there's the possibility to use a perfmap file to map address
> ranges to symbols, but it requires the runtime to generate it. And in
> this case the information is already there in the PE files, just not in
> a format that perf supports.

Right, IMHO the right approach is to abstract away these details and use
whatever PE has to offer.
 
> I also have some alternate ways to make it work, using perf-specific
> tweaks in Wine for instance. But I believe that having better support of
> PE binary format in perf could be generally useful, although for now
> Wine is the only use-case I know.

Agreed.
 
> This first starts using libbfd to parse the build_id and .gnu_debuglink
> section, to make sure perf gets the debug file location even if the code
> modules are in PE binary format.

Right, one thing I'd ask is for you to add to the tree a very simple PE
file, with debug info, a build-id, and then introduce a new 'perf test'
entry that uses the functions you're adding to read and check its
whatever the build-id is there, so that we keep testing this regularly,
please take a look at tools/perf/tests/ to see how to add a new test.
 
> Then, as Wine also generates debug files in PE or PDB format by default,
> it also tries to use libbfd to parse the symbol table from the debug
> file if libelf failed.
> 
> Of course, advanced features will still lack, but this makes it possible
> to have perf report symbols and source-level annotations for any Windows
> code running in Wine, assuming the modules aren't stripped.

Thanks for working on this, right now I'm doing the final touches for
this merge window, but surely I'll get back to this for 5.9, please
remind me if this falls thru the cracks,

- Arnaldo

> Cheers,
> 
> Rémi Bernon (2):
>   perf dso: Use libbfd to read build_id and .gnu_debuglink section
>   perf symbols: Try reading the symbol table with libbfd
> 
>  tools/perf/util/symbol-elf.c |  65 +++++++++++++++++-
>  tools/perf/util/symbol.c     | 124 +++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+), 3 deletions(-)
> 
> -- 
> 2.26.1
> 

-- 

- Arnaldo
