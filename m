Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7812206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf6FFYC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHFRxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgHFQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C80C002179
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:17:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f9so6812763pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvufMbgkHBSjZokNTrohW1HBR5GWTEJLiYyoeQKMQoc=;
        b=Pf6FFYC0wPxL6d8QETsIOkfOlxIwRY/C0AqdyI90hPQRstfaU9+B998DLapMl1WGNB
         WqNSPX1Ws7YGgGUmETWrVvIdqQE+KZKu7Ow4fEGNh7jS9vd1PbSjEQxo8NGLOIbGkQnR
         oSHKePrXKpHzckubyhQ7X72KnBZun5DiYD0CXDtPtXREXrLySRCC75b7GpvHOrtOcKt6
         PbtvmEzLWaCG3aBEKBJSVfX28GZPbZcsQxlpYrMWr01bo5XGkJXagMq5c9Uhp15tjooh
         GESXpv1yOSShPFWP37VfgRm+CD9yuOHPXAo8Pv868sTLAK/hmBknx2rTL5Gyent1nS+0
         uyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvufMbgkHBSjZokNTrohW1HBR5GWTEJLiYyoeQKMQoc=;
        b=k2HfWF/tg7UN1hkOcChJq4rc6ABSsB8jvWG/2DQFjZm89zl5CM5P6QOylMgZm/esBe
         Q+i+d5+4muEKbwsfUxyrmmpLpsQbnzBECVijNUHafpDpXlbToce1CWoOT29fMlipoJ+2
         5qQoK3uqwYyQmHwdRIlVj7W7kR5A01bgM54qDofrvMGEP8jmD9MpTBwzfYjGVMNSzPXf
         bFEUZR7shykjitDCaIHLk/KRpUyYXtnTqiekhszrT627ULlHBwUO0Y2lQreSTkNXesxq
         ZM47A8IFiTK+tXPSpEiR261vpSeMkNhl1+GWDhf4qojI+blz2aZk5pAoykZodczXi5bJ
         pJSA==
X-Gm-Message-State: AOAM530OGRyEYNVV3yt2SntPkK7vS7wqTkFUI5lqao5JdiNqbIe/iga0
        KMUnOfQdL6CNWc7VBF021eI=
X-Google-Smtp-Source: ABdhPJyL9VQsbyt/WHVXcimDWPjM4C/e72yvdlI9/2OSl5YId8/LBG90edfhPfoQPbfaX1tEPA/pOQ==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr8136734plr.116.1596730652080;
        Thu, 06 Aug 2020 09:17:32 -0700 (PDT)
Received: from gmail.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id z15sm4352201pjz.12.2020.08.06.09.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:17:31 -0700 (PDT)
Date:   Thu, 6 Aug 2020 21:47:25 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Greer <mgreer@animalcreek.com>,
        greybus-dev@lists.linaro.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: issue with uninitialized value used in a comparison in
 gbcodec_mixer_dapm_ctl_put
Message-ID: <20200806161723.GA6927@gmail.com>
References: <7da6363c-9423-2b9f-029a-395cc8a932d7@canonical.com>
 <07ad3809-de73-9a66-0e4f-3a49f395a98a@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ad3809-de73-9a66-0e4f-3a49f395a98a@ieee.org>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 08:35:15AM -0500, Alex Elder wrote:

<snip>

> 
> I think the fix is to add a call to this:
> 
>         ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
>                                       GB_AUDIO_INVALID_INDEX, &gbvalue);
> 
> before the field within gbvalue is used.
> 
> Looking at gbcodec_mixer_dapm_ctl_get() defined just above that, it
> seems that the call to gb_audio_gb_get_control() should be preceded
> by a call to gb_pm_runtime_get_sync().  And given that duplication,
> I suggest this call and the PM runtime wrapper functions should be
> placed in a new helper function.
> 
> I know that Vaibhav said he would be fixing this, so I guess my
> comments are directed at him.  Thanks for sending the patch Colin.
> 
> 					-Alex

Thanks Alex. I'll share a patch with the proposed fix.

--
vaibhav

> 
> 
> > Colin
> > 
> > 
> 
