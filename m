Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D328BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4365207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmBQU4Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgGAPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:38:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731815AbgGAPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593617911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Py/4SXH4WezveNFYu/+AP+Bhfed8tqRk59vhVofy0v8=;
        b=LmBQU4KppqXekRt9X1jkQ4GHSIcVKCv3VWP18LJeCRfiaR6t1UoivGSXb13BTWCU/jpxO8
        dgpZVRKHWv28lZXh+Q/4M1LFCqWtW1814TI7tnGMOZU0Zy1ip4slk3NnvYqKsesKKrbfuf
        2D0VStaJIeI3vt68tqMAd+L7VnXRzLE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-M-_PNu7TOiuUB9ScfHNFzQ-1; Wed, 01 Jul 2020 11:38:29 -0400
X-MC-Unique: M-_PNu7TOiuUB9ScfHNFzQ-1
Received: by mail-ed1-f72.google.com with SMTP id v7so21392768ede.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Py/4SXH4WezveNFYu/+AP+Bhfed8tqRk59vhVofy0v8=;
        b=njhMJ1Eqxic08KUGp3GflIQzovwIPcWeVecH4ILJFoyYgoEySqhzMUDjF1O/ydceqA
         n0IqdvydMej9lLfaYUHmIeJwVWM+mkhn0oBCrLaQV7L613BblpzaS0V0ld+RnTGbRT2f
         +nVxFcCFTu8w8eB15t7UwJq3jT/fgs7z4JrjxrXF8RI5af87fXGpz7MBhj5jvyiiLpWV
         +C593yxtlmItOP5J/e13VGQBPUj+0J7D1kcTPulqXCXlwgEaNgFDKcAHUt0E/xt9LQlp
         ARpXvxWMzCitMSKmVcAo9oZeNAu4SHLMbvrQkaGRE7Tz5sHwbAdemDPbxkBoYeoS5CJK
         cEiQ==
X-Gm-Message-State: AOAM530lwNt0iuXz55UFifIylg8A9sHheDKkkUNUyHylzjv3dee4+PNq
        chJhPov+g9cydkSuc4YfEcWPW2NvbjddjO583ahNvBSZv7wqJhaXhBdRyZWKVfcZh+DPDlITO1P
        pyjtZTUkqRGXYq89WWYKh7+V9
X-Received: by 2002:a17:906:a081:: with SMTP id q1mr18682451ejy.499.1593617908010;
        Wed, 01 Jul 2020 08:38:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy54o6ziuAtiZt1wxVzc00dbD4erN4UwBHRUGEg3DjhuOuIzpxwfUP54vl+2dn0vnK85F/E9Q==
X-Received: by 2002:a17:906:a081:: with SMTP id q1mr18682427ejy.499.1593617907763;
        Wed, 01 Jul 2020 08:38:27 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id d12sm6806675edx.80.2020.07.01.08.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:38:27 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: expose firmware config files through modinfo
To:     matthias.bgg@kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Double Lo <double.lo@cypress.com>,
        Frank Kao <frank.kao@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Soeren Moch <smoch@web.de>
References: <20200701153123.25602-1-matthias.bgg@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <338e3cff-dfa0-c588-cf53-a160d75af2ee@redhat.com>
Date:   Wed, 1 Jul 2020 17:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701153123.25602-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/20 5:31 PM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Apart from a firmware binary the chip needs a config file used by the
> FW. Add the config files to modinfo so that they can be read by
> userspace.

The configfile firmware filename is dynamically generated, just adding the list
of all currently shipped ones is not really helpful and this is going to get
out of sync with what we actually have in linux-firmware.

I must honestly say that I'm not a fan of this, I guess you are trying to
get some tool which builds a minimal image, such as an initrd generator
to add these files to the image ?

I do not immediately have a better idea, but IMHO the solution
this patch proposes is not a good one, so nack from me for this change.

Regards,

Hans



> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 310d8075f5d7..ba18df6d8d94 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -624,6 +624,22 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
>   BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");
>   BRCMF_FW_DEF(43012, "brcmfmac43012-sdio");
>   
> +/* firmware config files */
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4330-sdio.Prowise-PT301.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43340-sdio.meegopad-t08.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43340-sdio.pov-tab-p1006w-data.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43362-sdio.cubietech,cubietruck.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430a0-sdio.jumper-ezpad-mini3.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.AP6212.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.MUR1DX.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.MINIX-NEO Z83-4.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt");
> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4356-pcie.gpd-win-pocket.txt");
> +
>   static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>   	BRCMF_FW_ENTRY(BRCM_CC_43143_CHIP_ID, 0xFFFFFFFF, 43143),
>   	BRCMF_FW_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
> 

