Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87160C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60782221F1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClaI3OCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFTPFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgFTPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:05:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB76C06174E;
        Sat, 20 Jun 2020 08:05:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so14657235lji.11;
        Sat, 20 Jun 2020 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cC/kgYZ98AFtKsSnL1c9eWREKRXoMKu60JHedrpuptk=;
        b=ClaI3OCondxVk+pVJYSeistUsa1TfvZDmkq0JpZHtC8xsR0LnmmdEkgjNYoEkQnUKX
         tkGbCfVDf5tlH3C/BWaojJPDXgntX4ZpNhYO4Ax7KghREvaXj+aqxhECGB80nF2imTy1
         gLkDagTcQr9S2bxcx8R568dCyifzswvs+hpf218s6lNwETXVWrQQlbVl7Gex1GeWy3ob
         ffKGeJkYgbSUhhr5e78mHzksFV1Kz4JuMTz0bSdC2ekCuqu9Nvy4KDYjaOEdihGSuPgo
         kmd/8X3rH/OWDyIe7rA3eEAoRAfPms3tfjFq4TUc/8k63p0OsH48dycl5dLFVPmUZEy4
         osQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cC/kgYZ98AFtKsSnL1c9eWREKRXoMKu60JHedrpuptk=;
        b=SMUYrzZMtv/p4e3WlqDhEaaT6dojFY2SDc34sdscWPTtBuh63qz+6SfKeoSePnAEgA
         4SwPQrsuopX5sTSswKBdyPHsCaSPw8MWx2Ol4Xb1yaE/SfzigS5KOJxpjk7dKnZ/m/rt
         QYd/hIarcxre3uCymdrJrCCpB2kUeW/XQy9uLwuZQmC8MCpaWqqBza/lywoPORrg5ewo
         C8ir2VMWy0LQAyWihdga1BKVCjFS8pSrcl7NBBJP8mt8v5AvnFpf9z6jYjCxmKF8Boc1
         vdg8JaAQxVnkxUuyvNiIIuCbKhtRVfKj1/vW1cVUmNZ1QLjedyJIzd1Puaw6o0GMG2OE
         4ayA==
X-Gm-Message-State: AOAM530EtHBGjOBVe2IU3WEer0TkT5x+BLy2Jd/sknzvmIo96GXaz4VU
        ngDZ6YJvN4rbw9yuj5XXC2s=
X-Google-Smtp-Source: ABdhPJxkAwkMqQA+UTB5xAzf8ceKNP0+Ozy6OZt8rrWp77P4n6g60+DuTrmnJPIWs/EOJyIZCJJ6aw==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr3935669lji.255.1592665539062;
        Sat, 20 Jun 2020 08:05:39 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id m11sm2131027lfl.70.2020.06.20.08.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 08:05:38 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] drm/panel-simple: Add missing connector type for
 some panels
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200617222703.17080-1-digetx@gmail.com>
 <20200617222703.17080-8-digetx@gmail.com>
 <20200620112132.GB16901@ravnborg.org>
 <20200620114934.GB5829@pendragon.ideasonboard.com>
 <ea421084-a91c-bc03-5997-1723075b7cae@gmail.com>
 <20200620143114.GA22329@ravnborg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e77a34c1-3e0b-7f30-25d0-a955ec8d8c86@gmail.com>
Date:   Sat, 20 Jun 2020 18:05:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200620143114.GA22329@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.06.2020 17:31, Sam Ravnborg пишет:
> Hi Dmitry
> 
>>
>> Oops! Good catch!
> Yep, thanks Laurent. Should have taken a better look before applying.
> 
>> Indeed, I blindly set the LVDS type to all these
>> panels. Please revert this patch, I'll double check each panel and
>> prepare an updated version of this patch. Thank you very much for the
>> review!
> 
> If you can prepare a fix within a few days then lets wait for that.
> I will do a better review next time.

Hello Sam,

I should be able to make it later today or tomorrow. Could you please
clarify what do you mean by the fix, do you what it to be as an
additional patch on top of the applied one or a new version of the patch?
