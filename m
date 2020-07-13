Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9223EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1BA20578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgGMPts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:49:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB3C061755;
        Mon, 13 Jul 2020 08:49:47 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8234B60C;
        Mon, 13 Jul 2020 15:49:47 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:49:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 00/11] Documentation: userspace-api/media: eliminate
 duplicated words
Message-ID: <20200713094946.26971d3b@lwn.net>
In-Reply-To: <20200703235536.30416-1-rdunlap@infradead.org>
References: <20200703235536.30416-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 16:55:25 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop all doubled words in Documenation/userspace-api/media/ files.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> 
>  Documentation/userspace-api/media/dvb/audio.rst                       |    2 +-
>  Documentation/userspace-api/media/dvb/ca.rst                          |    2 +-
>  Documentation/userspace-api/media/dvb/demux.rst                       |    2 +-
>  Documentation/userspace-api/media/dvb/dmx-qbuf.rst                    |    2 +-
>  Documentation/userspace-api/media/dvb/net.rst                         |    2 +-
>  Documentation/userspace-api/media/dvb/video.rst                       |    2 +-
>  Documentation/userspace-api/media/v4l/buffer.rst                      |    2 +-
>  Documentation/userspace-api/media/v4l/selection-api-configuration.rst |    2 +-
>  Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst          |    2 +-
>  Documentation/userspace-api/media/v4l/vidioc-g-output.rst             |    2 +-
>  Documentation/userspace-api/media/v4l/vidioc-qbuf.rst                 |    2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
Mauro, I've been assuming you'll grab these; let me know if you'd rather I
just pick them up.

Thanks,

jon
