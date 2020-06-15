Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B70020756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qq3fN4y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgFOSoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgFOSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:44:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BCC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:44:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so7955794pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/L9vpEy4YW+wvyzUDXXcVOqQeUfP4Lan/mDToAVsZn8=;
        b=Qq3fN4y2CCfEPhibQkPDaZ75Ak5kNzodLN5Z3DKP2Bq96Tm1pExOLtH5IRqg3V67wN
         7KpKNhSUNdpTUyhFuzRc5jhgaJ8fabzwM7yYceZFF/SrROtrUgG07+eLCcFy32D6+U/3
         NmQEkdKxfiGBRWeC0hEo70hvO4o/6uQ/AETGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/L9vpEy4YW+wvyzUDXXcVOqQeUfP4Lan/mDToAVsZn8=;
        b=gpJAj6oCm6ihFCVOURoUyejxG4wtVMDsqOQON2QLASIzRMGdgCMUfBkB3cLSYFCJRb
         EWjivzxmbntzCPrsjbi6iXHfNYsBZdGv+BFAps6cpwkVEakM4owe/VK+wDmXUnmPWaPl
         8K6fTpxakcvzsnQO0jC6ZmDvRZ2VXs+za7MRvk2CG4MFEiDFr80D9IiQUUov/zzsmN7f
         q0CNama0gFvf0tPZc8yl5LsFvgNuKDpT8V1RpsSdPaS2iYpWvuSHRi9dNIBeO2ZDTqKa
         qvm11kOwiMOV/zMFOSb9C2h2MRfTu6bF6EiE0CQKZc1hFCV+v5y43R3lGTwQzK9gHa7K
         mG7A==
X-Gm-Message-State: AOAM532mDRYwUEASQYhxIAdpLVCbvyy17EtpQ2PUoy/5HADOytwna+Nn
        OcBaL+Tr16gXeWoVqPVGqftYYg==
X-Google-Smtp-Source: ABdhPJz0GnEMgd+NOJZ4YyIuSQqz2DIY7a1WO/6cybe4V5xreJTkji7NSBD9m9gfN0gcNG2/5EgGBg==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr21651876pgq.279.1592246647773;
        Mon, 15 Jun 2020 11:44:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm12552670pgo.92.2020.06.15.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:44:06 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:44:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006151142.8B78AAE7D2@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141050.5512F17@keescook>
 <CY4PR13MB11752A5C1586F3D597C52679FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB11752A5C1586F3D597C52679FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:45:28PM +0000, Bird, Tim wrote:
> Personally, as a human I find the space prefix a bit easier to read.
> However, I think that in "normal" kernel log output it is unusual for
> a line to be prefixed with a hash (#), so this might be easier to
> both visually distinguish and for automated parsing.
> So I'm torn.  I don't have a strong opinion on space vs. hash prefix
> for indicating sub-test.  I think the KUnit convention of matching
> whatever was the prefix of the "TAP version 14" line is clever, but
> it would be nice to just pick a prefix and be done with it.

Are there plans in kernelci for doing any parsing of subtests? (As in,
what do we break if we move from "# " to "  "?)

I'm really thinking "  " makes sense now. :)

-- 
Kees Cook
