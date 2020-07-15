Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80562064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594832640;
	bh=cDsELOUvG5N5I0jORAzEviOR3TkchkQPDHa6ikI8BSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A+A6CEbqEXHLRdV71weX+OkY2J7p1PglLh6uT9ZGd9/G01RzlyY9Hh5Y6ECj1a34+
	 RJPxHiLzoBbxIK2Vj1d/NYFWYmCLvPGiBMuBUdsOL1Ps/g3jXzBWvATJDhtyXBpM8k
	 F0gkwSxPZrL3mjWYs/N+NJHfakgzAB90OvssLsBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGORD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgGORD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:03:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A9C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q7so3458808ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWB0gQ10qeh+4PXw8FO13aNzf1PjQxfW3LedQu7gVUo=;
        b=ZAb6IkRHFqgS/ixB8RckGd2JLlLYEJx3XnPMK9Y9grilxTxWO62DxTZMe0mCUXDUit
         9Y51UGiVmOD4JlmAX8u1QOk+AUmgxA8gdS1gBW/T7osgLwpOYEzH3Hcpg42A7IeHh9yq
         XOQC7E3W9W6dg+itOn4eEb93JFZ5snDxmDGFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWB0gQ10qeh+4PXw8FO13aNzf1PjQxfW3LedQu7gVUo=;
        b=fg4UNReyk/SO7fOjxN1p1YsZ5YfJT0FTE+35JkGeRK5hP7Xm4OKVeD0WUEf4xt78xa
         YmyBZIuwDapBOXme/DqqwJ/7F3d2nD1TmonW2eJ2vsxo5y25EzDU9eDitZ0391ay6ZfO
         vzWG5CPHo12ZVAji/foAMnCGNRLSjC+OXiQ4xoG5Ex7Vy/rrkZXHBzju8neMrNW3C+LC
         SEY9lh7h5QPMjCyFVqX7wwtdSHz+CiH2bnso+hkKTygmwEvIk4hKFsW4U3BOyUgh2xut
         ThjGijcX0OGKttEdDdEDxwYfvb4NuEGrgVTBlwwao3BN8VJOhNXap2x9LzOPI7B38oJL
         rXow==
X-Gm-Message-State: AOAM531A9NVU3IHqBFahWLAXJ+0YEIXuXyLZ9+M4muOErrZhKXNQXwpU
        GHLzCPVonWgqvEP5BnY2V97kUy8BAmU=
X-Google-Smtp-Source: ABdhPJycNefv7aKh+Bx7BJrLI/rUz8CDNdfQ1NmKiFqzNWLDhqnSVZI8f8MVJjx2kznqhECkOkOmqw==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr64391ljm.116.1594832635901;
        Wed, 15 Jul 2020 10:03:55 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k8sm556450lji.13.2020.07.15.10.03.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 10:03:55 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x9so3418209ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:03:54 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr51043ljc.285.1594832634009;
 Wed, 15 Jul 2020 10:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200715065434.2550-1-hch@lst.de>
In-Reply-To: <20200715065434.2550-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 10:03:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wic28QHU6BmPt8WPr_MegXfyxcZxs3Upauw7SiC=X4zQA@mail.gmail.com>
Message-ID: <CAHk-=wic28QHU6BmPt8WPr_MegXfyxcZxs3Upauw7SiC=X4zQA@mail.gmail.com>
Subject: Re: clean up utimes and use path based utimes in initrams
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> here is the requested series to add a vfs_utimes and use that in
> initramfs, plus assorted cleanups that makes this easier.

Looks good to me, you can add my ack for all of them.

           Linus
