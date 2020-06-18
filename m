Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B642C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E7820706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592499569;
	bh=7Af5sOpfJeucXQCZbTSkfxpWlx6cVlBuf+6o0jqp/7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wIT0KaaFeL767y39rWItHLz+vhoMy4m2iEYOdocHZb1AvUuVZwLqhMW4a9OAIkIov
	 qCATEbgmIvkITvTq5Vsr6pLIi2WeNkfUno8yJ4dm2tUtMs+yX5FmaBu3oa5N4IMhMQ
	 xvD++L2rrf6Scr2vXOiJ/FDBkufVSdKwMYQEhC8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgFRQ71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbgFRQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:59:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B77C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:59:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d21so1820324lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZTFy5ThPSRkTApbGDSTvf3wKJlXjgfz5FQcS2Pn3hQ=;
        b=HDJ6bQERt+X7O0t2j7hc9AbCUxg5J1tIMjeYIdK5La+h/1O2f3FkOOPZooJsulPZDl
         Z1kVKwLZ+Kbbo0Gvy+4l/08hwrJAEOLbOFSdX74le2v85pqwLWiBY9teEGSAnVKZEiJz
         8bQHBLDZbPEjhDONH9rP9seGWnhqK/BY2KZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZTFy5ThPSRkTApbGDSTvf3wKJlXjgfz5FQcS2Pn3hQ=;
        b=l+YZakYzvxROlTIVRy+u3zeoT3LsFunXmEfOddT/BYwvbD3m87pCsrp62Hb9FwyE8q
         j3NwHwgAahqdIz/cfQbTm0zG97Tai6R91ANMsMcGOE31djmO/gZ4Y02CbmGGECIQVDd3
         dAtbt3X+yEZP+OwbQny+Zoul8HfD3EksNuq2Mm54yVrw/NBJ4uzHfoUlD+2NbhAv4OHC
         hoUHJeVMzuQjy/fG1P/eTqBe+2YktqGM9VhY2y/BMDCSe3QTCFpF7DuDDUCzbuWQp7kq
         00G4f0kzqR4S/GnP1xhKwKVk251afRqoA9Mi+n9MBhywDcW9AR0AAaH0cnonP5+Kr0qR
         A/Zw==
X-Gm-Message-State: AOAM532jZU/AEtsL3ggYCU8c6kiYzhSlah9BcBl4d0jCmeW0xNbaz2Yp
        YZ4Bq76Z/Y2wm1egNoFXvb+4n6gO4nA=
X-Google-Smtp-Source: ABdhPJxlnnkQa7AXAlf1y+oDP3O46re4ddfmNgfAE/N+Thzc/7LT5U9QndnME7n5OwkYIXN6VvJawQ==
X-Received: by 2002:a05:6512:318f:: with SMTP id i15mr2894399lfe.203.1592499562920;
        Thu, 18 Jun 2020 09:59:22 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l7sm726944ljj.55.2020.06.18.09.59.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 09:59:21 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s1so8169404ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:59:21 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr2996469ljn.285.1592499561309;
 Thu, 18 Jun 2020 09:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com> <202006181747.1x7hGaZR%lkp@intel.com>
In-Reply-To: <202006181747.1x7hGaZR%lkp@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 09:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=y6XoZKjxoGf9h4Zj3SPZnA+g5ZjsZ2hKT-AZW7H0ag@mail.gmail.com>
Message-ID: <CAHk-=wi=y6XoZKjxoGf9h4Zj3SPZnA+g5ZjsZ2hKT-AZW7H0ag@mail.gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
To:     kernel test robot <lkp@intel.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 3:06 AM kernel test robot <lkp@intel.com> wrote:
>
> I love your patch! Perhaps something to improve:

The new warnings don't seem to be due to the kernel test robot having
an old version of sparse, but just because the error strings changed,
and presumably the kernel test robot has some "ignore old sparse
warnings" logic.

So the warnings all look new, even if they aren't.

I'm planning on applying that patch soon, so this is just a heads-up
that that will (again) cause the big number of warning string changes,
but hopefully that will be a one-time event and the test robot will
learn.

             Linus
