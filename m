Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7EC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAA206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZiaeSXMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0Rnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:43:41 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39929 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Rnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:43:40 -0400
Received: by mail-pf1-f172.google.com with SMTP id d25so4818472pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fRE9oC9WiHZwMVzNf52uYzsY+j5aMEpW5+lAh89aIM=;
        b=ZiaeSXMA1EVGJVd7a9CrsdW2+EuI+VqqWxqb2xjpSjj3Vn41dz8cbG5VY1IRksxXzo
         jDt0C8jD/1PK1FA9fPTqm4xVof1oA1E5M604DauGk7nA2vz4PCXagVXEiZiS41OjylQy
         5AswoKFNiKCdJlmNqDj3v0WEbzQpZrFW4i2Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fRE9oC9WiHZwMVzNf52uYzsY+j5aMEpW5+lAh89aIM=;
        b=PWM/pJ3wC65YzXd24gaA9xPX32TA4PWXXuMNRHAbmHFc+pNXIOCx+2x6lhr9v1xm4P
         0M+sC3vje7VVmGnvWhh2RJ6G9qq30yCWoEtroypsgpKzFNeGWognE0u0LHAz2XGVCs2X
         li712qJ19MajhdTrd/DVwRug3109xO0FZAQiijM24jHYs237p72FzrHNJtt67jqTUyM8
         UaTv8bm01BEvdrjU1EzppKXRBN/Rw+RNC4BvDHGVOkzQYUaIBwo789SRjtniIWmgVAkG
         596hkf+pcBHuSBxCrfJvag9daAfl9WBqlQ2x9S0kgX3Jh7TQWSkAfZW5AipBFtmYScn5
         5l0g==
X-Gm-Message-State: ANhLgQ2GRZ5Dt+v2v6IKP2dYlpjhhdNoliZnUeohNjYG1OIy91z2OcA6
        wK6jByBIqKtcpymUIH6wdkJFPA==
X-Google-Smtp-Source: ADFU+vuNFYArnQxZChzKQFTXLl3l3wLcUHspaT0bjf+ZT62DMl+JtfSEttic0sSKcbYDg1Lw05+jfA==
X-Received: by 2002:aa7:943c:: with SMTP id y28mr342486pfo.52.1585331019698;
        Fri, 27 Mar 2020 10:43:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm4275778pje.9.2020.03.27.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:43:38 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:43:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/build] x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to
 generic DISCARDS
Message-ID: <202003271042.10557C6413@keescook>
References: <20200326193021.255002-1-hjl.tools@gmail.com>
 <158530727545.28353.10694097580939655357.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158530727545.28353.10694097580939655357.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:07:55AM -0000, tip-bot2 for H.J. Lu wrote:
> The following commit has been merged into the x86/build branch of tip:
> [...]
> x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to generic DISCARDS

Thanks! And just for note, I'll likely wait for -rc2 to resend the
orphan series -- I now depend on _three_ trees. ;) x86/boot, x86/build,
and arm. Heh

-- 
Kees Cook
