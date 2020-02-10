Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BEDC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DF12082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xx+XTdOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJCl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:41:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33875 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgBJCl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:41:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id a23so5170955qka.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 18:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zxVHFFA6yyeOB4fmv3rg72AN0/43RTyaD+z+SAXhgGU=;
        b=Xx+XTdOdvZNFSmUoTS8YIIhoVsC75PEy/QnHtWKbwzFR+mj10hYEFpz/qJqqjTayyz
         YT4CoDy9GnZZuKLxkVwhj+we3r6z9c7CCmwM7pMjWkkphRbC/nEIqw80JMD8HeOGy8tp
         FKhKgIdz/vKQ7SmRXfA6rD+dGJugVVhWA2QjgvZw/sFolOrqqobTvJQ6Y1ZV2RXOX9rT
         eiXKSbw/dAnT/fNO8gm3GWfZqLlnpWWjA0iZ/4itACSyIMBbKIQXBMFZFyRi0pyWSp2Y
         TkfKUcMlbfkA64+0PRfcn/4s3dZ5gPvUfPiBNNAHtDcWT+vHkU89zL5uVUpbj0cgxsz9
         MUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zxVHFFA6yyeOB4fmv3rg72AN0/43RTyaD+z+SAXhgGU=;
        b=VDJ5MIBj3UAoaovvqsTtNVq8ogr97Vaz1SQWhlAXzC8BDzcwjmDQNnJLFVXgQGHFyc
         a9PDLU/T+zGFuW4hb1UdPIXfVb7q4iO6PhKYjDcrnXFRLwayEExMoPGjsUk3shQuOrXs
         ioW6p8nBTSLldfMSh377ZlblTg8+N2VIaCrfqo/QlrwqkT22qYz2yBrhWSf5CFdLoL7h
         M8Ec8dIwAerQ+qRCLPMMV2CWkiGMUe0g7bczfqVPyxbJy7I7B4ZWE6sSlBoC3loEOkvi
         BaIbkAQAgL/Qtl6KMcfNbX5ASrpT0X8i3N+dWKrdZu31NuYeCjbeqHUX0Ae+fwhhBQA9
         ZuZg==
X-Gm-Message-State: APjAAAXBODtqSfEePU99LzIwL9nczIbfvQxpm+XndY1s1JHt30MtYfrz
        CN4gkJ5FedFs/Xp2zfhwJ44Upw==
X-Google-Smtp-Source: APXvYqxqEMoB3T9yTPQ+rQaEJFQKrQHqpYxewjHsDiEocdlR2K3Tx7o/7mRGwXykhNrOekDk6RzfCw==
X-Received: by 2002:a37:4f93:: with SMTP id d141mr8678882qkb.125.1581302517824;
        Sun, 09 Feb 2020 18:41:57 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z16sm2760351qkg.87.2020.02.09.18.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 18:41:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in page_zonenum
Date:   Sun, 9 Feb 2020 21:41:56 -0500
Message-Id: <2B333FA6-AB17-4169-B9EE-9355FF9C42A4@lca.pw>
References: <20200209182008.008c06f1cf4347a95f9de0a5@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, jhubbard@nvidia.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200209182008.008c06f1cf4347a95f9de0a5@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 9, 2020, at 9:20 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
> Using data_race() here seems misleading - there is no race, but we're
> using data_race() to suppress a false positive warning from KCSAN, yes?

It is a data race in the sense of compilers, i.e., KCSAN is a compiler instr=
umentation, so here the load and store are both in word-size, but code here i=
s only interested in 3 bits which are never changed. Thus, it is a harmless d=
ata race.

Marco also mentioned,

=E2=80=9CVarious options were considered, and based on feedback from Linus,
decided 'data_race(..)' is the best option:=E2=80=9D

lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7=
HL5AB2g@mail.gmail.com/

Paul also said,

=E2=80=9DPeople will get used to the name more quickly than they will get us=
ed
to typing the extra seven characters.  Here is the current comment header:

/*
 * data_race(): macro to document that accesses in an expression may conflic=
t with
 * other concurrent accesses resulting in data races, but the resulting
 * behaviour is deemed safe regardless.
 *
 * This macro *does not* affect normal code generation, but is a hint to too=
ling
 * that data races here should be ignored.
 */

I will be converting this to docbook form.

In addition, in the KCSAN documentation:

* KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN th=
at
  any data races due to accesses in ``expr`` should be ignored and resulting=

  behaviour when encountering a data race is deemed safe.=E2=80=9D=
