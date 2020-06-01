Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDCE206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDoJN4Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFARp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:45:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54033 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgFARpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591033554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MvYIT8xhqeQj773yS5nDiVAZoSLXTqEWT4NaJKHnlU=;
        b=FDoJN4TeYmmQs1qtph1xdQa9BSj1lai/TBq9NfVSK/P5eC4Aw+aoX9DWB/49NO3DsgYfFj
        GgZxvdbbyGh0FeNXm5c2qMWvNoOLRtunwWMr2A1nyvxcJcvuVo+zYGiLtLq5ohIXU/YV1W
        h/rlP863Z/E+VG00KP/iBt8G0vJrspU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-pDfbh3gdPm-wl773L47oKA-1; Mon, 01 Jun 2020 13:45:50 -0400
X-MC-Unique: pDfbh3gdPm-wl773L47oKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF9CA100A8E7;
        Mon,  1 Jun 2020 17:45:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC1F5D9C9;
        Mon,  1 Jun 2020 17:45:46 +0000 (UTC)
Date:   Mon, 1 Jun 2020 19:45:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [RFC PATCH 2/2] perf symbols: Try reading the symbol table with
 libbfd
Message-ID: <20200601174545.GF1031432@krava>
References: <20200601111915.114974-1-rbernon@codeweavers.com>
 <20200601111915.114974-3-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601111915.114974-3-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 01:19:15PM +0200, Rémi Bernon wrote:
> Wine generates PE binaries for its code modules and also generates
> debug files in PE or PDB formats, which perf cannot parse either.
> 
> Trying libbfd, when supported, if the default libelf symbol parsing
> failed, makes it possible to read the symbol table from any binary
> format supported by it, and lets perf report symbols and annotations
> for Windows applications running under Wine.
> 
> Because libbfd doesn't provide symbol size (probably because of some
> backends not supporting it), we compute it by first sorting the symbols
> by addresses and then considering that they are sequential in a given
> section.

hi,
would you have some example for easy test on this?

SNIP

>  static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
>  					   enum dso_binary_type type)
>  {
> @@ -1691,6 +1806,7 @@ int dso__load(struct dso *dso, struct map *map)
>  		bool next_slot = false;
>  		bool is_reg;
>  		bool nsexit;
> +		bool bfd_syms = false;
>  		int sirc = -1;
>  
>  		enum dso_binary_type symtab_type = binary_type_symtab[i];
> @@ -1712,9 +1828,17 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (is_reg)
>  			sirc = symsrc__init(ss, dso, name, symtab_type);
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +		if (is_reg && sirc < 0)
> +			bfd_syms = dso__load_bfd_symbols(dso, name);
> +#endif

hum, would it be better to find out is it's PE object
and call it directly instead of the failover?

jirka


> +
>  		if (nsexit)
>  			nsinfo__mountns_enter(dso->nsinfo, &nsc);
>  
> +		if (bfd_syms)
> +			break;
> +
>  		if (!is_reg || sirc < 0)
>  			continue;
>  
> -- 
> 2.26.1
> 

