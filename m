Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C083C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4271120674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRVVix6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgFBP7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:59:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99DC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 08:59:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c12so12968973qkk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhDlzzj1mv7yjNQeNayBeO/EQ27hFrs4LJVQMmEO7ZU=;
        b=HRVVix6fLBW7SoImi6PGKNWY5i637jkMDGxfNb8eOkFYvDbYhVtpRgIbPUDpAmUXjf
         UTqXCi9AycOA+YTVlnYw5fQKrexMzJi63m5RJF5KYgV5ejHwovcZUMej/vCTvN+RxnB1
         buligpO9CEtdJHqekLm24+bVz/gCOSWv7MnroG0OgTERoLrnrqeBKAULBEsRMEnGSvT5
         y0cFZzTGu9DA18IZoZUKgBHsBbY3yGLY2CWI04iwDas8pJZILbNQqIwArQQ+Lu9JDhN9
         3P80nOLUa3GvxWDVNPt/KEUA5hNCDFpB9y1NBFFR3u/8HcdLVyV1nmyN2J5fLkJSxOeG
         5/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhDlzzj1mv7yjNQeNayBeO/EQ27hFrs4LJVQMmEO7ZU=;
        b=VPguuxJepkRE/WPLt3JUSms7p/k0m84KaJ7WVITjx/5CIum0AW6c+3M76vGsUoWGV0
         d57Hvj9vvuKfYFdN7kWxXh5Xyo9c8RJrXh1HJ2/o94In3QahajweqKz2yLG6q8eh0JXT
         NZn5x3O6cRhFHyimTXzck2mV0UjD9axslXHbGf+NoNxwrvu76hGhbiPSI1RBxs5wbNBz
         v/YTdAwGdOaGcfTp7f4OTNV3eUC2LiRDOstZPDwcQND5HrJvKP15qcqryZrsdGwJtMcz
         hxTyIpon/Aa70q10PdBztIdO4ZC+nx+eVcDinWz7fRYbIPJly331Mqs/++xCC+yzeS4s
         sHhg==
X-Gm-Message-State: AOAM531qVZJkqpTHLfXAJxOhBetjcKBdYXc1L4M/4ip8sffY+wrT7PWN
        +N/wzujL1iZs9/MLK8NlPTIprjQoTMMC3GWAJvzfww==
X-Google-Smtp-Source: ABdhPJzPXqtYUnytWt1lWymuRWC7EmIk7gvjXjPqtJyBraYJlsrH+F7AKpB0S7/2vmcXlFuqJXfy40/Ft7BjRB6w5lE=
X-Received: by 2002:a37:be05:: with SMTP id o5mr10744656qkf.309.1591113543271;
 Tue, 02 Jun 2020 08:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200601202410.124593-1-pterjan@google.com> <e668fc72-9103-70cd-e545-095e88c53dcf@lwfinger.net>
In-Reply-To: <e668fc72-9103-70cd-e545-095e88c53dcf@lwfinger.net>
From:   Pascal Terjan <pterjan@google.com>
Date:   Tue, 2 Jun 2020 16:58:46 +0100
Message-ID: <CAANdO=KBPh81Jaxhta8k3ipnwWbr5xdhTuRW6GNEZsTTpyMjXQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: switch to common ieee80211 headers
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 15:57, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 6/1/20 3:24 PM, Pascal Terjan wrote:
> > This patch switches to <linux/ieee80211.h> and <net/cfg80211.h> and
> > deletes a lot of duplicate definitions plus many unused ones.
> >
> > Non obvious changes:
> > - struct ieee80211_ht_cap is different enough that I preferred to keep
> >    (and rename) it for now.
> > - mcs_rate in translate_scan was not read after being set, so I deleted
> >    that part rather than using the renamed struct
> > - WLAN_CAPABILITY_BSS is replaced with WLAN_CAPABILITY_ESS which is the
> >    corresponding one with same value
> >
> > Signed-off-by: Pascal Terjan <pterjan@google.com>
>
> This patch does not apply to the staging repo, current mainline, or
> wireless-drivers-next. Where did you intend it to go? Staging is the correct tree.

It was against staging-testing as there is a (trivial) merge conflict
in there with https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=2aaeaaff1ae21b2817256435c7fc0095eeda61ae
which is also in staging-next
What is the best practice in such case?

Thanks to kbuild test robot I found that it is failing to build there
because I forgot to add a dependency on CFG80211 in Kconfig, so I will
need to send a v2.
