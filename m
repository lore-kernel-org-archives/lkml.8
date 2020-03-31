Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C13C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8242208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtTy51Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgCaTNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:13:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39145 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCaTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:13:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id b62so24341547qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xnXKiXrY61oYolom9f5N9TQhFrH19Lqhp9XoUKFF+M=;
        b=NtTy51FzUVacP0N/3KFBUGjCOQLY4HrefnFV679cbFrBRiDI+PihQ2aM2ilgSzOFSm
         wvGUWR1XU3w2g3gnmAYEsbR3Pv1HU1Xa/QqMsGyNXABzCs6BBJI7ZHcjjK4TA0vK1lX2
         zZllfOmdkxFdsRHK0eQpy6m73BtxzjFMPaouhfeYlTeVuPHFNs6GVgbFgilv3qfp0rx4
         zxtmTgBuEsZToBfEwaGDiulcrMlAfGJN8AdC3hYZN1Y4etLx7fAQy7gxljsPmCddV+i4
         +8kG/LVta9z9ow5izaEx6yiwRR6ZTaY4IbcQomO9JD6zydkrBcokQBc4aT3F8A57FUq2
         W4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xnXKiXrY61oYolom9f5N9TQhFrH19Lqhp9XoUKFF+M=;
        b=G3lFNrvlpeomMni/1ulvhXIvzIxK/PV3ropxzFPd7H8AZH9M2RP97Kf3RyKE24PJfp
         DMF3+5DqWb+S7/8JF4OJAWji8LksT0BgTlzzXF82JI+xUalcTd6XuARzSr9C853/hBZw
         sUr04gn9cq0wNaOmL0+wQNwQjJEpvkvQXrVEKSjUI5v+DSU+W4+k2ay+LABPgh9Ijm0A
         bkjv1qm+4xDSFEp0QfOjvsMke4Q0md5ubMdqOUtAB/YKAzfQOaSL3gWLdsuaV0tXI+Z7
         ZS5V77hyeFRK+wEnnYKB1lGwFwAYZUgQAQstMzbENZxts53PS4E8HknOIwXaOwCa8Rqt
         TAZw==
X-Gm-Message-State: ANhLgQ3r1eoQKcR00uXLWa+1rUp6YlMkUBJhfvZVkGzdyu/343vh+loE
        fLONNsoRnORnmJgfFPmkK78=
X-Google-Smtp-Source: ADFU+vsRWnlI/jt5w4lXCMNVmI/dYIM0oVZuoFxLSnisC2C1lQfhSQlwzPPdqDA2EKE/yMlRsxPygQ==
X-Received: by 2002:a37:9b51:: with SMTP id d78mr6697810qke.65.1585681990793;
        Tue, 31 Mar 2020 12:13:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l60sm14089971qtd.35.2020.03.31.12.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:13:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12FF1409A3; Tue, 31 Mar 2020 16:13:08 -0300 (-03)
Date:   Tue, 31 Mar 2020 16:13:07 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH V2] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200331191307.GM9917@kernel.org>
References: <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava>
 <20200325142214.GD14102@kernel.org>
 <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
 <20200325152211.GA1908530@krava>
 <fc3c4dee-981e-4c39-566a-4163ee0bcc02@intel.com>
 <20200325174449.GB1934048@krava>
 <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
 <20200326092545.GE1947699@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326092545.GE1947699@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 10:25:45AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 26, 2020 at 10:01:47AM +0200, Adrian Hunter wrote:
> > The parser would need significant change to rationalize all this, so
> > instead fix for now by adding missing Intel CPU events with 3-part names
> > to the event parser as tokens.

> > Missing events were found by using:

> >     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c

> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
