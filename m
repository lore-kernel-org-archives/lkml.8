Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E509C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564EC205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVlUjrqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbgGVIra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:47:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5EC0619DC;
        Wed, 22 Jul 2020 01:47:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so1647345lji.2;
        Wed, 22 Jul 2020 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qmcGYJPSuyo4WuFIfVqxApT7la3Q4Txd8FLQ6LnHWo4=;
        b=IVlUjrqqH0pP9EmVDgkTU6EIgQeXEF3Gh/3cI5fsOThjWIECBl0cH1kSFmgcIfnw1+
         fu8ccq1XZ7wNqWXqScglWb3UJKE62Du90zTwS76lkvNpXhZ3BV3006kgYMCQPGlSx6y7
         veH8VJETf2hnCj6mfmjRBfbrR2oqMCxtTEGH0s49gHxXJsPHqtBDJ6mliw7ybiiG1W8d
         xZm8d5jSNfIOpItyIFkqfcHt9PZVQQdw7u7ffOz7wb3hXBPSl6VNO1bo1JDl/jLUrvRr
         EO0aw5NHOK0dtQuoCYEqXfFYrsCPzUfW1vk0ooc6fIs8J08l0H1KE0oaHWWPapYTO/Xo
         ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qmcGYJPSuyo4WuFIfVqxApT7la3Q4Txd8FLQ6LnHWo4=;
        b=Jsnw2c+kO+kUVz5Vgs5AbWgmCIfeQDWx24DwzJ+hd4chGc3N+eKVodsga0DEs29fiW
         GmP+IC+14qcQGq8io4W2fNY+zUnVLoMbpoFG2jaNhGKhry/8ekE//S4WjGuFfhETYrgV
         8aMBDuZU5kc9Kx1Q0uZq0IUpJlQ/A2PjLYz++KE91eVFWw/m4dh5E4WDNe37kdyhKQxG
         /Bltc+Nk2iAIpqjG6UDRjHWkYbiGByUV3e7i/DSWp1k2OMBBauGJamZjsEID9ZkdcXPv
         6bja2DlW5Nh91Y69AO6K+VZQCiaVjcoeOOMZpUw5hwH6DCIpDNKSdLWto53j1OBYSuy7
         Ievg==
X-Gm-Message-State: AOAM533t4bDD8RovUZLesafNURPUZm9ZfaOX+/PDP4xjuhVyRbiAuhTe
        pZtfvhwsXyfHvfClXWuaNXk=
X-Google-Smtp-Source: ABdhPJzxgSeLeWfdE37PuacpR3Wt8B+Wgl2c49Vt2KIZs+uwNveItzbShKhFT6aBtIvL9eDMu8fxhg==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr13830785ljh.246.1595407648046;
        Wed, 22 Jul 2020 01:47:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:44d2:25a2:d4ec:7c9e:620b:fb8? ([2a00:1fa0:44d2:25a2:d4ec:7c9e:620b:fb8])
        by smtp.gmail.com with ESMTPSA id y24sm6241661ljy.91.2020.07.22.01.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:47:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] usb: bdc: Add compatible string for new style USB
 DT nodes
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
 <20200721144326.7976-3-alcooperx@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <ca58400f-353b-64e6-d923-82978a48876a@gmail.com>
Date:   Wed, 22 Jul 2020 11:47:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721144326.7976-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.07.2020 17:43, Al Cooper wrote:

> Add compatible string for some newer boards that only have this
> as there match sting. Remove unused compatible string "brcm,bdc-v0.16".

    s/there/their/.

> Signed-off-by: Al Cooper <alcooperx@gmail.com>
[...]

MBR, Sergei
