Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B48C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43FC2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587890186;
	bh=A2pVdECl6vU8GbOTCulcgu4yc0FCNbcblWdGqfuD81s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=klpitz5hUbYe/gdxJV6L3lf33ea6FiKcUA9pxSilO+A19dKYTQC03FaH4um2kgzVC
	 ONMVdSXXXx/HXiP0sAhlQ8N6W3/i4kv66CTShavf+BZcQC0qaCCzyT83LMSmjfd1iQ
	 ItVSLoToGoFb9YF8mITxvps9+n1iL6aZtADJZ84E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDZIgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgDZIgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 04:36:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BAC2071C;
        Sun, 26 Apr 2020 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587890183;
        bh=A2pVdECl6vU8GbOTCulcgu4yc0FCNbcblWdGqfuD81s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIgLWRcgjagcw4P9B9YtX/57J8DbMbixFHSBrSpy4t7SSQ8lRobD57v/hUaRKK3Dn
         HpLkSoWUigga/lIU+AUHiu7H4xe/ayQmX92WUTO3p7Z8q/pOy+HndfRa+W1ywJINWg
         OkwzoJ68jt4SmrsocpAJ0NDA3KmQfFTN59Z741fc=
Date:   Sun, 26 Apr 2020 10:36:19 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        masahiroy <masahiroy@kernel.org>,
        akpm <akpm@linux-foundation.org>,
        mchehab+huawei <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200426083619.GA2105859@kroah.com>
References: <20200425080343.GA2048673@kroah.com>
 <20200426024436.7534-1-xujialu@vimux.org>
 <20200426070919.GB2084805@kroah.com>
 <tencent_F9E56441F0B1BE9679BF02B22FA0EE610C0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F9E56441F0B1BE9679BF02B22FA0EE610C0A@qq.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sun, Apr 26, 2020 at 03:46:26PM +0800, xujialu wrote:
> Hi, greg
> 
> I'm really sorry for the bad reply i did, i even don't know what was my email problem ..
> 
> I mean i'm very new to git-send-email related, very very confused about the email processing..
> 
> Please help me understanding where my problem is, I am very serious in organizing this
> 
> submission related email, even every sentence written in the email.
> 
> Did i filled the wrong msg-id in --in-reply-to? Or i should directly answer your question by following
> 
> format, just like your reply:

Yes, please, just do proper email responses, like all the other
conversations on the mailing lists :)

>         > make defconfig
>         > make
>         > scripts/gtags_files_generator.sh
>         > gtags [-f gtags.files]
>         >
>         > Enjoy with vim+gtags. :)
> 
>         What's wrong with just 'make gtags' that we currently have in the kernel
>         tree?  Shouldn't that be sufficient, and if not, then you need to
>         explain why it isn't in your changelog.
> 
> How do you add '>' before this lines, all by hands?

No, my email client does it, as should yours with a simple "reply".
Perhaps you should read the email client documentation in the kernel
tree?

I still don't know what is wrong with 'make gtags'.  If it does not work
properly for you, why not fix that up instead of creating something
totally new that is not even hooked up to the kernel build system?

thanks,

greg k-h
