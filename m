Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14084C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E002020738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBt5RuJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbgFXN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:26:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57976 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389946AbgFXNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593005153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHBmr1gsipGNSeXyE8IuMQZe3fmcyM9AV9J06Evv2m4=;
        b=jBt5RuJAB3Hd0zgZ6KBot2D2cy39EkrO8ZBQLmJX5OdQsAVE+qYQ6GY6RXapyMP+Ze+CXv
        PMmbA2/WVZCrP5RJcFvcy6y95IDegNYAeQ1vRuPj+ZbPYoeAdIVL6sewPRHdSvKCBE2ctX
        N32rjBJiu8wUHEQxnPSq06mW4pY9jKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-j1bCL0XkMLeXnwnmIp6YPg-1; Wed, 24 Jun 2020 09:25:49 -0400
X-MC-Unique: j1bCL0XkMLeXnwnmIp6YPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757D7804015;
        Wed, 24 Jun 2020 13:25:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.204])
        by smtp.corp.redhat.com (Postfix) with SMTP id 733D86106A;
        Wed, 24 Jun 2020 13:25:46 +0000 (UTC)
Date:   Wed, 24 Jun 2020 15:25:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH 2/3] perf symbols: Try reading the symbol table with
 libbfd
Message-ID: <20200624132545.GD2719003@krava>
References: <20200624103041.825746-1-rbernon@codeweavers.com>
 <20200624103041.825746-2-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624103041.825746-2-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:30:40PM +0200, Remi Bernon wrote:

SNIP

> +
> +		symbols__insert(&dso->symbols, symbol);
> +	}
> +#ifdef bfd_get_section
> +#undef bfd_asymbol_section
> +#endif
> +
> +	symbols__fixup_end(&dso->symbols);
> +	symbols__fixup_duplicate(&dso->symbols);
> +	dso->adjust_symbols = 1;
> +
> +	err = 0;
> +out_free:
> +	free(symbols);
> +out_close:
> +	bfd_close(abfd);
> +	return err;
> +}
> +#endif
> +
>  static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>  					   enum dso_binary_type type)
>  {
> @@ -1695,6 +1816,7 @@ int dso__load(struct dso *dso, struct map *map)
>  		bool next_slot = false;
>  		bool is_reg;
>  		bool nsexit;
> +		int bfdrc = -1;
>  		int sirc = -1;
>  
>  		enum dso_binary_type symtab_type = binary_type_symtab[i];
> @@ -1713,12 +1835,19 @@ int dso__load(struct dso *dso, struct map *map)
>  			nsinfo__mountns_exit(&nsc);
>  
>  		is_reg = is_regular_file(name);
> +#ifdef HAVE_LIBBFD_SUPPORT
>  		if (is_reg)
> +			bfdrc = dso__load_bfd_symbols(dso, name);
> +#endif

so the comment says that we try bfd when the libelf fails,
but the code seems to do the oposite.. starts with bfd
and skip libelf if it's ok

jirka

> +		if (is_reg && bfdrc < 0)
>  			sirc = symsrc__init(ss, dso, name, symtab_type);
>  
>  		if (nsexit)
>  			nsinfo__mountns_enter(dso->nsinfo, &nsc);
>  
> +		if (bfdrc == 0)
> +			break;
> +
>  		if (!is_reg || sirc < 0)
>  			continue;
>  
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index ff4f4c47e148..11fe71f46d14 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -175,6 +175,10 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
>  
>  struct symsrc;
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
> +#endif
> +
>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		  struct symsrc *runtime_ss, int kmodule);
>  int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
> -- 
> 2.27.0
> 

