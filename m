Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E2DC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E30820736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiysLsC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgELN1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:27:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:27:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s186so11647371qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hgJlpCzVnBpL1XV2wP4C/UIOKzLGdGv6rDaqtuPF5W8=;
        b=aiysLsC1PNn+V2AotzxI/8raxwtN08rq5kT8VhWiKLEA0WlCRDxxhaSiU8kLQFaulo
         20LQ+/OFvMhpnP8itGDI0+F+LH/qISdQm0a/euoduVSNYwdvux3WQx86Aw1ijDztzQDo
         jCiwoqcdfoUj5mJd33NSRdZMgRGafgCxAnifbRUl1Au/Lxl5tOvPwX1iyQ65VuvUvYr7
         muZT6Huzx5cMSIaiWRgOYXZ6uXMbencGm4ZQEAat0lP4uJ3uv4mMTVELSXNiob804g98
         4vBO7bvhSSP/IhkMDCmikOumjhY6tHdSbjozjtVDNdvAQFkegaSrKxCd1U6985uHJ8pz
         /Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgJlpCzVnBpL1XV2wP4C/UIOKzLGdGv6rDaqtuPF5W8=;
        b=B+WWe77q/F9Xtp/3AV+cnc2am9YD8jsQWm5AP6jkJ5wUaGfK6/ZK+7UiimW2TVrISK
         NKQgXL1rOhKa7hRbC0fiwmCj/6+sHGL38yVPxLx2YNY2lbw515sk9tTKqKvDQRCfXwmV
         9TUHP7YunxtcGCm0AkKcuyj8b+wC2/H1cl8uTYz4F2nBfbL17cYNTorMMTXxeCYcmzTS
         R5Eq6zs39x37GePSJE7c8ihx/0AhPsSYoseokJvJII+dODmx0wDYn+3mt5/oM5m8dhGK
         FAn50lxtqdl7IYRjwbXWgDjxfbUSP5VaqDQcOafZQ3gNACzj2SkHGakFBYeqVXftAnTc
         On5Q==
X-Gm-Message-State: AGi0PuYp0+WtZNzOfOAt9yOO02LoWP0phoxWw+OlD9e8EtX8O6Nl7U2S
        /d1lROtQy3yD18gH42nAd5LO4+z+1PM=
X-Google-Smtp-Source: APiQypImA70y63CVdkACbNHwYhfu+kd+8Xr84h0nX1J/9/L4fia6ubX3gGzRT3EOWlMGJk2PzCEoHw==
X-Received: by 2002:a37:943:: with SMTP id 64mr20230522qkj.14.1589290060929;
        Tue, 12 May 2020 06:27:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 23sm10994962qkk.11.2020.05.12.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:27:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D33E40AFD; Tue, 12 May 2020 10:27:37 -0300 (-03)
Date:   Tue, 12 May 2020 10:27:37 -0300
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, leo.yan@linaro.org,
        jolsa@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf powerpc: Don't ignore sym-handling.c file
Message-ID: <20200512132737.GH28888@kernel.org>
References: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
 <88066ce0-f586-b88d-75b5-2706684818d7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88066ce0-f586-b88d-75b5-2706684818d7@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 11, 2020 at 11:45:09PM +0530, Sandipan Das escreveu:
> 
> On 09/05/20 4:51 pm, Ravi Bangoria wrote:
> > Commit 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> > removed powerpc specific sym-handling.c file from Build. This wasn't
> > caught by build CI because all functions in this file are declared
> > as __weak in common code. Fix it.
> > 
> > Fixes: 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> > Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > ---
> >  tools/perf/arch/powerpc/util/Build | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> > index e5c9504f8586..e86e210bf514 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -2,6 +2,7 @@ perf-y += header.o
> >  perf-y += kvm-stat.o
> >  perf-y += perf_regs.o
> >  perf-y += mem-events.o
> > +perf-y += sym-handling.o
> >  
> >  perf-$(CONFIG_DWARF) += dwarf-regs.o
> >  perf-$(CONFIG_DWARF) += skip-callchain-idx.o
> > 
> 
> Thanks for fixing this!
> 
> Acked-by: Sandipan Das <sandipan@linux.ibm.com>

Leo, Naveen, can you comment on this?

- Arnaldo
