Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6F9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1262073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="GIr3jiVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCZQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:47:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45408 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:47:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so8607995wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kYmZ7W7spXJCoSjpaQQC+a9kzIPwWZNW6wR0y26VyYE=;
        b=GIr3jiVdrqj3bn59MVLn4TI9NEimaDRJDtviwTb1yGhBa4MRpNqFrbqzMF1fYfGVyo
         zyjFWXtmLjvyFM+kTu2YAvkZCtbSAZ/SpplHv2w7uu3gpFdPI3hOY3FlpoVSJooIiuS2
         rgN04v4rRUDOgRrktidIM0Dxy9Jbe0qXePkvXL2Oz3dTVTT5ya2XFOsaxZZ0D1N9rFaz
         b+5CKnM4F5wcg2ovEo5pLcgNAuvq2RydWfGPN26aWoYYA72NoHbBVWJRY+9ZOVOho4uj
         td34p19/XoQpGn8MFPanfE+Ke1/KARSmsW3CUfSFAbRg8xFvHbRjIND5iX4+KvJ0k6qV
         9o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYmZ7W7spXJCoSjpaQQC+a9kzIPwWZNW6wR0y26VyYE=;
        b=GPoU7AAN+dV8sHsbSAosT0mZq1D+UQ2gFtKj39mdFkfufZoN3ugo5aIWKkuiJ4tGgH
         mSqR8VQpZ5JkgRBXPgc3XGQN3QaeSbzxb8RuuBke9I4py9U8oSPsXgIzPpJQanIfuDXZ
         0ZeUhvdTjmUyR5cwEGN58YB1FTZvuERcBOA9dqE2GWvxwHPDvUtBjxArzM2rnMDoslfA
         nrXi5KBazPZsWSM8ad9wQl/FrDIxpN+L+3xn1NpQPuJSg69jLw2ucN/YLPxfHqmHVYju
         yRPYdPPR2sRf/nF8I9I6D7hIZL+9UdIhR6XyMBnHTGoJuk3GOH85Xx1puDLhY007QSF6
         JIDQ==
X-Gm-Message-State: ANhLgQ228m/Z+nV/IOrxDTA+kApmCuziSDoyeImMjrUxfFFRVTxYPPkl
        SHmzSkvnUwPm+tzGklPzcF2JHw==
X-Google-Smtp-Source: ADFU+vuRzdEN8e+GgVOpVQoXZAfKd/+Jvd09vBvkB4h9XjIMrTsmDS1awfgMR59e60AKC7QqAgFC2w==
X-Received: by 2002:adf:f104:: with SMTP id r4mr9875048wro.375.1585241263872;
        Thu, 26 Mar 2020 09:47:43 -0700 (PDT)
Received: from ntb.petris.klfree.czf (p5B36386E.dip0.t-ipconnect.de. [91.54.56.110])
        by smtp.gmail.com with ESMTPSA id e5sm4130732wru.92.2020.03.26.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:47:43 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:47:32 +0100
From:   Petr Malat <oss@malat.biz>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, gregkh@linuxfoundation.org,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v3 3/8] lib: add zstd support to decompress
Message-ID: <20200326164732.GA17157@ntb.petris.klfree.czf>
References: <20200325195849.407900-1-nickrterrell@gmail.com>
 <20200325195849.407900-4-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325195849.407900-4-nickrterrell@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Wed, Mar 25, 2020 at 12:58:44PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> * Add unzstd() and the zstd decompress interface.
Here I do not understand why you limit the window size to 8MB even when
you read a larger value from the header. I do not see a reason why there
should be such a limitation at the first place and if there should be,
why it differs from ZSTD_WINDOWLOG_MAX.

I removed that limitation to be able to test it in my environment and I
found the performance is worst than with my patch by roughly 20% (on
i7-3520M), which is a major drawback considering the main motivation
to use zstd is the decompression speed. I will test on arm as well and
share the result tomorrow.
  Petr
