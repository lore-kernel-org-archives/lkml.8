Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCD42073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvd4DMwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCZPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:01:43 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:44341 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:01:42 -0400
Received: by mail-qv1-f52.google.com with SMTP id ef12so1018320qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13CrhytIMMcnlVBokpCdEBMEfUnQ7bmbVlTMOywGV+g=;
        b=Mvd4DMwqV1n3c4iCCF8PtasIVjG85yp7XCgFhljS6Nsju7OWAGWOmd4C+ps+eK+nqs
         AYYc0MoJHIOPivwz5Ib/utrST8Gq+iCl4lXD19UQUKrN0BgXGiixAEkRxSxiBbuLNvHa
         Pe/ueKMKq3L2eDggjXVydQ/isJ9iivuyRaI8LgDtTUilzV5pe60UrtRMdH/xCY02MJ5R
         +Ay+0tzp+q3nQ61T6uP7x/WhmcMgheSlCh9ZcmV1hKvIgY4Io93uTGNF5wcn2Gx0HM9s
         y2T+cux3QgwlvzwFzQPhWKhODH55Ei74M63ktH2Mq6PLUOePk3FuG2UrDigqrQIsxIBB
         B7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13CrhytIMMcnlVBokpCdEBMEfUnQ7bmbVlTMOywGV+g=;
        b=mlu6KeoOx+3TbLFR9uoHmzN/I+BaF6ncn9FSwsU1kuaxSvowByexv2q9Lq6e0DsocW
         KpYIZHBEqWCOzXt0kiTRDE4olDWUpAAgysTcGgKM4hk3Us1qk0RsdxORZLclsl3xT13R
         mZwgGebeTPZCJxPUTapnscfACHW6J57tL6LtcHT7RdCsNXA1Y9lqwyFnXQiTQDoUfdTu
         ETM1wyqXUtc3lIHQz36YHGHmIYrYXu9PN+Iyy2ji/EADEtod1XWVRuqi0YOWnXZPcufY
         MI1Cv3KqcsvfoudMzhrwymtVENl9L9H1gyA3HqOkHuEDZkQI+tgV37dslgdCaKnr7T6a
         rlvA==
X-Gm-Message-State: ANhLgQ3KpoNy+s5n7rIqXst2zpsIKb2K76VLH8kD4Iw8w74XNgeFw5oD
        H0HA9r15+oEtfzZvQZggFf0=
X-Google-Smtp-Source: ADFU+vtFKQ144kgqmnspv4XWXrH92pOvHBG+pScRxVbkAJDxq31DBcYKJa/p19B/LLrXq75aK0AIuw==
X-Received: by 2002:ad4:5184:: with SMTP id b4mr8531990qvp.221.1585234900794;
        Thu, 26 Mar 2020 08:01:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x124sm1548388qkc.70.2020.03.26.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:01:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA99A40061; Thu, 26 Mar 2020 12:01:37 -0300 (-03)
Date:   Thu, 26 Mar 2020 12:01:37 -0300
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Message-ID: <20200326150137.GD6411@kernel.org>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
 <20200326135547.GA20397@redhat.com>
 <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
 <20200326145726.GC6411@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326145726.GC6411@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 11:57:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Mar 26, 2020 at 02:19:07PM +0000, Hunter, Adrian escreveu:
> > > > But they have not yet been applied.

> > > > Sorry for the confusion.

> > > I'll collect them, thanks for pointing this out.

> > The patches are in tip courtesy of Borislav Petkov thank you!
 
> Ok, thanks Borislav,

I didn't notice because it didn't made into tip/perf/core :-\ In what
branch is it btw, I couldn't find any cset with substr summary "Add
Control-flow Enforcement" in, tip/master also doesn't have it.

- Arnaldo
