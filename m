Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE6EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F8222BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B4GeYb0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGTBBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgGTBBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:01:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C1C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:01:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so9343004pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hvvOCUPbJEpbxZk7PaEWl4M3lvQaWAxT42n6XCsQWaI=;
        b=B4GeYb0wInBCQRNp7ox3pW2Yc3TmPpVWRajy+4bOPK/aODu8t/L3NRI8n+1oL6ouk0
         TRdmSja8SxiX/G+895Je9OJhq6VZdRP2WW3cxaR5U4/3wHu4jp5MUiXQCEPR81exYrpg
         MOa9x36Gi20U7zkpEOg2zuumW9c6b1dwaUveY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hvvOCUPbJEpbxZk7PaEWl4M3lvQaWAxT42n6XCsQWaI=;
        b=ssQcCbkgqZlATVI1vUNaGrI84X4VQqJ45qQF0sN317fn9hW7j0zP75x3aO1zn1LYjN
         lOT1wh4ZiJv81p7aVz+er0yS0RMb7/TYlwdwdJdA0p/831UDft0mpH6zY/tK5BaQA7ST
         2k4hgMN1AU+wlqyUjtl4f+gPlhpXqQOesS0HBhW2+2qOQFN+6xuhXN217rJl41D231ra
         WuLzxiSR7F0TRps9hqex3EQjIyJcEdrexMe4S7lqN+LbzyfYjcNVvFTs3la5Hz/SpX+b
         mt5X8AXDxbygS7L44fCRS/t3d8l79jDcIi0Vhj7OFWiSgWHWoSJ6esBaKqOnqzxNHJtf
         wqTg==
X-Gm-Message-State: AOAM530yRJIf1aMOmxOYflagN0hiO0Zy15N4kuBto0pdZuSF6xdFigdK
        v1RxVHc4+NMozXUntRihWn8BoQ==
X-Google-Smtp-Source: ABdhPJyhjZsJkKkPWh0fgHOVavXbU60PiNHbHew+yqhSGhykxv1BnFiYN887Ztf2rd63TD3S0OeIuQ==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr19980773pjq.95.1595206900318;
        Sun, 19 Jul 2020 18:01:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm13585272pgh.94.2020.07.19.18.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 18:01:39 -0700 (PDT)
Date:   Sun, 19 Jul 2020 18:01:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     corbet@lwn.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, mchehab+huawei@kernel.org,
        j.neuschaefer@gmx.net, shobhitkukreti@gmail.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide/index.rst: Add pstore-blk.rst
Message-ID: <202007191801.5F4190C61F@keescook>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
 <20200718165107.625847-9-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718165107.625847-9-dwlsalmeida@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 01:51:03PM -0300, Daniel W. S. Almeida wrote:
> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> Documentation/admin-guide/pstore-blk.rst:
> WARNING: document isn't included in any toctree
> 
> By adding 'pstore-blk.rst' to the index
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Whoops! Thank you. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
