Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFFFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C015624655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIR8TO7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgAUQEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:04:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36831 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgAUQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:04:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so2731173lfh.3;
        Tue, 21 Jan 2020 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4QElD4aLgqnxIJYOw+6hd85zSf1XDYHPFQQs8FVOpM4=;
        b=RIR8TO7sH4q9qS6/bFOYNX7/b+ZDX2vFNdHP/g+lQB6/t8sLVO/BG/dOQK5bd4YkS9
         3xUOVihE7L7weX1mW9pVZHpPTX8Khtm0hc+BXfTytT5F6A9ZEuKkwliKQoxHbgU87YJz
         eX0bCZH4JjFHyBoGPnUoH4r8Sjk6zc8Xe0dqe1P8OzP2eqyNAV8wSMLwz6Rbw03UBNxZ
         mUv81d8q3O1kvCcYE0pKMEnUypCOUgKMrAVfIIOHRyM3drDIDLC1lXDWx0jwKYQMnxIl
         CyOrsEwX5FoRyQGI29X3DrN31rN3VnpxB2XPF1kT0orssRzlu3C6xD4QruxVxdNql7V5
         Oj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QElD4aLgqnxIJYOw+6hd85zSf1XDYHPFQQs8FVOpM4=;
        b=pfkdj2wTBfYmVoIf5MMw8Vp4NDYk9E6kLEoJdR6RnQ9RYbgSPhvNhoE1n9kzRBRZnO
         G+29Ykb+2csykuQS2AVPgI73eGRgcinpiFomkf7kZePIcxVNxiugyAli+MUw7F8Zx1cP
         6CxnlzRYwmOWA5Acc8V1GUVLhfqSbTHrYrTbTStY+xk6AzQxRrAlhCJsVu6yvRemtrhy
         HmGRNppnGz2gpoPKCl8zh/3hufzXI3JNx1NM+VFJGLp2OR5ZfFHxTNgObMrJRFhA9JrW
         oXDNVfSYnBn6EyRGFvwce1Ypz4pb0z9hlAQm5tb4PAKE+6eRCdL10Xs0AGlo4RGWDRyR
         QexA==
X-Gm-Message-State: APjAAAWysPhimv0kKf8RC5fgs2lqIiHmCOYdgIr6sJk8ppMYgb6w0Obr
        gDCm+jGGXyHDix+Y38iAlRY=
X-Google-Smtp-Source: APXvYqy7EtDOd9lxlMN59AeictrAoxR0wB9a8lavz+2thaHFgaRugWz3ll5Ecy/t12c/eutcaI9siw==
X-Received: by 2002:a19:550d:: with SMTP id n13mr2212655lfe.48.1579622661898;
        Tue, 21 Jan 2020 08:04:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f8sm1936176lfc.22.2020.01.21.08.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:04:21 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: tegra: add support for CIF
 programming
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-3-git-send-email-spujar@nvidia.com>
 <d01ed171-d949-19b2-3390-ee30eada2779@gmail.com>
 <a8409b81-7c6b-37a9-81fd-772eb2eca185@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <229def08-6bd4-30d7-056b-92329e48c699@gmail.com>
Date:   Tue, 21 Jan 2020 19:04:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a8409b81-7c6b-37a9-81fd-772eb2eca185@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.01.2020 07:41, Sameer Pujar пишет:
> 
> On 1/20/2020 9:28 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Sameer,
>>
>> 20.01.2020 17:23, Sameer Pujar пишет:
>>
>> [snip]
>>
>>> Tegra30 and Tegra124 have an identical CIF programming helper function.
>> [snip]
>>
>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT  24
>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US        0x3f
>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK  
>>> (TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US <<
>>> TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT)
>>> -
>>> -/* Channel count minus 1 */
>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT   24
>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US 7
>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK   
>>> (TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US <<
>>> TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT)
>> The AUDIOCIF_CTRL bitfields are not the same on T30 and T124, why are
>> you claiming that programming is identical? Have you actually tried to
>> test these patches on T30?
> 
> Oh yes! seems like I overlooked the macro values. Thanks for pointing
> this. I will retain separate CIF function for Tegra30.
> I do not have a Tegra30 board with me and hence could not test anything
> specific to it apart from build sanity.
> If someone can help me test I would really appreciate.
> 

I'll help with the testing once all obvious problems will be fixed.
