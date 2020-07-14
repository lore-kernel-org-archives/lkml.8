Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C69C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D13022518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgGNQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgGNQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:40:09 -0400
X-Greylist: delayed 2238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jul 2020 09:40:09 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8476C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:40:09 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jvNO8-004kKg-Pp; Tue, 14 Jul 2020 18:02:37 +0200
Message-ID: <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Jul 2020 18:02:29 +0200
In-Reply-To: <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
References: <20200704085213.444645-1-ignat@cloudflare.com>
         <20200704085213.444645-3-ignat@cloudflare.com>
         <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
         <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
         <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 11:43 +0100, Anton Ivanov wrote:

> Patch is OK with me, should not read patches before the 3rd double espresso next time.
> 
> I will +1 it, Richard, Johannes, what do you think?

I got dropped off the list in "The Great Infradead Purge" but I see it
in patchwork ;)

Not sure we should modify cc-can-link.sh without at least CC'ing
Masahiro Yamada?

But yeah, looks fine to me. Not that I have any interest in static
linking.

johannes

