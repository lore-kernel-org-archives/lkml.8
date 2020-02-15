Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2DCC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E9120848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bU6lw4iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBODXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:23:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41814 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgBODXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:23:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so5828855pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z65G6LKuEtCoqo5GGaPgx09a+2BXvSVN0w9gGi4UAJ4=;
        b=bU6lw4iUNRZ3eVEcecIzhDwY9EGz7Ivsr5ShJBODZVWSZfQHGxXtJeIczMMQFqeupW
         tRqD3LiPDR1i3d5ZvyWF3RJj3LeFOWgspQSmwt0RGku7p9WU9R/a6foQ7hRfoPcm9OWi
         x5wFkiHkg+iSWGPnf2hzAfxokrMTRGK+i4kPY4sMy0h4mGkJKJdJs9fB0NByyplFu/U/
         ZFF9Psd8FIhYNT1cJZObY9WidgauX5USFvm+ReCvkHEoVrRRF35ZuvGiaanUYr6gS3lI
         yv2XCeelDb33HF8DI07EPbLtcAaeAnpMxzGXSBrPaOoyLdRcvQ8VG3h5Sd1pxUj8PR8B
         7b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z65G6LKuEtCoqo5GGaPgx09a+2BXvSVN0w9gGi4UAJ4=;
        b=Ym/kHU8URKRGekqaQDfw0v0adQrsVlgqegemdxH6FtXI5lVKz2ztFJmE3QRW674X4v
         zi8lriHXY67P8cwYJmXoi0PGTZKsY4/vT/O/66mljrxO+lmpWfXFtDKa3rwVMjzxPXXB
         5k0uqvshbkfJKKN+h1ETjO/8vTMLGmD5RF89piW4PKpb2bqmrjb92aEFK75wy/9/2gqN
         v7G6yciCTWgsDjqT0GbLwAS7CfvLjLo0T1N2T1p4g+GFGX3jgcosm16DS8rTov4nDscx
         W7fEI53w5uUd226Ylz0xpVXjAVf9tRT1zJ+sUiUiSjmPrgMIdIiLuwVt+grRDVsvE8a7
         MHcw==
X-Gm-Message-State: APjAAAUz7ZFH/fieBZfI2KlZEPJlJSUVzKLEweW+MfQ+/hKzOR7LBnYl
        0lR+eYj72AgM7MH49HCM6TWU9w==
X-Google-Smtp-Source: APXvYqxSr0LLisbZgcKQK0MuobOfHy4v5r4xZsAbkqx0/24TWjgLiRbGkJv+2SZWfbXt2/Knv6LljQ==
X-Received: by 2002:a63:d710:: with SMTP id d16mr6641376pgg.393.1581736990851;
        Fri, 14 Feb 2020 19:23:10 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id u3sm7948843pjv.32.2020.02.14.19.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 19:23:10 -0800 (PST)
Date:   Sat, 15 Feb 2020 11:22:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200215032259.GA21048@leoy-ThinkPad-X240s>
References: <20200213094204.2568-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:41:59PM +0800, Leo Yan wrote:
> This patch series is to address issues for synthesizing instruction
> samples, especially when the instruction sample period is small enough,
> the current logic cannot synthesize multiple instruction samples within
> one instruction range packet.

Thanks a lot for Mike's review.

Hi Mathieu/Suzuki, I'd like get your green light before we can ask
Arnaldo to help merge this patch set.  Thanks!

Leo
