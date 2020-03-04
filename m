Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6BC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903420838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbgCDVXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:23:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:47366 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388337AbgCDVXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:23:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 510F8537;
        Wed,  4 Mar 2020 21:23:00 +0000 (UTC)
Date:   Wed, 4 Mar 2020 14:22:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200304142259.7eaa3633@lwn.net>
In-Reply-To: <a6680eb7-5a1d-ea58-0eec-14f2b5bcd99a@web.de>
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
        <158322635301.31847.15011454479023637649.stgit@devnote2>
        <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
        <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
        <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
        <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
        <a9f8980e-4325-52c1-d217-d2fca1add37d@web.de>
        <3118d72b-a33c-e6d7-36a1-204d39d2bdbb@infradead.org>
        <a6680eb7-5a1d-ea58-0eec-14f2b5bcd99a@web.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 22:20:07 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > I'm hoping to be done with the current changes. :)  
> 
> Will a term like “grouping of parent keys” need any additional explanation?

Honestly, Markus, I think that the patch is good enough for now; time to
merge it and move on to something else.

Thanks,

jon
