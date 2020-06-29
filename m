Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8EDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC08821D81
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgF2Sg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:36:59 -0400
Received: from ms.lwn.net ([45.79.88.28]:46808 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgF2Sg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:56 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 959E92B7;
        Mon, 29 Jun 2020 18:36:55 +0000 (UTC)
Date:   Mon, 29 Jun 2020 12:36:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     mchehab+samsung@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, robh@kernel.org,
        j.neuschaefer@gmx.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones:
 Documentation/arm
Message-ID: <20200629123654.1d1b62ce@lwn.net>
In-Reply-To: <c5d49d66-7765-d6e3-003a-c17bdef1c6b0@al2klimov.de>
References: <20200626194408.61245-1-grandmaster@al2klimov.de>
        <20200626150911.3d4f9ca7@lwn.net>
        <c5d49d66-7765-d6e3-003a-c17bdef1c6b0@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 09:10:58 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> You know what: I totally agree with you! They are actively harmful and 
> shall not be there. End of story.
> 
> But *why* you don't let me work step-by-step and *focus on one task* at 
> a time?

Nobody is preventing you from doing that.  But this work *does* require
corresponding work from me and others, so I don't think it's inappropriate
to say that there are other, related projects that, in my mind, have a
rather higher priority.

Thanks,

jon
