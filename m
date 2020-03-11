Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A299CC5ACBF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473C02072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ8fFFHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgCKSSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:18:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45852 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgCKSSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583950717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIEuNm0s1KSd9ucNBIED5u8XC49ZUleRh3A+TtaDM9A=;
        b=KJ8fFFHckcEzm/tOgMlOhjukcLZa6Bhpj8Y8fqcrEGjUUhkjJdL6y4N1MpXpKffmsv0CSv
        /0T8quhQoWgflpt3zJ5o6qoiWwhZqiAyoyEBJkXSlPai30WTvPDKMA3Ac5zocoGRKs56pJ
        ZpiJwu2uwyQ9TqGSJPEFNTtlRH935HI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-m9lhqwNmM3qj11U6qp1tYw-1; Wed, 11 Mar 2020 14:18:35 -0400
X-MC-Unique: m9lhqwNmM3qj11U6qp1tYw-1
Received: by mail-wr1-f69.google.com with SMTP id z13so1313506wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIEuNm0s1KSd9ucNBIED5u8XC49ZUleRh3A+TtaDM9A=;
        b=tcaZELvTkjRCFDrGMXhTvDZB664pU/5m2KJP3ZLwVtECcxSL/joXofwYodkxVBCgV5
         wAAU5NFnrKUO+vuBZYHbAnunKD3rHdXKpcueRkvxIwHO8Gk49GdwgKIH/x/HaHJUOxLU
         Hxiv7H+eciswJwke28otl1QVO0IgXBugyViHQdE84wR15F0DS4TAQTCJhhVX76AylV2V
         0NihvaWIel09muFLG7ZgRGkMwD0z/FoxbokwmTTmwXIK9F3nM9M9+Em8Whp3dO3T+pv7
         8+hWik578hfeI14NUtFNB9icrk9kzcSMrEzU6xJpWqks4YrIgoXXA0+GGMKEwriB9xpv
         YpMg==
X-Gm-Message-State: ANhLgQ3Kg4ewxxLeiN2tpARFMvKQKxA15rk0W/P6SgkroeCoNAtq4Fo4
        ybUnBp45lHUmrFDue9XyIXe9R4xqmqZ6w7BfnYJ8xMYlj7/QDEaWp5Vasm0E4oWFvBv880SMEMl
        OeO2N2B9UzfMJwtLkPsWjsP2+
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr35462wmb.118.1583950713295;
        Wed, 11 Mar 2020 11:18:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vull0VAoH6OT00g7UtPFzzvBf5edDKUbKJ3cpfh/bStE6A6kp/2YRlGvAJBVLJS4Bh77Ftt5Q==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr35442wmb.118.1583950713010;
        Wed, 11 Mar 2020 11:18:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id r9sm1977728wma.47.2020.03.11.11.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:18:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] x86/tsc_msr: Use named struct initializers
To:     Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Vipul Kumar <vipulk0511@gmail.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Len Brown <len.brown@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200223140610.59612-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9705677f-f52e-938f-a84a-8db8afc9fc8f@redhat.com>
Date:   Wed, 11 Mar 2020 19:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223140610.59612-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/23/20 3:06 PM, Hans de Goede wrote:
> Use named struct initializers for the freq_desc struct-s initialization
> and change the "u8 msr_plat" to a "bool use_msr_plat" to make its meaning
> more clear instead of relying on a comment to explain it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I believe that this series is ready for merging now? Can we
please get this merged?

Regards,

Hans


> ---
>   arch/x86/kernel/tsc_msr.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
> index e0cbe4f2af49..5fa41ac3feb1 100644
> --- a/arch/x86/kernel/tsc_msr.c
> +++ b/arch/x86/kernel/tsc_msr.c
> @@ -22,10 +22,10 @@
>    * read in MSR_PLATFORM_ID[12:8], otherwise in MSR_PERF_STAT[44:40].
>    * Unfortunately some Intel Atom SoCs aren't quite compliant to this,
>    * so we need manually differentiate SoC families. This is what the
> - * field msr_plat does.
> + * field use_msr_plat does.
>    */
>   struct freq_desc {
> -	u8 msr_plat;	/* 1: use MSR_PLATFORM_INFO, 0: MSR_IA32_PERF_STATUS */
> +	bool use_msr_plat;
>   	u32 freqs[MAX_NUM_FREQS];
>   };
>   
> @@ -35,31 +35,39 @@ struct freq_desc {
>    * by MSR based on SDM.
>    */
>   static const struct freq_desc freq_desc_pnw = {
> -	0, { 0, 0, 0, 0, 0, 99840, 0, 83200 }
> +	.use_msr_plat = false,
> +	.freqs = { 0, 0, 0, 0, 0, 99840, 0, 83200 },
>   };
>   
>   static const struct freq_desc freq_desc_clv = {
> -	0, { 0, 133200, 0, 0, 0, 99840, 0, 83200 }
> +	.use_msr_plat = false,
> +	.freqs = { 0, 133200, 0, 0, 0, 99840, 0, 83200 },
>   };
>   
>   static const struct freq_desc freq_desc_byt = {
> -	1, { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 }
> +	.use_msr_plat = true,
> +	.freqs = { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 },
>   };
>   
>   static const struct freq_desc freq_desc_cht = {
> -	1, { 83300, 100000, 133300, 116700, 80000, 93300, 90000, 88900, 87500 }
> +	.use_msr_plat = true,
> +	.freqs = { 83300, 100000, 133300, 116700, 80000, 93300, 90000,
> +		   88900, 87500 },
>   };
>   
>   static const struct freq_desc freq_desc_tng = {
> -	1, { 0, 100000, 133300, 0, 0, 0, 0, 0 }
> +	.use_msr_plat = true,
> +	.freqs = { 0, 100000, 133300, 0, 0, 0, 0, 0 },
>   };
>   
>   static const struct freq_desc freq_desc_ann = {
> -	1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 }
> +	.use_msr_plat = true,
> +	.freqs = { 83300, 100000, 133300, 100000, 0, 0, 0, 0 },
>   };
>   
>   static const struct freq_desc freq_desc_lgm = {
> -	1, { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 }
> +	.use_msr_plat = true,
> +	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
>   };
>   
>   static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
> @@ -91,7 +99,7 @@ unsigned long cpu_khz_from_msr(void)
>   		return 0;
>   
>   	freq_desc = (struct freq_desc *)id->driver_data;
> -	if (freq_desc->msr_plat) {
> +	if (freq_desc->use_msr_plat) {
>   		rdmsr(MSR_PLATFORM_INFO, lo, hi);
>   		ratio = (lo >> 8) & 0xff;
>   	} else {
> 

