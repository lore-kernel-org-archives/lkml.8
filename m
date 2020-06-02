Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C04206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mixtli.metztli.it header.i=@mixtli.metztli.it header.b="Qv8Uty7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBNU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:20:56 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:26701 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:20:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1591104055; h=From: Date: Message-Id: Cc: To: Subject: Sender;
 bh=TAsRPfKbTy6wQKeY54GoiEPQoaLtaNTmbgeoV1jTBA0=; b=Qv8Uty7+T6RRF1BCz96qfkCmGvTquKN9o/NqK23tvxMINLxOrYXEPr3YCytm4VACAwf7Ga5y
 9zCE+tmNaazBYETcfVELqwCSNy/PxOvVNbChZpTwJapPlSG9NgzytNJnQ7vG/6lOGGcPOCcB
 PghPKsxBopU9S1wcvs0mfB5ubiU=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli-it.com
 (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ed652352c54998475a46679 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 02 Jun 2020 13:20:53 GMT
Received: by huitzilopochtli.metztli-it.com (Postfix, from userid 1000)
        id A89BA6095180; Tue,  2 Jun 2020 06:20:51 -0700 (PDT)
Subject: Re: [GIT PULL][PATCH v5 0/8] Add support for ZSTD-compressed kernel and initramfs
To:     <nolange79@gmail.com>
Cc:     <nickrterrell@gmail.com>, <akpm@linux-foundation.org>,
        <Kernel-team@fb.com>, <clm@fb.com>, <gregkh@linuxfoundation.org>,
        <keescook@chromium.org>, <kilobyte@angband.pl>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <oss@malat.biz>, <patrick@stwcx.xyz>,
        <patrickw3@fb.com>, <rmikey@fb.com>, <sedat.dilek@gmail.com>,
        <terrelln@fb.com>, <x86@kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <edward.shishkin@gmail.com>
X-Mailer: mail (GNU Mailutils 3.9)
Message-Id: <20200602132051.A89BA6095180@huitzilopochtli.metztli-it.com>
Date:   Tue,  2 Jun 2020 06:20:51 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 2:59 PM Norbert Lange <nolange79@gmail.com> wrote:
>
> The series seems to be stuck in limbo, and I got the hint to bring
> this to Andrew's attention [1].
> Hope this will finally end in upstream, been using these patches for ~2 years.
>
> Regards, Norbert
>
> [1] - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955469

Began using your patch for Debian Buster backport of 0.136 initramfs-tools, and Nick Terrel's kernel patch for 5.6 -- but modified for 5.5.17-19 in my reiser4 builds -- and set both defaults to zstd.

Thus far, as long as there exists 'a priori' the Zstd package, the combination works in both local and my custom Google cloud instances installations.

Best Professional Regards.


-- 
Jose R R
http://metztli.it
---------------------------------------------------------------------------------------------
Download Metztli Reiser4: Debian Buster w/ Linux 5.5.19 AMD64
---------------------------------------------------------------------------------------------
feats ZSTD compression https://sf.net/projects/metztli-reiser4/
-------------------------------------------------------------------------------------------
Official current Reiser4 resources: https://reiser4.wiki.kernel.org/
