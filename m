Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822FBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6138C20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEU41 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:56:27 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57431 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgCEU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:56:26 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1j9xXZ-002RaT-5l; Thu, 05 Mar 2020 21:56:21 +0100
Received: from tmo-119-22.customers.d1-online.com ([80.187.119.22] helo=[10.152.169.150])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1j9xXY-0001iO-RS>; Thu, 05 Mar 2020 21:56:21 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
Date:   Thu, 5 Mar 2020 21:56:15 +0100
Message-Id: <91C97773-5873-4336-9926-A013BB96B75C@physik.fu-berlin.de>
References: <20200305205158.GF6506@cisco>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200305205158.GF6506@cisco>
To:     Tycho Andersen <tycho@tycho.ws>
X-Mailer: iPhone Mail (17D50)
X-Originating-IP: 80.187.119.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 9:52 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> ﻿On Thu, Mar 05, 2020 at 10:56:29AM -0500, Arvind Sankar wrote:
>>> On Thu, Mar 05, 2020 at 04:49:22PM +0100, John Paul Adrian Glaubitz wrote:
>>> On 3/5/20 4:46 PM, Arvind Sankar wrote:
>>>> Not really too late. I can do s/pr_info/pr_devel and resubmit.
>>>> 
>>>> parisc for eg actually hides this in #if 0 rather than deleting the
>>>> code.
>>>> 
>>>> Kees, you fine with that?
>>> 
>>> But wasn't it removed for all the other architectures already? Or are these
>>> changes not in Linus' tree yet?
>>> 
>>> Adrian
>> 
>> The ones mentioned in the commit message, yes, those are long gone. But
>> I don't see any reason why the remaining ones (there are 6 left that I
>> submitted patches just now for) couldn't switch to pr_devel instead.
> 
> If you do happen to re-send with pr_debug() instead, feel free to add
> my ack to that series as well.

Since it already got removed for most other architectures, I don’t think it makes much sense to keep it for consistency.

I just didn’t understand why it was made configurable for debugging purposes in the first place.

Also, many distributions disable access to the kernel buffer for unprivileged users anyway.

Adrian
