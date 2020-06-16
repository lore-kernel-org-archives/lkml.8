Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64022082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SAV8xUEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgFPSjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgFPSjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:39:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:39:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so1825499pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vp2fqjjZdes2B7W91JMCuB5LFtsnAMdY6ZBY6L4IP8k=;
        b=SAV8xUEzj2gEWxGNaBcin0vQhUi2TmB59JW67wCa0d2L+PZWp9sd2AAa+Jh2gtweAC
         OXWrAs/MliNXV1aw7NDaHpIOhhZQ0f+0MjJMjvUT/TzQJ+Ad5HplbsUzWcajuZyrLJXV
         IVgUlxEWC5VJ4yd4ZRfPaqUYLyW2/LDL9wZ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vp2fqjjZdes2B7W91JMCuB5LFtsnAMdY6ZBY6L4IP8k=;
        b=D8XQE6FvxWm+QMJisSw1iN+aNeKjJ/t24SKxG4LurSIpCVR+goXU9xo/hopgn6kDYP
         TZ0ynmyPzWQ3iuq1CUK4aXei1btTn2bA7/D1wA175v7znhhiq055q/+bi8pskzxLlkxO
         /kmV+Vs63ZQgPTOrBDfKTLHgQFKrJwCHf6c35GCJZVIC1CZWo14ohcn2/KpphsayHb3V
         T2Xi/OE9XFSHsc4PxcZzZ3J4X9RfyNWOVTdFPP13xpsScrVuwhvsglLBGVVJB59/SUX9
         jzEwRLcPitZYCsIg4Ew+V4JSzm0+2a+EaD7xsUJVIB6a6ePjQbRygwQlQoO9eS7TKrE4
         3ihA==
X-Gm-Message-State: AOAM5311xdW1NZaeD7SaNb+JpbPVoi3t/N6ecKjLMl91CMB4hlpY7eZO
        TzXUCS7COxrUsY6daWZqAtVgKA==
X-Google-Smtp-Source: ABdhPJzt4XdOvwZCrbaMGs+JJgx9xErpkz3qsuKsT8dcqLbIJM1K9NrpAao28zb4PeFW9GEIYIeL4w==
X-Received: by 2002:a17:902:ff18:: with SMTP id f24mr3163733plj.118.1592332780927;
        Tue, 16 Jun 2020 11:39:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r33sm3210867pjg.47.2020.06.16.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:39:40 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:39:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] rapidio/rio_mport_cdev: Use array_size() helper in
 copy_{from,to}_user()
Message-ID: <202006161139.AA7D18E833@keescook>
References: <20200616183050.GA31840@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616183050.GA31840@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:30:50PM -0500, Gustavo A. R. Silva wrote:
> Use array_size() helper instead of the open-coded version in
> copy_{from,to}_user(). These sorts of multiplication factors
> need to be wrapped in array_size().
> 
> This issue was found with the help of Coccinelle and, audited
> and fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
