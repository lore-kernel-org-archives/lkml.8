Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9BC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B78214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p72bhPsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgAaDSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:18:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46025 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgAaDSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:18:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so6168765edw.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UFuNa0uGTLSS1K01AHJXT4Immh/ilmwx1a5+JX2kzY=;
        b=p72bhPsqHNefTSK6Ep+tGbjM2dm4qropADYIbAbcPBmXX4btpOIYu/AUklLtW9HlW+
         dD/G19PbLERrH9LJFPYgrkrgnoGLgRydZfUG9raQPMIbnA3IDRUSFwLT90c/JLHmEt0j
         n+R19nbrys+yrn0UOhbRBsTMZAL6NGCtCNiOiL6fsvbBAskEB4v2s9YqP9C4YvuV1PNH
         by/mU9jceZdiFlqAndGuo1BPis8TBbIgMHr6w4CvxbWJwl2NhcMS0JjYXqIduazoC0lA
         LgG1dafhhm9rpDiuaCqZF9Y1kmgCbD1GnsnpJUurEV8iGXZNTMG2N6yv+3642xEriwg3
         9daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UFuNa0uGTLSS1K01AHJXT4Immh/ilmwx1a5+JX2kzY=;
        b=BvMBOHxKS2vvcmbMVP+s4roYg2tQcFHctnZwipbiJM+y7avQw9WwMOH6E6gWMUY9Qr
         /IBJBzSUa/lUcGIaVlUV76LiqjtTkgicAQ/6bQ9iMO2sS0k4zNK/E6Kag9mr6dG99Mqy
         Y3uMiyaJXBil+lg1rVDvEWEIgx1VauRdHcWQYrwKrfoxLH0Ulb6Xpz1KltJFn0OCSz+K
         9FNMbw4mihq2XP5K9DrfoR128/hrHiGGFtYIiOz0fCNgicg2xDRdW+kR/yK+BW3DhXvv
         NQB7MnD4srA16hLfakSZ/SgAZVljkflLYBo7pHG55m8t0vbzyBjA14hrUwcdeNcB61+8
         QTvA==
X-Gm-Message-State: APjAAAVgllP5m/brg4qMarR85eq/8iRc3Pn0iyP5bp5gFHB5VWSqTb/r
        KOPuPjt7MFho62kOR/NgXYFPgiZTIOSdxG7IdYWxrUa+Kg==
X-Google-Smtp-Source: APXvYqxZYRdy66YBGdH/VpIt3ZboIykO9cetzPypkFQfg4TUGmTfhLVz2mVM4N1TFUn6xMYy7WmQgJiTKAg/wHr3E28=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr6686444edw.269.1580440687367;
 Thu, 30 Jan 2020 19:18:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <7df83e229cff2518e73425cdc712505fb773a9c2.1577830902.git.rgb@redhat.com>
In-Reply-To: <7df83e229cff2518e73425cdc712505fb773a9c2.1577830902.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:17:56 -0500
Message-ID: <CAHC9VhR=KOAJz5F1XtqSiQkX7c90qCf6dzwZp+j+BTL=sfwTFg@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 3/9] netfilter: normalize ebtables function
 declarations II
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:55 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Align all function declaration parameters with open parenthesis.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  net/bridge/netfilter/ebtables.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

My comments from the first patch regarding style changes also applies here.

--
paul moore
www.paul-moore.com
