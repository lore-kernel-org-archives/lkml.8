Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D9C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E71721744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9QyZnM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDTUqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgDTUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:46:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB6C061A0C;
        Mon, 20 Apr 2020 13:46:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x66so12275323qkd.9;
        Mon, 20 Apr 2020 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nvxgsMTqVG4TNWLC+4i+8i0Jqdi4qvFfrMl4dwSRAcU=;
        b=H9QyZnM572sPJ1t9YpaU1b7Fzit8xdn2U0ZntyFVN8XlR/RP7z1J0eMPuRnOYYjhHg
         5q9lKAB2udjx+dOLWPGHDFrbcuC24jRRLXa41M3tY50BhiZG2zZyYrAik5OtJ5US5DWP
         Y7o8YpXnBGue/n/us4oaO6ZLfIT/TCJ7g5lQDwy0pRKohm4CDjnxSX2gPBnepUt+Sv6Y
         5lyd6W7FoDcgmKkq4HmooNOoXDApN4jq19bnAtogIxV91yodV0L2RVIgTdyHkCDKqik/
         /91pp/34gvCgg5LEa8CyOIGl9uNo2zb1hvQzFbo/HQDtg8x94GFBnwduiDnrEz/KT0CK
         jJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nvxgsMTqVG4TNWLC+4i+8i0Jqdi4qvFfrMl4dwSRAcU=;
        b=ZHxEVEDPalTEYm9xnjpaLzit0HSn34jzLWFbV2qCvZkpq4yNcwhh717lCu3A37npsU
         c2OaafOiiaU5OkYzqOhaDkiKRa0h2BfyUQ5B6Jhl2T2zPLGv6HM90sjvjFtOBsio6y1b
         Nl+FMTsIkKmHBp4hKcu3RE7obDxMXVKqcrCWfqAzkd857AVIuqKzwiAP00+xVhuDvokK
         Ja+RDHtq/B+VCdxUAElyR4HWzIjELvjHvIQ8nLXeG6O++x/x7tLD4wG/8d0qmTbEqJkV
         kWP6s/jiRlpwnIOxRK54cTJ1nwbsiFo97btV5n/XgdPJN5eVAUB7eD/ELr2zeG/D7Fc/
         dmlw==
X-Gm-Message-State: AGi0PuYWjzWUabhLhlZOTkJIc7jUSyQIBgrf+EAej9yhpA4C/yf7Q4lt
        wYtepibyOnbPgkWC5bP2JoM=
X-Google-Smtp-Source: APiQypKq/OKlS541vak86v8EShwtXrE+6f3dfVfUvpZeyRIqO3mmy/gtqbpwwZYkojOlGqJ4jk4Guw==
X-Received: by 2002:ae9:e20d:: with SMTP id c13mr16863837qkc.241.1587415581397;
        Mon, 20 Apr 2020 13:46:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id s14sm322129qts.70.2020.04.20.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:46:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54E9C409A3; Mon, 20 Apr 2020 17:46:17 -0300 (-03)
Date:   Mon, 20 Apr 2020 17:46:17 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Message-ID: <20200420204617.GA23638@kernel.org>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415070744.59919-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
> Running commands
> 
>    ./perf record -e rb0000 -- find .
>    ./perf report -v

Or when pressing 'V' in the TUI.
 
> reveals symbol names and its addresses. There is a mismatch between

Yeah, an address that at some point was put there to help with debugging
the symbol resolution, IIRC how it looked like when looking at

  readelf -sW vmlinux

Or any other DSO, for instance, for a glibc symbol here:

Using 'perf report -s pid,dso,sym' then pressing 'V':

   1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2

[acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
 24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
[acme@five perf]$ 

Can you check if doing in /lib/modules/.../build/vmlinux produces what
appears when 'V' is in place?

And perhaps we can also show the DSO offset and the rip as it gets laid
out in memory in the end? So we have all the informations?

- Arnaldo

> kernel symbol and address. Here is an example for kernel symbol
> check_chain_key:
> 
>  3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key
> 
> This address is off by 0xff000 as can be seen with:
> 
> [root@t35lp46 ~]# fgrep check_chain_key /proc/kallsyms
> 00000000001f00d0 t check_chain_key
> [root@t35lp46 ~]# objdump -t ~/linux/vmlinux| fgrep check_chain_key
> 00000000001f00d0 l     F .text	00000000000001e8 check_chain_key
> [root@t35lp46 ~]#
> 
> This function is located in main memory 0x1f00d0 - 0x1f02b4. It has
> several entries in the perf data file with the correct address:
> 
> [root@t35lp46 perf]# ./perf report -D -i perf.data.find-bad | \
> 				fgrep SAMPLE| fgrep 0x1f01ec
> PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
> PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
> 
> The root cause happens when reading symbol tables during perf report.
> A long gdb call chain leads to
> 
>    machine__deliver_events
>      perf_evlist__deliver_event
>        perf_evlist__deliver_sample
>          build_id__mark_dso_hits
> 	   thread__find_map(1)      Read correct address from sample entry
> 	     map__load
> 	       dso__load            Some more functions to end up in
> 	         ....
> 		 dso__load_sym.
> 
> Function dso__load_syms  checks for kernel relocation and symbol
> adjustment for the kernel and results in kernel map adjustment of
> 	 kernel .text segment address (0x100000 on s390)
> 	 kernel .text segment offset in file (0x1000 on s390).
> This results in all kernel symbol addresses to be changed by subtracting
> 0xff000 (on s390). For the symbol check_chain_key we end up with
> 
>     0x1f00d0 - 0x100000 + 0x1000 = 0xf11d0
> 
> and this address is saved in the perf symbol table. This calculation is
> also applied by the mapping functions map__mapip() and map__unmapip()
> to map IP addresses to dso mappings.
> 
> During perf report processing functions
> 
>    process_sample_event    (builtin-report.c)
>      machine__resolve
>        thread__find_map
>      hist_entry_iter_add
> 
> are called. Function thread__find_map(1)
> takes the correct sample address and applies the mapping function
> map__mapip() from the kernel dso and saves the modified address
> in struct addr_location for further reference. From now on this address
> is used.
> 
> Funktion process_sample_event() then calls hist_entry_iter_add() to save
> the address in member ip of struct hist_entry.
> 
> When samples are displayed using
> 
>     perf_evlist__tty_browse_hists
>       hists__fprintf
>         hist_entry__fprintf
> 	  hist_entry__snprintf
> 	    __hist_entry__snprintf
> 	      _hist_entry__sym_snprintf()
> 
> This simply displays the address of the symbol and ignores the dso <-> map
> mappings done in function thread__find_map. This leads to the address
> mismatch.
> 
> Output before:
> 
> ot@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
>      3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
>      						0xf11ec v [k] check_chain_key
> [root@t35lp46 perf]#
> 
> Output after:
> 
> [root@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
>      3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
>      						0x1f01ec v [k] check_chain_key
> [root@t35lp46 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/util/sort.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index ab0cfd790ad0..0695b3f6460f 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -297,8 +297,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
>  
>  	if (verbose > 0) {
>  		char o = map ? dso__symtab_origin(map->dso) : '!';
> +		u64 rip = ip;
> +
> +		if (map && map->dso && map->dso->kernel
> +		    && map->dso->adjust_symbols)
> +			rip = map->unmap_ip(map, ip);
> +
>  		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
> -				       BITS_PER_LONG / 4 + 2, ip, o);
> +				       BITS_PER_LONG / 4 + 2, rip, o);
>  	}
>  
>  	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
