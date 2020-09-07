Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E47206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lght7Ifr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIGGfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:35:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC5C061573;
        Sun,  6 Sep 2020 23:35:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d19so600144pld.0;
        Sun, 06 Sep 2020 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Lght7Ifr1LpMt8ODv/ddonkYDgzWp8nZkg1/c/SjWJ8F+ZngJs82vf/xcGWrzRvqY7
         ou1W681VqX+F9lu2Xqc0ZpV4i6UUyob9coYjA5tVJMOg07ZWGsDugXBqZBJWuaGCP+BS
         IfGVH9pKNnx82dDz/31NRPQDtBYa2qeQEUGBeXAiBUqJB+6B7fsASnM0vRbJTHMC9Qmj
         Wp5QykCr96OApc0FAUkWbPieinRUqhfSyP017+3ldlThqh0gNqvvYGQzol0Fi6Cm/Sp8
         pdT+pA8htrY9tVfsBb6O2UMBh8LZF5FBkt/j1e/oP9MkvS737M2GOLwfKA0H7Cyfa2f5
         lKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=c8PqAQVYtad1qJIcVZFhd/kZao542IWOBPfVEmqyHXOidEGnDS6Ea1b+DysAKrB+aI
         X2GxxK2ZDB6wAdvgZ8YTrLmCAo0UsAKb4bEMjlsynaV4cTkTRx2EnRCS4P7+Wa1ikGgs
         h2n/i9QvrTsp41LI9pvO5/s1+IPjgXyR3ENNzliVybpftNgar5X9TQX4ha09eavT2og9
         hRcZ/wlD9UYSo68Tmn046ArGMdkPQA1Oa6VeFnrSKFd3OARPR3R5CZscnUzzcifgObQO
         mila4IzCitX+fnQj2VtK40hFogGq5X8ldxfqMMlQBTiSZUxTtxK1+q2GOYuIbOqrYepL
         W/Rg==
X-Gm-Message-State: AOAM532BOGqR3LqFFRuuEkegkHwk0xfWgMGSVLPKOmF8EXwOKrpB0QO9
        7YlxEgb4AEiJUJTlvYoqFLk=
X-Google-Smtp-Source: ABdhPJwOD5kJx+DFcApvOWX+p/5e9qXZZ2sVaWifSzXJ6UpEB+RbV7/BqVTOwMBbgqsIz5Cei42hAg==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr17926553plo.76.1599460541415;
        Sun, 06 Sep 2020 23:35:41 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id y3sm11660330pjg.8.2020.09.06.23.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:35:41 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:03:47 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] video: fbdev: aty: radeon_pm: remove redundant
 CONFIG_PM container
Message-ID: <20200907063347.GB29062@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-2-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806072658.592444-2-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


