Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C148206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="rE8O+zrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGHS7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:59:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B7C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:59:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so4389510pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjEoHJO9VGUXepRxlrPCQ4t6OG2a6kpKSMLMfEHyb+4=;
        b=rE8O+zrfKM7aSbWPDdvMMpBZEBo1Ml4GDSOCdEYvqt+hN+jm3ChC2bCssrWN41KwRN
         1gfgIcu8NurhPn9mW54BPdYrWltji2fk1cGpWEXY0Wnj4V9iW7MuUiAmhrznmR8EsdfG
         jeiQK2S16OUgtf7cY42836y/5tXuv4LIBpwtclN+XnaCzeJfTG0+R2R37l4lp0L7u39D
         TCwuRzbgAtXvlD0zUNXeQNE270L0ybWdd4y6C1rB9q32315VEhe93aVvHq+brUKCoKx1
         DffKpydeMq9/ZDLyjib+bkE2GbcRZhajohxXavgMZsHGPwGmX6vG8Q5FbiLijnUqdAhk
         s4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjEoHJO9VGUXepRxlrPCQ4t6OG2a6kpKSMLMfEHyb+4=;
        b=NuL6KG+F1KIa71jO0w8mQG6fThdPKXRE/Y6Bu1XqIpVmLVR0tvqcyW2DBT+wCCqBuJ
         3kjeuvqIZAOuyX/ftA0Pg1h8vWSvYFF4FzQQRvgD9cE/O31VlRAhvqLR74JTE1qR40+/
         XOu/Od38yVWwiC/wXCzuc5d4FCNx8Zllh4TfUMhcAQfKyG8CCY0OEdxAJyoqXU3B/2P/
         rTu2c5mHa/KFHUE0Byfp3vNob6VTwiyO3COPwBzp+w8v3QBZjnbQ4uSyPTOHsMlbEtdH
         OjUBNcymTlkzWoWt5XzdskyLrXLuiGJU+08I8WYt4IEQWB0inSoNt5Cp9YBeveI3J05z
         aB+g==
X-Gm-Message-State: AOAM533g81k+ycGNq8rSznNLU1T2Vfo1xpkiyP9diB8gGEPAKeNvlOJR
        s9sjIJysms0FnRv8YgbCSaZxZA==
X-Google-Smtp-Source: ABdhPJziXNsDJgLEwOUYkszh0cJVAyOeTMEVXOMJ7Kk7vIMlv0zAR8pK8SzIIl4lO7Cz4vRzlwMY0Q==
X-Received: by 2002:a17:902:6943:: with SMTP id k3mr14777206plt.36.1594234751184;
        Wed, 08 Jul 2020 11:59:11 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z11sm478710pfg.169.2020.07.08.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 11:59:10 -0700 (PDT)
Date:   Wed, 8 Jul 2020 11:59:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Dave Airlie <airlied@redhat.com>
Subject: Re: [Ksummit-discuss] [PATCH v2] CodingStyle: Inclusive Terminology
Message-ID: <20200708115902.1c1d63a7@hermes.lan>
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 00:23:59 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
> 
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks for doing this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
