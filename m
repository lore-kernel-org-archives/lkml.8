Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E23206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvwfVyfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHRJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:52:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D7C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:52:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so17631626wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ipDKz5g1D0S+2ZDMowsxv3Wi3vQOCFMnWF8JkRRYICk=;
        b=jvwfVyfhN8w0TONtswrK+GiKQsmHt/iWEMCMOsUaFciLd9R2O69kCnn4TvpKendjen
         Motfa/oPNNXmJjVtbbGXmFdmnUy0TGznc7NiNnz2KRzH43UDkXWqYxb04YqYm7kqah9p
         k5DF0erG3ZmlwRBdCtpVUCR57/ifOBiAwdr2gQNJzAyE6zgfvpYAfPgy1NvQDNl3RDzC
         ZgkTqr/N/AGE0E28mFhteMTqzXEJNQ478wB4xFoZeTjw0SsnhkAQGw8kCJfY28A7vfcg
         Gyk/k6b1CA81mBcj8v1wZ6G+Tgxn77frmfiPs5nRxPG3gXUlsG/3aIFkhoJ5auz/nXqu
         klyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipDKz5g1D0S+2ZDMowsxv3Wi3vQOCFMnWF8JkRRYICk=;
        b=k52uj4SWq5sRTTbQbwI4NO4lpvcc1+AcMADNI9i7sPghQh1hMFCIfuBkJiW33hZ04n
         u4Q8HmjMDv8uqlw3lRiE1KvXlZhN/hSmm8/S4H9l1aEe7wXIjYew3JCZ6fTWksTX6YmV
         6zPVhoV3gQYOddJSM8wTHgxGgnmSKygxz85m1FDsShVM8zjMIKYYQdNZXFjh9+SNRRjg
         HcfiJUD62cP5+xdLQPgHVr3IEOFfTmzoP576rxW+fzDVsfF70FjRa/E+hIw8Ob77iFFT
         OqthV4l9BiVfba5DXF14jodqhxdvSFySReT2LcSL4YPUZIiJcpswVVYB8jNJtUgJyUvl
         RT9Q==
X-Gm-Message-State: AOAM531KUSCbdD3oEmmIkQDmLrfE2K3Wlg0pKlfuS6eLFF+c5XFSU5vE
        DQD3X3ZDwDVlDV0eyRAbkLw=
X-Google-Smtp-Source: ABdhPJxo82TEyMKUpw1MRRmNpYVm5KU0966dG/z9nADSZn2Aph3kAPhN4BhoFSrPfEp3Qg0paUYCeg==
X-Received: by 2002:adf:9e8d:: with SMTP id a13mr18529022wrf.94.1597744362803;
        Tue, 18 Aug 2020 02:52:42 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id v16sm32302023wmj.14.2020.08.18.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:52:42 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:52:35 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 0/4] *** SUBJECT HERE ***
Message-ID: <20200818095235.GA354542@tsnow>
References: <cover.1597742228.git.tomersamara98@gmail.com>
 <20200818095035.GA56916@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818095035.GA56916@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:50:35AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 18, 2020 at 12:17:08PM +0300, Tomer Samara wrote:
> > *** BLURB HERE ***
> 
> Really?
> 
> And your subject line could use some work too :(
>

sorry for that, i've made a script for sending patchset and accidently 
it sents mails without contorl.
Fixed that
