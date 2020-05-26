Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01550C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB26A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rYoyg9+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391767AbgEZWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391747AbgEZWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:01:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so5960497qkm.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFyf2LBGYvGusFP43rIvmvMj6csrO70L2r6mtlSO9dc=;
        b=rYoyg9+Je2ZBkMoBWH+yfXZTkMNPG3iZ7HGEW4+JjsmhEjNiDpAe1ETwdFHs+wTTlv
         4yhWBvRVkVch6Vej6DUgMlS4Jc42HJEtgEQUjSxP9gTpcltSad7v0TEUXW13sdqFE2PJ
         KEXFT7oict3RSbVycqpeCDDhp/h0RuzDMF9/Bmo9CeoypDDxe6T3c/OMAYLoNQm9lJPA
         AnSJKjEMcLEQAXln/0ZWFX+/zbrpqpHb2PaqRGpRXME10WwcP6cdnVtE/J3zJH+hFXZU
         eb8NHqLdWN174rh02bYHFO16mvHbBjThrty93MBSnpbbcsI/o+CNCLTH3SYehDygMlov
         Xo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFyf2LBGYvGusFP43rIvmvMj6csrO70L2r6mtlSO9dc=;
        b=VWYl7j+xXAYTLbRIF2HkIqyDyt9MobRMfhE7WL7Mm1DwHV3Xb1rViK4pDET4uDr48v
         T++zMNPDoMGCwqEwgNnjkvF3ze9JgduLRkQ2fWvGnkI59X3SZtPapBirfT5rcCCNmMI6
         HUZxiI62j0LRMDapBu5Uc2JfB85y0dgIDXJCrZ6/chD9GJdVX83pFM1otfzkkcicKKKu
         LvTbyeSNDJTz9+DKPyYEnIOxw6EY9Tdt4ZZ4zosRucEDoAa/Swd4T1qz0mpx+GHAYtAw
         iYj4CIekXrs24dgwl5pUReEPjt7Hy0yHkn2dnZNt9r1M+U13moc9HDrebviVJ+Mm0Dby
         0gmg==
X-Gm-Message-State: AOAM532wyxbkmAWA8VtYAJLBIHoMxQfaPBs+Hk10wjh5JwLPtLK0lFUC
        VJGX4s83PjIAHpgyYrCnZOwZKg==
X-Google-Smtp-Source: ABdhPJzYfNSECc3ExsPyOFv3thSrOj31TioNh+sxpB0emnK2SYr5mr5i6LVkpZtDvB3rkXw+/mjL8g==
X-Received: by 2002:a37:e101:: with SMTP id c1mr942846qkm.433.1590530517442;
        Tue, 26 May 2020 15:01:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id n68sm700264qkb.58.2020.05.26.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:01:56 -0700 (PDT)
Date:   Tue, 26 May 2020 18:01:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Message-ID: <20200526220133.GE6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-12-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:22PM -0600, Jens Axboe wrote:
> Checks if the file supports it, and initializes the values that we need.
> Caller passes in 'data' pointer, if any, and the callback function to
> be used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
