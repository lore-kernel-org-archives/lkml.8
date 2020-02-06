Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B685C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD61206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="E7jtNADX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBFLO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:14:59 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:42072 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgBFLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:14:58 -0500
Received: by mail-qk1-f179.google.com with SMTP id q15so5100379qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=WB+Kc4aaRBQVx/3SCitqv8cv9/UUnFK4MljQ4dR5GtU=;
        b=E7jtNADXGzRu45M+dCDpGkfhxH+nb5Uu9EeGhAhz01oZIq1wdu1r5uLevbmmBtVQbE
         zBKsMlYKn3+MDa5Uk/ruSCMXeOjQbZdcwU6zu090+cNAlEXOEYyaEG9uU4JH2oecn93B
         1ueLlIdMi0B+W6fn2APTO/OibDLHXkcI0+gObobCMlZA4FGMr29NRoM12z4msLfkdXUt
         Wif7H2ChB6lq7mk0OE8DgndujHdB1lHms2hMuyAD9ooIUHAhwIrieFqLYUi4ogyYLnDW
         YX/eoIFyZhTwgiBXq5JhdAQDyN4bNgWAk2H0cDu/sPX3olTkF+9sAA3eCh03IqE/pKei
         fYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=WB+Kc4aaRBQVx/3SCitqv8cv9/UUnFK4MljQ4dR5GtU=;
        b=BUdPQqRjhoszKL+4geFD7/sf6AQNvc3vYfyV275aqVhptmF1v/6mlvaWop5NqOg3Lb
         HLNsjXllqrevIb3O/nsWFYNrWyLmChe154fq+wovn+uPALEYg8mMPEqa1oVGGZjLLjip
         9U6MRNaIBJb9C9ubOpENe+fYqHGgrhAza3GQ3fCrdXMWrwEBRk9XWjq1LN4hrhpSdT/7
         8gBvh5n+AOzUDDwqenjLnWgBs/QFrPI/k4D/MlKbJsnPHtLqKjrwI+PRJXck3GI2sp7G
         YKSqqKLph+A3aptPlxMlO7759jUXHEVdn5a+qw2uI8B/EoA/BXxU0u85626t3r+sGjWZ
         1HKA==
X-Gm-Message-State: APjAAAW9Ki1BONQbkvTEllx9aDj8d8wftgSJUGSM+NEzhvvZ0DNeY057
        LlacQBtj3SkLlpQ+Ha0c49z4NA==
X-Google-Smtp-Source: APXvYqwvlxZN2Fs7dRKuWabEEgWbV/2Fzb0wdfDhk1fulIs8k8+rWzbgKsYVtvCjfNsLqu4oLpiP6w==
X-Received: by 2002:a37:6241:: with SMTP id w62mr1981884qkb.197.1580987696372;
        Thu, 06 Feb 2020 03:14:56 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z5sm1525247qta.7.2020.02.06.03.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 03:14:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
Date:   Thu, 6 Feb 2020 06:14:55 -0500
Message-Id: <3E1FB0B8-F499-45F7-9B03-7B80395FFF19@lca.pw>
References: <20200206090436.GF14001@quack2.suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>, akpm@linux-foundation.org,
        ira.weiny@intel.com, dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200206090436.GF14001@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 4:04 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> So in this particular case, store tearing is non-issue because we use
> atomic operation to store the value in page_cpupid_xchg_last(). I think it=

> would make some sense to use READ_ONCE(page->flags) here to prevent
> compiler from loading page->flags several times - I have hard time finding=

> a reason why a compiler would want to do that but conceptually that
> protection makes sense, it is for free performance wise, and will still
> allow KCSAN to find a race in case we ever grow a place that modifies
> page's zone non-atomically (which might be a real problem). And it should
> also silence the KCSAN warning AFAIU.

Ah, read up to 3 bits might be an issue then. I=E2=80=99ll post an alternati=
ve version which uses READ_ONCE() just for the old page ( because the new pa=
ge has not been published yet) in wp_page_copy() then.=
