Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88EAC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D81206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595701512;
	bh=Dq8mUWOBlA+CBHS/3t+mQ9cNSU1dWsOLOi1XG49t8hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ePRuQLp9gmlVMQ8DNkbklVj8L7zxPu+xzP3vgzWKZITamTUzfQQdd/COK5H85dYTU
	 rMoQ6zJ6FS8GE19UXM08/pM104t+z+O3bjCb809Ni60HBQ+f7M6D5PYE90iG5Z/O0p
	 EjqIBE+T3+8Nx7etbJbB5dT/GIjabOrUhPGrY0CQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGYSZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgGYSZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:25:11 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CC5206D7;
        Sat, 25 Jul 2020 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595701510;
        bh=Dq8mUWOBlA+CBHS/3t+mQ9cNSU1dWsOLOi1XG49t8hM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G2n1xKBvRbijSrFphE2XU2ZGjv478I3RfCkDSELHUv000Xni/x4J58J1pzLJIRCTL
         D4TmaMr1sn7yH7BH9vsQnUrM3tBlX0Aju3Atdgg+lQ3Ea7qaGDdiIVXG5oSDYHxhZp
         ZW+jINN+N3ZXma0l7P5zkSjoDq6E7034huYJwPsw=
Date:   Sat, 25 Jul 2020 20:25:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, sean@mess.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC, WIP, v7 0/4] media: vidtv: implement a virtual DVB driver
Message-ID: <20200725202506.1db9dd3b@coco.lan>
In-Reply-To: <1cd01ac5-55f7-68f5-791b-ae4955d916d7@linuxfoundation.org>
References: <20200608191333.1784963-1-dwlsalmeida@gmail.com>
        <1cd01ac5-55f7-68f5-791b-ae4955d916d7@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 24 Jul 2020 17:43:55 -0600
Shuah Khan <skhan@linuxfoundation.org> escreveu:

> Hi Mauro,
> 
> On 6/8/20 1:13 PM, Daniel W. S. Almeida wrote:
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> > 
> > This series is work in progress. It represents the current work done on a
> > virtual DVB driver for the Linux media subsystem. I am new to the media
> > subsystem and to kernel development in general.
> > 
> > This driver aims to:
> > 	- Serve as template for new DVB driver writers
> > 	- Help userspace application writers in general
> > 	- Push fake audio/video to userspace for testing
> > 		purposes
> > 	- Push debug information to userspace via debugfs
> > The Virtual Digital TV Driver (vidtv)  
> 
> Any feedback on this patch series for Daniel. He has been waiting for
> reviews and feedback from media developers for a while now.
> 
> Please review the patches and give him feedback and help him with
> next steps.

I'll seek for some time to look and review them next week.

What's the current status of it? Is it probing properly and working
fine, or are there any known bugs at the code?

Thanks,
Mauro
