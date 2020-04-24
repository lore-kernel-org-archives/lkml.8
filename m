Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613DC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206A92087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH651Ypc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgDXPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726301AbgDXPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:06:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC410C09B045;
        Fri, 24 Apr 2020 08:06:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so10453814qkk.5;
        Fri, 24 Apr 2020 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yyX/3hlYI9v8tniswwYztr6J4TMawjRxXhM0VuPsDdM=;
        b=NH651Ypc8kYaUmZRnZHoe1JJ3fUD2+GJ3Ju660JSJbKdjO/JCCfEnXMSbakVxDPR3I
         qlOXYi3UQkbrihFjzTzqi4rlyplp9mqERg06+Ye/uKROe4g6knNMuq4fEY/1Bn/REPhf
         YLt7GRxUm0FPcAu47KIwA7QADukeo0rQY6V14KjHcUmFl2e0CkpBvNVqhVdvolQ0/COm
         ccgjXiyQRe4bHPQ8URk26SSPW5ZFk4avXRwcriBEscsEjXf6ajuqjQmofaIQpagLGfVZ
         alejKa0+l0fdeCGdEQWiuNrODXjN5hfhQvMVVO/nJXJoW2oxVo28Zl68N0XQVH3MD2Qv
         H8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yyX/3hlYI9v8tniswwYztr6J4TMawjRxXhM0VuPsDdM=;
        b=sK+MaY4rdBBYO11SptlCAm0V6dsOl6F7EIz8NsV2rPrQZCwZU1dCmPkWQU/xj7oMM/
         tO9kTj/afVlwQaqtsfERM9JX11MpcIX8czYDPWXqRYCEmodHA4ENjj8zWYaRm/OXBXjr
         giaGwv+8/R15dVlcC0EyfRXQ7FXZHvabUSBZgPppoLrsaW8YfDOGJt5aGrsSW7EaP7bx
         /trXc41e4Qv4Wy+gBOQctfPXioZMLGDqb4m0CCgV0NR+o+ZvUvFos0CIAP8a9+CXsqc4
         aLX2s76Jyc1BvbnWkLKb8o0PNRhrQ27x01Dem/hV87ACGXybrmDdcClWfDANl0FR1azO
         sByA==
X-Gm-Message-State: AGi0Pubv+ZVMPEdsTp6vyuHs5ke2yqb7SNh3ODpGwgSE3rQ54O2b0qA+
        PAz7jCVqJNCn+Zd+ydWaDP8=
X-Google-Smtp-Source: APiQypKtscCOWMmu820+Wft70OlEY8PI5k3/2hiIPFvw+plUyz3duppEjFYPb+sUqI7aArSzgtVvZg==
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr9666653qke.307.1587740794854;
        Fri, 24 Apr 2020 08:06:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y185sm2740750qkd.29.2020.04.24.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:06:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78FFC409A3; Fri, 24 Apr 2020 12:06:31 -0300 (-03)
Date:   Fri, 24 Apr 2020 12:06:31 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf symbol: Fix kernel symbol address display
Message-ID: <20200424150631.GN19437@kernel.org>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
 <20200420204617.GA23638@kernel.org>
 <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <475a5c86-2be3-4f12-56f3-7bd6587e8ec3@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 24, 2020 at 02:37:01PM +0200, Thomas Richter escreveu:
> On 4/20/20 10:46 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 15, 2020 at 09:07:44AM +0200, Thomas Richter escreveu:
> >> Running commands
> >>
> >>    ./perf record -e rb0000 -- find .
> >>    ./perf report -v
> > 
> > Or when pressing 'V' in the TUI.
> >  
> >> reveals symbol names and its addresses. There is a mismatch between
> > 
> > Yeah, an address that at some point was put there to help with debugging
> > the symbol resolution, IIRC how it looked like when looking at
> > 
> >   readelf -sW vmlinux
> > 
> > Or any other DSO, for instance, for a glibc symbol here:
> > 
> > Using 'perf report -s pid,dso,sym' then pressing 'V':
> > 
> >    1.55%    20325:perf  /usr/lib64/libc-2.30.so   0x161825   B [.] __strlen_avx2
> > 
> > [acme@five perf]$ readelf -sW /usr/lib64/libc-2.30.so | grep strlen_avx2
> >  24371: 0000000000161810   414 FUNC    LOCAL  DEFAULT   15 __strlen_avx2
> > [acme@five perf]$ 
> > 
> > Can you check if doing in /lib/modules/.../build/vmlinux produces what
> > appears when 'V' is in place?
> > 
> > And perhaps we can also show the DSO offset and the rip as it gets laid
> > out in memory in the end? So we have all the informations?
> > 
> > - Arnaldo
> > 
> 
> Arnaldo,
> 
> having verified this also works in the TUI mode using 'V', are you going to pick
> this patch?

That would be a change in behaviour, the original intent was to show the
value one would get from the ELF symbol table, isn't that the case?

That is why I asked if you would think that providing the information
you want, which is matching to what is in kallsyms, would be
interesting, which I think it is, but how? showing the vmlinux offset
somehow?
 
> Thanks
> 
> 
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Matthias Hartmann
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 

- Arnaldo
