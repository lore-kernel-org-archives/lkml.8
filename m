Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861342065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fGI1PO1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgGURdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGURdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:33:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17408C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:33:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so1908198pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZrtoWffAVvd00OC4napBk7mfnvRG6TV5NcmGhEFIqG4=;
        b=fGI1PO1RQnaNqtLH3IMNze+lXGoK+/sqXMOIbNC5fb9Y+qE0UiZtQdnrUFxmierAVM
         nZ7ssJaql0aUGceNb9xMeoYPB0yDkCpvUcGRuAHHICddKgG35g+vEgEgUFmHwvro2onN
         A6pYbzRiCAdc7btuss+JFPOCOOS2LS8JXh/B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZrtoWffAVvd00OC4napBk7mfnvRG6TV5NcmGhEFIqG4=;
        b=JHB+1RLtAOSRicxcEShwWfRtBPBAH9DB6ydLFjX2yJV5vOh7eZ4vBmH23dBhk5wImC
         fD/67CisiXxrYMT77+58Sbh8Ua9UV5irjFdtYrOLMONBrDjeJ1aZzoNgxVoXSnkmDylc
         4/GH2PhsP3GWWFzP2qCdFzh0Qw6NQuslkC+MzbfQTRGhvUwLnBQRDKaiI2+ThX6Xt5NY
         ufxlPwRihAcd4PkLWBO230OWsb/t1uzQvx9jdJhtIk8oTU8t/eTIVlqzD6iJN0FiRXK2
         5DGC9nOV6GmO6dNkxeKDwi5fIDXPzlryTlOcIUXJ1iz0e1QdaO86G9QdG1qzuaiuqSok
         Sl1Q==
X-Gm-Message-State: AOAM533FXZ+PcUk6my/NN+3x3zmPOciIjLwdHvHIKsIp9R1teRRLxGit
        idFc3t8qlYEYtq8jgbcqrPExyA==
X-Google-Smtp-Source: ABdhPJzU37i8KDcAD2HXGEvmUA3lDt4PuqF7sWkap4/ymRc+jshHnRU1hmNlqVbOHdsE2PKK22aPKg==
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr23956289plj.145.1595352815262;
        Tue, 21 Jul 2020 10:33:35 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q24sm17943252pgg.3.2020.07.21.10.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 10:33:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] usb: bdc: Add compatible string for new style USB
 DT nodes
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
 <20200721144326.7976-3-alcooperx@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 OXY+VnhOn2EcREN7qdAKw0j9Sw==
Message-ID: <ed809bfd-655c-fd71-62e2-53f58af540bd@broadcom.com>
Date:   Tue, 21 Jul 2020 10:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721144326.7976-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/20 7:43 AM, Al Cooper wrote:
> Add compatible string for some newer boards that only have this
> as there match sting. Remove unused compatible string "brcm,bdc-v0.16".
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
