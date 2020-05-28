Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1699220888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAJbzZIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbgE1PW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgE1PWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:22:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F666C08C5C6;
        Thu, 28 May 2020 08:22:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e2so316395eje.13;
        Thu, 28 May 2020 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aO7HB3OY4vvptjuX4LbhmnN07enGDH14/ugvjwzLnnY=;
        b=LAJbzZIPjY54xOfhd19TofjJ3SmQw7Nm+UnbCL/LKcvsjbsUr0UfweZZ1qlcc1p4+A
         ttyVlteL9NDABV5OzWvlEsZlm2982NHi8qCfMA6wKrQ7Z9xSm7WfEYhr6KPzXW+TOqQz
         qINdTTUO8t9l9t8uxATnwPpGTuW9PyS4Bhfd60uF7tJpTisrKq9xnTLoHtlO1PG+nieR
         Rd6rzTXXNcJs8plfr1GbU8F1qUf+3zA8hVb0w7JfrMYIep487AqI7HIX0JP0tX9nW7vG
         JJlT35lLEXcMWHu5Y5dRd0tSeulfezFEiLYSj2ECphSwyYa/Ew+oy8UWmpAB8lbWDcft
         tnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aO7HB3OY4vvptjuX4LbhmnN07enGDH14/ugvjwzLnnY=;
        b=Nx/pu9Xzfew3kcZX19mWqIuBlO9etNLxGOG255IzLmvBmweJ4GAGQ3/MT4muzApZ2Q
         mE5wAeIFatnc2us9rbqsCNt7jcuFdTH/b2PdEu9Xt0uVta0xyCkZwBnUChcO8lEm9x4M
         od2GbaTh7hfGumXCCA9OEl8Ow3mAJXh1lYuWVfphAPJx+5QytapTBGpRTLGOjxCoYTwj
         4TAJ4HoHXh4ZEIEGZvAnPsD5f25CO6prOLZ/N5EHljnD1btDHObm/AA30Z5WbMMuAzQ2
         Le4k8qSqqnJ+PBlZDryS5OnXNt4LF2Yx6JGIYavj3+YxBnuBEXSZNIweN4OMuK2SIf6F
         wa1A==
X-Gm-Message-State: AOAM531LwXSNBynwDaayk6LjwR9RlGnS6/3KIevonyUjsl44gXFnxZ4a
        tpxkVlnvbjo7ufwE4MhPM1L5oTIT
X-Google-Smtp-Source: ABdhPJyfWf4LRMY8tHPgfcxrJHSdy/IYyN05y94+E89QNog4PgPPpHUGwT/KXgIzJIypxEi+IwVrTg==
X-Received: by 2002:a17:906:4803:: with SMTP id w3mr3365570ejq.316.1590679340109;
        Thu, 28 May 2020 08:22:20 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:e4ff:e63d:9072:506a])
        by smtp.gmail.com with ESMTPSA id j16sm1143058edp.35.2020.05.28.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:22:19 -0700 (PDT)
Date:   Thu, 28 May 2020 17:22:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-sparse@vger.kernel.org, arnd@arndb.de,
        will@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Message-ID: <20200528152218.npq53zode7hh7qh4@ltop.local>
References: <202005280727.lXn1VnTw%lkp@intel.com>
 <20200527235442.GC1805@zn.tnic>
 <20200528075900.GA236442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528075900.GA236442@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:59:00AM +0200, Marco Elver wrote:
> 
> Ouch. The below should be all we need, assuming it's the best we can do
> for sparse right now.

Upstream sparse should be OK with it now.

-- Luc 
