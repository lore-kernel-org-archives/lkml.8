Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782AC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ADB214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esy1o146"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBFXMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:12:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42878 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:12:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so464305qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aYzEAXY/pplsm/tbsCmU3SKX4j9BGaxg0LIHoc73LNo=;
        b=esy1o146jVZMm123lTDBiWEMUMQ/jolajhcbRHF6YsH7VDeqSGViXLnVVKnuo5xxe8
         Dv9shBiy3JZ0NZtUwG/+2YR16dnH2FfPrR2ooAxqHJDd4w7pOJ1rEjSXafzbO++n9Wbq
         KLoc20NHNJkkxIrqcAGYoKc3AUq6yDtxzjZFls/nY3nETH0moDQ3P+Xnu9Okp0SqFu4s
         ppxpkGxcn1P+EDZ6r3pk/+W9WMXdCCh4av080wxqocgNUhZj3m5vjbe+XXR4VZk+R2h9
         JuuawzkO5eJX9OMHdsj2PDrJCfEBZ4iEVJWLI1H1eXrA/hVb7LioWDSy482S3YIp8uUO
         YOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aYzEAXY/pplsm/tbsCmU3SKX4j9BGaxg0LIHoc73LNo=;
        b=NT/pbSAhwTGlUZL2Z1hJ9sK6vqeIiee1CXO4hKTgpk2tbV6Vuw5VtJYW/Z1GINsck4
         xmlJxvxRjkFfEoPnGkOnXhvNp8HXawkVPZ/2qaAWbr1zQPND+FEeyRSuaArutXCtRY7i
         UVG6Hkrf46VoMVYDGwU2NHnrdSB2hfovJ546ND2EIbrWqiU9h1MJvTXqn0PmYOmByBGC
         Vg5ptKo8fxO40+LhTVyToZ4d7xkZtt+yZbs/t8TCWVOnOb/a9gQ3A7cTUMJ0pRU5OMKq
         6cMhC1d8o+83Qhx4pZfsinxIciOIRUmnVaJgh7pbQy+FgRAzHXjoENT3VUHYePs9/JAm
         29OQ==
X-Gm-Message-State: APjAAAXTjDjE7zR8mZ86lQQqTzT/uO/TdYaYCu6Og8JvDyAbqLJO8a89
        U2ZGSFEDV00nDQ5yQnrKqtE=
X-Google-Smtp-Source: APXvYqxU9MaZ5D2GIUiFNp0dcOg7XLjz0B0sJOZXslXS1vHwTgV//Bzq5Wq9aaA4qQGapnDHPEGcQw==
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr4827412qtl.175.1581030735127;
        Thu, 06 Feb 2020 15:12:15 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t23sm394775qtp.82.2020.02.06.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 15:12:14 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 18:12:13 -0500
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Tom Anderson <thomasanderson@google.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Error building v5.5-git on PowerPC32 - bisected to commit
 7befe621ff81
Message-ID: <20200206231211.GA2976063@rani.riverdale.lan>
References: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fb64c98-57c2-b988-051c-6ba0e460ad37@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:46:52PM -0600, Larry Finger wrote:
> When building post V5.5 on my PowerBook G4 Aluminum, the build failed with the 
> following error:
> 
> drivers/gpu/drm/drm_edid.c: In function ‘cea_mode_alternate_timings’:
> drivers/gpu/drm/drm_edid.c:3275:2: error: call to ‘__compiletime_assert_3282’ 
> declared with attribute error: BUILD_BUG_ON failed: cea_mode_for_vic(8)->vtotal 
> != 262 || cea_mode_for_vic(9)->vtotal != 262 || cea_mode_for_vic(12)->vtotal != 
> 262 || cea_mode_for_vic(13)->vtotal != 262 || cea_mode_for_vic(23)->vtotal != 
> 312 || cea_mode_for_vic(24)->vtotal != 312 || cea_mode_for_vic(27)->vtotal != 
> 312 || cea_mode_for_vic(28)->vtotal != 312
> 
> This error was bisected to commit 7befe621ff81 ("drm/edid: Abstract away 
> cea_edid_modes[]").
> 
> This problem is clearly a problem with the gcc compiler on the box, namely gcc 
> (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3. I had no success finding why the 
> attributes were wrong, and finally settled on the following hack:
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 99769d6c9f84..062bbe2b254a 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3272,6 +3272,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
> *mode)
>           * get the other variants by simply increasing the
>           * vertical front porch length.
>           */
> +#ifndef CONFIG_PPC32
>          BUILD_BUG_ON(cea_mode_for_vic(8)->vtotal != 262 ||
>                       cea_mode_for_vic(9)->vtotal != 262 ||
>                       cea_mode_for_vic(12)->vtotal != 262 ||
> @@ -3280,6 +3281,7 @@ cea_mode_alternate_timings(u8 vic, struct drm_display_mode 
> *mode)
>                       cea_mode_for_vic(24)->vtotal != 312 ||
>                       cea_mode_for_vic(27)->vtotal != 312 ||
>                       cea_mode_for_vic(28)->vtotal != 312);
> +#endif
> 
>          if (((vic == 8 || vic == 9 ||
>                vic == 12 || vic == 13) && mode->vtotal < 263) ||
> 
> Disabling the build check allows me to build and test the post v5.5 versions.
> 
> Larry

It's not that the attributes are wrong. The problem is that BUILD_BUG_ON
requires a compile-time evaluatable condition. gcc-4.6 is apparently not
good enough at optimizing to reduce that expression to a constant,
though it was able to do it with the array accesses.
