Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83502C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5662A206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="WkKjeeRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgHFDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:20:51 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:30008 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgHFDUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=2018; bh=Ue08wca4aM0I
        SmyWal/liLfS8epsmUBIz5UxuAqlMdw=; b=WkKjeeRRzXXMuvvZ7LZy7tuRkHmJ
        xnuXeUrmIDPlpQT8vqygaTkAIy85owyfpWtBJT7ufwuZ+UOzpNujxMT5hOy3dIhJ
        dqDp/UBPWqvlCQwSUixUl2k5dtDXXnABZKIAaDUKhVQzeIN2TGSs3PYDisxdH4lL
        imqJEI7J6fQ2/Ns=
Received: (qmail 56125 invoked from network); 6 Aug 2020 03:20:47 -0000
Received: by simscan 1.4.0 ppid: 56117, pid: 56122, t: 0.2011s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 6 Aug 2020 03:20:47 -0000
Date:   Wed, 5 Aug 2020 23:20:38 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Is anyone else getting a bad signature from kernel.org's 5.8
 sources+Greg's sign?
Message-ID: <20200805232038.7a1767cc@Phenom-II-x6.niklas.com>
In-Reply-To: <5a943a1f-c5ef-937f-f67e-1c59c04d63fb@infradead.org>
References: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
        <5a943a1f-c5ef-937f-f67e-1c59c04d63fb@infradead.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 18:36:08 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/5/20 5:59 PM, David Niklas wrote:
> > Hello,
> > I downloaded the kernel sources from kernel.org using curl, then
> > opera, and finally lynx (to rule out an html parsing bug). I did the
> > same with the sign and I keep getting:
> > 
> > %  gpg2 --verify linux-5.8.tar.sign linux-5.8.tar.xz
> > gpg: Signature made Mon Aug  3 00:19:13 2020 EDT
> > gpg:                using RSA key
> > 647F28654894E3BD457199BE38DBBDC86092693E gpg: BAD signature from
> > "Greg Kroah-Hartman <gregkh@linuxfoundation.org>" [unknown]
> > 
> > I did refresh all the keys just in case.
> > I believe this is important so I'm addressing this to the signer and
> > only CC'ing the list.
> > 
> > If I'm made some simple mistake, feel free to send SIG666 to my
> > terminal. I did re-read the man page just in case.  
> 
> It works successfully for me.
> 
> 
> from https://www.kernel.org/category/signatures.html::
> 
> 
> If you get "BAD signature"
> 
> If at any time you see "BAD signature" output from "gpg2 --verify",
> please first check the following first:
> 
>     Make sure that you are verifying the signature against the .tar
> version of the archive, not the compressed (.tar.xz) version. Make sure
> the the downloaded file is correct and not truncated or otherwise
> corrupted.
> 
> If you repeatedly get the same "BAD signature" output, please email
> helpdesk@kernel.org, so we can investigate the problem.
> 
> 
> 

Many thanks. I've never seen a signature done that way before, but I
understand why you would do it that way.

David
