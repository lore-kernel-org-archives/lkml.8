Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C38C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFE320775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEGKuITj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgCZO0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:26:30 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33471 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:26:30 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so2998957qve.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRJWwNt45KOlJFv0+GV8rTP+VDDuM81/hCQ1ITt89VA=;
        b=ZEGKuITj9R8iEiPb3twAjh/lLsU7Lbd/rUcjDsFdUOKJ7/xQaLuSsdAFyEjuERpy6E
         QskVooDIhlJhIqVS+lVR3CHDKjhtfuw231VnqhTttA77myRGdG33b3qTzl9l1ccaKycg
         5BKfLy2gdqJjiShn8V9OCyq1RbOplIy6gHEuhqlpSGL5CsCuOttEHKfX9fqjVTHr8ZtF
         XXTls/H0exKKhxRPs2eSRMMkS7koSN85nAVrHkStN6xHWpgQzdfA2AeGeD6uDHO1I8p5
         VWNxkpPZaSGYFrwy8YKBlLqZ6HQ9C+k3s9HPV1wHYQzYWgLI5/hwjnrBW1rB7ImQNA5q
         gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRJWwNt45KOlJFv0+GV8rTP+VDDuM81/hCQ1ITt89VA=;
        b=GKwIleWvHk8U0Obi7vZNheKGj9t3Gzoj/CuqjFXOn5LNHgoCulS65o65+qciZiICvv
         p32BFyw11YI5bQgts8ipbRgk545SVQZO2oYm8muFBHET8uOapjGeloRgV0//GDeBKl5v
         1Qtdd7QKHUEf14GbwvDlHRNPmMqG594dKrTVpZ1E2pmxX5bTUDBi3Bw2wZZsWpRi3kcx
         hQzLA9qIhSt/QgY7xborLJwnzDAtlOswoODld/ot2YWbM4DEQ/jn8TJ92QuNhZETJQWh
         OysliZ/ZFq5jUVher1Mt+jZ1F/rpvUsx4bgEYumNcuIui9VSjk7Uxgg0B1UnuliTz/0a
         614w==
X-Gm-Message-State: ANhLgQ2lUeC8WPUJgC7U0ZRv2qwGR5ghl81KVviIWmUesL3fuU1UKMUZ
        M3dSO7MaIHCwLvL6aiWPeeY=
X-Google-Smtp-Source: ADFU+vvuw4hcflYtITSxYXHTo+rByjGPFuw1vxLzLvN/Uok6bOOqgUuFTVjU1n5tiUBUIJ7lOqfkJg==
X-Received: by 2002:a0c:b757:: with SMTP id q23mr8330697qve.213.1585232787222;
        Thu, 26 Mar 2020 07:26:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d19sm1468808qkc.14.2020.03.26.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:26:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EE5A40061; Thu, 26 Mar 2020 11:26:24 -0300 (-03)
Date:   Thu, 26 Mar 2020 11:26:24 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] Introduce Control-flow Enforcement opcodes
Message-ID: <20200326142624.GA6411@kernel.org>
References: <20200204171425.28073-1-yu-cheng.yu@intel.com>
 <20200303193550.692bf2be0ee800c21bd05215@kernel.org>
 <684e6012-b433-4b61-936d-b5c3b71e246c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684e6012-b433-4b61-936d-b5c3b71e246c@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 07:11:18AM +0200, Adrian Hunter escreveu:
> On 3/03/20 12:35 pm, Masami Hiramatsu wrote:
> > On Tue,  4 Feb 2020 09:14:23 -0800
> > Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> >> Control-flow Enforcement (CET) introduces 10 new instructions [1].  Add
> >> them to the opcode map.  This series has been separated from the CET
> >> patches [2] for ease of review.

> >> [1] Detailed information on CET can be found in "Intel 64 and IA-32
> >>     Architectures Software Developer's Manual":

> >>     https://software.intel.com/en-us/download/intel-64-and-ia-32-
> >>     architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

> >> [2] CET patches:

> >>     https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
> >>     https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

> > Sorry, somewhat I've missed this series...

> > This looks good to me.

> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> > for this series.
 
> These are the correct patches for CET instructions.
 
> Sorry for the confusion.

Thanks, applied, sorry for the long delay in doing so.

- Arnaldo
