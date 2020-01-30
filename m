Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75EC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1832083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YI05/kb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA3Lua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:50:30 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35466 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Lua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:50:30 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so1323151qvi.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ttghg393IcGYJbiUFt+itRymnd0g1UG0znqTqhkFJvg=;
        b=YI05/kb5PylcWPrNdQz66P/RD1w239dHch8g0Ed+JSrJAyrwTMGmFQSi5sjikFFjxF
         4nEz6igVFHV7W8JuJtfTJA9A7xsUKQnJDngMYyEe3f8Y+F06w2fTt+R6KcldkvgKNUKV
         h+AFu+ksY6xGX7xyA4ZgQ7/77Bx6hZMdw52JT1XPuVhbekLGMfYd5P6SIjSfrbhn45/7
         yE9xwrzKZbzCDLmHkAF7OUXaUnkd+/1/J61o78QaS/mPDer8tBRE0gLmOz+eTdV9Y9ff
         1h3El82Y1tme6BsrI3jgMmHnKfGn9QYr2Mt7Iv8TfZu1I4UMYoEyTX++wl8u3Cp/bxDE
         tP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ttghg393IcGYJbiUFt+itRymnd0g1UG0znqTqhkFJvg=;
        b=oIRH4SwABGCKeMB3uZPHMR5vw+UjGWuA8rjgkPJw9P7yhgbteTyeRb13PPeDZ9/j8Q
         +2W8rp/DPA/XklVxbBJhXSqeHblRrht8t1yBoP7YyTP2/FbsXpOwL8lpjABVJVf5wEKI
         nktKDBTAlFGtQUN6hi2wGfZ+zAE3C3K98VM0y6BbQvqZYz/dU1DrjudkwTSNmGvfJzb0
         rSXT84dIBUStwLjv140hl/1pbyp0asYpIYtlEVRz0HtFPFu5QTrTAQCUN7bKXRSzEgDb
         JSwlFzRSFxguKbS+QGJ1It44PjnkelDOO1f+wyiFIWbIi/ZMKtiiT/KDMTFOFD6yn7uU
         tIcg==
X-Gm-Message-State: APjAAAVngwSJx0RgoMsqS428zVA6ykhKUvkF6gM8jqOjxrm5gTCuU43M
        zvNV5vaND17UOKJKkZHSc5J/cA==
X-Google-Smtp-Source: APXvYqz9K0TnyCHjPr4h7Ru5x4wYWQDd6UzsnvxHEaln5ea4uS8H4TF0QIknxQK6MN6zdBgpeV7czQ==
X-Received: by 2002:a0c:ac4e:: with SMTP id m14mr3953888qvb.37.1580385029184;
        Thu, 30 Jan 2020 03:50:29 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 206sm2604472qkf.132.2020.01.30.03.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 03:50:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/util: fix a data race in __vm_enough_memory()
Date:   Thu, 30 Jan 2020 06:50:27 -0500
Message-Id: <1135BD67-4CCB-4700-8150-44E7E323D385@lca.pw>
References: <20200130042011.GI6615@bombadil.infradead.org>
Cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200130042011.GI6615@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 11:20 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> I'm really not a fan of exposing the internals of a percpu_counter outside=

> the percpu_counter.h file.  Why shouldn't this be fixed by putting the
> READ_ONCE() inside percpu_counter_read()?

It is because not all places suffer from a data race. For example, in __wb_u=
pdate_bandwidth(), it was protected by a lock. I was a bit worry about blind=
ly adding READ_ONCE() inside percpu_counter_read() might has unexpected side=
-effect. For example, it is unnecessary to have READ_ONCE() for a volatile v=
ariable. So, I thought just to keep the change minimal with a trade off by e=
xposing a bit internal details as you mentioned.

However, I had also copied the percpu maintainers to see if they have any pr=
eferences?=
