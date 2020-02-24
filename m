Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E7C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqlsWUNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBXP3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:29:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBXP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:29:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id z12so6195574wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AXpFOJp0zSaTFAP+me7G07Iilsucf3whVGy3CIL9cVI=;
        b=aqlsWUNPbsW9l28BYG/n5HyXAUrCXzZQydP4nPSMTpgPgE7D9QXgxjLMGZtexm0jFa
         Lm0qzuluSGBlNKpNchaYfMS7nS4loKI4RVOfhX/JnJHzd1YsDB7DZQ2fLXN+WfCRCCwY
         WG1Ya2gJH4sFiQA0nkfGCminkhxH73nrSrsG248xK8Vsxv4+9/G4unhB5wOMtmOdLg3z
         T++jB+yd5dzHPinJnxW7PyAGeyfKhUA87XxmdT+hlSywoCt3/R27XGzCwFqCxruLTIvf
         MhPbb1KfkobcJenuHhtKE2Zp0Z6UKs74Y9KPa8uejUm6zAnbQ0OgJ4JOrxktbnc9zJnP
         Tsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AXpFOJp0zSaTFAP+me7G07Iilsucf3whVGy3CIL9cVI=;
        b=U/gshKI3ezeRy7vd2YCMPkMCysuqiXEXU7r4rI4jCmfoAtQc0SS5BZ1ckFajVA56FB
         lfrXyAdO7HQzhmmWYwgeVEsRZ3FFpKP8SYaagU5+RnVIdiWz+rcU0ZYoRnbL2duR2ft4
         OiNLV81Zq505n2FgHRHeqoMRY68Tds/NRhXZ+NVt5WCL6xqCFci1/mwFZPRYPx6W/RZW
         jh5tK6gtZTkinpfxWKddH24cYp/+l6PBy/jqAMjVCsWBVPof1ZUsCUcMq8KTBMq8cqaJ
         z7RH+e6ZiErWGlBW88e310iaJiFzGcWUI0CZm+kAqL7YYyKcxT+Y1QCoY50hsXDCxjKH
         WXsg==
X-Gm-Message-State: APjAAAWVr09/utjIqI5gAjhLfnrf+o/tUP8Z6kpRlFDlsILiq1bvM8NW
        aHRLl54nvdD6VVAud3aDwn75dw==
X-Google-Smtp-Source: APXvYqyW7u01kII2K7pYNHauJqRc75jIktUIXQaMXO5DBluLiHAFSlxuEEylaK9W/agE16CWGXMiNQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr22226152wmi.58.1582558176258;
        Mon, 24 Feb 2020 07:29:36 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id f8sm18200741wru.12.2020.02.24.07.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:29:35 -0800 (PST)
Date:   Mon, 24 Feb 2020 15:30:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/19] mfd: intel_soc_pmic: Add SCU IPC member to
 struct intel_soc_pmic
Message-ID: <20200224153006.GV3494@dell>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-11-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200217131446.32818-11-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Mika Westerberg wrote:

> Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
> be using this field going forward to access the SCU IPC instance.
> 
> While there add kernel-doc for the intel_soc_pmic structure.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/mfd/intel_soc_pmic.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
