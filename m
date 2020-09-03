Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEBDC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10F120786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a94Ux7R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgICPV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgICPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:21:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2042C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:21:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so3278015wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUweod+uqjt0fy1FhQduTmrLFzl6ANoKL+CTIQ2c5rE=;
        b=a94Ux7R1+N0TZSiVBeTS41VzYFQ5koFtL0bMtGK4k3B/ay3KEcxS2pseWU5EYobR0U
         ANKvasdf/uxjAaffItCOwnfj1qk1OiwOqRvOEByrftd7mt0p0DA+LHZEWLvYRsLZIbz9
         vuQmiA1mjeKWRNRKbmPgQJLUbL6cQkWGwzh6OHx2mYOpVca1H1oAipcAoRKc3Kg6jn8k
         6BsiAGvjaZpE0QpyOQA1mslKBeRTFV9lahSbFasMU5U0v7Te+Cc7Qgu5dFk8C+HrxwDr
         JWXpK7qEqzw9IYGI7TqboAbRAc1SeBOzSsrPVEuDEFxgwsBfvcG58Gc67Xpt31i+gS2r
         VQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUweod+uqjt0fy1FhQduTmrLFzl6ANoKL+CTIQ2c5rE=;
        b=nkn0rar4B7ZtATyAgdbUx1DzvsWe2zRKN/OqCBnTircsOofUPzTXXPfQ8SF8AvqPLI
         3hG65bV2VXtGhcz3pF28qvcvEn5cD/iZ/NDGXViBJGUSmxXeWeCszLx9mPOrzAUO2zkU
         43HcwtTqYr4eIpqRYaudaysI6HlD64qTGUz/HGWhUN8WXRpq/h8Tqk4jTn4WGsiZWzAb
         zFpHHP3Ll053xQjFL2oHuRY7i0Zikt0NMKe7TfovQTMW7WcwKK4N9fsd9OQH6sRHD5dh
         aJA6wTxJln7hrJUd4DmNB3ReKGUrjjDCMJEZAK9yi7MJfRPf+Ur9wgHar409NtnUvASm
         imgQ==
X-Gm-Message-State: AOAM530STLY+RYmjV4IxLePbT+KvNsfzax2O9bKuDZ4aIv/iOQS0Y0sy
        VlsK7nNd/w6yMlfFSvB2/ge9sQ==
X-Google-Smtp-Source: ABdhPJzxRDkEmapAsv/TYOx7yttyGVeDeT1Fd/0U949bh6H04Zct7H1cMTXcadc5J/FIMSgkjkvgvw==
X-Received: by 2002:a1c:964b:: with SMTP id y72mr3081957wmd.69.1599146482589;
        Thu, 03 Sep 2020 08:21:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k22sm5168697wrd.29.2020.09.03.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 08:21:21 -0700 (PDT)
Date:   Thu, 3 Sep 2020 16:21:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/13] x86/debug: Untangle handle_debug()
Message-ID: <20200903152120.zroztjtwqtx37asg@holly.lan>
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902132549.496605622@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:25:49PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> The first two patches probably ought to go in x86/urgent, the rest (!RFC) can
> go into x86/core and wait a bit.
> 
> handle_debug() is a mess, and now that we have separate user and kernel paths,
> try and clean it up a bit.
> 
> There's two RFC patches at the end that impact the ptrace_{get,set}_debugreg(6)
> ABI, I've no idea what, if anything, is expected of that or if anybody actually
> cares about that. If I read the code correctly nothing actually consumes the
> value from ptrace_set_debugreg(6).

I applied this both with and without the RFC patches and pointed the
(still work-in-progress) kgdb test suite at it. I won't pretend the
suite is comprehensive but nevertheless FWIW:
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> 
> Kyle, you seem to be pushing all this to the edge with RR, any clues?
> 
> Since v2:
> 
>  - fixed (user) INT1 / icebp detection
>  - some further cleanups
>  - two additional RFC patches
> 
