Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E95C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9D42087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQY8ewMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDWFYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:24:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F899C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 22:24:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so2384625pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lEVdnd8EWeQZgsT9ppcu9Jy5EeI1fMWvBp6M+DR99hQ=;
        b=kQY8ewMuRx6utXx9z5qFH+eTWEbWI04gFeiaHLd9L+sbKysrrKlNGh8U5OzQ4EDCbF
         8n4K9BE1hF7dOxzkE9EuDf7QQ34nq1nnULKRG99nWC9inbw3UJFXYuQALQrshY77uyMD
         l8H/Z3PI6IBbrGOhowqvVL5dKviS48T2lxwX7JEU1d6sPaVpP6gFgvZywsI6MpMn36QB
         1ONxFcxh1w2viXPOBE5z7QXCPVWN7UiRndeOVQr/E6CPFqzWqSvA9HKpUJyfIWFbErIL
         qBPMlheEH72AUe/KvKVF+l0zyQ8jUG+prsEN/7s4bfX0t5JChog/GzMlBMIUyLhcPf2w
         QKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lEVdnd8EWeQZgsT9ppcu9Jy5EeI1fMWvBp6M+DR99hQ=;
        b=qnHQ7OgJAtxG/fAsLHqbupHBHdU2BLeve5VI6FnVxIQ94Bw9Y4zJDJlz0PitalAc6h
         6cmpG9Quitf+MCTn51PNMd4CzB+dNOIIbAEEl3Sd4MO7BtB19DCXuv4kNB7eOEkr8sat
         3rC8kzgDlhQIS23xqWjLW3UObj1ABJ8UKRM4163eCwFiKQs6Prjld0xe+ZqUdwv/ZPT2
         YvDoyvahCCOObo+Eg2VTRvWm0/QhpuVR8TulBZyF4n+aYZAjA6muOTqJA+D8dPSXBeGt
         07wyMFtrRR/ZbgxrbOgVic7FY/34y1Fy6i9DVCZWCSJbLuY82UeYxF4NTYlqhHi1Sfuu
         Glbg==
X-Gm-Message-State: AGi0PubNn+LI9XQXlXRqCLuBgbHJQ1UhxLZTtsTScP0n1p3YwE/O7oCP
        9dm/pDIZLiZ3WOO6vO8W0mXyxZzg5h8=
X-Google-Smtp-Source: APiQypLR2/06UhIEsqhcv1dfYIqMq3kQEseREtteSWLWzX3fhIbeYEsVOhzx1kidIEIB+RGi3xOm1g==
X-Received: by 2002:a63:354:: with SMTP id 81mr2374158pgd.304.1587619443386;
        Wed, 22 Apr 2020 22:24:03 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id b140sm1305741pfb.119.2020.04.22.22.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 22:24:02 -0700 (PDT)
Date:   Wed, 22 Apr 2020 22:23:57 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 3/6] arm64/vdso: Add time napespace page
Message-ID: <20200423052357.GA967113@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
 <20200416052618.804515-4-avagin@gmail.com>
 <20200416104527.GD4987@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200416104527.GD4987@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:45:27AM +0100, Mark Rutland wrote:
> Hi Andrei,
> 
> On Wed, Apr 15, 2020 at 10:26:15PM -0700, Andrei Vagin wrote:
> > diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> > index 07468428fd29..351c145d3808 100644
> > --- a/arch/arm64/include/asm/vdso.h
> > +++ b/arch/arm64/include/asm/vdso.h
...
> > +#ifdef CONFIG_TIME_NS
> > +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> > +{
> > +	const struct vdso_data *ret;
> > +
> > +	ret = _timens_data;
> > +	OPTIMIZER_HIDE_VAR(ret);
> > +
> > +	return ret;
> > +}
> > +#endif
> 
> Sorry for the confusion here, but please either:
> 
> * Add a preparatory patch making __arch_get_vdso_data() use
>   OPTIMIZER_HIDE_VAR(), and use OPTIMIZER_HIDE_VAR() here.
> 
> * Use the same assembly as __arch_get_vdso_data() currently does.
> 
> ... and either way add a comment here:
> 
> 	/* See __arch_get_vdso_data() */
> 
> ... so taht the rationale is obvious.
> 
> [...]
> 
> > +enum vvar_pages {
> > +	VVAR_DATA_PAGE_OFFSET = 0,
> > +#ifdef CONFIG_TIME_NS
> > +	VVAR_TIMENS_PAGE_OFFSET = 1,
> > +#endif /* CONFIG_TIME_NS */
> > +	VVAR_NR_PAGES = __VVAR_PAGES,
> > +};
> 
> Pet peeve, but we don't need the initializers here, as enums start from
> zero. The last element shouldn't have a trailing comma as we don't
> expect to add elements after it in future.
> 
> Rather than assigning to VVAR_NR_PAGES, it'd be better to use a
> BUILD_BUG_ON() to verify that it is the number we expect:
> 
> enum vvar_pages {
> 	VVAR_DATA_PAGE,
> #ifdef CONFIG_TIME_NS
> 	VVAR_TIMENS_PAGE,
> #endif
> 	VVAR_NR_PAGES
> };
> 
> BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);

Hi Mark,

Thank you for the review. I have sent a fixed version of this patch in
replay to the origin patch.

Thanks,
Andrei
