Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E193C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7CF2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgH0P4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:56:53 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:42292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgH0P4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:56:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D437B837F24C;
        Thu, 27 Aug 2020 15:56:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pets52_1a0b0bf2706e
X-Filterd-Recvd-Size: 1677
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 15:56:50 +0000 (UTC)
Message-ID: <e8409fc18e39aeee3486c334d903b8a3e6ccaafa.camel@perches.com>
Subject: Re: [PATCH] deprecated.rst: Remove now removed uninitialized_var
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Date:   Thu, 27 Aug 2020 08:56:48 -0700
In-Reply-To: <202008270755.5B91A3D@keescook>
References: <5e10c1645dd8f735215cf54a74db0f8dd3f6cbd5.camel@perches.com>
         <202008270755.5B91A3D@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 07:58 -0700, Kees Cook wrote:
> On Wed, Aug 26, 2020 at 08:12:01PM -0700, Joe Perches wrote:
> > It's now gone from the kernel so remove it from the deprecated API text.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Oh! Right, thank you. I forgot to rewrite this. I'd like to keep the
> details about why "tricking the compiler to be quiet" should not be
> done.

Probably better in coding style.

>  One of my fears about removing uninitialized_var() is that folks
> may start adding open-coded versions to silence warnings. I'd like to
> keep a section in deprecated.rst that describes the problem and why
> those kinds of work-arounds should not be used.
> 

