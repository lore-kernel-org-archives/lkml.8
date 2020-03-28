Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0759EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E6E20578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585392543;
	bh=0cKR7Gg09PrWOD3Byl07C/3B0eIG99PscslH7mJoTyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tEAbgWYg2s+YHPOVvajwAPpHrfgtdhrCKbUWppJgiT88nYDWCd8KEjV2VjGHVjCx/
	 QaKbBEEFoV3MKwv+Atdh2klkpiMf1L0g590M9acBNoKuiEuAsdO89wHgmCzVBbCsC5
	 eN2qFrEF/ArIIkZ3vc/w0nIZxkMNUU6wh09Wby7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgC1KtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:49:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgC1KtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:49:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so14859574wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u3G6iIYGrMRkXzku2ElE66l7xM/3/5NEbShBWIcH9mE=;
        b=jzBUQs8M9ft4inBdcvhu69eoJ9SEJuQRjrw11ud4U3XggwEtplr92f7++HDK+0KYOK
         G6ZLlUilZN4VnnCutI5ZI46nWHCgw9EKjGGXYlW3XSi6Y3ueiA1nkJFdwwIP72pFsGTL
         rRoXlZ7dKKsN2tKW/gpDyoiiqMUOmUWMdCiTyWfCWtTNviYm3PnnkpIdBOmvR7dqSzOz
         AdkonUGuQEdjObTrGR0RrPSPcJC901te6MR5m3t0FJ8Cp30vRmPqrBnRq19JvNb6tRNt
         2ZFC98Us8JiPOr+nVchbYpYqHUm3H3ilgpyIYyblmWidlb+UoqrTOpsaz8pTJCO6d+DM
         KizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3G6iIYGrMRkXzku2ElE66l7xM/3/5NEbShBWIcH9mE=;
        b=fE9O6GORtAH5GecOTauwCiPaPOrXMhs7L/W3n1+co+QPVkK8lQ3Uv2SumQTvbv5J3B
         Fl/hJQzIOIzwJUMVHmFnISonsSmn0NjD84Ae/t9sAeme1/oId98E/5aejbh9KKInfjB8
         wiUEyCIS9AYYUcg2mqqT/tA9C3skLXZI4YKOKil+7K5XVRdjuNA+g3enpeIi+lANRVuo
         RP+0OT0La+KtNs4VLW8ys8X4g1k6JD1gUGV4zxxNJ8Pd/Sde2f3whvw2gQNerBf92vp+
         6h0yBcFYmK7tC+kebxO747Lghgx3VWeAm9Nct8jygMWdLhrvy+0tivy2SB2+SAmT5x7p
         tJPg==
X-Gm-Message-State: ANhLgQ08sYFNnFnzLMJ9zxsNTGbVAGcXwIQT1pUPwKk7KIAJjn1omQ1Z
        Bszpgy2eh8gAgtLOnv2Ra6k27pAU
X-Google-Smtp-Source: ADFU+vtktyyRpLq0BdVFI1IxPFRfUe83Ux1MdUnLsmbsMwjs9rEsRGD1ZllD5cVDKrsByk6Gbfwc8Q==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr4669616wrq.347.1585392540717;
        Sat, 28 Mar 2020 03:49:00 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c85sm11912573wmd.48.2020.03.28.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 03:48:59 -0700 (PDT)
Date:   Sat, 28 Mar 2020 11:48:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Message-ID: <20200328104857.GA93574@gmail.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@ZenIV.linux.org.uk> wrote:

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> rather than relying upon the magic in raw_copy_from_user()

> -		bytes = __copy_from_user_nmi(&frame.next_frame, fp, 4);
> -		if (bytes != 0)
> +		if (__get_user(frame.next_frame, &fp->next_frame))
>  			break;
> -		bytes = __copy_from_user_nmi(&frame.return_address, fp+4, 4);
> -		if (bytes != 0)
> +		if (__get_user(frame.return_address, &fp->return_address))
>  			break;

Just wondering about the long term plan here: we have unsafe_get_user() 
as a wrapper around __get_user(), but the __get_user() API doesn't carry 
the 'unsafe' tag yet.

Should we add an __unsafe_get_user() alias to it perhaps, and use it in 
all code that adds it, like the chunk above? Or rename it to 
__unsafe_get_user() outright? No change to the logic, but it would be 
more obvious what code has inherited old __get_user() uses and which code 
uses __unsafe_get_user() intentionally.

Even after your series there's 700 uses of __get_user(), so it would make 
sense to make a distinction in name at least and tag all unsafe APIs with 
an 'unsafe_' prefix.

Thanks,

	Ingo
