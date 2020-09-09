Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22478C2D0E1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC41E206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cT3ohcSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgIIRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgIIRMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D338C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 10:12:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so2730083pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CosBFDAizRNCISZV5eHVCzVDJVKQR4om2vS5xFZC3xc=;
        b=cT3ohcSj+rnWge0Nez3Heio2GDlTkUAedSsaOMSCyZ1XX47xxJRN/fvhoZM61JBJnI
         XNJwIA8eXAsyh/cC/8cwIgvWWgjjilJLUAmiOw+LcaaPoWKK5N9G6Nxjf0ndjKQs8eoj
         3LWq48FHhLfpq69l4uYmYS9P0AKNeHV/fl7uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CosBFDAizRNCISZV5eHVCzVDJVKQR4om2vS5xFZC3xc=;
        b=na0Rq593Adi4Mia/WCT5eCZT4T67epuMjtT3nIv9WfszjA/PKnS4Qhn7YtGeb6GAPN
         2YnhPLX/w7XH09WkKvUdOCYyq7dKzy2aWEfiIwA3eYF9OoCSGcKv4Pp6rpASIGj5w1Gv
         MerICYzNDOFPWAnQiGVImH78nIEg6fcsMsx/SZ+COUweZDYcxuReEajRIoXjFXz8RiWJ
         VrW3SzLa29fOKYUAzm74zM3Z85TXJvXUyMSKIQ3k5hjc6g2EQtQ2mjZ040qesb/MWl2g
         qYIdK5aM6tQ9w04Ne3rIF83Y4cv3Ezehg3m4AzJce4dz3XltrzFkQvQueSbpHTGo9Vto
         siHA==
X-Gm-Message-State: AOAM532b565i/yTBGP3O7z1hXJYx0fVnnA7o2r3doW9GqaiHcqAXDtc/
        66wCJKLtGLzXu4aBNnEpktOu6Q==
X-Google-Smtp-Source: ABdhPJxYjSzhB5uOfoaKKpdMENNizIwt9gyBznrahFk5i+IgdOKycZBi7etQDhEcw8TNcJftOjuAYA==
X-Received: by 2002:a63:3d0e:: with SMTP id k14mr1356378pga.219.1599671535897;
        Wed, 09 Sep 2020 10:12:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m20sm3314282pfa.115.2020.09.09.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:14 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:12:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Update zero-length/one-element
 arrays section
Message-ID: <202009091012.ADA0342C8@keescook>
References: <20200901010949.GA21398@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901010949.GA21398@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 08:09:49PM -0500, Gustavo A. R. Silva wrote:
> Update information in the zero-length and one-element arrays section
> and illustrate how to make use of the new flex_array_size() helper,
> together with struct_size() and a flexible-array member.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks great!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
