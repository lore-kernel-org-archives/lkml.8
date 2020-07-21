Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2348C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693D7206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5LmklQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgGUUTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGUUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:19:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4ADC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:19:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a24so11247352pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hAWhLrwvbifHp2r44fJg0rzAvtxe0k3AOZjhAZLRh1c=;
        b=L5LmklQjaL6F4zOLD9FizAG93/AhvEn+UIaST+HjlM4rNoQjhGUkFJntnwvm83k6mn
         Jh0z7d9MvGUCthqxlx7exI6mW6NOWFVRY9iTf/VVFmqFOmroIW4LBoS5Ken3iuLl8+SR
         XFiVmNUUvSJmWgMUpCEfIhCBBtdnBh7jUJQENsvn80e8+mc4IxeEsFMCCO7vUFvvNscl
         EXI0wSscJEdRMmHYbanQWF05NkipwC32yis7j0HiPxKCImt5mH8s+PeoOlsh2Jef0sHI
         EZwpqPI1pPYNoyKJfWAUmGuTM6P+sVohRNYsMAUgzvMgzUCHC729ZBrfFaNXgl4Rphf9
         iGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hAWhLrwvbifHp2r44fJg0rzAvtxe0k3AOZjhAZLRh1c=;
        b=gI8qm4jSAJgcRxA9XeVyxIPr89DVcnyIYu8P+wRLkufJpWRYJDUE1MN1Upm/DVRa1F
         yIxQpLAm3J6e+fgl+Ek6cM8JsIfMk1eXbWMhI//zniY7topFQLNj5aWKUUw3oKfRj3di
         lYM98xte2iCMSOkaYBmP9E1aeA8XrKcm+QPOY3bWsul7s+AAKem9TVJ2fBDdmxXFKdnw
         PWYZNM6pGsqRt73nwAylzWNKWRNYqO4DM+tqrNBEHpODc6bHTAk4oBo5yhudI1Uzpim/
         EhxN0lqUAesVAzWboCrOCTvcCA7zzLgSEO4Aca9t+o90OtHE6+7ebBRYYEs9l8BVjaL3
         6/3g==
X-Gm-Message-State: AOAM5335SMIwtTWSebYUSvNCRZ6jhNKQvo0sP8ZbSFhA6F6ddGRt/R1w
        U3F66ziO0KJ083sJOLIHvnU=
X-Google-Smtp-Source: ABdhPJziaxztSZAhHa+m0l5Ax/geN8yZuJfSvnIKlqjutJ1D7mapJPR156QkvV34H7mPW3cLucr1aw==
X-Received: by 2002:aa7:988e:: with SMTP id r14mr26369722pfl.35.1595362744690;
        Tue, 21 Jul 2020 13:19:04 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id b15sm3953746pje.52.2020.07.21.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 13:19:04 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:19:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] RMI: <linux/rmi.h>: drop a duplicated word
Message-ID: <20200721201902.GJ1665100@dtor-ws>
References: <20200719003131.21050-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719003131.21050-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 05:31:31PM -0700, Randy Dunlap wrote:
> Drop the repeated word "to" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nick Dyer <nick@shmanahar.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

-- 
Dmitry
