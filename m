Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201FC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3478A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582097945;
	bh=B2GzMBy13MmC/psvGtTK6OGFCy/sz5GHNIfzC5kBVcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oTJgHPJEQrOSZMsJ49+M54B4V5PgoSTpmQ7RzJh1av6XcsKx3mfAfKe0dzXAw6CLz
	 5ZdO65fU9L3LVkvvvA9qL/ttGjqjDAU5Pb7HVHt+latbjf9aRFHfQKClJH5y8kDL00
	 XgEieHY+nSDAEGvJNqvhq8PGRwelQ8vAYqPtj8YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB125208E4;
        Wed, 19 Feb 2020 07:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582097943;
        bh=B2GzMBy13MmC/psvGtTK6OGFCy/sz5GHNIfzC5kBVcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFKQy5flpgd/sQRMjCKY2AnM32grrfL+k8RvSpHce+jGMvOPG3b557sahZGcoXBRL
         aFTNUr00zzWi0Ur70ZpL5WkWckB0IWFerF+lSVSHWt0bUffttEfpw7BzGrUqqyAugI
         r2tLpQts92YL67LrGalmw6Q3q31t5zGIOPegBAww=
Date:   Wed, 19 Feb 2020 08:39:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20200219073901.GC2728338@kroah.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:20:42AM +0100, Vitor Soares wrote:
> +
> +static DEFINE_IDA(i3cdev_ida);

You never destroy this when the code is unloaded :(

