Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC67C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75D215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 22:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4bOOn6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDKWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:06:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41078 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDKWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:06:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so6191814wrc.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CT8vbEIXt/rtqjiLfFTHYgcGhI1PSosGnJ6VAYQC7l0=;
        b=J4bOOn6YtHKItlWGno1tp1PEe4m2yfp5kkTxtsAS6MCbWV06P2F6sxJW74C2I15Gxp
         lFsfsK0GkBnpRQv08c80DQzfDNO+3ZwFwfIozORFR4SJfL4ZWPfE8r+g9TtCvydaBreM
         khW2DB6szEu89TkWFM79SfyKOXufmxd4VR/hReWLFySw7lmGWyUfry9s5L83KizD12lz
         H57l94nzqXUonAtzr4npbteWssGs6BnRPi457b79GCjDRr80lpIsLp1a60eqhxgVtYjw
         nbWwgbVDrkFqvoPLCaWNVVVtvIKDuukhksn0JQS8eSgpFDf/NUZ5eNcmqLqwkbO3iRuZ
         0ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CT8vbEIXt/rtqjiLfFTHYgcGhI1PSosGnJ6VAYQC7l0=;
        b=qDLG2V+H9XCDrUUZN1Z+OrJ50VCBEAMax2G/WhSaovipxhst3vvA1pn/j9yLbKIebm
         PQjPi5NM+8F6ViKLIIpPD9Ypyh8whiUD4EuWBH+QIORQT+W2lfhG7qOnlrOkP4DibkzY
         rTX34EzwJgVX7t0DdfyspEPu6o89PqladZ0TWuTiIkx8wGsnSOKlhqOtdG8oIBN8vtvT
         WygkDT14uqjkQWRZSqiJuYRbxPKT6RSwSEPe3pnIGmdVe+vqcjuLcu6EzNzYLMJhqfox
         tDOgq55P30jVyMcFA1qjINyy2exjqujI363zdrWq6nznu3b1M93EnNyBzasni9P4YZO8
         nDjA==
X-Gm-Message-State: AGi0PubyDjcRxbOEdKY7hnBz/TVERcqg7+8naekwefYlaUZ9S/SOMqmr
        fwiqMYiJlLXSKt65yKYgl2M=
X-Google-Smtp-Source: APiQypIz+Ny13+X6E72YzdSGV0lYHyYCJYuAyJJufKA2xXLmydZgb9kyHTbnnjQTaMWvjwlEQR0Ndw==
X-Received: by 2002:adf:f443:: with SMTP id f3mr4493845wrp.117.1586642811354;
        Sat, 11 Apr 2020 15:06:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p5sm8781090wrn.93.2020.04.11.15.06.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 15:06:50 -0700 (PDT)
Date:   Sat, 11 Apr 2020 22:06:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        anshuman.khandual@arm.com, david@redhat.com
Subject: Re: [Patch v3 0/5] mm/page_alloc.c: cleanup on check page
Message-ID: <20200411220650.ncasijo276xgj6c2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200411220357.9636-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411220357.9636-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 10:03:52PM +0000, Wei Yang wrote:
>The patch set does some cleanup related to check page.
>
>1. Remove unnecessary bad_reason assignment
>2. Remove bad_flags to bad_page()
>3. Rename function for naming convention
>4. Extract common part to check page
>
>Thanks suggestions from David Rientjes and Anshuman Khandual.

Oops, miss the history.

v3:
  * still just print the highest priority bad reason
  * remove the bad_flags to bad_page()

v2:
  * merge two rename patches into extract patch
  * enable dump several reasons for __dump_page()

>
>Wei Yang (5):
>  mm/page_alloc.c: bad_[reason|flags] is not necessary when PageHWPoison
>  mm/page_alloc.c: bad_flags is not necessary for bad_page()
>  mm/page_alloc.c: rename free_pages_check_bad() to
>    check_free_page_bad()
>  mm/page_alloc.c: rename free_pages_check() to check_free_page()
>  mm/page_alloc.c: extract check_[new|free]_page_bad() common part to
>    page_bad_reason()
>
> mm/page_alloc.c | 74 +++++++++++++++++++------------------------------
> 1 file changed, 28 insertions(+), 46 deletions(-)
>
>-- 
>2.23.0

-- 
Wei Yang
Help you, Help me
