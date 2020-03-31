Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA8E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691886;
	bh=LGdCqe9ICfS1ZP4zD/UtW5mZe+3VLA+Ia7BX+4lYg9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rD6H0dcvQh9D/VNINWu0nC1JyCOq9Ff0sOeLipvYgtKAwPZhkLlhxCt5FxMoS63CR
	 uaRwcueberAIcQ/bOjYNprijU+mZBgboL9E3oj9kSyHUK6YQhYf5ApdehpcBnhl6qF
	 UkONPTalxY8ZjsU1Xs+DcZkfW2EWngKxO3zpgRio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgCaV6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:58:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41698 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgCaV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:58:03 -0400
Received: by mail-io1-f66.google.com with SMTP id b12so7246460ion.8;
        Tue, 31 Mar 2020 14:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIozpEk7R1PWhZJHP9ojDFOfKg1S3YK7gkqKMg9XXHk=;
        b=QPidKuxGI964vU+w0yj8FdrizZ34M/TsuP8aHMcghFIWTeuzlA/3LMproIeLBAoHCq
         VbnHDcDhMLKpMP4i9xnriVo/R1NwS0lo903WuiY6ko816A4C3mDfQrhxxafkwaJirhT9
         cbBO1+B3z2pKhCuRGVw8OHD7yHDjeWsVuk6aoOxhnMeTl3NLFnNM3v3bWDA+PBlzDM4C
         SVvWzrwdjCjASzSjmlniO1GmrWahkqD0TUjat0Q7fuTRQFdF10qNECW/yJSTJ+USo9/Y
         yUIQRDbSy+i6wzFS88NCl2p0L14hVhmLF9UNS1t+EZqV4gtqSaTuIYaZlEUcrl8bmBGh
         cn3Q==
X-Gm-Message-State: ANhLgQ3Rp+0GRQWCifvs/NHp11DN5naq7cIs/y98BCoetBAsgxnUpo3F
        m5cuT0HRZZqE1t2NwkIjlw==
X-Google-Smtp-Source: ADFU+vu0NMEdlvuQiIfFmwmzLSErBtVKPP2kioAGYOPrT6CrZ8qm7nBCn4yQsGAHOA4m8jUxbO73IQ==
X-Received: by 2002:a6b:2d7:: with SMTP id 206mr17354362ioc.42.1585691882134;
        Tue, 31 Mar 2020 14:58:02 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t77sm36579ilk.83.2020.03.31.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:58:01 -0700 (PDT)
Received: (nullmailer pid 12849 invoked by uid 1000);
        Tue, 31 Mar 2020 21:58:00 -0000
Date:   Tue, 31 Mar 2020 15:58:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 2/2] of: some unittest overlays not untracked
Message-ID: <20200331215800.GA12799@bogus>
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
 <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 20:45:31 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> kernel test robot reported "WARNING: held lock freed!" triggered by
> unittest_gpio_remove(), which should not have been called because
> the related gpio overlay was not tracked.  Another overlay that
> was tracked had previously used the same id as the gpio overlay
> but had not been untracked when the overlay was removed.  Thus the
> clean up function of_unittest_destroy_tracked_overlays() incorrectly
> attempted to remove the reused overlay id.
> 
> Patch contents:
> 
>   - Create tracking related helper functions
>   - Change BUG() to WARN_ON() for overlay id related issues
>   - Add some additional error checking for valid overlay id values
>   - Add the missing overlay untrack
>   - update comment on expectation that overlay ids are assigned in
>     sequence
> 
> Fixes: 492a22aceb75 ("of: unittest: overlay: Keep track of created overlays")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 

Applied, thanks.

Rob
