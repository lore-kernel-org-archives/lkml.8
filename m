Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D8C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AF32075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HSWxiMXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgDVKdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgDVKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:25:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C1C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:25:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so4569552wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=knCP+aW8Y5W/PEzN9s6sK2CQNm77tzBl1PV89WdKtO8=;
        b=HSWxiMXMmyQS4oSTX9w7RsB9TQfw8MQXxMJYukgHAavi2y+mFGugiOpVIQO0wAzWgD
         dC8EYYHRBD69HWWWiUKJaZaLavOGSYiVS8HdMjCbqgJRyOgzJR0fIjaLaMS6CXplCUJD
         HVWMDwOvpolQ6wXQe4IbWRp0m+sWByb3EWA9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knCP+aW8Y5W/PEzN9s6sK2CQNm77tzBl1PV89WdKtO8=;
        b=Z1twk+lyg+Gs8vtjwzbqgzJ4QAwn+c8W+RFqUmU+WA3SedpeEgPcGW23i6wfEKoWbL
         /58zdhp52F7fGqu0oHFPhz/Gx0AhtoxWFyffFr/V8BiNT6u3ptWnPTXoBhZdfKXjS23h
         oCpRjLDdp0xRBZqX4lYXwPDEcnnlmM+EKEgBtWO3pZ49VJ8q5aYBinZB9glbFAwgDkI7
         q+iQ1AvpiGxWoP8sE6H5U2618Q4YpkOoI4QsILFDg6S/hhjAlQk0MkJCN9QYjAxRoEDD
         sE1zCONMWCW2q+znuCbBl5O7PZ+RP/QdVQftLt/2wEB5t9eTE97Dtq+FpzhbGJvqlSIC
         IhQw==
X-Gm-Message-State: AGi0PuYiaM3V/WYP450yw1yXvVEoWKMmPwCTNKXnV7xnHn9K8K9Kmn/I
        b2ExDaRtFX33i/53qlw1AdwNUQ==
X-Google-Smtp-Source: APiQypJGosHQPF1ZsovGLZqXng+4NqAXsZZT0+x9rW0B7ixde2wymhQ4VWtJizufYNWp9iDN0SsCkg==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr10265956wmg.32.1587551105770;
        Wed, 22 Apr 2020 03:25:05 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id g69sm7524299wmg.17.2020.04.22.03.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 03:25:05 -0700 (PDT)
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-9-will@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk>
Date:   Wed, 22 Apr 2020 12:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421151537.19241-9-will@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2020 17.15, Will Deacon wrote:
> Passing a volatile-qualified pointer to READ_ONCE() is an absolute
> trainwreck for code generation: the use of 'typeof()' to define a
> temporary variable inside the macro means that the final evaluation in
> macro scope ends up forcing a read back from the stack. When stack
> protector is enabled (the default for arm64, at least), this causes
> the compiler to vomit up all sorts of junk.
> 
> Unfortunately, dropping pointer qualifiers inside the macro poses quite
> a challenge, especially since the pointed-to type is permitted to be an
> aggregate, and this is relied upon by mm/ code accessing things like
> 'pmd_t'. Based on numerous hacks and discussions on the mailing list,
> this is the best I've managed to come up with.

Hm, maybe this can be brought to work, only very lightly tested. It
basically abuses what -Wignored-qualifiers points out:

  warning: type qualifiers ignored on function return type

Example showing the idea:

const int c(void);
volatile int v(void);

int hack(int x, int y)
{
	typeof(c()) a = x;
	typeof(v()) b = y;

	a += b;
	b += a;
	a += b;
	return a;
}

Since that compiles, a cannot be const-qualified, and the generated code
certainly suggests that b is not volatile-qualified. So something like

#define unqual_type(x) _unqual_type(x, unique_id_dance)
#define _unqual_type(x, id) typeof( ({
  typeof(x) id(void);
  id();
}) )

and perhaps some _Pragma("GCC diagnostic push")/_Pragma("GCC diagnostic
ignored -Wignored-qualifiers")/_Pragma("GCC diagnostic pop") could
prevent the warning (which is in -Wextra, so I don't think it would
appear in a normal build anyway).

No idea how well any of this would work across gcc versions or with clang.

Rasmus
