Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E92C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AB421741
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGSQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:07:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37002 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:07:54 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jxBqw-000719-EI; Sun, 19 Jul 2020 16:07:50 +0000
Date:   Sun, 19 Jul 2020 18:07:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] android: binder.h: drop a duplicated word
Message-ID: <20200719160749.26akaqytsugbdshw@wittgenstein>
References: <20200719002738.20210-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200719002738.20210-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 05:27:38PM -0700, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: devel@driverdev.osuosl.org
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/uapi/linux/android/binder.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/include/uapi/linux/android/binder.h
> +++ linux-next-20200717/include/uapi/linux/android/binder.h
> @@ -404,7 +404,7 @@ enum binder_driver_return_protocol {
>  
>  	BR_FAILED_REPLY = _IO('r', 17),
>  	/*
> -	 * The the last transaction (either a bcTRANSACTION or
> +	 * The last transaction (either a bcTRANSACTION or
>  	 * a bcATTEMPT_ACQUIRE) failed (e.g. out of memory).  No parameters.
>  	 */
>  };
