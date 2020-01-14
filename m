Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635DC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBBE24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNigWarx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgANRpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:45:02 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42659 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:45:02 -0500
Received: by mail-wr1-f50.google.com with SMTP id q6so13020473wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=johIKj6dr/XITu/mSGAE6g5raKwrSIWzAj9JFiJgZp0=;
        b=tNigWarx5ke1La+9w6d/S/X7/yRrrWd7jAYIGPzHfLFCs305UVPXrImQeIjDKOvY5c
         3h4IR6tH63m2dzPEt7yRl5wGrTKts8S+ICOaWQzPIOzokaYOWyKBk0toFE3Lj1fkEQhZ
         sZiyEmHvPP9iMRcLBpTkCHZKY2jJHbIrfsKEgJPQ6tZOd4SpaKZt7oBV2Z8hbdFnZath
         VowBAoqespXihmLFMLMWuwX+Ex6IcV7b+9861LWR9q8IdGHwGba/OUqWqQ7d/GOlYlD2
         NLWT+jQOBR70GLCzVlpCdtGc2u+hdO7tpitymzHXAF1iYVS9Ye6x8N4w+9OIusz1D6rw
         VlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=johIKj6dr/XITu/mSGAE6g5raKwrSIWzAj9JFiJgZp0=;
        b=H+w8tZCPzKbT2h53Sf9xNY34v8ovu/iDQ1gtGZaez8E6voLw2Lg1kLSGpruJ0ECvCJ
         9OkBEz292O+d61yks+qA0Ozt6p3GcSuc5qRwqXIkItcTuKkLt7sgqvfY+I1HI3TXXgbF
         295XvvhxYDGtKqrJsfKUqyAEb57ftW12oEMcRTDfqnHJZBtg/Uc9dI3JFlm+QWjE/Wir
         HW95mOuDzikM1Sp6tRQtb4eFRU3kKzoGuItl/AOtzQYUsYs/bd0YyRFxdGe289CREEz2
         WcUVsREeC4fU6VYRyoMUFH3RHONzdoXHJ4EGv0WyXFzc4nDY5GA7vzsuU4h7QHQjFFJp
         oK3g==
X-Gm-Message-State: APjAAAX1PrPyoqV2WN3bFkPSzG61hrelO2R4qdXHVIGaWJF2mNTLrLjS
        ApF/FJXudPH/NR5jwC9WktNpWPD0f8Y=
X-Google-Smtp-Source: APXvYqz5Qc+4O/USr1TX1xAf6bLnx0eSbH85RdsiEXAoS1TbZhv0N5hOIM8m6sDVQT962I1Mz1GorA==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr28229493wrn.219.1579023899775;
        Tue, 14 Jan 2020 09:44:59 -0800 (PST)
Received: from [192.168.0.104] (p5B3F6CFD.dip0.t-ipconnect.de. [91.63.108.253])
        by smtp.gmail.com with ESMTPSA id l3sm18615197wrt.29.2020.01.14.09.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 09:44:59 -0800 (PST)
Subject: Re: regulator: mpq7920: Some inconsistencies in current driver
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAFRkauBRi2g_4b3wUnmwLkeogTyWjX4=6VfyDLJr-REf=LeC-w@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <673bbb3e-70e1-db4e-239e-3fedbbfdd5ad@gmail.com>
Date:   Tue, 14 Jan 2020 18:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFRkauBRi2g_4b3wUnmwLkeogTyWjX4=6VfyDLJr-REf=LeC-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/01/20 1:49 pm, Axel Lin wrote:
> Hi Saravanan,
>
> There are a few inconsistencies in current driver:
> I don't have the datasheet, so I'm not 100% sure.
> Maybe you can help check it.
>
> 1. It's unlikely MPQ7920_LDO1_REG_B and MPQ7920_REG_CTL0 have the same address.
>     I think this needs double check.

There is no REG_B register for MPQ7920_LDO1, it is a tweak for MACRO expansion consistence of MPQ7920LDO.
However LDO1 doesn't not access this register since mpq7920_ldortc_ops discharge api is set to NULL

> 2. The MPQ7920_DISCHARGE_ON seems wrong because it does not match
> MPQ7920_MASK_DISCHARGE.
>     I guess MPQ7920_DISCHARGE_ON should be BIT(5).
Yes, you are correct and thanks for pointing out
>
> 3. The MPQ7920_MASK_BUCK_ILIM seems wrong. I guess it should be 0xC0.

Yes, you are correct and thanks for pointing out

> 4. Not sure why define both MPQ7920_REG_REGULATOR_EN1 and
> MPQ7920_REG_REGULATOR_EN.
There is EN1 register exist but later decided that cannot be handled by 
driver so its stray which
shall be removed.
>
> Regards,
> Axel

Thanks,
Saravanan

