Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD2E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCaR6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:58:20 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:52270 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbgCaR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:58:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 83B8C18021E49;
        Tue, 31 Mar 2020 17:58:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boys35_481ed8d64f731
X-Filterd-Recvd-Size: 2177
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2020 17:58:15 +0000 (UTC)
Message-ID: <78a8ba04459f8a4ea6bcb8811f35490018b763f2.camel@perches.com>
Subject: Re: single target builds are broken
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Date:   Tue, 31 Mar 2020 10:56:20 -0700
In-Reply-To: <CAK7LNAT-8TbLRPB=PNsbAORKYvYL+m3JmA-iSDieK8Uv7MAvGA@mail.gmail.com>
References: <a5ce79eb-be9d-df97-0b58-5aee5a48f4d3@oracle.com>
         <CAK7LNAQ8LZMPxrjVkuLizHjVZyBtSmLFZ=EvDCCAPb-XGfJLHA@mail.gmail.com>
         <8c491e3b-a622-14c1-15c3-8cff061017ba@oracle.com>
         <CAK7LNAT-8TbLRPB=PNsbAORKYvYL+m3JmA-iSDieK8Uv7MAvGA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 01:03 +0900, Masahiro Yamada wrote:
> On Tue, Mar 31, 2020 at 8:02 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> > It's really useful to be able to build object files separately, but as
> > if it was part of the kernel (so e.g. with all the gcc flags, include
> > paths, etc.).
[]
> So, there were lots of cases where single builds did not work:
> 
> https://www.spinics.net/lists/linux-kbuild/msg21921.html
> 
> The way to do this correctly is to
> descend directories one by one, parsing Makefiles.
> 
> With no entry in obj-y/m,
> Kbuild cannot determine where to build that object.
> 
> > At the very least, can we find a way to reduce the typing overhead for
> > testing one-offs like that? 'make STANDALONE=1 test.o' or something?
> 
> Probably, I do not want to do this.
> 
> Supporting everybody's demand is not a good idea.
> So, I draw a line somewhere.
> 
> Saving some typing is less important.

I too find this regression less than desirable.

make <single_object> is/was quite useful even
if it didn't always work.



