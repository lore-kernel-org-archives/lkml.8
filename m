Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1398BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A2121739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCBNLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:11:32 -0500
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:45496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727334AbgCBNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:11:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E6E32B2BE;
        Mon,  2 Mar 2020 13:11:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: teeth95_644aa53c30800
X-Filterd-Recvd-Size: 2034
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 13:11:29 +0000 (UTC)
Message-ID: <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
From:   Joe Perches <joe@perches.com>
To:     glider@google.com, tkjos@google.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, arve@android.com, mingo@redhat.com
Cc:     dvyukov@google.com, jannh@google.com, devel@driverdev.osuosl.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 05:09:58 -0800
In-Reply-To: <20200302130430.201037-2-glider@google.com>
References: <20200302130430.201037-1-glider@google.com>
         <20200302130430.201037-2-glider@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> Certain copy_from_user() invocations in binder.c are known to
> unconditionally initialize locals before their first use, like e.g. in
> the following case:
[]
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
[]
> @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
>  
>  		case BC_TRANSACTION_SG:
>  		case BC_REPLY_SG: {
> -			struct binder_transaction_data_sg tr;
> +			struct binder_transaction_data_sg tr __no_initialize;
>  
>  			if (copy_from_user(&tr, ptr, sizeof(tr)))

I fail to see any value in marking tr with __no_initialize
when it's immediately written to by copy_from_user.

>  				return -EFAULT;
> @@ -3799,7 +3799,7 @@ static int binder_thread_write(struct binder_proc *proc,
>  		}
>  		case BC_TRANSACTION:
>  		case BC_REPLY: {
> -			struct binder_transaction_data tr;
> +			struct binder_transaction_data tr __no_initialize;
>  
>  			if (copy_from_user(&tr, ptr, sizeof(tr)))

etc...


