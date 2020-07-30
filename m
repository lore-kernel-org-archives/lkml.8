Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3835BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1814C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgG3Hbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:31:34 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:34098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725892AbgG3Hbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:31:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 56C49100E7B46;
        Thu, 30 Jul 2020 07:31:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stop99_63068d426f79
X-Filterd-Recvd-Size: 1484
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jul 2020 07:31:31 +0000 (UTC)
Message-ID: <a2773089a844047407855f2da7bd72c2970d2e6b.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>
Cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 30 Jul 2020 00:31:30 -0700
In-Reply-To: <alpine.DEB.2.21.2007300746330.13710@felia>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
         <alpine.DEB.2.21.2007300746330.13710@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-30 at 07:58 +0200, Lukas Bulwahn wrote:
> Hi Joe,
> 
> did you see this quick fix to checkpatch.pl? Can you comment on the 
> commit and can we get a quick ack on that fix, please?

Yes, in a bit.

> General question on patches for ./scripts/checkpatch.pl:
> How do they travel to Linus?

Generally via Andrew Morton.

> Do you pick those patches and provide them to Andrew Morton?
> Or do you just ack them and we need to send them to Andrew Morton to get 
> them into mainline?

Generally, ack and forward.


