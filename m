Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9905EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A4220885
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaDnHb2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRTw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRTw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:52:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE80C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:52:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so119638pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9oJ2zfjKJJiXgn03b7esdKzd42rBKqiMgP8CTxYlR44=;
        b=CaDnHb2DPPFZ3mItkFuZdu+ViUsmHwSbos09211JJsLn3Ol/WlaJSGPMCX7WzRKr7B
         pAScD3z9uCqffbd/9A0vHlDnFSWlanOTPNdr4mPvlh07kqUxuIJwHSbcyN0y5x7GWZV8
         sfsvudehB07JsdS0kQ455gU2WI7mU7/NkUOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9oJ2zfjKJJiXgn03b7esdKzd42rBKqiMgP8CTxYlR44=;
        b=NyQz/ll8gmDRdIUa4rWRP6gwpLXaLvQcNNXo3gc3qaLETb7iAN0Jl7bOGhukL26Kms
         wj9Q4BBE7bnnUgKmoyPU3tBIOg5WchMv6OnfsIhwVlrcDbPAZf6Z15uzc98MVkfsz9Mc
         tqiEXt2h1sxStun06O2HeQ7x+MlSBQm+eK43ZsFgeeU7VZNcPvL2iI+HXfq3lOZPWs5h
         w6oeXMcbfgGKtOykA4G+BS/hfTQ2XwnuGVUTj6QSIUEoKskW++7qcujliyCoe54AZyex
         c3Fozcl5o6lUmM96tdUp5WCZQo40IYlEdityyB4IBQc7VngZwtzuACfRjOONrJtzAhrA
         flLQ==
X-Gm-Message-State: AOAM530FqUhUyFbxWyidA6/lM/oXEb2PcTDU9DdwIC6QxXM4SgrvBam6
        draVxuR/+SIhHSxCMyBJyAcBYA==
X-Google-Smtp-Source: ABdhPJyNRFjIYwrofkjNhSwiglIYTHnPVqwppmbBIFgjNQKAiRA+xOIr1l8+uIh1VuQ8P4aHkAbxVw==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr1136640pjw.233.1597780377087;
        Tue, 18 Aug 2020 12:52:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h65sm25459943pfb.210.2020.08.18.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:52:56 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:52:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 0/3] Add Broadcom VK driver
Message-ID: <202008181251.1CA80429@keescook>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806004631.8102-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:46:28PM -0700, Scott Branden wrote:
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
> 
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition in
> other patch series [2] being applied first).
> 
> Please note this patch series will not compile without [2].
> 
> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> [2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/

Greg, is your intention to take [2] into your tree? AFAICT, it's got the
appropriate Acks, etc.

-- 
Kees Cook
