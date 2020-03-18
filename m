Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A0C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5367B20767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNnKXZf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCRPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:44:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43340 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgCRPoD (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:44:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so19305626qki.10
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rT40cecCHxpNI8dib7IN8ZvHL9ABQbvv9Z12Olg7CGM=;
        b=nNnKXZf1OWMaTETbhEZTXsv5fRoDFWRJCqtaoaQruZhYhwlFUHQC+v76ef5SRXaPVN
         kevPWFzikBLRJ0qMhGz+bItU3YXgxNEM6C5sQZC3VOHd4YOJvLF4NC+lT5vGBPYi1q4H
         DmNfvmwvST7XjAvmQqPgmJYMEpGi8m+lEA29lweQVFcpfOf0SZa5jCVVre6aL3Ma4MoM
         UUe0AIomwuS8uayj6MokY9iSr6pAQzErPOXDRKIdGeA7rVVn+FKCJ8rCsTxOyUyp1Mo3
         4JDOa9fQC+8XEHHfd5vwbRL4b6wRowQcXyiQuLSX2ikm0tHsWVFiMA+0AgDyvGMIv28C
         wPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rT40cecCHxpNI8dib7IN8ZvHL9ABQbvv9Z12Olg7CGM=;
        b=m4ZgrfkcR8dgzFEwjAbEAekdYWI2aAasqzClnMfSeo5QHmD0wY9ZXf0p9rki3PbQtc
         vFBvfsNikHlDHWMCeTBicDGxnQeGD0cOmmBE0X/w0aFi9bW27IOxsBGfWP96HRrUB6IG
         Zg3TEGR4Q9yG106TMAUy9V4bJdZHtCWqBtZLWvOUI3xKTIvQZR2tLbXrEU10EfpArMm3
         0HRhbWPTIqIB0E8lFLtBp7vSzHwf1Wc82sK3VNV0j8Nitl/nzzw05Ejc/dXBtQaNgxgl
         Fic5bOSj3hUzlkEOLIWMbtdLGqFitDat8kV9YAMC253mfJr7m7vDP+t621QXTDpFQIQL
         E6gA==
X-Gm-Message-State: ANhLgQ2QE90+cusvEr/yy3vCob5srYnlYr2lTkGyFkZ9ziwWp6iKOLwd
        knd14w+LKUI58XeCAMNOoR4=
X-Google-Smtp-Source: ADFU+vst9c9J0hbpeLijRPXB8Ok5fTUStYb4qaRZf6FTo8M8QhsDOChEyumQRgW9YVlN51OMqU95ow==
X-Received: by 2002:a37:aa54:: with SMTP id t81mr4943275qke.234.1584546241169;
        Wed, 18 Mar 2020 08:44:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x37sm5029415qtc.90.2020.03.18.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:44:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AD49404E4; Wed, 18 Mar 2020 12:43:58 -0300 (-03)
Date:   Wed, 18 Mar 2020 12:43:58 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 2/3] perf report: Support interactive annotation of
 code without symbols
Message-ID: <20200318154358.GH11531@kernel.org>
References: <20200227043939.4403-1-yao.jin@linux.intel.com>
 <20200227043939.4403-3-yao.jin@linux.intel.com>
 <20200318154206.GG11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318154206.GG11531@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 12:42:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 27, 2020 at 12:39:38PM +0800, Jin Yao escreveu:
> > For perf report on stripped binaries it is currently impossible to do
> > annotation. The annotation state is all tied to symbols, but there are
> > either no symbols, or symbols are not covering all the code.
> > 
> > We should support the annotation functionality even without symbols.
> > 
> > This patch fakes a symbol and the symbol name is the string of address.
> > After that, we just follow current annotation working flow.
> > 
> > For example,
> > 
> > 1. perf report
> > 
> > Overhead  Command  Shared Object     Symbol
> >   20.67%  div      libc-2.27.so      [.] __random_r
> >   17.29%  div      libc-2.27.so      [.] __random
> >   10.59%  div      div               [.] 0x0000000000000628
> >    9.25%  div      div               [.] 0x0000000000000612
> >    6.11%  div      div               [.] 0x0000000000000645
> > 
> > 2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.
> > 
> > Annotate 0x0000000000000628
> > Zoom into div thread
> > Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
> > Browse map details
> > Run scripts for samples of symbol [0x0000000000000628]
> > Run scripts for all samples
> > Switch to another data file in PWD
> > Exit
> > 
> > 3. Select the "Annotate 0x0000000000000628" and ENTER.
> > 
> > Percent│
> >        │
> >        │
> >        │     Disassembly of section .text:
> >        │
> >        │     0000000000000628 <.text+0x68>:
> >        │       divsd %xmm4,%xmm0
> >        │       divsd %xmm3,%xmm1
> >        │       movsd (%rsp),%xmm2
> >        │       addsd %xmm1,%xmm0
> >        │       addsd %xmm2,%xmm0
> >        │       movsd %xmm0,(%rsp)
> > 
> > Now we can see the dump of object starting from 0x628.
> 
> Testing this I noticed this discrepancy when using 'o' in the annotate
> view to see the address columns:
> 
> Samples: 10K of event 'cycles', 4000 Hz, Event count (approx.): 7738221585
> 0x0000000000ea8b97  /usr/libexec/gcc/x86_64-redhat-linux/9/cc1 [Percent: local period]
> Percent│                                                                                                                                                                                                                                                  ▒
>        │                                                                                                                                                                                                                                                  ▒
>        │                                                                                                                                                                                                                                                  ▒
>        │        Disassembly of section .text:                                                                                                                                                                                                             ▒
>        │                                                                                                                                                                                                                                                  ◆
>        │        00000000012a8b97 <linemap_get_expansion_line@@Base+0x227>:                                                                                                                                                                                ▒
>        │12a8b97:   cmp     %rax,(%rdi)                                                                                                                                                                                                                    ▒
>        │12a8b9a: ↓ je      12a8ba0 <linemap_get_expansion_line@@Base+0x230>                                                                                                                                                                               ▒
>        │12a8b9c:   xor     %eax,%eax                                                                                                                                                                                                                      ▒
>        │12a8b9e: ← retq                                                                                                                                                                                                                                   ▒
>        │12a8b9f:   nop                                                                                                                                                                                                                                    ▒
>        │12a8ba0:   mov     0x8(%rsi),%edx
> 
> 
> 
>  See that 0x0000000000ea8b97 != 12a8b97
> 
> How can we explain that?

On another machine, in 'perf top', its ok, the same address appears on
the second line and in the first line in the disassembled code.

I'm applying the patch,

- Arnaldo
