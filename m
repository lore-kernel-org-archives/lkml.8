Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D32C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB8F2467D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGHlRD9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgB2SNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 13:13:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbgB2SNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 13:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582999990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELSAoUxGc8eBF9PUWqfNY/f+wik89k5lBPM0FZuTUWc=;
        b=CGHlRD9JNV7VJxqWT/2lk0IC+GMEHdvl0Ps+szQt5N5zFqZm4upoF8NoxyRcSU0M3ppgIh
        SnvEccGdgzCusfqjOpGPj5Nhdc5vp+ZIvxiLjKtOoZusCSzysp7b9x1SmjN4xlrsnIMWHa
        eFdw9zZuvV4PIKuqi9pnyR/stWWM7l0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-bB7Ijg_JN1S9aVmQmD3H9Q-1; Sat, 29 Feb 2020 13:13:02 -0500
X-MC-Unique: bB7Ijg_JN1S9aVmQmD3H9Q-1
Received: by mail-wr1-f70.google.com with SMTP id p8so3159818wrw.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 10:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ELSAoUxGc8eBF9PUWqfNY/f+wik89k5lBPM0FZuTUWc=;
        b=VOnngo1dGji8Hk22qE5LDBq5/gEHM+Wxiet3+ODSzhJtFD85x7dGHxm0ejIxDemvAR
         j6YVlsWzGL1faCujutZVPe9SjRS0xODO1tJIQio2l4I7/H63tcMJu5301rYTW2NXFGg7
         meFpMN3yC6tGWsPAkentsRNO9PaksXaRosLnkvzG4fc1UDvup0wQ+PVOdZMKX2DRzV+t
         yCrFTVh7ZhvtS808LY5GEWhyJ8zMBZPx7HxDUiSaSZW6313mWmBWam3Kms1l0ZI4MMSh
         c/fK5SJbJgZQeLOcnFhl3MYyz+WzrKUXvYSd31niOhliHBK7WWljGSOldKPNj92bLhGi
         oxqg==
X-Gm-Message-State: APjAAAXwJgeZ//DF70KGp2G1Sfu7PkVitriZPH6Cumm38BSaUqHjb4lQ
        GV0LhWCQ5egLfK3Gw1ufNLpeT3EnNAyhPBbmSXJbTX5CbPE2THattWZTaOKuXqgdlOuulBD7mPU
        tdCS3TD4bxFVdAeqnACe/GxKD
X-Received: by 2002:a1c:5419:: with SMTP id i25mr10895774wmb.150.1582999980671;
        Sat, 29 Feb 2020 10:13:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbOVpxd5tn7CkCk0SX9+v/bCLUDXMet7HYFiuNoqrKMS+TRkVnk+yNM9FmR5+dDyUPdaZLzw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr10895751wmb.150.1582999980244;
        Sat, 29 Feb 2020 10:13:00 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id a9sm7443089wmm.15.2020.02.29.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 10:12:59 -0800 (PST)
Subject: Re: [PATCH resend] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200221165941.508653-1-hdegoede@redhat.com>
 <202003010150.eyjF3gp0%lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b9a34773-ab38-a3c7-3e35-7da95dc625f4@redhat.com>
Date:   Sat, 29 Feb 2020 19:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003010150.eyjF3gp0%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/29/20 6:16 PM, kbuild test robot wrote:
> Hi Hans,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v5.6-rc3 next-20200228]
> [cannot apply to tip/auto-latest]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-purgatory-Make-sure-we-fail-the-build-if-purgatory-ro-has-missing-symbols/20200223-040035
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 248ed51048c40d36728e70914e38bffd7821da57
> config: x86_64-randconfig-s1-20200229 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ld: arch/x86/purgatory/purgatory.ro: in function `kstrtoull':
>>> (.text+0x2b0e): undefined reference to `ftrace_likely_update'

AFAICT this is the patch working as intended and pointing out an actual issue
with the purgatory code. Which shows that we really should get this
patch merged...

Regards,

Hans

