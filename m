Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BE3C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B5621741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="rdwjo19Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHWEPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 00:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgHWEPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:15:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F8C061575
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:15:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m71so3092623pfd.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eiosga/qagR3C9gYuMR7EHBVLO+uLZbegdD5rhWbiSU=;
        b=rdwjo19YoaY7gwE0KX3I5hlr+Qja1Oq7gu9RcwSvo0vqozspi22t3IchXeYlqmpHg7
         d1Mzo7xTo4ilHpBlyz4HSXlMPIskV+X1/+MYxGnswbhEQNPJdl+cCf3CgCYj4akSsp95
         FOVMIhib3nzIGT/e4DQg4Nk9B/dySfoTF6jB0h7qtfj6BRoPYiuTBq7M6za2SW5ZbB1G
         wAr1ig+p0/YUUzPmNU9QwZgqUAVvUEWG4xEODMVnwtPt5eYsHuokqya3BvLqRyxX7cPc
         eVgIUkovx1kI38CzSGCSBNly0yDyn4kNqGH3ctkzRbEWRb/x4hEdKHXgiianvsegcPsu
         mvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eiosga/qagR3C9gYuMR7EHBVLO+uLZbegdD5rhWbiSU=;
        b=eIQsQ/UUQREDgxN58zfIt/ZqpkLjCliVuj3U6Ew5cM1vdG9FBQNGiSOnhOMakDZPgp
         0lcSMPUmdCc82+fRAIV1vTEFqg8Hh9ixKCWbrJnj9FXw2Dp2TKXy5dPGbJHgm0cMTMpy
         kncKR1eV9vd2OwqeVhBjh0kNV6kr0wAQ/WBjnbdfradmOplQPGWBFK/iHd1ekkO+UK8V
         Mx2ZI5chnzH+l3y1SSk6vdPw7QvgYgJsYcToOMNOdlqnc5Jqbf1K5bfN/m0Y+rCX+Auq
         acAj9Gd8cp4BYsov+M42plHjeooi770pQb9li1GlB5MZ5QVdjmyyJBeSFJkpu47oAjy4
         gUcw==
X-Gm-Message-State: AOAM533k/M3ZeN2YkXLbbodyuhHH0E+VLX8p4m7iXyZHRUTq5TxNUBWE
        hOg8rsi3QWGuR4mkxL8u4mCMoQ==
X-Google-Smtp-Source: ABdhPJw3AWXPJc4NQHorWrZQKh8kgFaW93zl4K6ZlfuMbq5YdJi2KXPlWC1ANoDGzTSeMpmqHkKK/Q==
X-Received: by 2002:a63:df10:: with SMTP id u16mr195683pgg.437.1598156141144;
        Sat, 22 Aug 2020 21:15:41 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id k29sm6903335pfp.142.2020.08.22.21.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 21:15:40 -0700 (PDT)
Date:   Sat, 22 Aug 2020 21:15:32 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <nsekhar@ti.com>, <vinicius.gomes@intel.com>
Subject: Re: [PATCH iproute2 v5 0/2] iplink: hsr: add support for creating
 PRP device
Message-ID: <20200822211532.53dc3270@hermes.lan>
In-Reply-To: <20200817211737.576-1-m-karicheri2@ti.com>
References: <20200817211737.576-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 17:17:35 -0400
Murali Karicheri <m-karicheri2@ti.com> wrote:

> This series enhances the iproute2 iplink module to add support
> for creating PRP device similar to HSR. The kernel part of this
> is already merged to v5.9 master
> 
> v4 - addressed comment from Stephen Hemminger
>    - Sending this with a iproute2 prefix so that this can
>      be merged to v5.9 iprout2 if possible.
> v3 of the series is rebased to iproute2-next/master at
> git://git.kernel.org/pub/scm/network/iproute2/iproute2-next
> and send as v4.
> 
> Please apply this if looks good.
> 
> 
> Murali Karicheri (2):
>   iplink: hsr: add support for creating PRP device similar to HSR
>   ip: iplink: prp: update man page for new parameter
> 
>  ip/iplink_hsr.c       | 17 +++++++++++++++--
>  man/man8/ip-link.8.in |  9 ++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)

Applied. Than
ks for updating
