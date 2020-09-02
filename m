Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197CC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD86207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBFYK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:24:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42153 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgIBFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:24:09 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kDLE4-0005iX-RO
        for linux-kernel@vger.kernel.org; Wed, 02 Sep 2020 05:22:29 +0000
Received: by mail-pf1-f199.google.com with SMTP id 196so2021969pfx.21
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 22:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wMqbe9fjKIQ0LZl5FhPinVHwgKbnNs2WDnA3NP2bLUs=;
        b=leg6xCZX1xCDBMLoJEP7EC19edblew6HU4goWWacS+dVEPqPtpIUaIldB1sMBcJ0nu
         +kegXQ2KIFeh5Uf50pBzsW8ZxXfBbyDmh5/Nppzpgs9HMkSFLu9zLN8NHO9wTCZmB5uY
         f2/aOK6hoo5b8a+oIErM9Yaf9mITQcznPqk62nMNijstgy6C56FcHYFO/MyWqjk1nsuq
         GpQfmuKWQctSLy66fQ4RlNwJAUnEuxumQBfyhxC/Vmd+0ungJsRK8owPOjNS6OaczItY
         tFtBCYuUCdV+Q2wWWqL92TKLP4FKhXxuSw1Mji7eOvaOKGptwe75BNwjej83/Yah7Rjw
         BF0w==
X-Gm-Message-State: AOAM5311l+ZPJPVGdC33wg1Q342VMq63SiBjnMSTFVTFFX0QmgZ2/GVC
        tjU3MRkUMi3XxonBlE3mbCJ6wvzNCmz21xYLM/k9VPj8jIYQNu5Pb+quxacsLNHjvCtQXUbyqER
        TLOw7cIBGRhMme9qlwWaf7281jbbGZ+GM10AH0A2Axg==
X-Received: by 2002:a17:90a:af82:: with SMTP id w2mr722038pjq.185.1599024146760;
        Tue, 01 Sep 2020 22:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwViL3221ms+ijBjNKHR4OA2XAP9LtY9zANzX6D+Esz/RzAKY2p2wPTcMpDjCcWoSdimi1SAg==
X-Received: by 2002:a17:90a:af82:: with SMTP id w2mr722004pjq.185.1599024146154;
        Tue, 01 Sep 2020 22:22:26 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id t11sm3826352pfe.165.2020.09.01.22.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 22:22:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] drm/i915/lspcon: Limits to 8 bpc for RGB/YCbCr444
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200831194820.GB6112@intel.com>
Date:   Wed, 2 Sep 2020 13:22:22 +0800
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Uma Shankar <uma.shankar@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F51DEE39-6D93-41A2-9EA4-C7FE94F04E72@canonical.com>
References: <20200826052143.17607-1-kai.heng.feng@canonical.com>
 <20200826162458.GP6112@intel.com>
 <6D40F1E0-AFF6-4D38-BB9B-C52B43F83266@canonical.com>
 <20200831194820.GB6112@intel.com>
To:     =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2020, at 03:48, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> 
> On Thu, Aug 27, 2020 at 01:04:54PM +0800, Kai Heng Feng wrote:
>> Hi Ville,
>> 
>>> On Aug 27, 2020, at 12:24 AM, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>>> 
>>> On Wed, Aug 26, 2020 at 01:21:15PM +0800, Kai-Heng Feng wrote:
>>>> LSPCON only supports 8 bpc for RGB/YCbCr444.
>>>> 
>>>> Set the correct bpp otherwise it renders blank screen.
>>> 
>>> Hmm. Does 
>>> git://github.com/vsyrjala/linux.git dp_downstream_ports_5
>>> work?
>>> 
>>> Actually better make that dp_downstream_ports_5^^^^^^^^^^^ aka.
>>> 54d846ce62a2 ("drm/i915: Do YCbCr 444->420 conversion via DP protocol
>>> converters") to avoid the experiments and hacks I have sitting on top.
>> 
>> Can you please rebase it to mainline master or drm-tip?
> 
> git://github.com/vsyrjala/linux.git dp_downstream_ports_6

Yes this solves the issue. Thanks a lot!

Any timeline this will get merged?

Kai-Heng 

> 
> I threw out the hacks/experimental stuff.
> 
>> 
>> I am getting errors on the branch:
>> 
>>  DESCEND  objtool
>>  CALL    scripts/atomic/check-atomics.sh
>>  CALL    scripts/checksyscalls.sh
>>  CHK     include/generated/compile.h
>>  Building modules, stage 2.
>>  MODPOST 166 modules
>>  LD      arch/x86/boot/compressed/vmlinux
>> ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
>> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
>> ld: warning: creating DT_TEXTREL in a PIE
>> make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1
>> make[1]: *** [arch/x86/boot/Makefile:113: arch/x86/boot/compressed/vmlinux] Error 2
>> make: *** [arch/x86/Makefile:284: bzImage] Error 2
>> make: *** Waiting for unfinished jobs....
>> 
>> Kai-Heng
>> 
>>> 
>>>> 
>>>> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2195
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/gpu/drm/i915/display/intel_lspcon.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
>>>> index b781bf469644..c7a44fcaade8 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
>>>> @@ -196,7 +196,8 @@ void lspcon_ycbcr420_config(struct drm_connector *connector,
>>>> 		crtc_state->port_clock /= 2;
>>>> 		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR444;
>>>> 		crtc_state->lspcon_downsampling = true;
>>>> -	}
>>>> +	} else
>>>> +		crtc_state->pipe_bpp = 24;
>>>> }
>>>> 
>>>> static bool lspcon_probe(struct intel_lspcon *lspcon)
>>>> -- 
>>>> 2.17.1
>>> 
>>> -- 
>>> Ville Syrjälä
>>> Intel
> 
> -- 
> Ville Syrjälä
> Intel

