Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C8FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE91F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592420883;
	bh=e/5+Rb5G33cHdb0vaSQhP5UBxDZid2EqzR4REteNm0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qwmTSZ35EQgLUhHA/hxxay78qdeMsAuXs69NdNq9V5njuYKXvy1DTA2UjtBafBFL/
	 05C8vTvLnsNNanzBm7i43VsH+ZVjIl3bbHUlKrVFNvrKvCxb4X4h2oNePd6bqFmU1b
	 tuS6cMSiyDptat5vTPVIjG/0pmygE3ZEpDNb6/KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFQTIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFQTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:08:01 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8348C212CC;
        Wed, 17 Jun 2020 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592420880;
        bh=e/5+Rb5G33cHdb0vaSQhP5UBxDZid2EqzR4REteNm0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijyw4jYzonC/TpUxkUJcYLfLFvoV/dmUA8cVBeRHaoHrHlBI7zK+yMx9+lllc15a/
         WuEhuYKCU3ar0yPMOCqvBCBoGM3ojMuJYBnwdCzSXD0Lie1rzsM2M0s2x+/8tp4Z0i
         8xRnltLkln8admHqJZo1pd6PJRKGyBPVv6kXccOE=
Date:   Wed, 17 Jun 2020 21:07:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brad Love <brad@nextdimension.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Sean Young <sean@mess.org>,
        devel@driverdev.osuosl.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RFC 0/4] Don't do tuning zigzag using the very same frequency
Message-ID: <20200617210755.1138caa2@coco.lan>
In-Reply-To: <cover.1592419750.git.mchehab+huawei@kernel.org>
References: <cover.1592419750.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 17 Jun 2020 20:52:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Marc reported on IRC that the zigzag code is trying to tune several times using
> the same frequency with si2168. Well, this is not how this would be supposed
> to do: it should try with different frequencies each time.
> 
> Change the core to use the one-shot mode if the frontend doesn't report a
> frequency step. This will default to the current behavior, except that tuning
> should be faster.
> 
> Yet, probably the right thing to do is to implement a frequency shift at such
> frontends, as otherwise  tuning may have problems. So, produce a warning
> on such cases, in order for the FE driver to be fixed.
> 


> Mauro Carvalho Chehab (4):
>   media: atomisp: fix identation at I2C Kconfig menu
>   media: atomisp: fix help message for ISP2401 selection

Those two patches are unrelated. Please ignore it on the context of this RFC.


Thanks,
Mauro
