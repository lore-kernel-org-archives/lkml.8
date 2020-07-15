Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF97C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E919B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgGONf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgGONf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:35:59 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666AC061755;
        Wed, 15 Jul 2020 06:35:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C406EC01B; Wed, 15 Jul 2020 15:35:56 +0200 (CEST)
Date:   Wed, 15 Jul 2020 15:35:41 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Victor Hsieh <victorhsieh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Fix TCREATE's fid in protocol
Message-ID: <20200715133541.GA22828@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715080358.GA2521386@kroah.com>
 <CAFCauYPo_3ztwbbexEJvdfDFCZgiake1L32cTc_Y_p4bDLr7zg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Hsieh wrote on Tue, Jul 14, 2020:
> Please disregard this patch.  I misunderstood the protocol and have
> found the actual problem in the hypervisor's 9P implementation.  Sorry
> about the noise.

Ok, thanks for the notice.

Greg KH wrote on Wed, Jul 15, 2020:
> As Eric says, this is fine to cc: stable with this kind of thing.  It's
> good to get a "heads up" on patches that are coming, and Sasha runs some
> tests on them as well to make sure that they really are going to apply
> to what trees you think they should apply to.

Hmm, I'm really not sure how useful that is for first version of a patch
that actually got refused ;)
But if you both say it doesn't hurt I won't advise against it anymore,
thanks for correcting me.

-- 
Dominique
