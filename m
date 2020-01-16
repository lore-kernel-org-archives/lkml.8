Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1474C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="L4YqFRv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgAPQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:47:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43984 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbgAPQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so19699050qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8oCauuYRE1SlMMis3dug2fzKpE+RxnAnTLSLcxoqrg=;
        b=L4YqFRv/HIosI38aRfTT9RUoXYUj5gQCPC2lArCXXcZhT8t0cWEC5wVZA8qKxvlc8a
         kFYGvUo+HfNgYQP5yPBmaD3GAw0/rCSUBrGiyK46FsXGD+FxCHNdf3wU6/EbRw6drZdM
         BaaqTF8xakilbxpoHJCvVUvFlAVn1cjTacfc18AokSq9CqlXbX7wNG6B13LCivkmaGXV
         o2644W/3TW05Zf43G7sN96NwNRdIoFERGAo5K2JsFxDugp6M6REY7PisyJhaMFRram5w
         hcKpzOqOXD8LemsJxsbLKLg8RobdeM2oxSb2ZlzeQUlTRKEV0tW5CN8EchDmUYAP6uAb
         1hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8oCauuYRE1SlMMis3dug2fzKpE+RxnAnTLSLcxoqrg=;
        b=DEIUULvw8ofzEahmDanGShwg859wCyAPEDvQf1r2CndPevmveBaySh5eypvqon61in
         mlxiHQfNDdkOARfEKGlJ4/gP5LdP6NcjYxW4TttmfVFZnwx9u/cXLxkj699u1Yo+5AJP
         nEkZZ3hqq5U5NKkSzRZkkfdfne9mlRYN2u4LdJBNaDkTtEWIiOTgx7BWHbHkEmyXT1Dz
         1izAAEfiCv1b6dNYFe8ZwLHeX80hQqKy5Pf856kmrRU3WkS4mm3lV8N0XK/b7iF8g6G6
         vCdrViK9JzDTOcvLED8CrWmsTDsiO2MsVmqkHTq4FXmwAfIrNvJ4YTNq9KwIxbe/+6rC
         RUQQ==
X-Gm-Message-State: APjAAAVcCvBBMhMcTm4HVf/irrW/7UKq7lVNqQWn/oUWDiQhiPyfOo5m
        yrzAapgwtXwr17c7tD6SWNUCIw==
X-Google-Smtp-Source: APXvYqypp+d90Y4yoYRO3EuxkUOreoMMGp2MQ/4d0Q0SkDfhkqBQ3/udYa+fIlCQoetHxtkhSbTxiA==
X-Received: by 2002:a37:68d5:: with SMTP id d204mr29461217qkc.171.1579193223959;
        Thu, 16 Jan 2020 08:47:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id t3sm11697374qtc.8.2020.01.16.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:47:03 -0800 (PST)
Date:   Thu, 16 Jan 2020 11:47:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/6] mm: kmem: rename memcg_kmem_(un)charge() into
 memcg_kmem_(un)charge_page()
Message-ID: <20200116164702.GC57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-4-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:56PM -0800, Roman Gushchin wrote:
> Rename (__)memcg_kmem_(un)charge() into (__)memcg_kmem_(un)charge_page()

I almost bluescreened trying to parse this!

> to better reflect what they are actually doing:
> 1) call __memcg_kmem_(un)charge_memcg() to actually charge or
> uncharge the current memcg
> 2) set or clear the PageKmemcg flag
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Agreed, this is better.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
