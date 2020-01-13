Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481ADC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D22207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkPnfeVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAMPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:23:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45293 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgAMPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:23:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so3930086pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P5Fr7LX8SyGjfIYpXVgAHCXpeiamvTYOg9P0ZgSQ/fA=;
        b=wkPnfeVgMtuBv2icEDFQ9boOu3Dyeg4c36Gok3ASUmMFIlaqOiUsxaKd+nbDDgdHgB
         rJbJhRj0zhfQ/kLnXvQAaysOxwd7l2cKa9v+KIrDskDBMdTMLg2naGKhCwfhjTEjsRMW
         xnb2dQ8S1jiM/bEEsiw1tBZ1/KbmafhDH3/GAdJlUWDUq111+5/eG6b/WKyQPUGaiSYC
         1gSanHXp+/Qi+SKhY4kRYyUlRoCUYiBqLls4c0pWlXO5dnKMR4wPu8d+9Bd480R7yfDS
         bc1V2De00kB9a9qw7liS48SdBOXgoorg5q2tu0WyGdsO1dpBY4T1wVEGr3Rt3ze1dce3
         uhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P5Fr7LX8SyGjfIYpXVgAHCXpeiamvTYOg9P0ZgSQ/fA=;
        b=hKgGDXXq3kIL/8psa1JpugjLOBOd46B40Dw7/534vd7VUEWKXRj45xD4vDfk/JxlrD
         QjGvA6QbpLr8qy+7uB4QZXH7qzos7/fp8oMJsVURe+9Y1PbNEQNg25iC2MR0CwtIAP7v
         GXEW3R8OQvqOcbxBpheorKwgnNUz2mrgsS37Lq6IFf/HrLZfLQ4Xff2K0zgsZ+f7yGqr
         POdIET4heJdHOYWBaUSi0wcl5yO9TxAc6MXexdzzqrIDewhA3PY3z4Gy5HUyfIf9Kq1i
         bc34wHaJaNQOwlMeyajs//tzWzLiWN2TH3xhYHCX2Pok+ct5XMZESDcTiWGwFQ4mjqkX
         1DJg==
X-Gm-Message-State: APjAAAWcd6B9UmXmVX6E5/AZNpceAConmVklryx+KTcpCbOwObN8fZEc
        nA7IJSkzjHTyiYVn4UMsOFldzw==
X-Google-Smtp-Source: APXvYqyoZxD3ZhwhXAePP17c+P28G/HRivKern1yZbJF0kFmt9zZKnhCqnFNhZU2yiwviUn4RKBr+Q==
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr23213686pjr.17.1578928991071;
        Mon, 13 Jan 2020 07:23:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id a1sm14299950pfo.68.2020.01.13.07.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 07:23:10 -0800 (PST)
Date:   Mon, 13 Jan 2020 23:22:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200113152259.GD10620@leoy-ThinkPad-X240s>
References: <20200108142010.11269-1-leo.yan@linaro.org>
 <20200110150422.GH82989@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110150422.GH82989@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:04:22PM +0100, Jiri Olsa wrote:
> On Wed, Jan 08, 2020 at 10:20:09PM +0800, Leo Yan wrote:
> > The struct perf_evsel_config_term::val is a union which contains
> > multiple variables for corresponding types.  This leads the union to
> > be complex and also causes complex code logic.
> > 
> > This patch refactors the structure to use two general variables in the
> > 'val' union: one is 'num' for unsigned 64-bit integer and another is
> > 'str' for string variable.  This can simplify the data structure and
> > the related code, this also can benefit for possibly extension.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> there's some arch code that needs to be changed.. please
> change other archs as well
> 
> 
>   CC       arch/x86/util/intel-pt.o
> arch/x86/util/intel-pt.c: In function ‘intel_pt_config_sample_mode’:
> arch/x86/util/intel-pt.c:563:24: error: ‘union <anonymous>’ has no member named ‘cfg_chg’
>   563 |   user_bits = term->val.cfg_chg;

This compiling error will be dismissed in patch v5, since val.cfg_chg
is kept in the structure.

Thanks,
Leo
