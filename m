Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2762086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3nUdOps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgHDUuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHDUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:50:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:50:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so18167955ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KkI8LyHYPiT/h3NnMBo5llKwufDfy44GU0em0whdiHo=;
        b=N3nUdOpstU6tgvlbaZ/Vd5Np5LpD5/A/embmd7N8aOzXsl7s+P7D0Divmm7dFugl7D
         /7e+Nb3uchaRfzeevOYDdWbFPiQMCmqkeud32UoqnkEQeQtXl6DX7yjM/rnerZEfSE8N
         2+oMoDhNuPtZY5WnljVg8cEv+RkFWeUKZ+B9iBA9USpMe2DhREho5nmjjE02gsjOxt4a
         p0cwYS+gl6C/noiagQyf2FdL1wxAmF4kr6fPgY4VcWMhsvWF3hMxGIfjtwXL7/dBZD2y
         YVgN+7n4q/gPj0BgeLCrGKyvPq70CkWuZWD1/8mccmNcqIuAb7EBLYKvCQffSRASuk/c
         WWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkI8LyHYPiT/h3NnMBo5llKwufDfy44GU0em0whdiHo=;
        b=CqRY6C5ZU/kggSgwsYz7NqC3WXmhfAjNMSwFxxkZh326A7s3XBL4Mdfep1GvZF2eDA
         uqGbROd1sXYaJAWBLwuha1ExlzDSR7wEfXw86pyPjarBbqzQeDu3zZHfaSte7AkTGnbC
         hwb+HtCLY20CGzQ4z70x0lvIHJMqiqnE4B4gkpw8YldGtqSEssHinI0cB880rprsbEOh
         dnCndVntQ83Rx3IV1NPOX/7gvUpOLkvvDvMeYJ8sR/+pwgkV6sUpYu4p2LjTAlM5GrSp
         in+tVlFXgZOrrf0NC5S/ryhesR/Y+QYF3rV9BZ7RTnnrMOcPjLP2mtng+0r4L7hRhfOg
         mzmA==
X-Gm-Message-State: AOAM533Lmt+swcEfZOoUbuDDP+dZ3bJ5PcEdXnxF9l+INOx2WKIlefTN
        F056PVy5VHENDtJKRa6oSiU=
X-Google-Smtp-Source: ABdhPJzHvn4emSveEiuT4CvTKsAbWiDEiECpET9ac5jEqbAsUZ/TicV6wxWGqMfcKf8yQYkAsx+fBA==
X-Received: by 2002:a17:906:2801:: with SMTP id r1mr4018755ejc.17.1596574237558;
        Tue, 04 Aug 2020 13:50:37 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id f22sm58218edt.91.2020.08.04.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:50:36 -0700 (PDT)
Date:   Tue, 4 Aug 2020 22:50:36 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 6/6] openrisc: uaccess: Add user address space check to
 access_ok
Message-ID: <20200804205036.vgy7h3mmojzmjihs@ltop.local>
References: <20200804042354.3930694-1-shorne@gmail.com>
 <20200804042354.3930694-7-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804042354.3930694-7-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:23:54PM +0900, Stafford Horne wrote:
> Now that __user annotations are fixed for openrisc uaccess api's we can
> add checking to the access_ok macro.  This patch adds the __chk_user_ptr
> check, on normal builds the added check is a nop.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Look good to me.

-- Luc
