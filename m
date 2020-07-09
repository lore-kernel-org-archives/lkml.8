Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F415BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39F320708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGINJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:09:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGINJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:09:28 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtWIm-0001QU-LZ; Thu, 09 Jul 2020 13:09:24 +0000
Date:   Thu, 9 Jul 2020 15:09:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Hridya and myself into Android
 driver maintainers list
Message-ID: <20200709130924.alkcskho5miybvd2@wittgenstein>
References: <20200708231253.3831497-1-surenb@google.com>
 <20200709081820.GB13487@kroah.com>
 <CAEXW_YQ5VoN6DZcfJH_4u5MnRc0vybY7zYH3Y_WD=j3u-RRVHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ5VoN6DZcfJH_4u5MnRc0vybY7zYH3Y_WD=j3u-RRVHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:03:13AM -0400, Joel Fernandes wrote:
> On Thu, Jul 9, 2020 at 4:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > And I thought we were deleting ashmem soon?
> 
> This seems harder than initially thought. The Android userspace is
> intertwined with ashmem in various ways (security policies, apps etc).
> There were various concerns with old apps using /dev/ashmem directly
> without going through library layers and that such apps could not be
> upgraded. Various approaches were tried to work around this by
> different folks to varying degrees of effect. Also, I am no longer
> with the Android team at Google, but I continue to work with them
> upstream.
> 
> Fwiw, I will continue reviewing this and other Android code from my
> side. Thanks.

Same.
