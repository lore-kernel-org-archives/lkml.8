Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA29C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114120656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kq76A0lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbgG1TZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgG1TZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:25:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:25:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so12626822pgm.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jv1dvYdq8eJEzFdUSscz1BOoXXTkZcjav2RFBunoTFM=;
        b=kq76A0lTi8jchEwvaC48PBEuds1Wn1jiikAVioJ41DM8T8wrDetkd/hnwQQTiuxVKj
         D8SSmZS7x5ywaIUtbhQ4RrUBD2Ph2CG4jVRveqKOiuQUBROilqRnGWWwhdAgWk0bpGkn
         RMsbna6SKCbD/ku74N9KZje7ChYEji4gTzTm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jv1dvYdq8eJEzFdUSscz1BOoXXTkZcjav2RFBunoTFM=;
        b=XV/wEl1FlHcWZlg5SNf7RHHbizmQi4c+ehHdEEM7L/UlIgfiRyb2j+OlGivWvu4dqJ
         UZzc1yqUX4YZRf8ehMu33e936vUYuaempggvj+5MJvgplw74B6wbOOyF3f3hMROPWd5w
         p+mvx8fr5ZGtfNgrRUXY0gI6Xnty5lBkqs+0m4HTVc2+Jt6LLMD2Z7/u7QCGhjm8rNiz
         u3lRaH/39L+J/52InuI1F2X/xHll4PBmPtDUr60llau6Sq4Mgtrnx767vrjHRPARjdf8
         j95EOZ5V/c8VvBm986dgFX2gw2YJ7engmaMV0ojfss0w1FKvLE87Isj5epp9rHg3SdWg
         xeHg==
X-Gm-Message-State: AOAM533dcZ4KqXaDwwoAhij5hJgzp61N/hyW2Hr9yNo1na5gQqY5iTJc
        XGwHz2FiaoCLlGNUnxRNGDu9vmlKcW4=
X-Google-Smtp-Source: ABdhPJwnNWmKRmXaJycjJGbixKnAzcH0WBAJLNlgax1cXRM4cfbmdEgCqqAjHy2kSpIEdSWNPsk8nA==
X-Received: by 2002:a65:6384:: with SMTP id h4mr25642129pgv.196.1595964318670;
        Tue, 28 Jul 2020 12:25:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d25sm19239139pgn.2.2020.07.28.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:25:17 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:25:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] x86/kaslr: Simplify __process_mem_region
Message-ID: <202007281152.6B15179@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-6-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:58PM -0400, Arvind Sankar wrote:
> Get rid of unnecessary temporary variables and redundant tests in
> __process_mem_region.
> 
> Fix one minor bug: in case of an overlap, the beginning of the region
> should be used even if it is exactly image_size, not just strictly
> larger.
> 
> Change type of minimum/image_size arguments in process_mem_region to
> unsigned long. These actually can never be above 4G (even on x86_64),
> and they're unsigned long in every other function except this one.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Please split this up (which I think is already planned):

- bug fix (which looks like a correct fix to me)
- arg type size changes
- refactoring

I don't currently agree that the refactoring makes things easier to
read, but let's see v3. :)

-- 
Kees Cook
