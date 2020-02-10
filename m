Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB1C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF8214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581307583;
	bh=mgQgZnHgJLUe03AmTrnxQLHDg/eEeWeFgD4hyyYyxP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CEphgihx93y8Fc255Vs2YgSek1xRbHRO8KT8npPcV2AMSnKHiek3VTGCzEfXDv1Cz
	 Xl9NndCebao8NXlj2RNJrFz3Ix3A3rdkyiHqBXQ/WUH46XqXbjMo0TJK+psTtZ8dN9
	 A/XygKoEgN25ta2uC6GifUuJ3hMVJGPLW9F+9A5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBJEGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 23:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgBJEGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 23:06:22 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131AA20870;
        Mon, 10 Feb 2020 04:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581307581;
        bh=mgQgZnHgJLUe03AmTrnxQLHDg/eEeWeFgD4hyyYyxP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=roX/OaMPuaOv9ISVlRhS8nrMi9iND/OqFcBkES9ueWrlcDx64VzCadTQKwBbre8iM
         hwBbMd4Qi1C6yYmyiossT24qhGZlW6MjKtT647usK5EpaYia6+geLFpXS1Awr1tvUE
         +eUX7COsz5JFthVysynN0wpwQhohR5qSKA8lksP8=
Date:   Sun, 9 Feb 2020 20:06:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, jhubbard@nvidia.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in
 page_zonenum
Message-Id: <20200209200620.883ad431b01bcd38939ff5b4@linux-foundation.org>
In-Reply-To: <2B333FA6-AB17-4169-B9EE-9355FF9C42A4@lca.pw>
References: <20200209182008.008c06f1cf4347a95f9de0a5@linux-foundation.org>
        <2B333FA6-AB17-4169-B9EE-9355FF9C42A4@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2020 21:41:56 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Feb 9, 2020, at 9:20 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > Using data_race() here seems misleading - there is no race, but we're
> > using data_race() to suppress a false positive warning from KCSAN, yes?
> 
> It is a data race in the sense of compilers, i.e., KCSAN is a compiler instrumentation, so here the load and store are both in word-size, but code here is only interested in 3 bits which are never changed. Thus, it is a harmless data race.
> 
> Marco also mentioned,
> 
> “Various options were considered, and based on feedback from Linus,
> decided 'data_race(..)' is the best option:”
> 
> lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/
> 
> Paul also said,
> 
> ”People will get used to the name more quickly than they will get used
> to typing the extra seven characters.  Here is the current comment header:
> 
> /*
>  * data_race(): macro to document that accesses in an expression may conflict with
>  * other concurrent accesses resulting in data races, but the resulting
>  * behaviour is deemed safe regardless.
>  *
>  * This macro *does not* affect normal code generation, but is a hint to tooling
>  * that data races here should be ignored.
>  */
> 
> I will be converting this to docbook form.
> 
> In addition, in the KCSAN documentation:
> 
> * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
>   any data races due to accesses in ``expr`` should be ignored and resulting
>   behaviour when encountering a data race is deemed safe.”

OK.  But I believe page_zonenum() still deserves a comment explaining
that there is no race and explaining why we're using data_race()
anyway.  Otherwise the use of data_race() is simply misleading.

