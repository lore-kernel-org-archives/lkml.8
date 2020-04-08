Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01883C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92C720768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586341208;
	bh=yKozUSAfD7WpYIcWLmx7zfhM5IlRSW9D87rkJqsrJoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pRupqXu+sbgBkou2M5krkPNq/oOYlcPL/T4LUjBibb4YE+S4Nq8KWSFoyqlF9NZ8I
	 oPnGWtcvuWt258DjPSm0DVTOAiXJqwX/Ymny4DKAmUrMGpAfXceid3r8gJ/YcXO+x3
	 Vw7WR/TN22BBQSsfqlgLcV08TFfZADj9xsCY2Z50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgDHKUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgDHKUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:20:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6201620768;
        Wed,  8 Apr 2020 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586341205;
        bh=yKozUSAfD7WpYIcWLmx7zfhM5IlRSW9D87rkJqsrJoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txCudZCBIjpriNoN6AWxW0kYsMzP8IMFLdzHgxanNz3dag6SE4pJWaekq76lMLyVw
         1N/qZZOl98X/rUYF4BpNskqD9lJDaDyR1dhPwQ8nUSmdRixNO2cq/D+qWMu3/2Kr0x
         Rdxd25vAoryA4owm+mbaigQJsfVlmzDYs71txn50=
Date:   Wed, 8 Apr 2020 12:20:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Export fw_get_builtin_firmware()?
Message-ID: <20200408102003.GA1070237@kroah.com>
References: <20200408094526.GC24663@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408094526.GC24663@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:45:26AM +0200, Borislav Petkov wrote:
> Hi guys,
> 
> so I've come across this recently where the microcode loader
> has a trivial helper get_builtin_firmware() which scans through
> the builtin firmware to find microcode in there. Looking at
> fw_get_builtin_firmware(), that one does practically the same so how
> about I export it and have the microcode loader use it instead of
> homegrowing the same thing?
> 
> IOW, something like this below?
> 
> If you agree with the approach, I'll split it properly into patches,
> etc, of course.

Looks sane to me, thanks!

greg k-h
