Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1184C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766D72072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Sa0LMs4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHVHYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 03:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgHVHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 03:24:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9572C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:24:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a65so184546wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6U5VsJiOvwoKSeq8i4SuBH869R0qJJNwlA5i8UJmv1c=;
        b=Sa0LMs4O1BZWbNh3nc5ZpOwo02B8a7BK8f+0ItUxGWaVjd1/HeuQ6pFw29icSNit0s
         8F7F3s4PFk1JZdoofJE9yfiXjt4JaqRawIb070HzoKXkjcpicNGelRZ6lT7T9Ro4IhVJ
         9g4feFl5nvjEryKQCXa/rteuljT/8vyJLClT0MFqZxKvUdH3CQBYmX80B9KrHRAaLdwT
         Ypg9K5W7CmVJ16bOEvWMzfcursbZmvo8tm7crzf23CZVtWbfMP34spRIqbom/91ujtbx
         9AZw5traqujfA+aZOmsXnYhAn9Yujm3aAFJioeBcrMG9ODmk5KrHZlrK4EzycqLcI54l
         b0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6U5VsJiOvwoKSeq8i4SuBH869R0qJJNwlA5i8UJmv1c=;
        b=YX3pil+7Fer9ydsbXiojyhQBnkBJ1baUUylBj3te1dSSPX5Ub8e+AEj7aT/WCUD+UJ
         +0N61FuxctoKMU9PaE6EPDfciyhuyRTWLRCFKqaFoFVTRI2n9mwC/BnjHf645icOBavn
         W+oppvdTA7aeFQQHVGP/fQHigQm/b7EeFGUQOhnBHfqPY7/Bs1RlzBYcK08FMsg2pKho
         BKQaRbXEEOZMKBE0CCCAiYChjXekTg9pOzCAOxRyOYa5DAX3KcB0qmZhctYN1ME8DLS9
         ii1JaO+j/TMVlFNMnZk2iCrTbAsIlP0E+HuAT6n4aSCC29Pklv4lXjQgb/k5D3UW1J0+
         6ZRQ==
X-Gm-Message-State: AOAM533vmG5s9nQa2zgEEP25/tuVCaT7nkkclLpRMiZpUNiVXGUlqgcs
        gGNEs4p1HT96UA4UWci7BMI=
X-Google-Smtp-Source: ABdhPJyRBVyMKS2GcuAZNOEqvh9FAmdOz8jtI4OqOQe3emis8LaXL9BkGNqvsSEBqWMr0YvffLTREg==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr7427469wmh.21.1598081050315;
        Sat, 22 Aug 2020 00:24:10 -0700 (PDT)
Received: from [192.168.1.20] (host86-161-135-137.range86-161.btcentralplus.com. [86.161.135.137])
        by smtp.googlemail.com with ESMTPSA id i4sm8615188wrw.26.2020.08.22.00.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 00:24:09 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
From:   Chris Clayton <chris2553@googlemail.com>
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
 <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
 <19de15c2f07d447dace6bea483d38159@realtek.com>
 <152ef6c0-f3c0-bb67-4175-adced3c720cd@googlemail.com>
 <e1c295f28e3d4bdd8c78dfd3a5ed398c@realtek.com>
 <68b9bdd2-a05e-7fb0-ec9a-70b03e0c5289@googlemail.com>
 <20da8b4b-8426-9568-c0f1-4d1c2006c53f@googlemail.com>
Message-ID: <29b12ecc-6e5c-8c1a-942b-ad23a95d020a@googlemail.com>
Date:   Sat, 22 Aug 2020 08:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20da8b4b-8426-9568-c0f1-4d1c2006c53f@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Ricky.

On 05/08/2020 13:48, Chris Clayton wrote:
> Hi Ricky
<snip>
>>
>> Ah, OK. I'll prepare the patch and send it to you once I've tested it.
>>
> 
> Please see the patch included below. As you suggested, it removes the code that does the OC power down on card readers
> that are not members of your A series. The patch is against a fresh pull of Linus's tree this morning
> (v5.8-2768-g4da9f3302615).
> 
> I've tested the resultant kernel on my Intel NUC6CAYH box (which contains an NUC66AYB board) and the rts5229 works fine.
> I've also tested it on my laptop which also has a card reader supported by the rtsx_pci driver (an RTL8411B) and that
> also works fine.
> 
> As I mentioned yesterday, I think it's a candidate for the 5.4 ans 5.7 stable series.
> 
> Thanks for your patience!
> 
> Chris
> 
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> --- a/drivers/misc/cardreader/rtsx_pcr.c        2020-08-05 07:10:21.752072515 +0100
> +++ b/drivers/misc/cardreader/rtsx_pcr.c        2020-08-05 07:11:05.568074278 +0100
> @@ -1172,10 +1172,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *
>                         rtsx_pci_write_register(pcr, REG_OCPGLITCH,
>                                 SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
>                         rtsx_pci_enable_ocp(pcr);
> -               } else {
> -                       /* OC power down */
> -                       rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
> -                               OC_POWER_DOWN);
>                 }
>         }
>  }
> 
> 

Is there some problem with my patch? If you are too busy to deal with it, perhaps I can submit directly it to Greg/Arnd.

Thanks

Chris
