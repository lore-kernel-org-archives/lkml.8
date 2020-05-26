Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039F0208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="TbpZRzX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbgEZVCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbgEZVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:02:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1367C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:02:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so22207019qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYvRBfRL1Chxl6N02AVU3ob8SeK5Em8eIPxgIgFZVfM=;
        b=TbpZRzX63dJ2+Ocj8xjAqu83TXAj654ic7kUQQn6sWS1KWcK9gwcqjgZsyZcUIifNm
         y3WmFIKT2TCVYWOhVk7VoVhncFO6EXhqjqKMvkCcxtQhgi0bGMCnqPds7h09Bqr5YHfo
         uicADVWEac+ikHItmqbtxBydLHlwflxYNmoXHhIDzZ/r9Q2c3oMrB/w1kPlJ6E7QvNgI
         M/PSAdTcXnkGIRETpLeFBzvgnIv6v19LIZh7DUAHIUtzaQ4pMhVM8K3oonrgaRuUiJ+F
         hS2gO+7lSvlwQ3iS6VTPyFS/IW42kEqEHkUuRW7RTyDUHz3EZasnQtYKqJAf39e428Ko
         hxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYvRBfRL1Chxl6N02AVU3ob8SeK5Em8eIPxgIgFZVfM=;
        b=fcCB2R/VNnL29woGpQE+YJALIjN6+PyEkoK7J8SwH1rxX9IOWDORW72EnpCkUKdwPC
         OjRWl9IxSnxFBRUhnpLEDr/quJ0O9qrPavhrrt3XJeun0zGd4MLLQiEM83Esv/dqRzV2
         muAcucLIibXZrmFuCKxYaaJx4DijTO1FCBiVrrMUQz25EkR8cUHihCGkH0f4mIacNYR1
         n6oCzaGPz82xf1/+v3yTP/BqBaZetDLNgGB4MbpQXJ0H3cQBYLbB4seWVs+JRzETx6uo
         GdbmlSS4OvR3Ni7RFUVjn2xqOfYXZgRLM1oF5f9ZflExPYFuRLsBgP/kBEqwALLQyZo/
         Rs1w==
X-Gm-Message-State: AOAM532EOjacgdJG/gwCwQVOiLz8C/Inx3ec1BmcJEH5QalKeNuDErHT
        6b5b5dixOA+RgXfmlAwHgf4ezQ==
X-Google-Smtp-Source: ABdhPJzOoMAaa/N7eYEB2bm3jnQJnePbljNoUWleNJ1ftEKJ5QLQcvc9lRiUScEF1va75YvzjLbyeg==
X-Received: by 2002:a37:9dc5:: with SMTP id g188mr750928qke.193.1590526964151;
        Tue, 26 May 2020 14:02:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id 66sm717594qtg.84.2020.05.26.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:43 -0700 (PDT)
Date:   Tue, 26 May 2020 17:02:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 03/12] mm: abstract out wake_page_match() from
 wake_page_function()
Message-ID: <20200526210220.GB6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-4-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:14PM -0600, Jens Axboe wrote:
> No functional changes in this patch, just in preparation for allowing
> more callers.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
