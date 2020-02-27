Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC654C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0742246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582840421;
	bh=K5shtj2gR06IHxqx2BJjVubweRhgFaN6g2UMrpfQW00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2afgNApCl0f/tyU/ySG6zspasz8ZxYUan0HUWL/UopTCdt6LyxzYyCLhg3n4VMU97
	 /DSJcbCoxKddhpFBf8IDapM0VcgLxELaEDj8XFb9n2JvdCCxateFdZ8+iu5gTpvccd
	 6yYWBFJdVcy/iUlKbWm3KrizpaUxGeV6y/9MJoK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgB0Vxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36928 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgB0Vxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so537760pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kC1Xoh5We8HW6QYhWDydXI61P1j3Hdueu4SIi8W2Ufs=;
        b=p9M/TOc0o3The2WYnf221ywfa6k7xOY1mIPKc1L5s6zfgau1Qi+PEvy4EjCT08fHST
         f47H8FwNUcqbBDCRKgEdus0eh3pTBHGUWQDTwR7rSXN39i41cOOKxsL2qjQkrDtambcM
         h+eCff3n1DSR6UAMf8VUUJrTwY7sY4aJCLVVUmVge1g0VpRAV2ohuZwKWx13k2g9oapt
         eCrDQZ+dXwP3iysq5TFRpgTQBHGk+fFtxvTpPnud1SMy4AGEVBSBDI7F/aPraxwFGSmR
         rtdM0ZpTb4AxYOoUpOncbLLxdNnsVj62J17te/jLf5zEc3DT761ZFGKyyC8klncRGezj
         prtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kC1Xoh5We8HW6QYhWDydXI61P1j3Hdueu4SIi8W2Ufs=;
        b=fNkacmEx5AMsV4g1LY+SEx3+tkSCMAmWwJzmEDG25bIlAHWVl6CFvbJ4dgrs3K5eS7
         OdIcmSF/RQclVRsO3qCm0ktYTbNmhzK1eVOkRA91q+3NH1e/x8+j1vDMIyU0LxfQ6qrY
         OuiJWjRfAzDMs30bShmeXi3jATuwLRTZOEV4mHf+7jLSAaRod2M2w3rczkyYaHAIszfh
         HyUc0zUsS+BgYAPNroYB7VoUNJrp1pojLBzJQXIrsWYQaXphZhVKd67jVnCzfG/z5G44
         3DcaVRQfcUboZcgx0WsjTzXrRRdeOHkHrHHwM/q8oUHa/6GljuSxB9HQ2WHadOBDmL8z
         du5A==
X-Gm-Message-State: APjAAAV8KyTMSFKSkMlFt6HYVq65utMyNk+ictwqiVpG5KyCrKZqXhsS
        XFl5yZqi+jp82In+s5SbON8=
X-Google-Smtp-Source: APXvYqw+Q6jXwMaLoCpk0a9L4HlEF/CXRHuyZuHxR4f3O+ZrtJMfhRLEUWpmbJo2JWI+nsY0qsJkCw==
X-Received: by 2002:a63:f302:: with SMTP id l2mr1361641pgh.294.1582840418096;
        Thu, 27 Feb 2020 13:53:38 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 190sm7673311pga.85.2020.02.27.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:53:37 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:53:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 12/30] mm/zsmalloc: Add missing annotation for pin_tag()
Message-ID: <20200227215335.GD215068@google.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-13-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214204741.94112-13-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:47:23PM +0000, Jules Irenge wrote:
> Sparse reports a warning at pin_tag()()
> 
> warning: context imbalance in pin_tag() - wrong count at exit
> 
> The root cause is the missing annotation at pin_tag()
> Add the missing __acquires(bitlock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
