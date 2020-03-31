Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89679C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgCaXIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:08:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:44738 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCaXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:08:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6531E2F3;
        Tue, 31 Mar 2020 23:08:43 +0000 (UTC)
Date:   Tue, 31 Mar 2020 17:08:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to
 ReST
Message-ID: <20200331170842.517ddc0a@lwn.net>
In-Reply-To: <6db0b1a2a521386613489443053a980621c48767.camel@massaru.org>
References: <cover.1585693146.git.vitor@massaru.org>
        <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
        <20200331165707.7c708646@lwn.net>
        <6db0b1a2a521386613489443053a980621c48767.camel@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 20:03:46 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> Thanks for the review, I will check your comments and correct themif
> that document is still needed.

Oh we definitely still want the document; it's out of date but not overtly
wrong.

Thanks,

jon
