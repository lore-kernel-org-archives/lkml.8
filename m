Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF4AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9291020674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxR0rJBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCRPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:47:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45318 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRPrB (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:47:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so39441735qke.12
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zLFQzh61eijrm/J64EbULdSAxWQkM+wMQak8AnWfjyE=;
        b=lxR0rJBydpYvL7FIDDB4WDQO6VHkmnyuew+ejFkWbnM+rHX+rjKnE6mjFTXe4dZUg/
         X6n3QVkYg13LUkx1rEevwarNyHX3dWHNfZRaXgluyQu2NgGrQEGagkxUlGeSdWn2vzeJ
         VzbAYoOnnpqD56rIhLUfxVZC3OgbdK9qBpJ9c9cpQ0ncYU6SiGGNs2JDvA6FyOOsnkhn
         rz/6NyaTXWgZh+K3itiYmzkLqhqqD6o1ofXjDXUFIkgIXf4KPvQQcv81HmP78BhcgYjt
         EhBs12EZQ+VKsetf/Byf2jpS0N5fH85wz1EwpW+WTK38NiQbs2Gb0rPBBePYw2NxnL5v
         CSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zLFQzh61eijrm/J64EbULdSAxWQkM+wMQak8AnWfjyE=;
        b=to/nZFVrWJkOgkIBzlPWZce32jViw7I4/jj6LCoK9gjXs25uyW6+UbC7M1AhJ6tJHc
         brYBgRTIEsP2C5DnZfwAgOr8M/pSnrma6qRzyUYMHC53LnJgEXoEz3AjiZpo91Ar0QNu
         lpB57glPBvsv7Z1g+EUaAZ9EORAgLJXXqgkyWjMYEUTxpWbZbBQ9wvYPADfQWDc/HDXS
         riLyTz7JwJUITtnrTsurxUyHNj+sdb7Kt7rsoEqSoVBW94Kvu6roQEF3G9CgAnLkBu1t
         ZZmOnVv8LIkrWqSx+O5odNy7Vb90tyenaoTYKadAS4xCIAm0OVNmmd8piO5JA4dhxdvf
         9fpw==
X-Gm-Message-State: ANhLgQ2OUmgadDTX8sCyi3N1+kjl1J7n+dgwokZI495iuGXrsP7Lh5Ts
        wJ7R9d9a6qo2X0ZlUnC/C3A=
X-Google-Smtp-Source: ADFU+vt63tLFp0sOAKU+ota/O5hQz8lqPk9EUUO8FaFtlAZ4B0OgI4U7CM/HKTgO6cKBHrUrVCxtkA==
X-Received: by 2002:a05:620a:13fa:: with SMTP id h26mr4845455qkl.491.1584546419848;
        Wed, 18 Mar 2020 08:46:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a186sm4457531qkg.2.2020.03.18.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:46:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E4702404E4; Wed, 18 Mar 2020 12:46:56 -0300 (-03)
Date:   Wed, 18 Mar 2020 12:46:56 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 2/3] perf report: Support interactive annotation of
 code without symbols
Message-ID: <20200318154656.GI11531@kernel.org>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
 <20200227043939.4403-3-yao.jin@linux.intel.com>
 <20200318154206.GG11531@kernel.org>
 <20200318154358.GH11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318154358.GH11531@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 12:43:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 18, 2020 at 12:42:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Feb 27, 2020 at 12:39:38PM +0800, Jin Yao escreveu:
> > > Now we can see the dump of object starting from 0x628.

> > Testing this I noticed this discrepancy when using 'o' in the annotate
> > view to see the address columns:

> > Samples: 10K of event 'cycles', 4000 Hz, Event count (approx.): 7738221585
> > 0x0000000000ea8b97  /usr/libexec/gcc/x86_64-redhat-linux/9/cc1 [Percent: local period]
> > Percent│
> >        │        Disassembly of section .text:
> >        │
> >        │        00000000012a8b97 <linemap_get_expansion_line@@Base+0x227>:
> >        │12a8b97:   cmp     %rax,(%rdi)
> >        │12a8b9a: ↓ je      12a8ba0 <linemap_get_expansion_line@@Base+0x230>
> >        │12a8b9c:   xor     %eax,%eax
> >        │12a8b9e: ← retq
> >        │12a8b9f:   nop
> >        │12a8ba0:   mov     0x8(%rsi),%edx

> >  See that 0x0000000000ea8b97 != 12a8b97

> > How can we explain that?

> On another machine, in 'perf top', its ok, the same address appears on
> the second line and in the first line in the disassembled code.

> I'm applying the patch,

With this adjustments, ok?

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 2f07680559c4..c2556901f7b6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,10 +2465,10 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
-static struct symbol *new_annotate_sym(u64 addr, struct map *map)
+static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
 {
-	struct symbol *sym;
 	struct annotated_source *src;
+	struct symbol *sym;
 	char name[64];
 
 	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
@@ -2497,7 +2497,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		return 0;
 
 	if (!ms->sym)
-		ms->sym = new_annotate_sym(addr, ms->map);
+		ms->sym = symbol__new_unresolved(addr, ms->map);
 
 	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
 		return 0;
