Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B93C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601DA2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585322508;
	bh=bMKA/njcNLdYnsV0HkVziUEuigOUwS1wO51wrpw/0+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KDOK3j8/w4Lrhfdm8Gc0q02vGLmkgVvv0erKncEjqFGHYhClf1VJP6EXnrGk0P6z9
	 Nd5lt/mJ9YZtDN/WSPWfdliaSpjXXOIygjDeuHHPcqHw0sGo0ga4uEuj31c7Wg9VMz
	 VERdef4i1Q7oB/j2EgG+Sy1Ia6covqlZ4GVb6XOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0PVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgC0PVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:21:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8090206F2;
        Fri, 27 Mar 2020 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585322506;
        bh=bMKA/njcNLdYnsV0HkVziUEuigOUwS1wO51wrpw/0+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7lUXgm0yW97YRmqowZ6P+3l/BUBtb8fmq9MY8/8zcXePhELjO5WQ/89FEwb7pxV/
         6QEjgBRGkMSf5l+9I+/VUX9Qvd43/faWjuo+0g4UXTGwO8TZjRaFKfSeewRD2geCpJ
         36tpGiHo3dmHrn+naSiZkqUUvmAZj5A2SRZ+pWSI=
Date:   Fri, 27 Mar 2020 16:21:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
Message-ID: <20200327152144.GA2996253@kroah.com>
References: <20200321210305.28937-1-saravanak@google.com>
 <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
 <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:25:48AM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 2020-03-21 22:03, Saravana Kannan wrote:
> > Set fw_devlink to "permissive" behavior by default so that device links
> > are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
> > firmware.
> >
> > This ensures suppliers get their sync_state() calls only after all their
> > consumers have probed successfully. Without this, suppliers will get
> > their sync_state() calls at late_initcall_sync() even if their consuer
> >
> > Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
> > that needs more testing as it's known to break some corner case
> > drivers/platforms.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> This patch has just landed in linux-next 20200326. Sadly it breaks 
> booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit 
> mode. There is no warning nor panic message, just a silent freeze. The 
> last message shown on the earlycon is:
> 
> [    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled

I've just reverted this for now.

thanks,

greg k-h
