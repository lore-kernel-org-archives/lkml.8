Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE22C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621F92468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SZKiRRvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgA1KUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:20:38 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37246 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgA1KUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:20:38 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so12798882qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8nN4YmrckRTf8D2dP5lgaGNARd4RPlRhl2giKkNVrQI=;
        b=SZKiRRvvRUyAp1uFv/kJcIBn/Bf2xzyeiBe/6+Lcw8TL7vaRckTn3FRww7Y8C4p8ix
         H+mce+5WKiydHgnr3WppBsKE9xBTAMIu7Ue/YTthYC7XHytWFUPte57JqleUi/rvLP/+
         hebaZYBTg4DYG0lGKoZvEhIxdzwBoQrY7aivkZu2yjQQzi/gENjt6eIlpGXgEJ7J4LQj
         jis0rtbnAygbXy8xMVB5AAlD615DIlK6n5dLrcIi86j5JKB/qgHdz8OV1TAYcXolU72j
         fDAHWhf3QXs2KHz1zyBwWgxuP0ipTjW3v6A+GS0RK4O+BYe5041poUOQt6s3nE/bzbQN
         NaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8nN4YmrckRTf8D2dP5lgaGNARd4RPlRhl2giKkNVrQI=;
        b=RrPRtHbnkGdThKv7xO0xyCq8XW9SVNPbtCRxsgCEBf6W8FvlqKFGtuuqi7H8Uv3PL+
         cJ9W47GiCYdrmCAZS+oTbhS6MI28Mi9HK4kAK8fWJmjg98YTcdfyprsMZUnbyFjCHYPG
         ggCG9Vr7xSZW2xiwHVEFpb3qG1jJGdrHw+w4Vk37Bfk7UDPNi7EjZEmCWk90klotL/v+
         p85b3XQdLFJZIZQENHZ6qmYwVHIM63KfOQG1lGwNYm7DOnDYQfzVM5wY/jJya62h8TCo
         e/JpGnLGHVlimmMWVNWzO35kAkGmDXoTowjN022l6q+p1ptEOp4OMIvezTmx9Q3o/lzL
         70Vw==
X-Gm-Message-State: APjAAAXxbhf6NMBYJxv7FmqcS+4cLZyYRvU6w4Cj/+RpzBAJGzHialQf
        7Vxfrm/tyCxQZpEhCYyjNknraw==
X-Google-Smtp-Source: APXvYqwU7/hPZRUWDnW/GNfRKd6PyEbF4B9KvaAC3dn3Ta6yCqfrL75TqqBlagLHsnIkgINypMF+mw==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr21006594qkg.71.1580206837123;
        Tue, 28 Jan 2020 02:20:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c8sm3228988qkk.37.2020.01.28.02.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 02:20:36 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Jan 2020 05:20:35 -0500
Message-Id: <D20B234E-04EE-4410-9B27-FF63AB3E1808@lca.pw>
References: <20200128085742.14566-1-sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        sj38.park@gmail.com, acme@kernel.org, amit@kernel.org,
        brendan.d.gregg@gmail.com, corbet@lwn.net, dwmw@amazon.com,
        mgorman@suse.de, rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200128085742.14566-1-sjpark@amazon.com>
To:     sjpark@amazon.com
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 3:58 AM, sjpark@amazon.com wrote:
>=20
> This patchset introduces a new kernel module for practical monitoring of d=
ata
> accesses, namely DAMON.
>=20
> The patches are organized in the following sequence.  The first four patch=
es
> implements the core logic of DAMON one by one.  After that, the fifth patc=
h
> implements DAMON's debugfs interface for users.  To provide a minimal refe=
rence
> to the low level interface and for more convenient use/tests of the DAMON,=
 the
> sixth patch implements an user space tool.  The seventh patch adds a docum=
ent
> for administrators of DAMON, and the eightth patch provides DAMON's kunit
> tests.  Finally, the ninth patch implements a tracepoint for DAMON.  As th=
e
> tracepoint prints every monitoring results, it will be easily integrated w=
ith
> other tracers supporting tracepoints including perf.

I am a bit surprised that this patchset did not include perf maintainers whi=
ch makes me wonder if there is any attempt to discuss first if we actually n=
eed a whole new subsystem for it or a existing tool can be enhanced.=
