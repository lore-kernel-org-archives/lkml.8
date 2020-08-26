Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE84AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E39E214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UqSLNW2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgHZN32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgHZN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:29:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:29:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i17so198766edx.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkhfN3cT3cQJ7PHsuf80oD0j4Kw1XGx7zDFLh/m4hhg=;
        b=UqSLNW2hVsumXhgcQeQDY4OnmCva9EEDgjjcCwt9TV+Zuz4I6QA8U1eEubCj2/AJ5h
         t2ivF2dl8jJ/cr4v01TBDLpXDGxXwKcjESKz2yNujWqKdU0mTRg+GbDecTKczbpwOvdA
         ObTvuOgAv9+DkNzmlY3xhEf/v6MHVjY7Vf3iE+Pi8MtWGi4nT6O08H/ZWC39lfvKPFBv
         KfhltH5++yR/hM5qe+d7Ydo8ixo8iHTg7RSiCW1R7/xSEyXaWnJnGa3pmPMAmjwVb2B+
         RZfDlP/Ez7m7YLxVcJWZWERD7YrxnqY1y7oDnxLqUXJX9QFYWfZH0WV6oACAO/2zV46h
         5APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkhfN3cT3cQJ7PHsuf80oD0j4Kw1XGx7zDFLh/m4hhg=;
        b=H0CTgKaHHWvDk2dh6DcYyXUVvu4rWdWcGhdSL6dAxEoe68CtDtT3qVKSksfw3aR5Wm
         qPcFHV4KUS/Vj1ErpRJJqEqc3cUxS5RreE/F+xPzn1WRW93NKB6PtdLo9ENhMIv4d0rE
         uSLXFrMruPRXA509KKKye8Q31snn+UKbYbq4RTB/ODz/T8042/kUMp6w2KDSMIBNvEiG
         nyS9XM/x+joAtXpjEG6x4QEhTO60YpcnhcwP6IXaGp/D+En9UZ5yL+cQEcpUlO/FIcG/
         Mui6aOK7Ny8+5zV3JJQHDHkPbmfHUPOAcDCKtdtL0K9ZGwctFi1ezIRqm5umAxJdYc0z
         yRVw==
X-Gm-Message-State: AOAM532lLEbz9uK+Xs+JZNOARSQoKYa3U+YIkagD6b52QDeYH7v/Jifm
        wa3QFLLEDBuV7xVPx2hkRNy7yI3kSdlO3uEGAaEXJrwzgg==
X-Google-Smtp-Source: ABdhPJy/N1m1QzN8hzuSoLW6wNSlJZrPDSeobXqXnAmnCcPwNhVqQBagGacLHid3njrXbdkAgFSZbO3tzWrJYWtoQyY=
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr12617276edt.128.1598448562248;
 Wed, 26 Aug 2020 06:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200826040022.5297-1-vulab@iscas.ac.cn>
In-Reply-To: <20200826040022.5297-1-vulab@iscas.ac.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 09:29:11 -0400
Message-ID: <CAHC9VhSt83DCf7hwavCJvgTSSVy7xgvumjx-hAk+cG1faig_XA@mail.gmail.com>
Subject: Re: [PATCH] audit: Remove redundant null check
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:00 AM Xu Wang <vulab@iscas.ac.cn> wrote:
>
> Because kfree_skb already checked NULL skb parameter,
> so the additional check is unnecessary, just remove it.
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  kernel/audit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
