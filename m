Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F84C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCCF21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/+wEX2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAWStB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:49:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54274 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:49:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so3653891wmj.4;
        Thu, 23 Jan 2020 10:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yh9nHowTnaSL47uvaYVVI7m+jnVxsZ/MKQRfRY8pD64=;
        b=r/+wEX2sGMhxBivDFH6tLvn76xPqD6EJ77Z5JtUVYxe1XwkWOgRpxy4XGCt6utVBc9
         jvPQlz6XyGa/k6uadaduIsa6SgSx+OYVoGQKNV1+Ymi+itNbdDTHaEyE2nqp3AGTMEWd
         140ypqgfm6iHna39SyP76RoI9KcQa+6PT+i3oklISTj2o05hH0ces9bZsqGYq/f9cXfC
         tzMY/84kf0a6OdZLYjjYH9G9DYWNH64sl3hHR+RGgpScUOz5Y+0n46qiAeN0X7OyKi0C
         d9cM9SZg1xxRq17QweH4rQcp+RjFvOSZ65ZfUCw5SflDDq3rFsHVA3mMqTa/11eVg0bn
         aAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yh9nHowTnaSL47uvaYVVI7m+jnVxsZ/MKQRfRY8pD64=;
        b=rnFuQYzw5Xj+nGv8fAiALqf+kB7TL+C3tONt2NQmVDACO9aS8bSBEDUbrGl0m4/kQQ
         /9PVyqshYd29GzrgcawNlsWAJwgT5Ld8hQ+ZB/XHq97xtmZAAln3dDkxTl30qCC16j1L
         jrqYmVkLFUtBqhjaeQj5Z288FklyiU1zwCRBTbjUXlpxKGydbsNNa571N6baEHjx9fOU
         FaANkp4q1aBsptAC8D/YTvpPQgbF2nhRyTh6OcZ1DGSwfS5yjg9RoqHBnpNHT3ju/5kW
         NETUCFnTD3jRrbCX/D/j74A6vUrJj2WaAlBJiHaJZ+oPob0aQ4CtgnJ28bPTKt27PlaY
         CpqA==
X-Gm-Message-State: APjAAAW7954AetOSEWi0a7vphRYUfwdavkxB/VZ/jvGjgZee0/pWNMWL
        z0GiDrqsOYaRnSyZOwda37V1gx6K
X-Google-Smtp-Source: APXvYqwALRz1ZVvn8odzLEaelMFb0G2tlfq1y9vSXNCZ3Fn+vvguhzaJeCepEwgfTF78hiTLBr5nvg==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr5385058wmd.23.1579805339789;
        Thu, 23 Jan 2020 10:48:59 -0800 (PST)
Received: from [192.168.0.104] (p5B3F68EB.dip0.t-ipconnect.de. [91.63.104.235])
        by smtp.gmail.com with ESMTPSA id q3sm4167784wrn.33.2020.01.23.10.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:48:59 -0800 (PST)
Subject: Re: [PATCH v8] dt-bindings: regulator: add document bindings for
 mpq7920
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200122174005.17257-1-sravanhome@gmail.com>
 <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <01c2d052-5e98-6fa6-dc66-08de194c491f@gmail.com>
Date:   Thu, 23 Jan 2020 19:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLq5XFdVRJa-XuTDbA_s=hpu3P4VGou=XfmSJs5NFAQqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/01/20 11:16 pm, Rob Herring wrote:
> On Wed, Jan 22, 2020 at 11:40 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> Add device tree binding information for mpq7920 regulator driver.
>> Example bindings for mpq7920 are added.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>
>> Notes:
>>      Changes on v8 :
>>        - fixed error reported by dt_binding_check
> Still broken. :(


Sorry I cannot reproduce any error, yaml is parsed and 
mps,mpq7920.example.dts is generated
   CHKDT Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
Please help me giving more detail

> Rob
