Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B8C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA922080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691864;
	bh=O8kunBfWKRqS97ByfKBHH9TqSMDTRE0G1JnjUob7VJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCzxPC3DHfX/QDqDu+1dw+IhIskl9MaSpKejakczyh2Alcw8H+rrV87DZCpKj5Zdb
	 JjVUhnc//eZDMPzPFjvnHOgHQvnWj8vrAHNE+q8aIVnAa7tv+P3uwWPoiXkVHrrV0T
	 cZ7oy4Thy9rBcOEJenVEFby5cvXK581tDGfLoJVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgCaV5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:57:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33270 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgCaV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:57:43 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so21010794ilg.0;
        Tue, 31 Mar 2020 14:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QEqtdDPs3fIca6WRuiiLpB1Rw0w1HZd/cc02uAbwKQ=;
        b=EIidPigLsOJtwT2GeBWYF0q9/Lai4ggaPliqG3jdh10hcPiIohgrN9cIZEgAIRbKAS
         N1FEkjRdLCK4nQuLLf6Lf+5bB1p1mRrChFJ4OzJyHJYYhEP1TOY0ZAGFkMkXC6dfgCL1
         w63vggn0/DlvsgwT91Fb5JRgs2+mvGnwHntLAKKsMwCUO0UH4Z5ulMQMBAZi+1EqxqXd
         YH8XaGm4RcwOqJKTndn95pJt/pc3uLNwPVVhxzqauz4p8XSFTlEh9c8kZIUCCdB6XEqk
         mI/k/W8jOSzVCSp4ljCRoIlTVz0IWAFE6akgh4dfFQdp1T5gLJz1jsDRcpM3rKL0XKER
         ldzg==
X-Gm-Message-State: ANhLgQ0q/L8R6rtyRfYtiV2QnoR5yeUJ48rdJ4S86J9u6JcD6FQBA3tT
        63aUwoI8AWup7Ka+AmX5ig==
X-Google-Smtp-Source: ADFU+vvBIEGlbOI6faPF9K8IAOJ/ri8FhnlXczhbYRNtjtERZ5gcGCOfaseZHNNUNem9nC0Kotewaw==
X-Received: by 2002:a92:1d4b:: with SMTP id d72mr18224640ild.14.1585691862545;
        Tue, 31 Mar 2020 14:57:42 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m71sm38807ilb.67.2020.03.31.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:57:41 -0700 (PDT)
Received: (nullmailer pid 12286 invoked by uid 1000);
        Tue, 31 Mar 2020 21:57:40 -0000
Date:   Tue, 31 Mar 2020 15:57:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 1/2] of: gpio unittest kfree() wrong object
Message-ID: <20200331215740.GA12198@bogus>
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
 <1585187131-21642-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585187131-21642-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 20:45:30 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> kernel test robot reported "WARNING: held lock freed!" triggered by
> unittest_gpio_remove().  unittest_gpio_remove() was unexpectedly
> called due to an error in overlay tracking.  The remove had not
> been tested because the gpio overlay removal tests have not been
> implemented.
> 
> kfree() gdev instead of pdev.
> 
> Fixes: f4056e705b2e ("of: unittest: add overlay gpio test to catch gpio hog problem")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
