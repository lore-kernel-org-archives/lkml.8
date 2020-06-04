Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60116206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IL8Pqzrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgFDVjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFDVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:39:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9EC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:39:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so3877422pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxmJqfLXObgDK+KB4PktwKQFJAVJiTIxba9sH+6Najs=;
        b=IL8PqzrsuWRpBzyTHT6o67zwSfyJJ6H/YAm4mMD8v7ox1q08sv6wEjeO8FYLb+b+u5
         T4TxLa3f+a7JsAat6XVteKXKr50/vz9U4bbt2xSwSoxPwJWsrOWNwCr12xX1XiqWyjlD
         ifUVNqz6+Xm3SeIrbKJESfeN0Va5dTiUHsfug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxmJqfLXObgDK+KB4PktwKQFJAVJiTIxba9sH+6Najs=;
        b=lE3pjGyXDpfThNTjCKB37gnHhWLVMb6DkMz9wT6E2bfjbfLa0UZLSptiocPb9m7JoF
         RjC827DzKni6z/0JWud+ktJxlJju8l27OGzNZDAVorjIuuhMV+pgXwYvmlYkCdQQhvXw
         B1oPQbMGl4pQw++T60mVBMgTafoF0ksm8ZEpP/5TaJaI8uOv95bWWTqjkFiFM6BooHY9
         0UZ0LiWwkepwzH9JvfBXX658vellfVm2hXHD3aoFLMBnRAK2jKpCYNcPEkE0tPkcFIDD
         ku/g1NDQDjzgkRPX0VoxmHyIrs6P5Fq9L0RnO50cjH9LGJx3ClpJ1jINKt3dC7ZHze2+
         JDCg==
X-Gm-Message-State: AOAM5317pyd8fT2g+eZDE5GCmZ9fl7cYrR7xF9zCVi6pwEbuInXDKk4K
        o/fJQRd8S54UukIrTYfsxJLMKA==
X-Google-Smtp-Source: ABdhPJwqmO+s5Ayfmro9mp6aw3eLObX16a9Bk2z2nYF2A6vjUV7vUQolmxGSqZ4qFoJVLF9U3yhHpg==
X-Received: by 2002:a62:1d89:: with SMTP id d131mr6161118pfd.294.1591306745710;
        Thu, 04 Jun 2020 14:39:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm5928280pjl.52.2020.06.04.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:39:04 -0700 (PDT)
Date:   Thu, 4 Jun 2020 14:39:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 0/5] Improvements of the stackleak gcc plugin
Message-ID: <202006041437.F63645F390@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134957.505389-1-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:49:52PM +0300, Alexander Popov wrote:
> In this patch series I collected various improvements of the stackleak
> gcc plugin.

Great; thank you! I'll take a closer look at this shortly!

-- 
Kees Cook
