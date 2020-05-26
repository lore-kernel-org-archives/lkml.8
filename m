Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DEF20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590509747;
	bh=gUa5ba6GWA5xYBQnyy/CNy8dovH0TV4Cna3GtLzW9vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KpbxcYOgD/111HHnaLduM+7KDAR/ATsy8+N7w3ranjSq6JRcEVBb3g5JmfplySNy9
	 mKNREQOBq4LL8btFQCKAANitJZ6//wLOxkXOvc7B7ZqZ4UQRN2js6IfdNeXXvUKrcN
	 9JF27yZpore407OSxTH2Ugds2JLb6xpOOk/w+Bic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEZQPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgEZQPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:15:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8977A20704;
        Tue, 26 May 2020 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590509746;
        bh=gUa5ba6GWA5xYBQnyy/CNy8dovH0TV4Cna3GtLzW9vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxyu26eVjFiFixuGaFBOBgSkGNA/ucV+JYGmxPBgVqBFbFp+o7oQ+9IHd8fOKdSQ7
         W97sBK+yFe3QdSrh/xUBwFqIchtzbo5U2bqHUXi0ClsPL5YpSaZFuWvQtp4ZPiTGLe
         8L/KCbeUs62iZrZQqOu3+UVI73JojwevT8hnH7wI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7953340AFD; Tue, 26 May 2020 13:15:43 -0300 (-03)
Date:   Tue, 26 May 2020 13:15:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Travis Downs <travis.downs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2] perf tools: Fix debuginfo search for Ubuntu
Message-ID: <20200526161543.GB14219@kernel.org>
References: <20200526155207.9172-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526155207.9172-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 26, 2020 at 06:52:07PM +0300, Adrian Hunter escreveu:
> Reportedly, from 19.10 Ubuntu has begun mixing up the location of some
> debug symbol files, putting files expected to be in
> /usr/lib/debug/usr/lib into /usr/lib/debug/lib instead. Fix by adding
> another dso_binary_type.
> 
> Example on Ubuntu 20.04
> 
>   Before:
> 
>     $ perf record -e intel_pt//u uname
>     Linux
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.030 MB perf.data ]
>     $ perf script --call-trace | head -5
>            uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
>            uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          7f1e71cc4100
>            uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4df0
>            uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4e18
>            uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc5128
> 
>   After:
> 
>     $ perf script --call-trace | head -5
>            uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
>            uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )      _start
>            uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
>            uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
>            uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
> 
> Reported-by: Travis Downs <travis.downs@gmail.com>

Thanks, applied.

- Arnaldo

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org
> ---
> 
> 
> Changes in V2:
> 	Added  'break' after 'ret = -1'
> 
> 
>  tools/perf/util/dso.c          | 16 ++++++++++++++++
>  tools/perf/util/dso.h          |  1 +
>  tools/perf/util/probe-finder.c |  1 +
>  tools/perf/util/symbol.c       |  2 ++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e68e1375e3c0..be991cbbe9f8 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -47,6 +47,7 @@ char dso__symtab_origin(const struct dso *dso)
>  		[DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO]	= 'D',
>  		[DSO_BINARY_TYPE__FEDORA_DEBUGINFO]		= 'f',
>  		[DSO_BINARY_TYPE__UBUNTU_DEBUGINFO]		= 'u',
> +		[DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO]	= 'x',
>  		[DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO]	= 'o',
>  		[DSO_BINARY_TYPE__BUILDID_DEBUGINFO]		= 'b',
>  		[DSO_BINARY_TYPE__SYSTEM_PATH_DSO]		= 'd',
> @@ -129,6 +130,21 @@ int dso__read_binary_type_filename(const struct dso *dso,
>  		snprintf(filename + len, size - len, "%s", dso->long_name);
>  		break;
>  
> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> +		/*
> +		 * Ubuntu can mixup /usr/lib with /lib, putting debuginfo in
> +		 * /usr/lib/debug/lib when it is expected to be in
> +		 * /usr/lib/debug/usr/lib
> +		 */
> +		if (strlen(dso->long_name) < 9 ||
> +		    strncmp(dso->long_name, "/usr/lib/", 9)) {
> +			ret = -1;
> +			break;
> +		}
> +		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> +		snprintf(filename + len, size - len, "%s", dso->long_name + 4);
> +		break;
> +
>  	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
>  	{
>  		const char *last_slash;
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 42b3a278ac59..8b7958f02609 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -30,6 +30,7 @@ enum dso_binary_type {
>  	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
>  	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
>  	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> +	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
>  	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
>  	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
>  	DSO_BINARY_TYPE__GUEST_KMODULE,
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index e4cff49384f4..55924255c535 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -101,6 +101,7 @@ enum dso_binary_type distro_dwarf_types[] = {
>  	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
>  	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
>  	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> +	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
>  	DSO_BINARY_TYPE__NOT_FOUND,
>  };
>  
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 7725c83996f4..44d81f90b604 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -79,6 +79,7 @@ static enum dso_binary_type binary_type_symtab[] = {
>  	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
>  	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
>  	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
>  	DSO_BINARY_TYPE__NOT_FOUND,
>  };
>  
> @@ -1529,6 +1530,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>  	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
>  	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
>  	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
>  	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
>  	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
>  		return !kmod && dso->kernel == DSO_TYPE_USER;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
