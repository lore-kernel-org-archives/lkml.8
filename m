Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC17C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B5420756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fT4toYG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgFOSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgFOSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:24:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DCC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so906405pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pl3r1Mo5DEUisrXbKPOtpyPnis/yzGfz3EgWzAoPwXs=;
        b=fT4toYG06r37evU/maAh2RirK9WTvH2JEmqWPeB5OgGr2LHf5lvhX5VIreBX5cQcsk
         8qyUaqFw1i3A5N7EV7RB0ADb6FLd3LhIiiVfmzCCd+inR5KDOu5P9vHm1tJ9ieLCP2r1
         G4EEGO+EPH+3sOrdpbxtwXHgca8jQ+LZN4MNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pl3r1Mo5DEUisrXbKPOtpyPnis/yzGfz3EgWzAoPwXs=;
        b=EcR8NHuBPb8lGiD0tzoL8RxGZD+f/qeA6kAHLumMqEiI00Az4LYe/YWpoWoGMftBLQ
         rrkbIHFLaUV8k5Y5TQlCA9uSwNd+cZwD65PHOiZ6VraNd9fCzhGacvtKi55zaqMkJnCq
         XAC/bUClAeNuXWuZw7p+kpiIrT3C3i7bR0MrAJUUytHmmBNyGUQNzgF9kfg9WtBK0h/W
         JfWEtL7SB7VnYB1Vm/3ckwr1OMKidlRL7YLlORK0xWyjxYbgGvv52Em9Iy8YjplKBKDD
         6rrDzN24v7bvb6tOT0e638PTWEmlecGXAv2VE9jljszpKbjaYIEM1T4vBOHmILd/a7VB
         Y3LA==
X-Gm-Message-State: AOAM532esXnl0OsDAFx/BWMvhqyGoatXBR8lgJLZh78QtGspq7T1WWYv
        xrYe990ZEFqfcM6Gy3RUn6Q4yQ==
X-Google-Smtp-Source: ABdhPJz2j5KqTcW1tgWTu2+4lo+i14GErKTSjLBB+uSZ/F60UMMETlkha5A8A0B6bkLa0R7oM7Sg7g==
X-Received: by 2002:a62:5ac5:: with SMTP id o188mr24743080pfb.37.1592245469314;
        Mon, 15 Jun 2020 11:24:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm225015pjh.5.2020.06.15.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:24:28 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:24:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 28/29] docs: fs: proc.rst: fix a warning due to a merge
 conflict
Message-ID: <202006151124.89C934DDE6@keescook>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <7d46aec2cb7a5328d260c7c815b9be9737b43ee1.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d46aec2cb7a5328d260c7c815b9be9737b43ee1.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:47:07AM +0200, Mauro Carvalho Chehab wrote:
> Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> added a new parameter to a table. This causes Sphinx warnings,
> because there's now an extra "-" at the wrong place:
> 
> 	/devel/v4l/docs/Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> 	Text in column margin in table line 29.
> 
> 	==    =======================================
> 	rd    readable
> 	...
> 	bt  - arm64 BTI guarded page
> 	==    =======================================
> 
> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
