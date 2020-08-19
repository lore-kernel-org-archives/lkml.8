Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9132EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F44F207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ik2wmMPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHSNLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:11:31 -0400
Received: from forward1-smtp.messagingengine.com ([66.111.4.223]:48273 "EHLO
        forward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgHSNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:11:11 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 09:11:10 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailforward.nyi.internal (Postfix) with ESMTP id E241C194197D;
        Wed, 19 Aug 2020 09:01:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 19 Aug 2020 09:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FQUJJ4
        ivYQ+lk1mPpagdjqu+O8nCipPJWuj36SsFCY8=; b=ik2wmMPArMQsS7GdM799dW
        Z2d7Jqw88uy8Q1YKkJUccVx9oleK92RoarvxWT3BJTawhoyK3Rrhf6J1dyAPnAGC
        wflBwIxaiBC2+Cr02FsneZdxWTKggcBzH7/MLbevMe+h77yh7xEDiTXjW90ICasI
        9mCloktwVu7D+hQ0IDdsztPiJFVpwsXcQfDeShwBTo1LuOsOv1Rs05hliuhmwfsT
        /Hpp7nlkN6tT6JK19il2dB+x3dkbk0RyYukPyUI/HjbdX+uh4se3+Sv/vxjcglKY
        IlDb97chqQxiauPZJJe5olrfi+sZ6o9Y/4fZuba5+F6uPVFBjZTfdHwFSL2odPpA
        ==
X-ME-Sender: <xms:rCI9X1-qI_GjNoEW-SK559H8NZSLZvyZWQl7zqOOyWFqhuS_y_zLqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvghkkhgr
    ucfgnhgsvghrghcuoehpvghnsggvrhhgsehikhhirdhfiheqnecuggftrfgrthhtvghrnh
    epgfffgeekteetvdejledufeelleeuudeigfevvdeileeludehiedugefhleehvdeunecu
    kfhppeeivddrjeekrddujeelrddufedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphgvnhgsvghrghesihhkihdrfhhi
X-ME-Proxy: <xmx:rCI9X5sAy3BG4lCuP7996cLCL14do5WCDdJcpESgK8BJDmT1fGnfbg>
    <xmx:rCI9XzDcPll05dprsTKe9FFd_DJXB-M9ymUY_1cYZLlADyJNdNgTIQ>
    <xmx:rCI9X5dMulrIK9WUNRF0VxW2LQYCnPRsg-k_3pLUNIYJZFgxG-IlOw>
    <xmx:ryI9X2Bl3P9yFxoYQAVe5Iy5X8ik_69m80XArRpfZWSe4UqnyUo-mA>
Received: from localhost (62-78-179-131.bb.dnainternet.fi [62.78.179.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0AF87328005D;
        Wed, 19 Aug 2020 09:01:31 -0400 (EDT)
Date:   Wed, 19 Aug 2020 16:01:30 +0300
From:   Pekka Enberg <penberg@iki.fi>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        penberg@kernel.org, rppt@kernel.org, eert@linux-m68k.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/mpparse: remove duplicate include
Message-ID: <20200819130130.GA1903671@nero>
References: <20200819112910.7629-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819112910.7629-1-wanghai38@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:29:10PM +0800, Wang Hai wrote:
> Remove asm/io_apic.h which is included more than once
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>
