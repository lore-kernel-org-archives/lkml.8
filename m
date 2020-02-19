Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D59C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BD821D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBSKpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:45:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:33756 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:45:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5BF5C2DC;
        Wed, 19 Feb 2020 10:45:29 +0000 (UTC)
Date:   Wed, 19 Feb 2020 03:45:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] docs: sysctl/kernel.rst rework
Message-ID: <20200219034523.773492e6@lwn.net>
In-Reply-To: <20200218125923.685-1-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 13:59:15 +0100
Stephen Kitt <steve@sk2.org> wrote:

> A recent discussion about differences in the "panic" description in
> sysctl/kernel.rst led me to look into completing that file, and it
> turned out that more work was needed than documenting "panic". This
> patch series is the first batch, making the resulting documentation
> hopefully nicer and more accurate. It doesn't add fields that are
> present in 5.5 but not documented; I've started adding these, but I'd
> rather submit them individually once the basic kernel.rst is
> committed, to make it easier to request review from the appropriate
> maintainers (each patch adding documentation should be mergeable
> separately, without needing a patch series).

OK, I've applied everything except #7, which I commented on separately.

Thanks,

jon
