Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD597C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB6D206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHWy9+oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgFDUZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgFDUZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:25:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959DC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:25:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so2648853pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M8rV5wMhr+CTs8zWrj1I0mKf+otww3BG2ynj9BMAk9c=;
        b=JHWy9+oaDCCQPV+LrS/GW4glpXwsJ+BPkxaB5OkyqvIZd+J91AYL13gzM4WSEoDndc
         QUw7/nsDDwWp9iV0s+Rn/55R3wC9Ia+u4dqaENDPPa6W0HFrXn1sVQ1Q7PvFoXfFqbcC
         HFzpYAH0ornyNVI3yDebE5rzy+eCafqkJO8s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8rV5wMhr+CTs8zWrj1I0mKf+otww3BG2ynj9BMAk9c=;
        b=jejZQ3XYrpnFDCn9+gRGonTOzeroeKQVY7NnZxd/laWqPpJ19A5/+oR6kch5briNMc
         WbP0+jS0TtHX5pRrsQlNqNrJ+2/rxqzchZImuIOKVJzfXYU02cJh93imnNIarHKC/Ny7
         r9AETIDCKLgbRC6SyLF7eQJlw1LeCPqFz+kNVr5/FfwPOHD+mAOtgPMQLXH369P6SHvJ
         YM3sRNliEipSmINtOoWvXwHohDn2JK86BkjM7j4lR00bRPdffy29UXzvaxDo4/eH60Ef
         pp+bbCHobzdeZ8ROjuEztF846/YxfpEu4FvB1Lo+lHx+L61q3MoJrvoH1tnXa2NvSfqI
         yNUg==
X-Gm-Message-State: AOAM530V7qVqtuQiahG+xvDbU0TteuQaD2NK0Ti4BlGNW9xJAytQ6VE4
        TInGyJNB3s5rWLAQOc1uQcgbKQ==
X-Google-Smtp-Source: ABdhPJx5gjx/wHBmJvPVxVDergI4eThW/vphGdEs2oI7RZWROvAHDSkMtileUpP9eLY3tOxuNmGaVg==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr5844075plc.209.1591302328111;
        Thu, 04 Jun 2020 13:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm4742914pgv.52.2020.06.04.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:25:27 -0700 (PDT)
Date:   Thu, 4 Jun 2020 13:25:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: deprecated.rst: Add note to the use of
 struct_size() helper
Message-ID: <202006041322.35912ABB@keescook>
References: <20200604172138.GA21820@embeddedor>
 <202006041047.9B3E8FB951@keescook>
 <20200604182123.GD10051@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604182123.GD10051@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:21:23PM -0500, Gustavo A. R. Silva wrote:
> Yeah. My reasoning for is that it will take a while --at least one 
> development cycle more-- to completely get rid of all the 0/1-arrays.

Right -- but we need a place to point people when we tell them "please
don't use 0-byte and 1-byte arrays", and the deprecated.rst is the place
for that.

Having it in deprecated.rst once they're all gone only serves to explain
why various compiler flags are enabled, etc. But while they're being
removed, it serves as a single place to document the issue (as in, much
of the flex-array patch commit log "boilerplate" can actually be
repeated in deprecated.rst.

> But I think we can add this note while I continue working on the flexible-array
> conversions. Once that work is complete, I can go back and update the
> documentation. :)
> 
> What do you think?

I think we need to document it at the beginning of the work (and I
should have asked for this earlier). So let's just add a new section on
dynamic array usage, etc. It can include a note about struct_size() as
an example for why 1-byte arrays are so weird. :)

-- 
Kees Cook
