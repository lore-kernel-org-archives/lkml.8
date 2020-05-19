Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B119C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85528207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgESTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:43:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85CDC08C5C0;
        Tue, 19 May 2020 12:43:54 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 725CC23B;
        Tue, 19 May 2020 19:43:54 +0000 (UTC)
Date:   Tue, 19 May 2020 13:43:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200519134353.2ebc7de3@lwn.net>
In-Reply-To: <b0402faa-1028-4b31-6c8b-b0bf4f37a53d@al2klimov.de>
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
        <20200517134544.7d649bbb@lwn.net>
        <1bc96da4-49d7-1c8e-de15-858641aba59f@al2klimov.de>
        <20200519101043.4471069a@lwn.net>
        <b0402faa-1028-4b31-6c8b-b0bf4f37a53d@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 20:50:55 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> > OK, I fed your patch to the script, waited a fair while, and got what's
> > below.  And yes, you don't want to actually send a patch to such a list of
> > recipients - it's a sign that your patch is too large.  
> Please could you share the exact command you ran?

scripts/get_maintainer.pl your-patch

jon
