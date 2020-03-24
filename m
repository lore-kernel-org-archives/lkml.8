Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D8C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0132076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585058585;
	bh=nZheRtnEx8p5KPd5Sx+dBSzlY74POjtd9VyQ8pp502Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aXtILuBxSpUV0CZwiwQ8Ujvq9kl3oD1uJWtRDYCPgYsBKjxfFSlf7jDRoUlNbJtO5
	 c0BlIguQiiH0tEuAxuPREWC8qS/RjZWif+cGRgksTDfdOOuonLk7OM/voxGiiHNAaf
	 TYSJ7kMDeXVR/+GG6UAaa9MgGyRWbzAIkychAj9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCXODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCXODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:03:04 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25FF205ED;
        Tue, 24 Mar 2020 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585058584;
        bh=nZheRtnEx8p5KPd5Sx+dBSzlY74POjtd9VyQ8pp502Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kw0j4nhJWqpbk1JdoTcnIE0HHfHnre7W0Rfcuski5nX85ulIIY2ebZYgY26zMo9sB
         moY9eCEscP9YWFnMqp91LKQKU63KrX2cZtsIHahGapEejvMhHuYFGOPoUi1p/m/8YZ
         /Jqw19sx9Kuaof5LPKzNzlJVQBIDwPASfo8+NPr4=
Date:   Tue, 24 Mar 2020 15:02:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v2 00/20] Reorganize media Kconfig
Message-ID: <20200324150258.492000e4@coco.lan>
In-Reply-To: <20200324135359.GA21251@pendragon.ideasonboard.com>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
        <20200324135359.GA21251@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 24 Mar 2020 15:53:59 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> Thank you for the patches.
> 
> On Tue, Mar 24, 2020 at 02:42:53PM +0100, Mauro Carvalho Chehab wrote:
> > This patch series do lots of reorg at the media Kconfig options.
> > It also move test drivers from platform dir to a new one.
> > 
> > After this change, the main config is organized on menus, allowing to
> > select:
> > 
> > 	- type of devices selection - the filtering options
> > 	- Media core options - with API and other core stuff
> > 	- Media core extra options
> > 	- Media drivers
> > 	- Media ancillary drivers
> > 
> > The "type of devices" menu has the filtering options for:
> > 
> > 	- Cameras and video grabbers
> > 	- Analog TV
> > 	- Digital TV
> > 	- AM/FM radio receivers/transmitters
> > 	- SDR
> > 	- CEC
> > 	- Embeded devices (SoC)
> > 	- Test drivers
> > 
> > This way, one interested only on embedded devices can unselect
> > everything but "Embedded devices (SoC)" option.
> > 
> > Distros for PC/Laptops can enable everything but 
> > "Embedded devices (SoC)" and "Test drivers".
> 
> How about a device such as the Intel IPU3 ? It's a SoC, and is present
> in laptops. Unlike the physical interface which is a fairly well defined
> way to categorize devices, creating artificial classes will always leave
> some devices without a home. We could have a capture card that supports
> both analog and digital TV. A digital TV capture card with an HDMI input
> can have a CEC device. Lots of combinations are possible.

This is basically what we had before, just better organized. 

It is a hints based selection. So, a multi-function device like IPU3
would basically do (either directly or the menu which contains it):

	depends on MEDIA_EMBEDDED_SUPPORT || MEDIA_CAMERA_SUPPORT

When the filter is disabled, both options tune to "y".


Thanks,
Mauro
