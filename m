Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD19C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DC5217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="BdhSzvxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBEQoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:44:54 -0500
Received: from dougal.metanate.com ([90.155.101.14]:41952 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbgBEQoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=5TnnbfbmRYgwjjhpTjawl4vnqo8YhsgOfpVYZxeXVKc=; b=BdhS
        zvxB5zXvgJLw4G/jrE4kb4+zEcZ9l38ys9Co0baEmheFGfwWOMe1xHOseUwLSyogyDnrHmTRABs7g
        pvXUhfTQyNbYZYlo8UJMjUUDEY+u9yuzvH2UTeI1ysuxtA1agn3Kw+3bzVqVyIpuVkjFOL2bdgJRt
        6V6XFPdwRb1Zx74c5F6zBWOqdJ5BlgcWZPYPoHhwzlQMpHysIlB1QGvvPJFIvFWB8DearZbsQd49Q
        2p7rUbvTEsmzbpHmEZ5opxn3lJV2T+grA7iqbYMqB3Y3uDSFcblbE4MPSPgfsRXNGcEKjZrY6xvOt
        kp05NMaH//eiLwTxTKaouP77+LLN3Q==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1izNnE-0008Q9-VC; Wed, 05 Feb 2020 16:44:49 +0000
Date:   Wed, 5 Feb 2020 16:44:48 +0000
From:   John Keeping <john@metanate.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
Message-ID: <20200205164448.0c7532c1.john@metanate.com>
In-Reply-To: <87wo9156uy.fsf@kernel.org>
References: <20200204152933.2216615-1-john@metanate.com>
        <87wo9156uy.fsf@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Feb 2020 18:36:21 +0200
Felipe Balbi <balbi@kernel.org> wrote:

> John Keeping <john@metanate.com> writes:
> 
> > dwc2 always reports as self-powered in response to a device status
> > request.  Implement the set_selfpowered() operations so that the gadget
> > can report as bus-powered when appropriate.
> >
> > This is modelled on the dwc3 implementation.
> >
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---  
> 
> what's the dependency here?

It depends on 6de1e301b9cf ("usb: dwc2: Fix SET/CLEAR_FEATURE and
GET_STATUS flows") in your testing/fixes tree.

Sorry, I should have mentioned that in the original message.


John
