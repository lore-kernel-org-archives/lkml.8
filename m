Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4889C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C570221744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596553155;
	bh=m/XhRdnVL7H+dxQP7FTMHFl64txEHb+4AnXJNh0yLck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a6q13ZKKFNBCpUPpPIN33vuzIl27HiXTpeoMXT7TYBFRALibfACz96xoljneQ8SfT
	 ZGb8g9QkU8uu5vKzlcQflYV6MZB1eCA3WQznhrxOdoxDpgAU4q3VRF8NDIeSDASn6s
	 s5UF2eTaD7TiEgmWoOn6fzYhwspdGS8p9C77Tgj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgHDO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgHDO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:59:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 161F821744;
        Tue,  4 Aug 2020 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596553148;
        bh=m/XhRdnVL7H+dxQP7FTMHFl64txEHb+4AnXJNh0yLck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idbCl9zyYdUMi+iYtEAoZXwlyuRGzpLVoczEaRU9ma2eEnnvUOeJrBegWCBA73k+x
         Jk2BTV7bXIxwpZkiG82hiSX+jkBlOPxOu7IEfrfolnJjD3GStmHORMsfyHwo7KW/BE
         8LmzQHys1AOTZZARokpeW24kXkXeq80xD4bdFSrg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6241D40C7C; Tue,  4 Aug 2020 11:59:05 -0300 (-03)
Date:   Tue, 4 Aug 2020 11:59:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/12] perf intel-pt: Add support for decoding FUP/TIP
 only
Message-ID: <20200804145905.GH3440834@kernel.org>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
 <f0a4f89f-f642-f75f-a390-da16d0a058d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a4f89f-f642-f75f-a390-da16d0a058d0@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 04, 2020 at 04:34:36PM +0300, Adrian Hunter escreveu:
> On 10/07/20 6:10 pm, Adrian Hunter wrote:
> > Hi
> > 
> > Here are some fixes and small improvements for Intel PT.
> 
> Andi added his "Reviewed-by" with 2 comments to tweak the
> documentation.
> 
> The patches still apply, so do you want me to send a V3?

Thanks for the reminder, will apply and test build,

- Arnaldo
 
> > 
> > Changes in V2:
> > 	For d/e flags, use +/- alphabetic options instead of numbers
> > 	Update help text
> > 	Improve documentation
> > 
> > 
> > Adrian Hunter (12):
> >       perf intel-pt: Fix FUP packet state
> >       perf intel-pt: Fix duplicate branch after CBR
> >       perf tools: Improve aux_output not supported error
> >       perf auxtrace: Add missing itrace options to help text
> >       perf auxtrace: Add optional error flags to the itrace 'e' option
> >       perf intel-pt: Use itrace error flags to suppress some errors
> >       perf auxtrace: Add optional log flags to the itrace 'd' option
> >       perf intel-pt: Use itrace debug log flags to suppress some messages
> >       perf intel-pt: Time filter logged perf events
> >       perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
> >       perf intel-pt: Add support for decoding FUP/TIP only
> >       perf intel-pt: Add support for decoding PSB+ only
> > 
> >  tools/perf/Documentation/itrace.txt                |  14 ++
> >  tools/perf/Documentation/perf-intel-pt.txt         |  63 +++++-
> >  tools/perf/util/auxtrace.c                         |  50 +++++
> >  tools/perf/util/auxtrace.h                         |  31 ++-
> >  tools/perf/util/evsel.c                            |   4 +
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 214 +++++++++++++++++++--
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
> >  tools/perf/util/intel-pt.c                         |  45 ++++-
> >  8 files changed, 389 insertions(+), 33 deletions(-)
> > 
> > 
> > Regards
> > Adrian
> > 
> 

-- 

- Arnaldo
