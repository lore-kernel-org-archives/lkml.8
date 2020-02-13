Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D0C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677520724
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBMDc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:32:29 -0500
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:46907 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729467AbgBMDc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:32:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8F5A3100E7B40;
        Thu, 13 Feb 2020 03:32:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: debt42_6ca657be6622e
X-Filterd-Recvd-Size: 1290
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 03:32:26 +0000 (UTC)
Message-ID: <71b3bf53c0fc3c68b10368092022e3bf2cffc506.camel@perches.com>
Subject: Re: [PATCH] KVM: x86: enable -Werror
From:   Joe Perches <joe@perches.com>
To:     linmiaohe <linmiaohe@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linus Walleij <linux.walleij@sterricsson.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Date:   Wed, 12 Feb 2020 19:31:08 -0800
In-Reply-To: <12259a951c5e47359c46f7875e758d41@huawei.com>
References: <12259a951c5e47359c46f7875e758d41@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 01:40 +0000, linmiaohe wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Avoid more embarrassing mistakes.  At least those that the compiler can catch.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---

I think adding -Werror is a bad idea as
new versions of compilers can create
additional compilation warnings and
break builds in the future.



