Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD128C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FFB20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OWDasQsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBJBno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:43:44 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44008 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgBJBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 20:43:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so4779825oth.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HdwoUvKACAu13YTpgkcA2GYzOLF4EXKUPzTpSp3Y354=;
        b=OWDasQsz0mzVFR9NAt3/dyP6IIx6MvuQQk/PMLMcNc5J5Q2l/ZX9JlPy3ONAjfV1M+
         sEuBiVbCoGOeWqeDw32+6/YQUu6fznqbJ8ZexyTCMHECPY64+PRjoV1PwfDHfxiuqPig
         m2wz/WYPPexf1OuqvnAwKlwoUCD3O0DULryKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HdwoUvKACAu13YTpgkcA2GYzOLF4EXKUPzTpSp3Y354=;
        b=Mw5e/nHvmW/AOUvuciP6RXSk3m97osx232gc2rxJ8PQv2JpJ/01oUjaTlpWzee12rD
         SKhz55xnOY89ng3hBjcxM2CBifYpYH/2ObEJ120dueK5b0Uyyj0Y3MPkazX/PBEB1Ri7
         u6DzriD6b7CEgl9DBjze5cXW4T66byWREzgTGT3tEJDv30ksVVVznWZcYDM2t/1fs9PO
         UAs4FFQlLuMDbA3i4CaXqMLbfCKba8EKiLyo8MsCmi7ygmkgGFdq+DPURyEXg1V9ep3E
         WbbMIBR8vFDxfGSAwOmV2OOkYMPZvnqyq/HO9ReQzz7KJ/d5JvTmQ4FJDRK2mjTsi0ZJ
         cMtw==
X-Gm-Message-State: APjAAAUKuB7mJ1/AJvMByH2Z7APrGH82ymfpEsSKJ8fP+c4nUNaiDWTi
        HghsXZ6haNlY2FheA/2M/oFowA==
X-Google-Smtp-Source: APXvYqxJIiGcpGRtLkseu5csk6qVTgBaW3SqsXIHMJ1sQpVYEgldsMB1fM/RGLKTb04sdm8bPtwUSQ==
X-Received: by 2002:a9d:7a89:: with SMTP id l9mr6809190otn.228.1581299023111;
        Sun, 09 Feb 2020 17:43:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y25sm3999524oto.27.2020.02.09.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 17:43:42 -0800 (PST)
Date:   Sun, 9 Feb 2020 17:43:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <202002091742.7B1E6BF19@keescook>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207092423.GC14914@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:24:23AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2020 at 12:02:36PM -0800, Andy Lutomirski wrote:
> > Also, in the shiny new era of
> > Intel-CPUs-can’t-handle-Jcc-spanning-a-cacheline, function alignment
> > may actually matter.
> 
> *groan*, indeed. I just went and looked that up. I missed this one in
> all the other fuss :/
> 
> So per:
> 
>   https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf
> 
> the toolchain mitigations only work if the offset in the ifetch window
> (32 bytes) is preserved. Which seems to suggest we ought to align all
> functions to 32byte before randomizing it, otherwise we're almost
> guaranteed to change this offset by the act of randomizing.

Wheee! This sounds like in needs to be fixed generally, yes? (And I see
"FUNCTION_ALIGN" macro is currently 16 bytes...

-- 
Kees Cook
