Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C811C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6126D21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJAUC0Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:47:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36708 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:47:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so8229ljg.3;
        Fri, 07 Feb 2020 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2NMoRT30iQ+tCo0o0Sn90sldXaVgelaqy3SMc26eMtE=;
        b=pJAUC0TsXgq8V5q0nrf82Olq+fHeZmx4A+vXaFdqCwqBniHusEs5vD8tsVePEJQ0VN
         OD/7GI77Pg1RtMeKJYnk+t3MVsZ90WZ5q0/tWtNGYeBMIx6HhUxM9KdzoJpSuAQLqiDz
         lD5ejn9V87l0JzWmz9AnsJ8M0nX3K10M9fgUhc0Q0DIy+kg3V18BgkbQ2I+WxulTAmSd
         9lMreixRIylJAIuSE48keuOcSpvpyeS0LDVdqpj6Oult4eGtrHwNYylBEwETnEBHBMxi
         ilqzd94/HH94uDlOOGpVbB2FHN7LJfxWyeYkap/9/9Cznd5zttkCVleaH423dUVodumC
         8xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2NMoRT30iQ+tCo0o0Sn90sldXaVgelaqy3SMc26eMtE=;
        b=kYRlC9wC2Kugc0xvMh3wFS6BBwRjS5yni//9E9BBk9XWw49vndDNCt8HXSa1VEjgOA
         6RBCkLvTa0ZXhkk2IK8Pz3fG2S2Mjv2aKjP9MFzHPuYfQoQ7vorb3Zdm9OblYS1IUa5j
         KzeEaOcyWhF11PBRk0P4BT8kFa8OgSaku0wrOIh6jaP1vxsdmLgaaGUPv4oSMKeuW1Kd
         84rgXJjlsacPQ6CJrdvM6Pms5SA5DxORk6luzSSRID7PFj+n+SpBwtv3rNTlfFL2IghT
         lkIdf0grhSKKZ2I08q2wl5hBNIFXfiWgAIi8EiAWo1ogvMOQwppuIjlQJEU3qIiNPzTF
         Pe1Q==
X-Gm-Message-State: APjAAAVQPe2F6IkGrmlIJzl7XB2q8KJQbqjFlEp/Hil00xjF4T5ZrUiw
        2gW0b27gSDpV9aPKQ6OEj4A=
X-Google-Smtp-Source: APXvYqw0/SNfI1cihxngPVjF8J849HZFhXP/YpBwLSsMLOgVrBJYt0XZMy9zqY0e10k9XX/vCTxcow==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr67349ljk.201.1581094062464;
        Fri, 07 Feb 2020 08:47:42 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e12sm1292984lfc.70.2020.02.07.08.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:47:41 -0800 (PST)
Subject: Re: [tip: core/kprobes] arm/ftrace: Use __patch_text()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Will Deacon <will@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
 <157544841563.21853.2859696202562513480.tip-bot2@tip-bot2>
 <10cbfd9e-2f1f-0a0c-0160-afe6c2ccbebd@gmail.com>
 <20200207112720.GF14914@hirez.programming.kicks-ass.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <039eac1a-cafe-b20b-77c8-bad019d4320c@gmail.com>
Date:   Fri, 7 Feb 2020 19:47:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200207112720.GF14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2020 14:27, Peter Zijlstra пишет:
>> NVIDIA Tegra20/30 are not booting with CONFIG_FTRACE=y, but even with
>> CONFIG_FTRACE=n things are not working well.
> 
> Ooh, I think I see. Can you try this:
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 2a5ff69c28e6..10499d44964a 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -78,13 +78,10 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
>  {
>  	unsigned long replaced;
>  
> -	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
>  		old = __opcode_to_mem_thumb32(old);
> -		new = __opcode_to_mem_thumb32(new);
> -	} else {
> +	else
>  		old = __opcode_to_mem_arm(old);
> -		new = __opcode_to_mem_arm(new);
> -	}
>  
>  	if (validate) {
>  		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> 

Hello Peter,

It fixes the problem, at least kernel is booting fine now and I can't
notice any problems. Thank you very much! :)

Tested-by: Dmitry Osipenko <digetx@gmail.com>
