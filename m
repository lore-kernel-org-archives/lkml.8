Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AFDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBED2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAia+4Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgGLVHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgGLVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:07:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F6C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 14:07:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so13318978lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lS5XTrwedb/3nokz4lVo12gjMCK4Z6XI2hGCylgUL6I=;
        b=EAia+4Ip1P74K7zvOGJQNCPkEkazJ01C3M3lYtd7RnTeJAHFGfX8gZ1A7e8HJoAQn1
         OEmPVc5UaLa+X5RLXNONbvJWMmBnU4RAmlTLr3Uh6i50Q9HmEL3NMmHFxGo8+O871Cg1
         38ewH3MDsUg0zK1F7CyX8Fy87RvwJSOjs0sz+tDC+0VVxcBwsT6FJBfKvChJTA67D9w3
         KGphUmmi/vzO6oObyRp6GockyR1ca5LmtSyb0yIZQf2FEtDNEDTaI8h+80YoxCvqn8i6
         C8R654bnc9RCb05PlLJAlFJxQKFBPLzkD0ZXMc7YrNXFSgrgtqVmgUkJeVshuEGbOuTZ
         AUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lS5XTrwedb/3nokz4lVo12gjMCK4Z6XI2hGCylgUL6I=;
        b=HDqN2e9CvMnyQX7CB/wlAB5SCjaMPp99vXE4qfRvJ89tJgTVANumA6udc43rfReXG+
         2ZKdk6swqf2gQe7X33yPzTDsS1W4z2QQgiU1/sKJM+dlFijPBiVG0f1YgWyCmPAEi+GZ
         b28GehHgKrVrL205XFEQGOa7/wFXp/X4uQLOk+pNwvJISMkKuaf1rpyFsXP/6l10uu4X
         iz4cbtInmQgY0Bf5QG9fGqXpHKVWi20kaaE3pBExMI22kkrivRha0uhjT9siDb3Gpcai
         tt+DK5S2xDSAvNdbTkLzp2nDNfUMuareyvnd2F2++LphHFy2pOepcoAH/aEjWbaMsYkH
         jyyg==
X-Gm-Message-State: AOAM5338Smd+riaBjQ4en/cxVSWDvXRCIgzIH5JLYR+cnwdnRpBh7ViE
        Gxn8rsU8zIwfFoJvocK+Nkf3GFHA
X-Google-Smtp-Source: ABdhPJyCQwxcVr3RbS0QnV7knavaFbEEkYSPr8tJNJNzyTamoWqPzBwK6gVq1p1v7xkcpFNxYse1pg==
X-Received: by 2002:a2e:7202:: with SMTP id n2mr22638166ljc.7.1594588024796;
        Sun, 12 Jul 2020 14:07:04 -0700 (PDT)
Received: from [192.168.0.160] (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id l14sm4175132lfj.13.2020.07.12.14.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 14:07:03 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove unused members of struct
 xmit_buf
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200712123821.553420-1-insafonov@gmail.com>
 <895d5f76-832f-62a0-fc82-79b26ca104d4@lwfinger.net>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <5e3186e7-4b07-c119-2658-ebe5464a9fa7@gmail.com>
Date:   Mon, 13 Jul 2020 00:11:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <895d5f76-832f-62a0-fc82-79b26ca104d4@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 8:55 PM, Larry Finger wrote:
> On 7/12/20 7:38 AM, Ivan Safonov wrote:
>> Remove unused members of struct xmit_buf: alloc_sz, ff_hwaddr,
>> dma_transfer_addr, bpending and last.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
> 
> Have you tested this change? Previously with this driver, an unused 
> quantity was removed from one of the structs and the driver failed. 
> Apparently, the alignment of some other quantity was affected. I do not 
> think that this change would have that affect; however, you should be 
> testing whenever the changes are more than cosmetic.
> 
> Larry
> 

I have not tested this patch.

Ivan.
