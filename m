Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB31CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F0320786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcmAqGk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgFQDgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:36:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF0C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:36:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z63so468212pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLJBB3pRoWG5efQHi3veUFRcagcqJ+oWknNXTwAk0o0=;
        b=NcmAqGk+iRuqRcsBVf4/+Ex0k/oFPhiAYwMxrL0tiAKhUfjO6L9sXlM9BOpAI6QVbu
         KDVYyPvTr3mHFIUXiuuzh8dTwGEfhsa0pRlk7EZ2vdpybUMt71pw5yS5SLUilMgf9lvA
         KLYKhZNTSD40IU6tRKvcLbIBTkgWccHUzP0bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLJBB3pRoWG5efQHi3veUFRcagcqJ+oWknNXTwAk0o0=;
        b=FooyjQUzJ408dj+Xd30wY6KqUUYcgWVYNd6dnCE0/qJhg72LpKTQRy6Um5mdU8U1Li
         5xgH3A+LBtDXAiK/93pG4nRS4fNrLs/HslwH4kHAmUg5qMbQUGaxauUbHbMPs9jEDDCW
         k9L0bi1ZEPmflHgxsSbMTjqI9sORN6UkvTQjpISc9NoNgxnszo+hJch/s+ams00ccP4/
         PTmJS3T0J38o3ABKAK5zw3Rsl2UFjwI0xjmmbFZb09F2pAh1Ot9mRf4BqxE5kNzfLWKN
         geyaV2JHe88/8frVuaWJvqGg8Ad6ISQkBHOt8OBVer8qrd0vncMKB8c/jSN9dTurqx9M
         Qwzw==
X-Gm-Message-State: AOAM530if/GxmX0mJQVL3I68SkT/X9AAFcmtTtBm0iO7VYB8k4GsgecC
        W2sRQ0qENwXopGNpm/m8qd/AiA==
X-Google-Smtp-Source: ABdhPJzt2IyfSrsCjbnEWsH+80i2Sph0IP1u82KvDONyDI5ns9Z8WN7IKClvSiOHQihmzNQ32Orptg==
X-Received: by 2002:a63:778c:: with SMTP id s134mr4407440pgc.273.1592364968589;
        Tue, 16 Jun 2020 20:36:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt14sm3797226pjb.52.2020.06.16.20.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 20:36:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 20:36:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006162032.9BF6F8F4E@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook>
 <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:30:45AM +0000, Bird, Tim wrote:
> Agreed.  You only need machine-parsable data if you expect the CI
> system to do something more with the data than just present it.
> What that would be, that would be common for all tests (or at least
> many test), is unclear.  Maybe there are patterns in the diagnostic
> data that could lead to higher-level analysis, or even automated
> fixes, that don't become apparent if the data is unstructured.  But
> it's hard to know until you have lots of data.  I think just getting
> the other things consistent is a good priority right now.

Yeah. I think the main place for this is performance analysis, but I
think that's a separate system entirely. TAP is really strictly yes/no,
where as performance analysis a whole other thing. The only other thing
I can think of is some kind of feature analysis, but that would be built
out of the standard yes/no output. i.e. if I create a test that checks
for specific security mitigation features (*cough*LKDTM*cough*), having
a dashboard that shows features down one axis and architectures and/or
kernel versions on other axes, then I get a pretty picture. But it's
still being built out of the yes/no info.

*shrug*

I think diagnostic should be expressly non-machine-oriented.

-- 
Kees Cook
