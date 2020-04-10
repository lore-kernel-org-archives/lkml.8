Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C57C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72D020857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJQPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:15:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:37980 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDJQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:15:42 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB7E9307;
        Fri, 10 Apr 2020 16:15:42 +0000 (UTC)
Date:   Fri, 10 Apr 2020 10:15:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: android: binderfs: add 'stats' mount
 option
Message-ID: <20200410101541.73768714@lwn.net>
In-Reply-To: <20200408190809.eb4znnjjhdaycmep@wittgenstein>
References: <baa0aa81-007d-af46-16a5-91fead0bd1b9@infradead.org>
        <20200408190809.eb4znnjjhdaycmep@wittgenstein>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 21:08:09 +0200
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> On Wed, Apr 08, 2020 at 10:29:50AM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Add documentation of the binderfs 'stats' mount option.
> > 
> > Description taken from the commit message.
> > 
> > Fixes: f00834518ed3 ("binder: add a mount option to show global stats")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Hridya Valsaraju <hridya@google.com>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: devel@driverdev.osuosl.org  
> 
> Thanks!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks.

jon
