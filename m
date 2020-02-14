Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7FFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3324650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581666177;
	bh=m798uLVqmuYtv5ug6phfy9RoTjgQyqUELX3cTjvJVMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdt0srhhORgBTSkjDkk2CGmmfqrk+xHXQIaTf54LJW6RYTPGbKdRkq75Qhz8S30Gn
	 2jS3MhuxypLjK2cP9vJYgM3ZlD9Ga9bROhyDI3mUpGf2wdP4DFB/jI2kR1948upxZ/
	 TkBEE7mnwPuWXQOCvcjtOG1vHhghLU2iW62KqoJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgBNHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgBNHm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:42:56 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6462467B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581666175;
        bh=m798uLVqmuYtv5ug6phfy9RoTjgQyqUELX3cTjvJVMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YmBuwPtRGIYFABvzK00gyC3HUwpkhd/mEGyopNk7IWDExVBsz/aTGXp1t1UP1LsS3
         uKmBHo2k084OlSvg3VUjTwOLInWLBXXNkuBsNi+4em8YHwmrLR1vMgiGCaz94CY188
         daxj5etfGNvwT3FPWnhg4ZSyoFhNuG9BOFuYNC1U=
Received: by mail-lj1-f178.google.com with SMTP id r19so9609141ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:42:55 -0800 (PST)
X-Gm-Message-State: APjAAAX6F/NtbHB3wtwZyAvJINH8T8F4PLDgBXrJPrtasEfkgvKsBfc/
        K/zcexwhFcM/YQtHtRMEv3bSmEk3c51M1r8DB3A=
X-Google-Smtp-Source: APXvYqy7gojEaGR75YMM57u2JXSw/yOVghVztLaVTcFLE+UKiZQ9sYF9fwVeQGU1YORQn5Pe+ddsEzhZzr9AWB0N5kk=
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr1197113ljj.270.1581666173493;
 Thu, 13 Feb 2020 23:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com> <CAEnQRZA4W-i4zcF8jUL2zp5-dO-iX=KSp5Do2pCK9_oZiVtYEQ@mail.gmail.com>
In-Reply-To: <CAEnQRZA4W-i4zcF8jUL2zp5-dO-iX=KSp5Do2pCK9_oZiVtYEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Feb 2020 08:42:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPexfj9Rs+9jGSd4LWhcp0txdECBqsdvSJvHv7NdtNsaMA@mail.gmail.com>
Message-ID: <CAJKOXPexfj9Rs+9jGSd4LWhcp0txdECBqsdvSJvHv7NdtNsaMA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Yuehaibing <yuehaibing@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 22:09, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> Hi Krzysztof,
>
> Which symbol misses an EXPORT_SYMBOL?
> We already have EXPORT_SYMBOL(imx_dsp_ring_doorbell);

Hi,

Yes, exactly this one. That was just my guess.

Best regards,
Krzysztof
